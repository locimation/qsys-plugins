--[[

  Q-Sys Finite State Machine Plugin
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
    Name = "Locimation~FSM",
    Description = "Initial release",
    Version = "1.0.0",
    Id = "a54eab42-8563-4ca8-a4ca-f8c2a074ad19",
    ShowDebug = false
}

LOGO = [[PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjMwMCIgaGVpZ2h0PSIyMDAiPjxwYXRoIHN0eWxlPSJmaWxsOiNCRkUyRjkiIGQ9Ik0gNjcuMjc5OTE1LDE2NS45OTE2OCBDIDU2LjY5Nzk2NiwxNTQuOTg0MzQgNzYuNDY0MDUyLDE1MC4yMDY2NiA4NC4wNTI2NywxNTAuOTUwNzQgQyA4Mi45OTEyMTMsMTQxLjQ3NDcgODcuMzEwMjc0LDEzMC42ODM0NSA4OC41ODkxMTUsMTIzLjQ1ODI2IEMgNzguNjU2NzAzLDExNS40OTcwMiA2Ni44Mzk1MjcsMTI0LjI0NDA2IDY3LjQ4Nzg1NiwxMzUuOTMxMDcgQyA2NS4yMDU0NTUsMTUxLjU0ODMzIDQ5LjQ2OTc0LDE0OC41NjQ0MyAzOC4yNjM3MDYsMTQ3LjA0NTE0IEMgMzEuMzMxMjkxLDE0OC4yOTgwOSAxNi4yNDM3MzYsMTUyLjM0NzI3IDIwLjc0MDU3OCwxMzkuOTk1NjUgQyAyNy4zMjQxMiwxMjcuNDUyMjEgNDEuMjc4MTM2LDEzNC42NjM5NiA1MS43NDI2NTQsMTMzLjY1ODY4IEMgNTcuODM2OTg0LDEyNy4zOTAwOSA1NS4zNTg5OCwxMTUuNTgyNjcgNjQuOTQ2NDg2LDExMC40ODYyMiBDIDY5Ljc2OTcyNSwxMDIuNDk5NzIgNTIuOTY2NzE3LDk0LjE1NjkyMiA0Ni43MDIzMjIsOTguMDI5NzE1IEMgNTAuOTg5MDI3LDEwOC4zMTI3NSA0MC4yMjk4ODksMTIyLjg3ODY2IDI5LjI3MDQzNywxMTUuNTA0MTYgQyAyMy4xOTY1MjksMTA2LjY4NDE0IDYuMTQ2OTY2MSwxMTEuODI2ODYgNS4yOTAyOTc4LDEwMS4wMjc5MSBDIDEwLjQzMjA2Nyw4OS44MTc2NzYgMjUuMTYwMTM1LDk2Ljg5MzYzNCAzMi4yOTcyMTQsMTAwLjQ0MDk4IEMgMzEuNDMzNjE3LDg2LjM3MTQ1NSA0NS42NDkzMSw3OC45NzUzOCA1Ny44ODY0NTYsODUuMjgzMTIzIEMgNjcuNzQ4MzczLDkxLjY2MjIyIDc2LjYyMDg4Niw5Ny45MjExNzggODUuNzE2ODI5LDg2Ljk5OTU1OSBDIDk0Ljk5NTQ0NSw4MC4xNTQ5MjMgMTA2LjA2Mzc3LDc3LjAxMTg2OSAxMTYuNTg3MjcsNzIuNzM1MzE3IEMgMTMxLjI4MjY3LDYzLjMxNTM3OCAxMDQuNjA2MzQsNTYuMDM4NDc5IDEwNy4zMTc1MSw0NC42OTc2MTQgQyAxMDMuNTU5OTgsMzAuMzQ5Mzc0IDEyMS4zNjkzMSwyMC40MjExMzQgMTMzLjE2ODIsMjcuMjM0MjI0IEMgMTQ3Ljk0NTQ5LDM0LjQ3NjQ5OSAxNDMuMDcyNTksNTIuMzMxNDA1IDEzMy42MjA0Miw2MS4zMjExNzIgQyAxMzEuOTQ4ODUsNjYuMTYxNjE0IDEzMy4yNzQ0OSw2OS40MzA4OTYgMTM2LjE0NDMyLDcwLjU0MTkyNSBDIDE0MC40MDg4Niw3Mi4xOTI5MDYgMTU2LjA4Nzk3LDcxLjY4NTY0NyAxNTkuMTg0NDQsNjkuMDk1NzE4IEMgMTYxLjU2MjU3LDY3LjEwNjYxIDE2MS41MDk1LDYzLjAxNzk2NyAxNTguMzY0NTksNTguMTA1MDMyIEMgMTUwLjE0OTExLDQ5LjY5ODkzNSAxNDcuOTA2NTMsMzUuNDY1NzM0IDE1OC45NzkwNCwyOC4xMjkxMDQgQyAxNjkuNjA0MTMsMjAuNDEwMTIzIDE4Ni41MDU1LDI4LjEwNDM0NCAxODcuMDEzNjgsNDEuNDQ4MzQ3IEMgMTkyLjE1NDUsNTYuNDE4ODM3IDE2My44NzkwMyw1OC41NjEwOTcgMTczLjE3MTA0LDcyLjg3NDgwMyBDIDE4OC43MDk3LDc1LjgwMDgxNCAyMDMuMzc3NjksODIuNzQ5NjU3IDIxNS42MDEyNiw5Mi42OTUyNDMgQyAyMjcuNDMyNDEsOTcuMzQyMDE3IDIzNi45MTE5OCw3OS4xNDQwOTggMjUwLjIxMjAzLDg0Ljc2NTYwMyBDIDI2Mi4yNTQwNyw4My40MTA2MzQgMjU3LjczOTU5LDEwOS44MTY4MiAyNjguNjUwMTIsOTcuNTA2NTIzIEMgMjc1LjczNzgsOTAuOTYyMTAzIDI5NS45NDA4OSwxMDEuMjAxNTggMjgzLjY0NDY1LDEwNy40NzU4MiBDIDI3MS43MzY1NiwxMDguNjg4MTEgMjYwLjQ0MzQyLDEyMy4xNzA4MyAyNDguMzQ2NDksMTE1LjEyNDAyIEMgMjQzLjIxMTIyLDEwOS40MzQ5MSAyNDkuNDg0NDEsOTEuOTQ4OTczIDIzNy4yODU4OSw5OS45NzQ4NjYgQyAyMzAuNTExNTgsMTAxLjIwMDYxIDIyNi44NTE5NCwxMDUuNDk3NzEgMjI3LjYyNjU4LDEwOS40NjU5IEMgMjM1Ljk0MTU3LDExNy41MzQ1OCAyMzUuNDQxMywxMTguMjIyNjIgMjM5LjA2NTIsMTI5LjUxMzQ0IEMgMjQwLjkzOTE2LDEzNC41Mjg4OSAyNDQuMDEzMzgsMTM3LjY1MjE2IDI1MS40MDgxOCwxMzMuNDI1MzkgQyAyNjEuNTMwMzMsMTI4LjIxNDc4IDI4Mi44MTk3MywxNDIuOTM3NzEgMjY3Ljk5NTMzLDE1MC4zODc3NyBDIDI1Ny4xMTUxNiwxNDIuOTc5NjkgMjQ1LjgxMDk5LDE1MS42MDMyMiAyMzQuMTYwMDcsMTQ4LjExMzM4IEMgMjIyLjcwMTY1LDE0Mi42NjAyIDIyOS44Nzc4NywxMTguMzY0NDggMjEyLjkzNDAxLDEyMS4wMDg4IEMgMjA2LjU3MDQsMTIwLjI2NDc5IDIwNC42MjI5NCwxMjMuMDY1NzcgMjA1LjE1NzY3LDEyNi41NzMyMiBDIDIxMS4zMDE4NCwxMzQuMTA4MTUgMjA3LjMxMTA5LDE0MS4wNjY5NCAyMTAuMTgyNTQsMTQ5LjIyODQ0IEMgMjExLjc5NjI2LDE1Mi4zODE4IDIxNS4xMjQxMywxNTMuODY5NiAyMjEuMzUyMDQsMTUxLjc3NjExIEMgMjM0LjczMzAzLDE1NC45MTE4OSAyMjcuMzAwNjIsMTcyLjUzMTAzIDIxNS4yMjUyMiwxNjUuNjg5NjcgQyAyMDIuNzQ1LDE2Ni43NDc4MiAxOTEuNTE2MzUsMTU3LjU3NjQ0IDE5NS45Mzg5NywxNDQuNjExNjcgQyAxOTQuMDc0NTEsMTI4LjM1NzI1IDE3Ny4xODU5MiwxMzQuNTk0OTYgMTY2LjkwMzQ3LDEzNy40NzA2MiBDIDE0OS4xNTU2LDE0MS4yNzM1MyAxMzAuNjczNDUsMTQwLjAwNzk4IDExMy4zNDk2MywxMzQuNzk4MzkgQyAxMDIuNTUyNzEsMTMwLjIwNDY0IDk1LjY2Mjg3OCwxMzkuOTQ4OTQgOTkuMTYyOTg2LDE0OS43NTM4NSBDIDk4LjgzNDgyMywxNjUuMjA2MDcgODEuMjcwMDYyLDE2Ny4wNzQ3MyA2OS40MjA0NTUsMTY2LjM4NjY1IEwgNjcuMjc5OTE1LDE2NS45OTE2OCBMIDY3LjI3OTkxNSwxNjUuOTkxNjggeiBNIDE2My41LDEyNy45MTIxNCBDIDE3OC41NDEzMiwxMjYuMjcxMzcgMTkyLjkyODA5LDExOS42MDE4MyAyMDQuNjg3MiwxMTAuMzIxMzYgQyAyMTYuODM2MDUsMTA1LjQ4NjEyIDIwOC42NDYwNyw5Ny42NjQ1MTkgMjAwLjQ3Mzk5LDk0LjkzNTM3MyBDIDE2NS40OTQ4Miw3NC42NDM5MzMgMTE4LjM4NzcyLDc1Ljc4MTExNSA4NS43NDUwNjEsMTAwLjI3MjQzIEMgNzYuMDI4ODMyLDEwNy44NDg5IDk2LjM0NjkwNywxMTAuOTU0IDEwMC42NzQzOCwxMTYuNjcwMjkgQyAxMTguNzM0MzMsMTI5LjQwMDkzIDE0Mi4yMjkxMSwxMzEuMDc0NjcgMTYzLjUsMTI3LjkxMjE0IHogTSAxMjguMzQyNjgsNDkuODg5NzI5IEMgMTQyLjc0NzI2LDQyLjE0Mjc5OSAxMjEuMDEzNzksMjMuMDc3MDIgMTE1LjUwMDIxLDM5LjA3NDI2IEMgMTEzLjA1OTE4LDQ2LjMzNTc4OSAxMjEuNDg0MSw1My44NzI2NDEgMTI4LjM0MjY4LDQ5Ljg4OTcyOSB6IE0gMTIwLjY5NDgzLDQ1LjIxNTI3OSBDIDExNC42ODM2NCwyOS44MTc3OTYgMTQwLjE4ODc4LDQ1LjI2MjY5IDEyMS44OTkzOSw0Ni4yNDI4MjkgTCAxMjAuNjk0ODMsNDUuMjE1Mjc5IEwgMTIwLjY5NDgzLDQ1LjIxNTI3OSB6IE0gMTc2LjUsNDkuMDk3MTYgQyAxOTEuMTE4NzYsMzkuMTA5MDc1IDE2My4wMjI2OCwyMi45NTMzMzYgMTYxLjE2MDA4LDQxLjQ5OTEzMiBDIDE1OS45NDIxOSw0OS42MzQwMzggMTcwLjY2NTU5LDUzLjg4NDMxMiAxNzYuNSw0OS4wOTcxNiB6IE0gMTY2Ljc4MjY1LDQ0LjQyMjM0IEMgMTYzLjYwMjcxLDMxLjI1ODM0OCAxODMuNDA1NzcsNDUuMDQwMzA5IDE3MC4yNzE2NSw0Ny4wNDEwODggQyAxNjguNzM5MTIsNDYuOTI5MzEyIDE2Ny4zODAxOSw0NS44MzQ0NCAxNjYuNzgyNjUsNDQuNDIyMzQgeiIgLz48L3N2Zz4=]];

function GetPrettyName()
    return "Finite State Machine";
end

function GetColor()
    return { 70, 110, 240 };
end;

function GetProperties()
    return {
        {
            Name = "State Count",
            Type = "integer",
            Min = 2,
            Max = 100,
            Value = 5
        },
        {
            Name = "Direction",
            Type = "enum",
            Choices = { "Sequential", "Allow From", "Allow To", "Allow All" },
            Value = "Sequential"
        },
        {
            Name = "Allow Looping",
            Type = "enum",
            Choices = { "Yes", "No" },
            Value = "Yes"
        }
    }
end

function RectifyProperties(props)
    props["Allow Looping"].IsHidden = (props["Direction"].Value ~= "Sequential");
    return props;
end

function GetControls(props)
    local basics = {
        {
            Name = "Trigger",
            ControlType = "Button",
            ButtonType = "Trigger",
            UserPin = true,
            PinStyle = "Both",
            Count = props["State Count"].Value
        },
        {
            Name = "Name",
            ControlType = "Text",
            Count = props["State Count"].Value
        },
        {
            Name = "Active",
            ControlType = "Indicator",
            IndicatorType = "Led",
            Count = props["State Count"].Value,
            UserPin = true,
            PinStyle = "Output"
        },
        {
            Name = "Current State",
            ControlType = "Knob",
            ControlUnit = "Integer",
            Min = 1,
            Max = props["State Count"].Value,
            UserPin = true,
            PinStyle = "Both"
        }
    }
    
    local direction = props['Direction'].Value:match('Allow (.+)');
    if(direction == 'From' or direction == 'To') then
        table.insert(basics, {
            Name = "Allow " .. direction,
            ControlType = "Button",
            ButtonType = "Toggle",
            Count = props["State Count"].Value * props["State Count"].Value,
            UserPin = true,
            PinStyle = "Both"
        });
    end;

    return basics;

end

function GetControlLayout(props)

    local controls = {};
    
    local direction = props['Direction'].Value:match('Allow (.+)');

    local numStates = props["State Count"].Value;

    for i = 1, numStates do
        controls["Active " .. i] = { Position = {0, i * 16 }, PrettyName = string.format("State %d~Active", i) };
        controls["Trigger " .. i] = { Position = {16, i * 16 }, PrettyName = string.format("State %d~Trigger", i) };
        controls["Name " .. i] = { Position = {54, i * 16 }, Size = { 100, 16 }, HTextAlign = "Left", Padding = 2 };
        if direction == "From" or direction == "To" then
            for j = 1, numStates do
                controls["Allow " .. direction .. " " .. ((i-1)*numStates + j)] = {
                    Position = { 142 + j * 16, i * 16 },
                    Legend = "" .. j,
                    Color = {0, 255, 0},
                    Size = {16, 16},
                    PrettyName = string.format("State %d~Allow %s %d", i, direction, j)
                };
            end;
        end;
    end;

    local graphics = { -- graphics
        {
            Type = "Label",
            Position = { 16, 0 },
            Size = { 32, 16 },
            HTextAlign = "Left",
            Text = "Go"
        },{
            Type = "Label",
            Position = { 54, 0 },
            Size = { 72, 16 },
            HTextAlign = "Left",
            Text = "Name"
        },
        {
            Type = "Label",
            Position = { 0, numStates * 16 + 28 },
            Size = { 116, 16 },
            HTextAlign = "Left",
            Text = "Current State"
        },
        {
            Type = "Svg",
            Position = { 4 + ((direction == "From" or direction == "To") and (math.max(numStates,4.5) * 8) or 0), numStates * 16 + 28 + 30 },
            Size = { 150, 100 },
            Image = LOGO
        }
    };

    controls["Current State"] = {
        Position = { 118, numStates * 16 + 28 },
        Size = { 36, 16 }
    };

    if direction == "From" or direction == "To" then
        table.insert(graphics, {
            Type = "Label",
            Position = { 158, 0 },
            Size = { 72, 16 },
            HTextAlign = "Left",
            Text = "Allow " .. direction
        });
    end;

    return controls, graphics;

end;

if not Controls then return end;

local direction = Properties["Direction"].Value;
local numStates = Properties["State Count"].Value;
local allowLoop = Properties["Allow Looping"].Value;

for i = 1, numStates do
    Controls.Trigger[i].EventHandler = function(c)
        if(LOCKOUT) then return; end;
        local currentState = math.floor(Controls["Current State"].Value);
        if direction == "Sequential" then
            local ok = currentState + 1 == i;
            if allowLoop == "Yes" and i == 1 and currentState == numStates then ok = true; end;
            if not ok then print(currentState, i, 'noseq'); return; end;
        end;
        if(direction == "Allow From") then
            local crosspoint = (i - 1) * numStates + currentState;
            if(not Controls["Allow From"][crosspoint].Boolean) then return; end;
        end;
        if(direction == "Allow To") then
            local crosspoint = (currentState - 1) * numStates + i;
            if(not Controls["Allow To"][crosspoint].Boolean) then return; end;
        end;
        LOCKOUT = true;
        Timer.CallAfter(function()
            Controls["Current State"].Value = i;
            updateLeds(i);
            LOCKOUT = false;
        end, 0);
    end;
end;

function updateLeds(i)
    for j = 1, numStates do
        Controls["Active"][j].Boolean = (i == j);
    end;
end;

Controls["Current State"].EventHandler = function(c) updateLeds(c.Value); end;
updateLeds(Controls["Current State"].Value);