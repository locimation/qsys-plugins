--[[

  Q-Sys Stepper Plugin
  Author: Michael Goodyear
  Email: michael@locimation.com
  Version: 1.0
  
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
  Name = "Locimation~Stepper",
  Version = "1.0",
  Id = "28fd22ad-8698-4c86-93b3-9e719267b726",
  Description = "Initial release",
  ShowDebug = true
};

function GetProperties()
  return {
    {
      Name = "Steps",
      Type = "integer",
      Min  = 1,
      Max = 100,
      Value = 1
    }
  }
end;

function GetControls(props)
  return {

    {
      Name = "Trigger",
      ControlType = "Button",
      ButtonType = "Trigger",
      UserPin = false,
      PinStyle = 'Both'
    },
    {
      Name = "Reset",
      ControlType = "Button",
      ButtonType = "Trigger",
      UserPin = true,
      PinStyle = 'Both'
    },
    {
      Name = "Busy",
      ControlType = "Indicator",
      IndicatorType = "LED",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Bar",
      ControlType = "Knob",
      ControlUnit = "Percent",
      Min = 0,
      Max = 100,
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Total Time",
      ControlType = "Indicator",
      IndicatorType = "Text",
      UserPin = true,
      PinStyle = 'Output'
    },
    {
      Name = "Delay",
      ControlType = "Knob",
      ControlUnit = "Float",
      Min = 0,
      Max = 600,
      UserPin = true,
      PinStyle = 'Both',
      Count = props.Steps.Value
    },
    {
      Name = "Length",
      ControlType = "Knob",
      ControlUnit = "Float",
      Min = 0.1,
      Max = 600,
      UserPin = true,
      PinStyle = 'Both',
      Count = props.Steps.Value
    },
    {
      Name = "Output",
      ControlType = "Indicator",
      IndicatorType = "LED",
      UserPin = true,
      PinStyle = 'Output',
      Count = props.Steps.Value
    }
  };
end;

function GetControlLayout(props)

  local controls = {};

  controls['Busy'] = {
    Position = {0,0},
    Legend = "Running",
    Style = "Button",
    ButtonStyle = ""
  };

  controls['Bar'] = {
    Position = {0, 16},
    Style = "Meter"
  }

  controls['Trigger'] = {
    Position = {72,0},
    Legend = "Start"
  };

  controls['Reset'] = {
    Position = {72,16},
    Legend = "Reset"
  };

  controls['Total Time'] = {
    Position = {144,16}
  };

  local zOrder = 3;
  for _,n in pairs({'Trigger', 'Reset', 'Busy', 'Bar', 'Total Time'}) do
    controls[n].Size = {72,16};
    controls[n].Margin = 1;
    controls[n].CornerRadius = 2;
  end;

  for i=1,props['Steps'].Value do

    local dStyle = { Position = {i*36+36, 40}, PrettyName = 'Event ' .. i .. '~Delay' };
    local lStyle = { Position = {i*36+36, 57}, PrettyName = 'Event ' .. i .. '~Length' };
    local oStyle = { Position = {i*36+36, 74}, PrettyName = 'Output~' .. i,
      Style = 'Button', Size = {36,16}, Margin = 1,
      Legend = "Active", CornerRadius = 4
    };
    if(props['Steps'].Value == 1) then
      controls['Delay'] = dStyle;
      controls['Length'] = lStyle;
      controls['Output'] = oStyle;
    else
      controls['Delay ' .. i] = dStyle;
      controls['Length ' .. i] = lStyle;
      controls['Output ' .. i] = oStyle;
    end;
  
  end;

  return controls, {
    {
      Position = {144, 0},
      Size = {72,16},
      Type = "Label",
      Text = "Total Time"
    },
    {
      Position = {0, 40},
      Size = {72,16},
      Type = "Label",
      Text = "Delay (s)",
      HTextAlign = "Left"
    },
    {
      Position = {0, 57},
      Size = {72,16},
      Type = "Label",
      Text = "Length (s)",
      HTextAlign = "Left"
    }
  };

end;

if(not Controls) then return; end;

TICK = 0.01;

Ctls = {};
for n,c in pairs(Controls) do
  if(type(c) ~= 'table') then c = {c}; end;
  Ctls[n] = c;
end;

TIME = math.maxinteger;

T = Timer.New();
T.EventHandler = function()
  local sTime, eTime = 0,0;
  for i,c in pairs(Ctls.Output) do
    sTime = eTime + Ctls.Delay[i].Value;
    eTime = sTime + Ctls.Length[i].Value;
    Ctls.Output[i].Boolean = (TIME >= sTime and TIME < eTime);;
  end;
  Controls.Busy.Boolean = (TIME <= eTime);
  Controls.Bar.Position = (TIME ~= math.maxinteger) and (TIME / eTime) or 0;
  Controls['Total Time'].String = string.format('%.2f', eTime);
  if(TIME <= eTime) then
    TIME = TIME + TICK;
  else
    TIME = math.maxinteger;
  end;
end; T:Start(TICK);

Controls['Trigger'].EventHandler = function()
  TIME = 0;
end;

Controls['Reset'].EventHandler = function()
  TIME = math.maxinteger;
  for _,c in pairs(Ctls.Output) do c.Boolean = false; end;
  Controls.Busy.Boolean = false;
  Controls.Bar.Value = 0;
end;