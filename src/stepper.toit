// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be found
// in the LICENSE file.

import gpio
import math

class stepper_motor:
  static STEPS_PER_REV_  ::= 512           // number of steps per full revolution
  static STEP_ANGLE_     ::= 360.0 / STEPS_PER_REV_ // = 0.703125 degrees
  static COIL_SEQUENCES_ ::= [0b1000, 0b1100, 0b0100, 0b0110, 0b0010, 0b0011, 0b0001, 0b1001] // Half-step switching sequence
  motor_pin_1_ := ?
  motor_pin_2_ := ?
  motor_pin_3_ := ?
  motor_pin_4_ := ?

  constructor pin_1/int pin_2/int pin_3/int pin_4/int:
    motor_pin_1_ = gpio.Pin.out pin_1
    motor_pin_2_ = gpio.Pin.out pin_2
    motor_pin_3_ = gpio.Pin.out pin_3
    motor_pin_4_ = gpio.Pin.out pin_4

  rotate_degrees deg/any speed/int:
    i := 0
    steps := (deg.abs / STEP_ANGLE_ * 8).to_int
    if deg > 0:
      for i = 0 ; i < steps ; i++:
        set_output_ i%8
        sleep --ms=speed
    else: 
      for i = steps ; i > 0 ; i--:
        set_output_ i%8
        sleep --ms=speed

  rotate_radians rad/any speed/int:
    deg := rad * (180 / math.PI)
    rotate_degrees deg speed
  
  rotate_gradians grad/any speed/int:
    deg := grad * 0.9
    rotate_degrees deg speed
  
  rotate_gon gon/any speed/int:
    rotate_gradians gon speed
  
  take_step_cw:
    i := 0
    for i = 0 ; i < 7 ; i++:
      set_output_ i
      sleep --ms=1
  
  take_step_ccw:
    i := 0
    for i = 7 ; i >= 0 ; i--:
      set_output_ i
      sleep --ms=1
  
  set_output_ out/int:
    motor_pin_1_.set (COIL_SEQUENCES_[out] & 0x01)
    motor_pin_2_.set (COIL_SEQUENCES_[out] & 0x02)
    motor_pin_3_.set (COIL_SEQUENCES_[out] & 0x04)
    motor_pin_4_.set (COIL_SEQUENCES_[out] & 0x08)