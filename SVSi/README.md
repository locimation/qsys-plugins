# SVSi Control Plugins

A collection of plugins for controlling SVSi devices.

## SVSi Decoder
This plugin uses the "Direct Control" API to control a 1000, 2000 or 3000 series decoder.

It provides control of the audio and video streams, LocalPlay, and AV mutes.

It also provides Infrared control of an attached device via a Presto code input and *Send* trigger input.

### Please note
This is an *authoritative* plugin, meaning that any settings set by Q-Sys in the plugin (such as stream number) will be actively enforced by means of polling and correction.

This means that any other system attempting to control the decoder (such as an 8000-series controller, or the built-in web interface) will rapidly be overriden by the plugin.

To *disable* this behaviour, a plugin boolean property named _"authoritative"_ can be set _false_ to have the plugin track the changes but don't override them.
