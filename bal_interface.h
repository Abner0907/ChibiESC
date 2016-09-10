/*
 * bal_interface.h
 *
 *  Created on: 26.08.2016
 *      Author: joerg
 */

#ifndef BAL_INTERFACE_H_
#define BAL_INTERFACE_H_

#include <stdint.h>
#include "chconf.h"

#define printf(msg, ...) chprintf(&SDU1, msg, ## __VA_ARGS__)


void hal_conf_init();
int USB_CDC_is_connected();


#endif /* BAL_INTERFACE_H_ */
