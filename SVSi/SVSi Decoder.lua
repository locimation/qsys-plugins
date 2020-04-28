--[[

  SVSi Decoder Q-Sys Plugin
  Author: Michael Goodyear
  Email: michael@locimation.com
  Version: 1.3
  
  Copyright 2020 Locimation Pty Ltd

  Permission is hereby granted, free of charge,
  to any person obtaining a copy of this software
  and associated documentation files (the "Software"),
  to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify,
  merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom
  the Software is furnished to do so, subject to the
  following conditions:

  The above copyright notice and this permission
  notice shall be included in all copies or substantial
  portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY
  OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
  EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
  AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  OTHER DEALINGS IN THE SOFTWARE.

]]

PluginInfo = {
  Name = "SVSi Decoder v1.4",
  Version = "1.3.1",
  Id = "9d3fa871-0c9e-4bf3-85bc-f70656f4b5c4",
  Description = "Added suthoritative property and subsequent functions",
  ShowDebug = false
}

function GetColor()
  return {0,0,0}; -- black
end;

function GetProperties()
  local props = {}

  table.insert(props,{
    Name = "authoritative",
    Type = "boolean", 
    Value = "true",
  })

  return props;
end;

function GetControls(props)
  local controls = {

    {
      Name = "Video Mute",
      ControlType = "Button",
      ButtonType = "Toggle",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Audio Mute",
      ControlType = "Button",
      ButtonType = "Toggle",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Video Stream",
      ControlType = "Text",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Audio Stream",
      ControlType = "Text",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Audio Follow",
      ControlType = "Button",
      ButtonType = "Toggle",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Left Gain",
      ControlType = "Knob",
      ControlUnit = "Integer",
      Min = 0,
      Max = 100,
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Right Gain",
      ControlType = "Knob",
      ControlUnit = "Integer",
      Min = 0,
      Max = 100,
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Local Playback",
      ControlType = "Button",
      ButtonType = "Toggle",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Local Playlist",
      ControlType = "Text",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Unit Type",
      ControlType = "Indicator",
      IndicatorType = "Text",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Serial",
      ControlType = "Indicator",
      IndicatorType = "Text",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Name",
      ControlType = "Indicator",
      IndicatorType = "Text",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "SW Version",
      ControlType = "Indicator",
      IndicatorType = "Text",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Video Muted",
      ControlType = "Indicator",
      IndicatorType = "Led",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Current Video Source",
      ControlType = "Indicator",
      IndicatorType = "Text",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Current Audio Source",
      ControlType = "Indicator",
      IndicatorType = "Text",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Display Connected",
      ControlType = "Indicator",
      IndicatorType = "Led",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Current Resolution",
      ControlType = "Indicator",
      IndicatorType = "Text",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Audio Muted",
      ControlType = "Indicator",
      IndicatorType = "Led",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "IP",
      ControlType = "Text",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Status",
      ControlType = "Indicator",
      IndicatorType = "Status",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "IR Code",
      ControlType = "Indicator",
      IndicatorType = "Text",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "IR Send",
      ControlType = "Button",
      ButtonType = "Trigger",
      UserPin = true,
      PinStyle = 'Both'
    }

  }

  return controls;

end;

function GetControlLayout(props)

  local controls = {};

  -- tuck away IR
  controls['IR Code'] = {
    Position = {123,89},
    Size = {2,2},
    PrettyName = "Infrared~Code (Presto)"
  }
  controls['IR Send'] = {
    Position = {123,89},
    Size = {2,2},
    PrettyName = "Infrared~Send"
  }


  controls['Video Stream'] = {
    Position = {123,89},
    Size = {123,16},
    PrettyName = "Stream~Video"
  }
  controls['Audio Stream'] = {
    Position = {123,105},
    Size = {61,16},
    PrettyName = "Stream~Audio"
  }
  controls['Audio Follow'] = {
    Position = {184,105},
    Size = {61,16},
    Margin = 1,
    Legend = 'Follow',
    PrettyName = "Stream~Audio Follow Video"
  }

  controls['Local Playback'] = {
    Position = {123,155},
    Size = {123,16},
    Margin = 1,
    Legend = 'Enable',
    PrettyName = "LocalPlay~Enable"
  }
  controls['Local Playlist'] = {
    Position = {123,171},
    Size = {123,16},
    Style = 'ComboBox',
    PrettyName = "LocalPlay~Playlist"
  }

  controls['Current Video Source'] = {
    Position = {123,223},
    Size = {123,16},
    PrettyName = "Stream~Video Selected"
  }
  controls['Current Audio Source'] = {
    Position = {123,239},
    Size = {123,16},
    PrettyName = "Stream~Audio Selected"
  }

  controls['Video Mute'] = {
    Position = {397,88},
    Size = {107,16},
    Legend = 'Mute',
    Color = {255,0,0},
    PrettyName = "Mute~Mute Video"
  }
  controls['Audio Mute'] = {
    Position = {397,104},
    Size = {107,16},
    Legend = 'Mute',
    Color = {255,0,0},
    PrettyName = "Mute~Mute Audio"
  }
  controls['Video Muted'] = {
    Position = {504,88},
    Size = {16,16},
    Color = {255,0,0},
    PrettyName = "Mute~Video Muted"
  }
  controls['Audio Muted'] = {
    Position = {504,104},
    Size = {16,16},
    Color = {255,0,0},
    PrettyName = "Mute~Audio Muted"
  }

  controls['Left Gain'] = {
    Position = {397,154},
    Size = {123,16},
    Color = {153, 153,153},
    Style = 'Text',
    TextBoxStyle = 'Meter',
    PrettyName = "Gain~Left"
  }
  controls['Right Gain'] = {
    Position = {397,170},
    Size = {123,16},
    Color = {153, 153,153},
    Style = 'Text',
    TextBoxStyle = 'Meter',
    PrettyName = "Gain~Right"
  }

  controls['Display Connected'] = {
    Position = {397,222},
    Style = 'Button',
    Size = {123,16},
    Color = {255,255,255},
    Legend = 'Unknown',
    Margin = 2,
    PrettyName = "Display~Connected"
  }
  controls['Current Resolution'] = {
    Position = {397,238},
    Size = {123,16},
    PrettyName = "Display~Resolution"
  }

  controls['IP'] = {
    Position = {671,122},
    Size = {123,16},
    PrettyName = "Device~IP"
  }
  controls['Status'] = {
    Position = {671,138},
    Size = {123,16},
    PrettyName = "Device~Status"
  }

  controls['Unit Type'] = {
    Position = {671,188},
    Size = {123,16},
    PrettyName = "Device~Type"
  }
  controls['Serial'] = {
    Position = {671,204},
    Size = {123,16},
    PrettyName = "Device~Serial"
  }
  controls['Name'] = {
    Position = {671,220},
    Size = {123,16},
    PrettyName = "Device~Name"
  }
  controls['SW Version'] = {
    Position = {671,236},
    Size = {123,16},
    PrettyName = "Device~Software Version"
  }



  local graphics={



    {
      Type = 'GroupBox',
      Fill = {0,0,0},
      StrokeWidth = 0,
      Position = {0,0},
      Size = {844,299},
      CornerRadius = 0
    },

    {
      Type = 'GroupBox',
      Fill = {51,51,51},
      StrokeWidth = 1,
      StrokeColor = {0,0,0},
      Position = {21,56},
      Size = {255,219},
      CornerRadius = 8
    },
    {
      Type = 'GroupBox',
      Fill = {51,51,51},
      StrokeWidth = 1,
      StrokeColor = {0,0,0},
      Position = {294,56},
      Size = {255,219},
      CornerRadius = 8
    },
    {
      Type = 'GroupBox',
      Fill = {51,51,51},
      StrokeWidth = 1,
      StrokeColor = {0,0,0},
      Position = {568,88},
      Size = {255,187},
      CornerRadius = 8
    },

    {
      Type = 'Label',
      Text = 'SVSi Decoder',
      TextSize = 36,
      Position = {568,15},
      Size = {255,41},
      IsBold = true,
      HTextAlign = 'Right',
      Color = {255,255,255}
    },

    {
      Type = 'Label',
      Text = 'Input',
      TextSize = 12,
      Position = {34,37},
      Size = {242,19},
      IsBold = true,
      HTextAlign = 'Left',
      Color = {255,255,255}
    },
    {
      Type = 'Label',
      Text = 'Input',
      TextSize = 12,
      Position = {34,37},
      Size = {242,19},
      IsBold = true,
      HTextAlign = 'Left',
      Color = {255,255,255}
    },
    {
      Type = 'Label',
      Text = 'Output',
      TextSize = 12,
      Position = {307,37},
      Size = {242,19},
      IsBold = true,
      HTextAlign = 'Left',
      Color = {255,255,255}
    },
    {
      Type = 'Label',
      Text = 'Device',
      TextSize = 12,
      Position = {581,69},
      Size = {242,19},
      IsBold = true,
      HTextAlign = 'Left',
      Color = {255,255,255}
    },

    {
      Type = 'Label',
      Text = 'Video Stream',
      TextSize = 12,
      Position = {46,89},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Audio Stream',
      TextSize = 12,
      Position = {46,105},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Live / Local',
      TextSize = 12,
      Position = {46,155},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Local Playlist',
      TextSize = 12,
      Position = {46,171},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Video Source',
      TextSize = 12,
      Position = {46,223},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Audio Source',
      TextSize = 12,
      Position = {46,239},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },

    {
      Type = 'Label',
      Text = 'Video Mute',
      TextSize = 12,
      Position = {320,88},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Audio Mute',
      TextSize = 12,
      Position = {320,104},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Left Gain',
      TextSize = 12,
      Position = {320,154},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Right Gain',
      TextSize = 12,
      Position = {320,170},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Display',
      TextSize = 12,
      Position = {320,222},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Resolution',
      TextSize = 12,
      Position = {320,238},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },

    {
      Type = 'Label',
      Text = 'IP',
      TextSize = 12,
      Position = {594,122},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Status',
      TextSize = 12,
      Position = {594,138},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },

    {
      Type = 'Label',
      Text = 'Unit Type',
      TextSize = 12,
      Position = {594,188},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Serial',
      TextSize = 12,
      Position = {594,204},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'Name',
      TextSize = 12,
      Position = {594,220},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },
    {
      Type = 'Label',
      Text = 'SW Version',
      TextSize = 12,
      Position = {594,236},
      Size = {77,16},
      HTextAlign = 'Left',
      Color = {204,204,204}
    },

    {
      Type = 'Header',
      Text = 'Network',
      TextSize = 12,
      Position = {46,72},
      Size = {200,16},
      HTextAlign = 'Center',
      Color = {255,255,255}
    },
    {
      Type = 'Header',
      Text = 'Local',
      TextSize = 12,
      Position = {46,138},
      Size = {200,16},
      HTextAlign = 'Center',
      Color = {255,255,255}
    },
    {
      Type = 'Header',
      Text = 'Information',
      TextSize = 12,
      Position = {46,206},
      Size = {200,16},
      HTextAlign = 'Center',
      Color = {255,255,255}
    },

    {
      Type = 'Header',
      Text = 'Mutes',
      TextSize = 12,
      Position = {320,72},
      Size = {200,16},
      HTextAlign = 'Center',
      Color = {255,255,255}
    },
    {
      Type = 'Audio Gain',
      Text = 'Local',
      TextSize = 12,
      Position = {320,138},
      Size = {200,16},
      HTextAlign = 'Center',
      Color = {255,255,255}
    },
    {
      Type = 'Header',
      Text = 'Status',
      TextSize = 12,
      Position = {320,206},
      Size = {200,16},
      HTextAlign = 'Center',
      Color = {255,255,255}
    },

    {
      Type = 'Communication',
      Text = 'Local',
      TextSize = 12,
      Position = {594,105},
      Size = {200,16},
      HTextAlign = 'Center',
      Color = {255,255,255}
    },
    {
      Type = 'Header',
      Text = 'Information',
      TextSize = 12,
      Position = {594,171},
      Size = {200,16},
      HTextAlign = 'Center',
      Color = {255,255,255}
    },
    {
      Type = 'Image',
      Image = 'iVBORw0KGgoAAAANSUhEUgAAA4QAAAAoCAYAAACmeDQzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAG8WlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNi4wLWMwMDIgNzkuMTY0MzUyLCAyMDIwLzAxLzMwLTE1OjUwOjM4ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgMjEuMSAoV2luZG93cykiIHhtcDpDcmVhdGVEYXRlPSIyMDIwLTAzLTI1VDAzOjU5OjAxKzExOjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMC0wNC0xOVQxNDowODozOSsxMDowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMC0wNC0xOVQxNDowODozOSsxMDowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDowMjRkYTUxZS00NDA0LTIzNDktOGI1Mi1lZTA5NmJkMTc4ZDQiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDozNWYzZWI2YS1lMzYzLWJmNGEtOWJjOS01MTU1NjU1NTVmZGQiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDphYmI1NDFmOS1lOGFlLTBiNDgtYWY4MC0xYThiNGEyOTFhMjkiPiA8cGhvdG9zaG9wOlRleHRMYXllcnM+IDxyZGY6QmFnPiA8cmRmOmxpIHBob3Rvc2hvcDpMYXllck5hbWU9IlByb2R1Y2VkIGJ5ICAgICAgICAgICAgICAgICAgICAgICAgYW5kIGRpc3RyaWJ1dGVkIHVuZGVyIE1JVCBsaSIgcGhvdG9zaG9wOkxheWVyVGV4dD0iUHJvZHVjZWQgYnkgICAgICAgICAgICAgICAgICAgICAgICBhbmQgZGlzdHJpYnV0ZWQgdW5kZXIgTUlUIGxpY2Vuc2UuIi8+IDwvcmRmOkJhZz4gPC9waG90b3Nob3A6VGV4dExheWVycz4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDphYmI1NDFmOS1lOGFlLTBiNDgtYWY4MC0xYThiNGEyOTFhMjkiIHN0RXZ0OndoZW49IjIwMjAtMDMtMjVUMDM6NTk6MDErMTE6MDAiIHN0RXZ0OnNvZnR3YXJlQWdlbnQ9IkFkb2JlIFBob3Rvc2hvcCAyMS4xIChXaW5kb3dzKSIvPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0ic2F2ZWQiIHN0RXZ0Omluc3RhbmNlSUQ9InhtcC5paWQ6MDI0ZGE1MWUtNDQwNC0yMzQ5LThiNTItZWUwOTZiZDE3OGQ0IiBzdEV2dDp3aGVuPSIyMDIwLTA0LTE5VDE0OjA4OjM5KzEwOjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgMjEuMSAoV2luZG93cykiIHN0RXZ0OmNoYW5nZWQ9Ii8iLz4gPC9yZGY6U2VxPiA8L3htcE1NOkhpc3Rvcnk+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3Jk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',
      Size = { 450, 20 },
      Position = { 422-225, 310 }
    }

  };

  return controls,graphics;

end;

if(not Controls) then return; end;

SVSiSocket = TcpSocket.New();

DECODER_STATUS = {};

function updateStatus(code, str)
  Controls['Status'].Value = code;
  Controls['Status'].String = str;
end;

SVSiSocket.ReadTimeout = 2
SVSiSocket.WriteTimeout = 0
SVSiSocket.ReconnectTimeout = 3


SVSiSocket.EventHandler = function(sock, evt)
  if(evt == TcpSocket.Events.Connected) then
    -- connected
  elseif(evt == TcpSocket.Events.Data) then
    local line = sock:ReadLine(TcpSocket.EOL.Any);
    while(line ~= nil) do
      handleFeedback(line);
      line = sock:ReadLine(TcpSocket.EOL.Any);
    end;
    updateStatus(0,'');
    updateDisplay();
    if Properties["Authoritative"].Value == true then
      doDiff();
    else
      simplyUdateControls()
    end
  elseif evt == TcpSocket.Events.Reconnect then
    updateStatus(5, 'Connecting');
  elseif evt == TcpSocket.Events.Closed then
    updateStatus(2, 'Closed by remote');
  elseif evt == TcpSocket.Events.Error then
    updateStatus(2, 'Socket error');
  elseif evt == TcpSocket.Events.Timeout then
    updateStatus(2, 'Timeout');
  end

end;

PollTimer = Timer.New();
PollTimer.EventHandler = function()
  if(not SVSiSocket.IsConnected) then return; end;
  SVSiSocket:Write('?;\r\n');
end;
PollTimer:Start(0.1);

function handleFeedback(line)
  local prop,val = line:match('(.*):(.*)');
  DECODER_STATUS[prop] = val;
end;

function updateDisplay()  
  Controls['Video Muted'].Boolean = DECODER_STATUS['DVIOFF']~='off';
  Controls['Audio Muted'].Boolean = DECODER_STATUS['MUTE']~='0';
  
  local displayConnected = DECODER_STATUS['DVISTATUS']~='disconnected';
  Controls['Display Connected'].Legend = displayConnected and 'Connected' or 'Disconnected';
  Controls['Display Connected'].Color = displayConnected and 'green' or 'darkred';
  Controls['Display Connected'].Boolean = displayConnected;
  
  Controls['Current Resolution'].String = DECODER_STATUS['INPUTRES'];
  
  Controls['Unit Type'].String = DECODER_STATUS['SVSI_RXGEN2']:sub(1,5);
  Controls['Serial'].String = DECODER_STATUS['SVSI_RXGEN2'];
  Controls['Name'].String = DECODER_STATUS['NAME'] and DECODER_STATUS['NAME'] or '';
  Controls['SW Version'].String = DECODER_STATUS['SWVER'];
  
  local isLocalMode = DECODER_STATUS['PLAYMODE']~='live';
  local videoSource =
    isLocalMode and
      'Local Playlist ' .. DECODER_STATUS['PLAYLIST']
    or
      'Network Stream ' .. DECODER_STATUS['STREAM'];
  Controls['Current Video Source'].String = videoSource;
  local audioFollowsVideo = DECODER_STATUS['STREAMAUDIO']=='0';
  Controls['Current Audio Source'].String =
    audioFollowsVideo and videoSource
    or (isLocalMode and 'Local Playlist ' .. DECODER_STATUS['PLAYLIST']
      or 'Network Stream ' .. DECODER_STATUS['STREAMAUDIO']);
  
end;

--[[ Control Handlers ]]
function toggleAudioOption()
  Controls['Audio Stream'].IsDisabled = Controls['Audio Follow'].Boolean;
end;
Controls['Audio Follow'].EventHandler = toggleAudioOption;
toggleAudioOption();

Controls['Local Playlist'].Choices = { '1','2','3','4','5','6','7','8' };

function doDiff()
  
  -- Video stream
  local desiredVideoStream = Controls['Video Stream'].String;
  if(desiredVideoStream~='' and tonumber(desiredVideoStream)~=nil and tonumber(DECODER_STATUS['STREAM'])~=nil) then
    if(tonumber(DECODER_STATUS['STREAM']) ~= tonumber(desiredVideoStream)) then
      SVSiSocket:Write('set:' .. desiredVideoStream .. ';\r\n');
      return;
    end;
  end;
  
  -- Audio stream + follow
  local desiredAudioStream = Controls['Audio Follow'].Boolean and '0' or Controls['Audio Stream'].String;
  if(desiredAudioStream~='' and tonumber(desiredAudioStream)~=nil and tonumber(DECODER_STATUS['STREAMAUDIO'])~=nil) then
    if(tonumber(DECODER_STATUS['STREAMAUDIO']) ~= tonumber(desiredAudioStream)) then
      SVSiSocket:Write('seta:' .. desiredAudioStream .. ';\r\n');
      return;
    end;
  end;    
  
  -- Local playback
  local isLocalMode = DECODER_STATUS['PLAYMODE']~='live';
  if(isLocalMode ~= Controls['Local Playback'].Boolean or (isLocalMode and Controls['Local Playlist'].String ~= DECODER_STATUS['PLAYLIST'])) then
    if(Controls['Local Playback'].Boolean) then
      SVSiSocket:Write('local:' .. Controls['Local Playlist'].String .. ';\r\n');
    else
      SVSiSocket:Write('live;\r\n');
    end;
    return;
  end;
  
  -- Video Mute
  if(Controls['Video Mute'].Boolean ~= (DECODER_STATUS['DVIOFF']~='off')) then
    if(Controls['Video Mute'].Boolean) then
      SVSiSocket:Write('dviOff;\r\n');
    else
      SVSiSocket:Write('dviOn;\r\n');
    end;
    return;
  end;
  
  -- Audio Mute
  if(Controls['Audio Mute'].Boolean ~= (DECODER_STATUS['MUTE']~='0')) then
    if(Controls['Audio Mute'].Boolean) then
      SVSiSocket:Write('mute;\r\n');
    else
      SVSiSocket:Write('unmute;\r\n');
    end;
    return;
  end;
  
  -- Left Gain
  if(DECODER_STATUS['LINEOUTVOL_L']~=Controls['Left Gain'].String) then
    SVSiSocket:Write('lovolleft:'..(Controls['Left Gain'].String)..';\r\n');
    return;
  end;
  
  -- Right Gain
  if(DECODER_STATUS['LINEOUTVOL_R']~=Controls['Right Gain'].String) then
    SVSiSocket:Write('lovolright:'..(Controls['Right Gain'].String)..';\r\n');
    return;
  end;
  
end;

function simplyUdateControls()
  
  -- Video stream
  Controls['Video Stream'].String = DECODER_STATUS['STREAM']
  -- Audio stream + follow
  Controls['Audio Stream'].String = DECODER_STATUS['STREAMAUDIO']
  -- Local playback
  local isLocalMode = DECODER_STATUS['PLAYMODE']~='live';
  Controls['Local Playback'].Boolean = isLocalMode
  if isLocalMode then 
    Controls['Local Playlist'].String = DECODER_STATUS['PLAYLIST']
  else
    Controls['Local Playlist'].String = "n/a"
  end

  -- Video Mute
  Controls['Video Mute'].Boolean = DECODER_STATUS['DVIOFF'] == 'off'
 
  -- Audio Mute
  Controls['Audio Mute'].Boolean = DECODER_STATUS['MUTE'] ~='0'
  
  -- Left Gain
  DECODER_STATUS['LINEOUTVOL_L'] = Controls['Left Gain'].String
  -- Right Gain
  DECODER_STATUS['LINEOUTVOL_R'] = Controls['Right Gain'].String
  
end

-- IR functionality
Controls['IR Send'].EventHandler = function()
  if(not SVSiSocket.IsConnected) then return; end;
  local code = Controls['IR Code'].String:gsub("[^0-9A-Fa-f]", " "):gsub(" +", " ");
  SVSiSocket:Write('sendirraw: '..code..';\r\n');
end;

function updateIP()
  if(SVSiSocket.IsConnected) then SVSiSocket:Disconnect(); end;
  SVSiSocket:Connect(Controls['IP'].String, 50002);
  updateStatus(5, 'Connecting');
end;
updateIP();
Controls['IP'].EventHandler = updateIP;