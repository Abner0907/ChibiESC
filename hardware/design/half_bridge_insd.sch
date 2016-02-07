EESchema Schematic File Version 2
LIBS:BLDC_4-rescue
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:crf_1
LIBS:pkl_sensor
LIBS:pkl_drmos
LIBS:pkl_misc
LIBS:DrChibi-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 6
Title "DrMOS power stage"
Date "2016-01-22"
Rev "0.1"
Comp ""
Comment1 "DrMOS power stage"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 4100 4100 0    60   Input ~ 0
PWM
Text HLabel 4100 4000 0    60   Input ~ 0
DSBL
$Comp
L C Cboot1
U 1 1 55DF8D4F
P 6900 3700
AR Path="/55DB7E47/55DF8D4F" Ref="Cboot1"  Part="1" 
AR Path="/55E59DEF/55DF8D4F" Ref="C?"  Part="1" 
AR Path="/55E6829E/55DF8D4F" Ref="C23"  Part="1" 
AR Path="/55E631D7/55DF8D4F" Ref="C21"  Part="1" 
F 0 "Cboot1" V 6647 3700 50  0000 C CNN
F 1 "0.47uF" V 6739 3700 50  0000 C CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 6938 3550 30  0001 C CNN
F 3 "" H 6900 3700 60  0000 C CNN
	1    6900 3700
	0    1    1    0   
$EndComp
$Comp
L C CDrGate1
U 1 1 55DF8D84
P 4950 2900
AR Path="/55DB7E47/55DF8D84" Ref="CDrGate1"  Part="1" 
AR Path="/55E59DEF/55DF8D84" Ref="C?"  Part="1" 
AR Path="/55E6829E/55DF8D84" Ref="C22"  Part="1" 
AR Path="/55E631D7/55DF8D84" Ref="C20"  Part="1" 
F 0 "CDrGate1" H 5065 2946 50  0000 L CNN
F 1 "0.47uF" H 5065 2854 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 4988 2750 30  0001 C CNN
F 3 "" H 4950 2900 60  0000 C CNN
	1    4950 2900
	1    0    0    -1  
$EndComp
Text HLabel 7800 4500 2    60   Output ~ 0
SENSV
Text HLabel 8750 2650 2    60   Output ~ 0
SENSC
$Comp
L ACS711 Usens1
U 1 1 56984538
P 7850 3550
F 0 "Usens1" V 7797 2922 60  0000 R CNN
F 1 "ACS711" V 7903 2922 60  0000 R CNN
F 2 "Allegro:QFN-12-1EX_3x3mm_Pitch0.5mm" V 7956 2922 60  0001 R CNN
F 3 "" H 7700 3750 60  0000 C CNN
	1    7850 3550
	0    -1   1    0   
$EndComp
$Comp
L DrMOS_SiC632A UDrmos1
U 1 1 56A19C85
P 5850 4000
F 0 "UDrmos1" H 5650 5071 50  0000 C CNN
F 1 "DrMOS_SiC632A" H 5650 4979 50  0000 C CNN
F 2 "DrMOS:MLP55-31L" H 5650 4887 50  0000 C CNN
F 3 "" H 5850 3800 50  0000 C CNN
	1    5850 4000
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR35
U 1 1 56A2AE4F
P 5750 5050
F 0 "#PWR35" H 5750 4850 50  0001 C CNN
F 1 "GNDPWR" H 5750 4900 50  0000 C CNN
F 2 "" H 5750 5000 50  0000 C CNN
F 3 "" H 5750 5000 50  0000 C CNN
	1    5750 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 4800 6050 4800
Connection ~ 5850 4800
Connection ~ 5900 4800
Connection ~ 5950 4800
Connection ~ 6000 4800
Wire Wire Line
	5750 5050 5750 4800
$Comp
L GND #PWR32
U 1 1 56A2B769
P 5200 5000
F 0 "#PWR32" H 5200 4750 50  0001 C CNN
F 1 "GND" H 5208 4826 50  0000 C CNN
F 2 "" H 5200 5000 50  0000 C CNN
F 3 "" H 5200 5000 50  0000 C CNN
	1    5200 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 5000 5200 4800
Wire Wire Line
	5200 4800 5300 4800
$Comp
L GNDPWR #PWR31
U 1 1 56A2BBEE
P 4950 3200
F 0 "#PWR31" H 4950 3000 50  0001 C CNN
F 1 "GNDPWR" H 4957 3275 50  0000 C CNN
F 2 "" H 4950 3150 50  0000 C CNN
F 3 "" H 4950 3150 50  0000 C CNN
	1    4950 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 3200 4950 3050
Wire Wire Line
	4300 2750 5300 2750
Wire Wire Line
	5300 2750 5300 3200
$Comp
L C CDrLogic1
U 1 1 56A2CDC4
P 4300 3400
F 0 "CDrLogic1" H 4415 3446 50  0000 L CNN
F 1 "2.2uF" H 4415 3354 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4338 3250 30  0001 C CNN
F 3 "" H 4300 3400 60  0000 C CNN
	1    4300 3400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR30
U 1 1 56A2CDEC
P 4300 3550
F 0 "#PWR30" H 4300 3300 50  0001 C CNN
F 1 "GND" H 4308 3376 50  0000 C CNN
F 2 "" H 4300 3550 50  0000 C CNN
F 3 "" H 4300 3550 50  0000 C CNN
	1    4300 3550
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR29
U 1 1 56A2CF9B
P 4300 2650
F 0 "#PWR29" H 4300 2500 50  0001 C CNN
F 1 "+5V" H 4318 2824 50  0000 C CNN
F 2 "" H 4300 2650 50  0000 C CNN
F 3 "" H 4300 2650 50  0000 C CNN
	1    4300 2650
	1    0    0    -1  
$EndComp
$Comp
L R RDrLogic1
U 1 1 56A2D0BC
P 4300 2900
F 0 "RDrLogic1" H 4370 2946 50  0000 L CNN
F 1 "R" H 4370 2854 50  0000 L CNN
F 2 "Resistors_SMD:R_0603" V 4230 2900 50  0001 C CNN
F 3 "" H 4300 2900 50  0000 C CNN
	1    4300 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 2650 4300 2750
Connection ~ 4950 2750
Wire Wire Line
	4300 3050 4300 3250
Text HLabel 4100 4200 0    60   BiDi ~ 0
THWn
Wire Wire Line
	4100 4000 4650 4000
Wire Wire Line
	4100 4100 4650 4100
Wire Wire Line
	4100 4200 4650 4200
Wire Wire Line
	6650 3700 6750 3700
Wire Wire Line
	7050 3700 7050 3850
Wire Wire Line
	7050 3850 6650 3850
Wire Wire Line
	7350 3150 7350 2650
$Comp
L GND #PWR39
U 1 1 56A2EFF6
P 8550 3050
F 0 "#PWR39" H 8550 2800 50  0001 C CNN
F 1 "GND" H 8558 2876 50  0000 C CNN
F 2 "" H 8550 3050 50  0000 C CNN
F 3 "" H 8550 3050 50  0000 C CNN
	1    8550 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 2950 8350 3150
Connection ~ 8350 3050
Text HLabel 7850 2500 2    60   BiDi ~ 0
FAULTC
Wire Wire Line
	6650 4000 7550 4000
Wire Wire Line
	7550 4000 7550 3950
Connection ~ 7450 4000
Wire Wire Line
	6650 4000 6650 4500
Connection ~ 6650 4050
Connection ~ 6650 4100
Connection ~ 6650 4150
Connection ~ 6650 4200
Connection ~ 6650 4250
Connection ~ 6650 4300
Connection ~ 6650 4350
Connection ~ 6650 4400
Connection ~ 6650 4450
$Comp
L R Rhsens1
U 1 1 56A2FD69
P 7450 4300
F 0 "Rhsens1" H 7520 4346 50  0000 L CNN
F 1 "10k" H 7520 4254 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" V 7380 4300 50  0001 C CNN
F 3 "" H 7450 4300 50  0000 C CNN
	1    7450 4300
	1    0    0    -1  
$EndComp
$Comp
L R Rlsens1
U 1 1 56A2FEAC
P 7450 4700
F 0 "Rlsens1" H 7520 4746 50  0000 L CNN
F 1 "2k2" H 7520 4654 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" V 7380 4700 50  0001 C CNN
F 3 "" H 7450 4700 50  0000 C CNN
	1    7450 4700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR38
U 1 1 56A30067
P 7450 4950
F 0 "#PWR38" H 7450 4700 50  0001 C CNN
F 1 "GND" H 7458 4776 50  0000 C CNN
F 2 "" H 7450 4950 50  0000 C CNN
F 3 "" H 7450 4950 50  0000 C CNN
	1    7450 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7450 4950 7450 4850
Wire Wire Line
	7450 4550 7450 4450
Wire Wire Line
	7800 4500 7450 4500
Connection ~ 7450 4500
Wire Wire Line
	8150 4000 8850 4000
Wire Wire Line
	8250 3950 8250 4150
Wire Wire Line
	8150 3950 8150 4000
Connection ~ 8250 4000
$Comp
L +24V #PWR36
U 1 1 56A31D68
P 6050 3000
F 0 "#PWR36" H 6050 2850 50  0001 C CNN
F 1 "+24V" H 6068 3174 50  0000 C CNN
F 2 "" H 6050 3000 50  0000 C CNN
F 3 "" H 6050 3000 50  0000 C CNN
	1    6050 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 3200 6050 3000
Wire Wire Line
	5850 3200 6050 3200
Connection ~ 6000 3200
Connection ~ 5950 3200
Connection ~ 5900 3200
$Comp
L +3.3V #PWR37
U 1 1 56A32138
P 7350 2650
F 0 "#PWR37" H 7350 2500 50  0001 C CNN
F 1 "+3.3V" H 7368 2824 50  0000 C CNN
F 2 "" H 7350 2650 50  0000 C CNN
F 3 "" H 7350 2650 50  0000 C CNN
	1    7350 2650
	1    0    0    -1  
$EndComp
Text Notes 8700 2900 0    60   ~ 0
VIOUT muss mit min 15kOhm und max 1nF nach GND
$Comp
L R Rcfilt1
U 1 1 56A3225A
P 8350 2800
F 0 "Rcfilt1" H 8420 2846 50  0000 L CNN
F 1 "R" H 8420 2754 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" V 8280 2800 50  0001 C CNN
F 3 "" H 8350 2800 50  0000 C CNN
	1    8350 2800
	1    0    0    -1  
$EndComp
$Comp
L C Ccfilt1
U 1 1 56A3233B
P 8050 2800
F 0 "Ccfilt1" H 8165 2846 50  0000 L CNN
F 1 "C" H 8165 2754 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 8088 2650 50  0001 C CNN
F 3 "" H 8050 2800 50  0000 C CNN
	1    8050 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 3150 7750 2650
Wire Wire Line
	7750 2650 8750 2650
Connection ~ 8050 2650
Connection ~ 8350 2650
Wire Wire Line
	7550 3150 7550 2500
Wire Wire Line
	7550 2500 7850 2500
Wire Wire Line
	4650 3800 4650 3250
Wire Wire Line
	4650 3250 4300 3250
Text HLabel 4100 3900 0    60   Input ~ 0
ZCD_EN
Wire Wire Line
	4100 3900 4650 3900
$Comp
L +24V #PWR33
U 1 1 56A69AD2
P 5750 950
F 0 "#PWR33" H 5750 800 50  0001 C CNN
F 1 "+24V" H 5768 1124 50  0000 C CNN
F 2 "" H 5750 950 50  0000 C CNN
F 3 "" H 5750 950 50  0000 C CNN
	1    5750 950 
	1    0    0    -1  
$EndComp
$Comp
L C CDrHV1
U 1 1 56A69B0E
P 5750 1200
F 0 "CDrHV1" H 5865 1246 50  0000 L CNN
F 1 "10u" H 5865 1154 50  0000 L CNN
F 2 "Capacitors_SMD:C_1206" H 5788 1050 50  0001 C CNN
F 3 "" H 5750 1200 50  0000 C CNN
	1    5750 1200
	1    0    0    -1  
$EndComp
$Comp
L GNDPWR #PWR34
U 1 1 56A69BA7
P 5750 1500
F 0 "#PWR34" H 5750 1300 50  0001 C CNN
F 1 "GNDPWR" H 5757 1575 50  0000 C CNN
F 2 "" H 5750 1450 50  0000 C CNN
F 3 "" H 5750 1450 50  0000 C CNN
	1    5750 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 1500 5750 1350
Text Notes 6250 3250 0    60   ~ 0
Rboot can be used to\nslow down high side\nFET. (1-5ohm)
Text Notes 7850 4900 0    60   ~ 0
SENSV = Rlsens / (Rlsens+Rhsens)\nMust be below 4V to protect the input pin of STM32F4.\nIs 3.8V for Rl=2k2 and Rh=10k
Text Label 5750 4950 0    60   ~ 0
PWRGND
Text Label 5000 4950 0    60   ~ 0
GND
$Comp
L C CDrHVs1
U 1 1 56AF6D20
P 5200 1200
F 0 "CDrHVs1" H 5315 1246 50  0000 L CNN
F 1 "0.47u" H 5315 1154 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5315 1108 50  0001 L CNN
F 3 "" H 5200 1200 50  0000 C CNN
	1    5200 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 1050 5750 950 
Wire Wire Line
	5200 1050 5200 1000
Wire Wire Line
	5200 1000 5750 1000
Connection ~ 5750 1000
Wire Wire Line
	5200 1350 5200 1400
Wire Wire Line
	5200 1400 5750 1400
Connection ~ 5750 1400
Wire Wire Line
	8050 3050 8550 3050
Wire Wire Line
	8050 2950 8050 3050
Wire Wire Line
	7450 3950 7450 4000
Wire Wire Line
	8250 4150 7450 4150
$Comp
L PAD_SMD PMotor1
U 1 1 56B30AD6
P 9050 4000
F 0 "PMotor1" H 9177 4106 60  0000 L CNN
F 1 "PAD_SMD" H 9177 4000 60  0000 L CNN
F 2 "CRF1:1PAD_4x5mm" H 9177 3894 60  0000 L CNN
F 3 "" H 9050 3850 60  0000 C CNN
	1    9050 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	8250 3150 8250 3100
Wire Wire Line
	8250 3100 7350 3100
Connection ~ 7350 3100
Wire Wire Line
	8150 3150 8150 3100
Connection ~ 8150 3100
$EndSCHEMATC
