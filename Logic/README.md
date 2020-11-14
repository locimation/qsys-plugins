# Q-Sys Logic Plugins

A collection of Q-Sys plugins for control logic applications.

## Stepper

This plugin provides extends a trigger input into a sequence of momentary pulses.

Features:
 - Adjustable pulse duration
 - Adjustable delay before each pulse
 - Fractional progress output (0.0 - 1.0) for on-screen progress bars
 - Variable number of steps (specified in plugin properties)
 - Total time output, for use in external calculations

*Note:* The minimum pulse duration is 100ms.

## FSM (Finite State Machine)

This Q-Sys Lua plugin implements a finite state machine.

It accepts trigger inputs and will change state if the transition is permitted.

The permitted transitions may be defined in 
one of four modes:

 - Sequential (with optional loop around)
 - Allow from states
 - Allow to states
 - Allow all transitions

Tested on Q-Sys v8.0
