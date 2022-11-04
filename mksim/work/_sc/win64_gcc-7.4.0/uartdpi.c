/**
 * SPDX-License-Identifier: Apache-2.0
 *
 * Copyright 2016 by the authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//#include <pty.h>
//#include <printf.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

void* uartdpi_create(/*const char *name*/) {
  putchar('b');
  putchar('u');
  putchar('g');
  putchar('r');
  putchar('a');
}

int uartdpi_can_read(void* obj) {
  return 0;
}

char uartdpi_read(void* obj) {
 return 0x41;
}

void uartdpi_write(void* obj, char c) {
 return;
}
