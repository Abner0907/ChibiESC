/*
    ChibiOS - Copyright (C) 2006..2015 Giovanni Di Sirio

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/


#include "ch.h"
#include "hal.h"
#include "ch_test.h"
#include "chprintf.h"

//#include "subsystems/serial/chibiesc_usb.h"
//#include <stdint.h>

#include "subsystems/serial/chibiesc_serial.h"

#include "misc.h"
#include "bal_interface.h"



/*
 * Application entry point.
 */
char testtext[8] = "Hallo\n";

float testfloat = 3.14;



//#define chprintf printf
// BEGIN copy&paste from stmbl usb_cdc

#include "ringbuf.h"
#include "bal.h"
#include "bal_term.h"


GLOBAL_HAL_PIN(nrt_time);
GLOBAL_HAL_PIN(rt_time);
GLOBAL_HAL_PIN(frt_time);
GLOBAL_HAL_PIN(nrt_period_time);
GLOBAL_HAL_PIN(rt_period_time);
GLOBAL_HAL_PIN(frt_period_time);


#define RX_QUEUE_SIZE  128
uint8_t usb_rx_buf_raw[RX_QUEUE_SIZE];
uint8_t usb_rx_string[RX_QUEUE_SIZE];
//uint8_t usb_rx_buf[RX_QUEUE_SIZE];
//char rx_buf[RX_QUEUE_SIZE];


struct ringbuf usb_rx_buf = { .buf = (char[RX_QUEUE_SIZE]) {0}, .bufsize = RX_QUEUE_SIZE, .pos = 0, .len = 0 };

uint16_t cr_count = 0;

static uint16_t VCP_DataRx(uint8_t *buf, uint32_t len)
{
    for (uint32_t i = 0; i < len; i++) {
    	if (buf[i] == 0x0A) // 0x0A == '\n'
    	    cr_count++;
        rb_putc(&usb_rx_buf, buf[i]);
    }
    return 1; //USBD_OK;
}


#define USB_CDC_FIRST_ASCII 32    // erstes Ascii-Zeichen
#define USB_CDC_LAST_ASCII  255   // letztes Ascii-Zeichen
uint16_t USB_VCP_get_string(char *ptr)
{
    uint16_t akt_pos = 0;
    char wert;

    // test ob eine Endekennung empfangen wurde
    if (cr_count == 0) return 0;

    if (usb_rx_buf.len == 0) return 0;

    // kompletten String bis zur Endekennung auslesen
    // (oder bis Puffer leer ist)
    // es werden nur Ascii-Zeichen übergeben
   do {
        rb_getc(&usb_rx_buf, &wert);
        if ((wert >= USB_CDC_FIRST_ASCII) && (wert <= USB_CDC_LAST_ASCII)) {
            *(ptr + akt_pos) = wert;
            akt_pos++;
        }
    } while ((usb_rx_buf.len != 0) && (wert != 0x0A)); // 0x0A = '\n'

    // Stringende anhängen
    *(ptr + akt_pos) = 0x00;

    // eine Endekennung wurde bearbeitet
    cr_count--;

    return akt_pos;
}



void USB_VCP_send_string(unsigned char *ptr)
{ //TODO: Joerg implementiere senden von 0-terminiertem string. Implementiere was Schnelleres als PRINTF!!!
	//chprintf("%s", ptr);

    while (*ptr != 0) {
        // send a queued byte - copy to usb stack buffer
        //APP_Rx_Buffer[APP_Rx_ptr_in++] = *ptr;

        streamPut(&SDU1, *ptr);
        ptr++;

            // To avoid buffer overflow
            //if (APP_Rx_ptr_in >= APP_RX_DATA_SIZE) {
            //   APP_Rx_ptr_in = 0;
            //}
    }
}

//END copy&paste



#define ADC_GRP2_NUM_CHANNELS   2
#define ADC_GRP2_BUF_DEPTH      48

static adcsample_t samples2[ADC_GRP2_NUM_CHANNELS * ADC_GRP2_BUF_DEPTH];


systime_t count_adc, count_frt;
/*
 * ADC streaming callback.
 */
size_t nx = 0, ny = 0;
static void adccallback(ADCDriver *adcp, adcsample_t *buffer, size_t n) {

  (void)adcp;
  if (samples2 == buffer) {
    nx += n;
  }
  else {
    ny += n;
  }
  count_adc++;
}

static void adcerrorcallback(ADCDriver *adcp, adcerror_t err) {

  (void)adcp;
  (void)err;
}


/*
 * ADC conversion group.
 * Mode:        Continuous, 16 samples of 8 channels, SW triggered.
 * Channels:    IN11, IN12, IN11, IN12, IN11, IN12, Sensor, VRef.
 */
static const ADCConversionGroup adcgrpcfg2 = {
  TRUE,
  ADC_GRP2_NUM_CHANNELS,
  adccallback,
  adcerrorcallback,
  0,                        /* CR1 */
  ADC_CR2_SWSTART,          /* CR2 */
  ADC_SMPR1_SMP_AN12(ADC_SAMPLE_3) | ADC_SMPR1_SMP_AN11(ADC_SAMPLE_3),
  0,                        /* SMPR2 */
  ADC_SQR1_NUM_CH(ADC_GRP2_NUM_CHANNELS),
  0,
  ADC_SQR3_SQ2_N(ADC_CHANNEL_IN12)   | ADC_SQR3_SQ1_N(ADC_CHANNEL_IN11)
};




static THD_WORKING_AREA(waThreadFRT, 8192);
static THD_FUNCTION(ThreadFRT, arg) {
	// shortest time to compute, but highest frequency and highest priority
	(void)arg;
	chRegSetThreadName("ThreadFRT");

	int delta_count, last_delta_count;
	delta_count=0; last_delta_count=0;
	count_adc=0; count_frt=0;
	systime_t time = chVTGetSystemTime();
	adcStartConversion(&ADCD1, &adcgrpcfg2, samples2, ADC_GRP2_BUF_DEPTH);

	while (true) {
		time += US2ST(20); //20
		//palTogglePad(BANK_LED_GREEN, PIN_LED_GREEN);
		palTogglePad(BANK_LED_RED, PIN_LED_RED);
		delta_count = count_frt - count_adc;
		if(delta_count != last_delta_count) {
			//palTogglePad(BANK_LED_RED, PIN_LED_RED);
		}
		last_delta_count = delta_count;
		count_frt++;
		chThdSleepUntil(time);
		//chThdYield();
	}
}

static THD_WORKING_AREA(waThreadRT, 8192);
static THD_FUNCTION(ThreadRT, arg) {
	// longest time to compute (longer than ThreadFRT frequency, but lower frequency and lowest priority
	// long computation in this thread is interrupted by ThreadFRT and the main loop
	(void)arg;
	chRegSetThreadName("ThreadRT");

	systime_t time = chVTGetSystemTime();

	while (true) {

		//chThdYield();
    	//chThdSleepMilliseconds(100);

		   switch(bal.rt_state){
		      case RT_STOP:
		         return;
		      case RT_CALC:
		         bal.rt_state = RT_STOP;
		         bal.hal_state = RT_TOO_LONG;
		         bal.frt_state = FRT_STOP;
		         return;
		      case RT_SLEEP:
		         if(bal.active_rt_func > -1){
		            bal.rt_state = RT_STOP;
		            bal.hal_state = MISC_ERROR;
		            bal.frt_state = FRT_STOP;
		            return;
		         }
		         bal.rt_state = RT_CALC;
		   }

		   static unsigned int last_start = 0;
		   unsigned int start = hal_get_systick_value();

		   float period = ((float)(start - last_start)) / hal_get_systick_freq();
		   last_start = start;

		   hal_run_rt(period);

		   unsigned int end = hal_get_systick_value();

		   PIN(rt_time) = ((float)(end - start)) / hal_get_systick_freq();
		   PIN(rt_period_time) = period;

		   bal.rt_state = RT_SLEEP;

		   // TODO: Implement proper overrun check
		   time += US2ST(200); chThdSleepUntil(time);
		   //chThdSleep(MS2ST(1));

		   //palTogglePad(BANK_LED_ORANGE_DISCO, PIN_LED_ORANGE_DISCO);

	}
}


static THD_WORKING_AREA(waThreadNRT, 8192);
static THD_FUNCTION(ThreadNRT, arg) {
  (void)arg;
  chRegSetThreadName("ThreadNRT");
  int len;
  systime_t nrt_calctime = 0;
  systime_t nrt_starttime = chVTGetSystemTime();
  //systime_t nrt_nexttime = nrt_starttime;
  int nrt_blink_count = 1000;
#define nrt_Period MS2ST(1)
  PIN(nrt_period_time) = ((float)nrt_Period) / hal_get_systick_freq();
  while (true) {
	  if(nrt_blink_count-- <= 0) {
		  nrt_blink_count = 1000;
		  //palTogglePad(BANK_LED_RED, PIN_LED_RED);
		  palTogglePad(BANK_LED_GREEN, PIN_LED_GREEN);
	  }
	  nrt_starttime = chVTGetSystemTime();
	  hal_run_nrt(nrt_Period); // Calls term which calls USB_VCP_get_string. Call from own thread, NOT HERE!!!

	  nrt_calctime = chVTTimeElapsedSinceX(nrt_starttime);
	  PIN(nrt_time) = ((float)(nrt_calctime)) / hal_get_systick_freq();
	  //nrt_nexttime += nrt_Period; // TODO: Check if nexttime > starttime!!!
	  //chThdSleepUntil(nrt_nexttime);
	  chThdSleep(nrt_Period);
  }
}


/*
 * Start RT-Thread
 * */
void hal_enable_rt() {
	chThdCreateStatic(waThreadRT, sizeof(waThreadRT), NORMALPRIO+10, ThreadRT, NULL);
}
/*
 * Start Fast-RT-Thread
 */
void hal_enable_frt() {
	chThdCreateStatic(waThreadFRT, sizeof(waThreadFRT), NORMALPRIO+20, ThreadFRT, NULL);
}

void hal_disable_rt() {

}

void hal_disable_frt() {

}



int main(void) {
	// main loop always runs at NORMALPRIO
	int len;

  /*
   * System initializations.
   * - HAL initialization, this also initializes the configured device drivers
   *   and performs the board-specific initializations.
   * - Kernel initialization, the main() function becomes a thread and the
   *   RTOS is active.
   */
  halInit();
  chSysInit();

  /*
   * Activates the ADC1 driver and the temperature sensor.
   */
  adcStart(&ADCD1, NULL);
  //adcSTM32EnableTSVREFE();
  /*
   * Starts an ADC continuous conversion.
   */

  //ce_serial_init();
  usb_init();


  chThdSleepMilliseconds(2000);
  //setup();
  hal_init(); // from stmbl bal



  hal_set_comp_type("foo"); // default pin for mem errors
  HAL_PIN(bar) = 0.0;

  //feedback comps
  #include "comps/term.comp"
  #include "comps/sim.comp"
  #include "comps/sixstep.comp"

  //command comps

  //PID

  hal_set_comp_type("net");
  HAL_PIN(enable) = 0.0;
  HAL_PIN(cmd) = 0.0;
  HAL_PIN(rt_calc_time) = 0.0;
  HAL_PIN(frt_calc_time) = 0.0;
  HAL_PIN(nrt_calc_time) = 0.0;
  HAL_PIN(rt_period) = 0.0;
  HAL_PIN(frt_period) = 0.0;
  HAL_PIN(nrt_period) = 0.0;

  // Was macht das?
  nrt_time_hal_pin = hal_map_pin("net0.nrt_calc_time");
  rt_time_hal_pin = hal_map_pin("net0.rt_calc_time");
  frt_time_hal_pin = hal_map_pin("net0.frt_calc_time");
  nrt_period_time_hal_pin = hal_map_pin("net0.nrt_period");
  rt_period_time_hal_pin = hal_map_pin("net0.rt_period");
  frt_period_time_hal_pin = hal_map_pin("net0.frt_period");

  hal_comp_init();

  // Make some inits
  hal_set_pin("term0.rt_prio", 15.0);
  hal_set_pin("sim0.rt_prio", 14.0);
  //hal_set_pin("sixstep0.rt_prio", 13.0);
 //hal_link_pins("conf0.cmd_rev", "rev0.rev");

  if(bal.pin_errors + bal.comp_errors == 0){
     hal_start();
  }
  else{
     bal.hal_state = MEM_ERROR;
  }

  chThdCreateStatic(waThreadNRT, sizeof(waThreadNRT), NORMALPRIO-20, ThreadNRT, NULL);

    // Main loop
    while (true) {
	chThdSleepMilliseconds(1);
    //if (palReadPad(GPIOA, GPIOA_BUTTON))
    //  TestThread(&SD2);
	//palSetPad(BANK_LED_RED, PIN_LED_RED);       /* Orange.  */
	//palSetPad(BANK_LED_GREEN, PIN_LED_GREEN);
	//palSetPad(BANK_LED_ORANGE_DISCO, PIN_LED_ORANGE_DISCO);
	//chprintf(&SDU1,"Hallo %f\n", testfloat);

	len = streamRead(&SDU1, (uint8_t*)usb_rx_buf_raw, 1);
	VCP_DataRx(usb_rx_buf_raw, len);

	//usb_put_buffer(0, 0, testtext, 5);
	//printf("Hallo\n");
	//palClearPad(BANK_LED_RED, PIN_LED_RED);     /* Orange.  */
	//palClearPad(BANK_LED_GREEN, PIN_LED_GREEN);
	//palClearPad(BANK_LED_ORANGE_DISCO, PIN_LED_ORANGE_DISCO);
  }
}
