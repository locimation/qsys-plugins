# Q-Sys Logic Plugins

A collection of Q-Sys plugins for control logic applications.

## Match

This plugin performs comparison between an input string and any number of "search" strings, outputting a boolean result.

Typical uses include checking that a string is not empty, and fanning-out a single Q-Sys control's value to multiple boolean outputs (e.g. for UCI layer toggles or snapshot triggers).

In the properties, the number of matches to be tested ("Match Count") may be set - it defaults to one, for a single comparison.

Comparisons may be exact, or may use Lua's pattern-matching syntax.
See [Programming in Lua, 20.2 - Patterns](https://www.lua.org/pil/20.2.html).

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
