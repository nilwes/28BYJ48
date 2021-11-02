// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be found
// in the LICENSE file.

// This example demonstrates bidirectional operation of a
// 28BYJ-48, using a VMA401 - ULN2003 interface board to drive the stepper.
// The 28BYJ-48 motor is a 4-phase, 8-beat motor, geared down by
// a factor of 64. One bipolar winding is on motor pins 1 & 3 and
// the other on motor pins 2 & 4. 

import .stepper
import math

main:
  my_motor := stepper_motor 15 16 17 18

  my_motor.rotate_degrees -90.5 2
  my_motor.rotate_degrees 90.5 2
  my_motor.rotate_radians -math.PI 1
  my_motor.rotate_radians 2*math.PI 1
  my_motor.rotate_gradians 100 1
  my_motor.rotate_gradians -100 1
  my_motor.rotate_gon -100.5 1
  my_motor.rotate_gon 100.5 1
  sleep --ms=1000
  10.repeat:
    my_motor.take_step_cw
  sleep --ms=500
  512.repeat: // Full revolution
    my_motor.take_step_ccw
