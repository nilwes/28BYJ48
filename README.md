# Stepper Motor

A driver for the 28BYJ-48, using a VMA401 - ULN2003 interface 
board to drive the stepper. The 28BYJ-48 motor is a 4-phase, 
8-beat motor, geared down by a factor of 64. One revolution is
512 steps. One bipolar winding is on motor pins 1 & 3 and the 
other on motor pins 2 & 4. 

## Usage

A simple usage example.

```
import math

main:
  my_motor := stepper_motor 15 16 17 18
  
  10.repeat:
    my_motor.rotate_degrees -90.5 2
    my_motor.rotate_degrees 90.5 2
    my_motor.rotate_radians -math.PI 1
    my_motor.rotate_radians 2*math.PI 1
    my_motor.rotate_gradians 100 1
    
    10.repeat:
      my_motor.take_step_cw
    512.repeat: // Full revolution
      my_motor.take_step_ccw
```

See the `examples` folder for more examples.

## Technical Specifications - 28BYJ-48

```
Rated Voltage: 5V DC
Number of Phases: 4
Stride Angle: 5.625°/64
Pull in torque: 300 gf.cm
Insulated Power: 600VAC/1mA/1s
Coil: Unipolar 5 lead coil
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/nilwes/28BYJ-48/issues
