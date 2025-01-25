#Requires AutoHotkey v2
#Include %A_ScriptDir%\..\Lib\FindText.ahk
#SingleInstance Force
#Warn

CoordMode("Pixel", "Screen")  ; Ensure pixel color coordinates are relative to the screen
CoordMode("Mouse", "Screen")  ; Ensure mouse coordinates are relative to the screen

Unit_Slot_1 := 0
Unit_Slot_2 := 0
Unit_Slot_3 := 0
Unit_Slot_4 := 0
Unit_Slot_5 := 0
Unit_Slot_6 := 0

global Checkbox7 := "Nothing"
global Checkbox8 := "Nothing"

global ceo_maxed_1 := 0
global ceo_maxed_2 := 0
global ceo_maxed_3 := 0

global return_click := 0

Global Go_To_Infinity_Mansion_Check := true

; Create the main GUI
main := Gui("+AlwaysOnTop", "V1.6.0")

; Create the options GUI
options := Gui("+AlwaysOnTop", "Options")

; Create the readne GUI
readme := Gui("+AlwaysOnTop", "Read Me")

readme.SetFont("s20 Bold", "Segoe UI")
readme.Add("Text", "x25 y10 w680 h40", "Game Settings:")

readme.SetFont("s14 Bold", "Segoe UI")
readme.Add("Text", "x25 y60 w680 h30", "Graphics Settings:")
readme.SetFont("s10 norm", "Segoe UI")
readme.Add("Text", "x45 y90 w640 h20", "• Set to 1.")

readme.SetFont("s14 Bold", "Segoe UI")
readme.Add("Text", "x25 y120 w680 h30", "Camera Settings:")
readme.SetFont("s10 norm", "Segoe UI")
readme.Add("Text", "x45 y150 w640 h20", "• Sensitivity: 0.52")
readme.Add("Text", "x45 y180 w640 h20", "• Mode: Default (Classic)")

readme.SetFont("s14 Bold", "Segoe UI")
readme.Add("Text", "x25 y210 w680 h30", "Movement Settings:")
readme.SetFont("s10 norm", "Segoe UI")
readme.Add("Text", "x45 y240 w640 h20", "• Mode: Default (Classic)")

readme.SetFont("s14 Bold", "Segoe UI")
readme.Add("Text", "x25 y270 w680 h30", "Menu Settings:")
readme.SetFont("s10 norm", "Segoe UI")
readme.Add("Text", "x45 y300 w640 h20", "• Roblox Menu: Set to ESC")
readme.Add("Text", "x45 y330 w640 h20", "• Roblox Player Menu: Set to TAB")

readme.SetFont("s14 Bold", "Segoe UI")
readme.Add("Text", "x25 y360 w680 h30", "Gameplay Settings:")
readme.SetFont("s10 norm", "Segoe UI")
readme.Add("Text", "x45 y390 w640 h20", "• Auto-Skip Waves: On")
readme.Add("Text", "x45 y410 w640 h20", "• Disable Auto-Open Upgrade UI: On")
readme.Add("Text", "x45 y440 w640 h20", "• Show Upgrade UI on Left: On")

readme.SetFont("s14 Bold", "Segoe UI")
readme.Add("Text", "x25 y470 w680 h30", "Display Settings:")
readme.SetFont("s10 norm", "Segoe UI")
readme.Add("Text", "x45 y500 w640 h20", "• Change display to 1920 x 1080 resolution")
readme.Add("Text", "x45 y530 w640 h20", "• Set display scale to 100%")
readme.Add("Text", "x45 y560 w640 h20", "• If you have HDR or Night Mode enabled, turn it off.")

Checkbox9 := readme.Add("Checkbox", "x25 y670 w300 h30", "Never Show This Again")

DoneButton := readme.Add("Button", "x25 y700 w300 h30", "Done")
CloseButton := readme.Add("Button", "x375 y700 w300 h30", "Close Macro")

DoneButton.OnEvent("Click", (*) => readme.Hide())
DoneButton.OnEvent("Click", (*) => main.Show("w300 h300 x1610 y50"))
DoneButton.OnEvent("Click", (*) => Unit_GUI_Save())

CloseButton.OnEvent("Click", (*) => Unit_GUI_Save())
CloseButton.OnEvent("Click", (*) => ExitApp())

StartButton := main.add("Button", "x10 y270 w100", "Start (Ctrl+F4)")
StopButton := main.add("Button", "x120 y270 w100", "Stop (Ctrl+F3)")
OptionsButton := main.add("Button", "x230 y270 w60", "Options")
main.add("Text", "x10 y250 w200", "Made By Thuy")

StartButton.OnEvent("Click", (*) => Send("{Ctrl Down}{F4}{Ctrl Up}"))

StopButton.OnEvent("Click", (*) => Unit_GUI_Save())
StopButton.OnEvent("Click", (*) => ExitApp())

OptionsButton.OnEvent("Click", (*) => OpenOptions())
OptionsButton.OnEvent("Click", (*) => Unit_GUI_Save())

main.OnEvent("Close", (*) => Unit_GUI_Save())

; Add 6 checkboxes with corresponding dropdowns next to them
main.add("Text", "x10 y10 w150", "Enable Slot")
main.add("Text", "x170 y10 w150", "Placement Amount")

Checkbox1 := main.add("Checkbox", "x10 y30 w150 Checked", "Unit Slot 1 (Use C.E.O.)")
Dropdown1 := main.add("DropDownList", "x170 y30 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox2 := main.add("Checkbox", "x10 y60 w150", "Unit Slot 2")
Dropdown2 := main.add("DropDownList", "x170 y60 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox3 := main.add("Checkbox", "x10 y90 w150", "Unit Slot 3")
Dropdown3 := main.add("DropDownList", "x170 y90 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox4 := main.add("Checkbox", "x10 y120 w150", "Unit Slot 4")
Dropdown4 := main.add("DropDownList", "x170 y120 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox5 := main.add("Checkbox", "x10 y150 w150", "Unit Slot 5")
Dropdown5 := main.add("DropDownList", "x170 y150 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox6 := main.add("Checkbox", "x10 y180 w150 Checked", "Unit Slot 6 (Use A Hill Unit)")
Dropdown6 := main.add("DropDownList", "x170 y180 w50", ["1", "2", "3", "4", "5", "6"])

Checkbox7 := options.add("Checkbox", "x10 y30 w150", "Do Hardmode")
Checkbox8 := options.add("Checkbox", "x10 y60 w150", 'Click "Next Room" or "Retry"')

; Check if the settings file exists
if !FileExist("..\Settings\settings.ini") {
    ; Create a new settings.ini file with default values
    IniWrite("0", "..\Settings\settings.ini", "Show", "Read_Me")

    IniWrite("1", "..\Settings\settings.ini", "Units", "Slot_1")
    IniWrite("0", "..\Settings\settings.ini", "Units", "Slot_2")
    IniWrite("0", "..\Settings\settings.ini", "Units", "Slot_3")
    IniWrite("0", "..\Settings\settings.ini", "Units", "Slot_4")
    IniWrite("0", "..\Settings\settings.ini", "Units", "Slot_5")
    IniWrite("1", "..\Settings\settings.ini", "Units", "Slot_6")

    IniWrite("3", "..\Settings\settings.ini", "Placements", "Dropdown1")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown2")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown3")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown4")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown5")
    IniWrite("0", "..\Settings\settings.ini", "Placements", "Dropdown6")

    IniWrite("0", "..\Settings\settings.ini", "Options", "Hardmode")
    IniWrite("0", "..\Settings\settings.ini", "Options", "Next_Room/Retry")
}

; Define the function to open the options tab
OpenOptions() {
    global Checkbox7, Checkbox8
    global options

    options := Gui("+AlwaysOnTop", "Options")
    options.Show("w300 h300 x1610 y50")
    
    Checkbox7 := options.add("Checkbox", "x10 y10 w150", "Do Hardmode")
    Checkbox7.Value := IniRead("..\Settings\settings.ini", "Options", "Hardmode")

    Checkbox8 := options.add("Checkbox", "x10 y30 w200", 'Click "Next Room" or "Retry"')
    Checkbox8.Value := IniRead("..\Settings\settings.ini", "Options", "Next_Room/Retry")

    CloseButton_2 := options.add("Button", "x10 y270 w100", "Close")
    CloseButton_2.OnEvent("Click", (*) => options.Hide())
    CloseButton_2.OnEvent("Click", (*) => Unit_GUI_Save())

    options.OnEvent("Close", (*) => options.Hide())
    options.OnEvent("Close", (*) => Unit_GUI_Save())
}

Checkbox9.Value := IniRead("..\Settings\settings.ini", "Show", "Read_Me")

Checkbox1.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_1")
Checkbox2.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_2")
Checkbox3.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_3")
Checkbox4.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_4")
Checkbox5.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_5")
Checkbox6.Value := IniRead("..\Settings\settings.ini", "Units", "Slot_6")

Dropdown1.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown1")
Dropdown2.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown2")
Dropdown3.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown3")
Dropdown4.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown4")
Dropdown5.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown5")
Dropdown6.Value := IniRead("..\Settings\settings.ini", "Placements", "Dropdown6")

Checkbox7.Value := IniRead("..\Settings\settings.ini", "Options", "Hardmode")
Checkbox8.Value := IniRead("..\Settings\settings.ini", "Options", "Next_Room/Retry")

if Checkbox9.Value == 0 {
    readme.Show("w700 h750")
} else {
    main.Show("w300 h300 x1610 y50")
}

Unit_GUI_Save() 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6, Checkbox7, Checkbox8, Checkbox9
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Checkbox1.Value) {
        Unit_Slot_1 := Dropdown1.Value
    } else {
        Unit_Slot_1 := 0
    }
    if (Checkbox2.Value) {
        Unit_Slot_2 := Dropdown2.Value
    } else {
        Unit_Slot_2 := 0
    }
    if (Checkbox3.Value) {
        Unit_Slot_3 := Dropdown3.Value
    } else {
        Unit_Slot_3 := 0
    }
    if (Checkbox4.Value) {
        Unit_Slot_4 := Dropdown4.Value
    } else {
        Unit_Slot_4 := 0
    }
    if (Checkbox5.Value) {
        Unit_Slot_5 := Dropdown5.Value
    } else {
        Unit_Slot_5 := 0
    }
    if (Checkbox6.Value) {
        Unit_Slot_6 := Dropdown6.Value
    } else {
        Unit_Slot_6 := 0
    }

    IniWrite(Checkbox9.Value, "..\Settings\settings.ini", "Show", "Read_Me")

    IniWrite(Checkbox1.Value, "..\Settings\settings.ini", "Units", "Slot_1")
    IniWrite(Checkbox2.Value, "..\Settings\settings.ini", "Units", "Slot_2")
    IniWrite(Checkbox3.Value, "..\Settings\settings.ini", "Units", "Slot_3")
    IniWrite(Checkbox4.Value, "..\Settings\settings.ini", "Units", "Slot_4")
    IniWrite(Checkbox5.Value, "..\Settings\settings.ini", "Units", "Slot_5")
    IniWrite(Checkbox6.Value, "..\Settings\settings.ini", "Units", "Slot_6")

    IniWrite(Dropdown1.Value, "..\Settings\settings.ini", "Placements", "Dropdown1")
    IniWrite(Dropdown2.Value, "..\Settings\settings.ini", "Placements", "Dropdown2")
    IniWrite(Dropdown3.Value, "..\Settings\settings.ini", "Placements", "Dropdown3")
    IniWrite(Dropdown4.Value, "..\Settings\settings.ini", "Placements", "Dropdown4")
    IniWrite(Dropdown5.Value, "..\Settings\settings.ini", "Placements", "Dropdown5")
    IniWrite(Dropdown6.Value, "..\Settings\settings.ini", "Placements", "Dropdown6")

    IniWrite(Checkbox7.Value, "..\Settings\settings.ini", "Options", "Hardmode")
    IniWrite(Checkbox8.Value, "..\Settings\settings.ini", "Options", "Next_Room/Retry")

    return
}

; Get the directory of the current script
ScriptDir := A_ScriptDir

return_check := 0
reconnect_check := 0
wrong_map := 0

; Function to send click at specified coordinates
SendClick(x, y)
{
    ; Move the mouse slightly before the main move
    MouseMove(x + 5, y + 5)
    Sleep(100)  ; Short delay to ensure Roblox detects the move
    MouseMove(x, y)  ; Move to the target position
    Sleep(100)  ; Optional delay for stability
    Click("Left", "Down")  ; Press down
    Sleep(50)  ; Hold down for a moment
    Click("Left", "Up")    ; Release
    Sleep(100)  ; Delay after the click
}

; Function to send click at specified coordinates
SendClick_R(x, y)
{
    ; Move the mouse slightly before the main move
    MouseMove(x + 5, y + 5)
    Sleep(100)  ; Short delay to ensure Roblox detects the move
    MouseMove(x, y)  ; Move to the target position
    Sleep(100)  ; Optional delay for stability
    Click("Right", "Down")  ; Press down
    Sleep(50)  ; Hold down for a moment
    Click("Right", "Up")    ; Release
    Sleep(100)  ; Delay after the click
}

Go_To_Infinity_Mansion() 
{
    global wrong_map
    global Checkbox7, Checkbox8
    global return_click
    global ceo_maxed_1
    global ceo_maxed_2
    global ceo_maxed_3
    global Go_To_Infinity_Mansion_Check

    wrong_map := 0
    return_click := 0
    ceo_maxed_1 := 0
    ceo_maxed_2 := 0
    ceo_maxed_3 := 0

    Loop {
        SendClick(1848, 922)
        Sleep(500)
        if (ImageFound_mansion()) {
            break
        }
    }
    SendClick(774, 582)
    Sleep(1000)

    Send("{w down}") ; Hold "w" key down
    Sleep(500)
    Send("{w up}") ; Hold "w" key up
    Sleep(500)

    Send("{a down}") ; Hold "a" key down
    Sleep(4000)
    Send("{a up}") ; Hold "a" key up
    Sleep(1000)

    if Checkbox7.Value == 0 {
        Loop 5 {
            SendClick(1004, 700)
            Sleep(100)
        }
    } else if Checkbox7.Value == 1 {
        Loop 5 {
            SendClick(1166, 700)
            Sleep(100)
        }
    }
    Sleep(500)
    Loop 5 {
        SendClick(962, 841)
        Sleep(100)
    }
    if Checkbox8.Value == 1 {
        Go_To_Infinity_Mansion_Check := false
    }
}

Go_Lobby()
{
    global Go_To_Infinity_Mansion_Check
    SendClick(1714, 20)
    Sleep(200)
    
    SendClick(45, 1055)
    Sleep(200)
    SendClick(960, 310)
    Sleep(200)
    Loop 15 {
        Send("{WheelUp}")
        Sleep(100)
    }
    Loop 7 {
        Send("{WheelDown}")
        Sleep(100)
    }
    Sleep(500)
    SendClick(1150, 584)
    Sleep(200)
    SendClick(1305, 232)

    Go_To_Infinity_Mansion_Check := true
}

Go_Spawn() 
{
    Loop {
        if (ImagesFound_Yes()) {
            break
        }
    }
    Sleep(100)
    SendClick(45, 1055)
    Sleep(200)
    SendClick(960, 310)
    Sleep(200)
    Loop 7 {
        Send("{WheelDown}")
        Sleep(100)
    }
    Sleep(500)
    SendClick(1150, 480)
    Sleep(200)
    SendClick(1305, 232)
    Sleep(200)
    Send("{Tab}")
    Sleep(200)

    Loop 10 {
        Send("{i down}") ; Hold "i" key down
        Sleep(100)
        Send("{i up}") ; Hold "o" key up
    }
    Sleep(500)
    ; Move the mouse down 700 pixels
    MouseMove(960, 600)

    Loop 10 {
        Send("{o down}") ; Hold "o" key down
        Sleep(100)
        Send("{o up}") ; Hold "o" key up
    }
}

Find_Maps()
{
    Loop {
        if (ImageFound_snowy_town()) {
            Snowy_Town()
            break
        }
        if (ImageFound_sand_village()) {
            Sand_Village()
            break
        }
        if (ImageFound_navy_bay()) {
            Navy_Bay()
            break
        }
        if (ImageFound_fiend_city()) {
            Fiend_City()
            break
        }
        if (ImageFound_spirit_world()) {
            Spirit_World()
            break
        }
        if (ImageFound_ant_kingdom()) {
            Ant_Kingdom()
            break
        }
        if (ImageFound_magic_town()) {
            Magic_Town()
            break
        }
        if (ImageFound_haunted_academy()) {
            Haunted_Academy()
            break
        }
        if (ImageFound_magic_hills()) {
            Magic_Hills()
            break
        }
        if (ImageFound_space_center()) {
            Space_Center()
            break
        }
        if (ImageFound_alien_spaceship()) {
            Alien_Spaceship()
            break
        }
        if (ImageFound_fabled_kingdom()) {
            Fabled_Kingdom()
            break
        }
        if (ImageFound_ruined_city()) {
            Ruined_City()
            break
        }
        if (ImageFound_puppet_island()) {
            Puppet_Island()
            break
        }
        if (ImageFound_virtual_dungeon()) {
            Virtual_Dungeon()
            break
        }
        if (ImageFound_snowy_kingdom()) {
            Snowy_Kingdom()
            break
        }
        if (ImageFound_dungeon_throne()) {
            Dungeon_Throne()
            break
        }
        if (ImageFound_mountain_temple()) {
            Mountain_Temple()
            break
        }
        if (ImageFound_rain_village()) {
            Rain_Village()
            break
        }
        if (ImageFound_storm_hideout()) {
            Storm_Hideout()
            break
        }
        if (ImageFound_haunted_mansion()) {
            Haunted_Mansion()
            break
        }
        if (ImageFound_nightmare_train()) {
            Nightmare_Train()
            break
        }
        if (ImageFound_future_city()) {
            Future_City()
            break
        }
        if (ImageFound_walled_city()) {
            Walled_City()
            break
        }
        if (ImageFound_cursed_festival()) {
            Cursed_Festival()
            break
        }
        if (ImageFound_spirit_town()) {
            Spirit_Town()
            break
        }
        if (ImageFound_hellish_city()) {
            Hellish_City()
            break
        }
        if (ImageFound_strange_town()) {
            Strange_Town()
            break
        }
        if (ImageFound_planet_greenie()) {
            Planet_Greenie()
            break
        }
    }
}

; Function to check if both images are found on the screen within the specified region
ImagesFound_Return()
{
    global return_click
    global Checkbox8

    Return_To_Lobby:="|<>**50$266.00000000000000000000000000003s0000Q003U0000000000000000000000000000000001z0000Tk03y000001zzk0000000000000000000000000ss000CC01lk00000zzz0000Ds000000000000Tk00000A600031U0MA00000A00s0003z0000000000007y0000031U000kM0630000030070001Uk0000000000031U00000kM000A601Uk00000k00M000MA000000000000kM00000A600031U0MA00000A00700061000000000000A20000031U000kM063000003000k001UE0000000000030U00000kM000A601Uk00000kDUA7zUs7lw1yDbsyTU01kDUDy00A60Tw31z0MDs0y0zA7y1bvwS1zzUzzzzzzy00w3wDrs031UTjkkTw63zUzkDv1VUPU3g01sAMD1UQ61k0M03b0700kMC0CA63lUkSQA67kMM7k0D00C363k0710C0600PU0s0A6701n00CM01q1VUw661k01k03UlUQ01k01k1U07k07031XU0Ck01a00BUMkD1zUQ00Q00sAM700Q00A0M01M00k0kMk01g00BU01s3A3kTk60E300C361k07001U600Q0060A6M00D003M00P0q1g003UT0y1zUlUQ1rk20M1w3z0Q1U31a0s3k20S0E3s7UP000kDkDUTMAM70zg3s60D0zUDkA0kN0TUQ3s7UT0q0k6U"

    if (ok:=FindText(&X, &Y, 800-150000, 209-150000, 800+150000, 209+150000, 0, 0, Return_To_Lobby))
    {
        Loop 4 {
            if (Checkbox8.Value == 0) {
                SendClick(X, Y)
                Sleep(500)
            } else if (Checkbox8.Value == 1) {
                SendClick(X + 300, Y)
                Sleep(500)
            }
        }
        return true
    }
    else
    {
        return false
    }
}

; Function to check if both images are found on the screen within the specified region
ImagesFound_Return_2()
{
    global return_click
    global Checkbox8

    Return_To_Lobby:="|<>**50$266.00000000000000000000000000003s0000Q003U0000000000000000000000000000000001z0000Tk03y000001zzk0000000000000000000000000ss000CC01lk00000zzz0000Ds000000000000Tk00000A600031U0MA00000A00s0003z0000000000007y0000031U000kM0630000030070001Uk0000000000031U00000kM000A601Uk00000k00M000MA000000000000kM00000A600031U0MA00000A00700061000000000000A20000031U000kM063000003000k001UE0000000000030U00000kM000A601Uk00000kDUA7zUs7lw1yDbsyTU01kDUDy00A60Tw31z0MDs0y0zA7y1bvwS1zzUzzzzzzy00w3wDrs031UTjkkTw63zUzkDv1VUPU3g01sAMD1UQ61k0M03b0700kMC0CA63lUkSQA67kMM7k0D00C363k0710C0600PU0s0A6701n00CM01q1VUw661k01k03UlUQ01k01k1U07k07031XU0Ck01a00BUMkD1zUQ00Q00sAM700Q00A0M01M00k0kMk01g00BU01s3A3kTk60E300C361k07001U600Q0060A6M00D003M00P0q1g003UT0y1zUlUQ1rk20M1w3z0Q1U31a0s3k20S0E3s7UP000kDkDUTMAM70zg3s60D0zUDkA0kN0TUQ3s7UT0q0k6U"

    if (ok:=FindText(&X, &Y, 800-150000, 209-150000, 800+150000, 209+150000, 0, 0, Return_To_Lobby))
    {
        if (return_click == 1) {
            Loop 4 {
                if (Checkbox8.Value == 0) {
                    SendClick(X, Y)
                    Sleep(500)
                } else if (Checkbox8.Value == 1) {
                    SendClick(X + 300, Y)
                    Sleep(500)
                }
            }
        }
        return true
    }
    else
    {
        return false
    }
}

ImagesFound_Yes()
{
    Yes:="|<>**50$39.60M0003s7k000tVb0006CMM000kn300063kzs7sMS7znznVVs7s7A8S0S0Mk3U1U770sAATkMD3lUy1Vs0C0sA/01s31VMTzsMA93vrX1Vg0A0MA9k1U31n70T1k7sTyTw0A0T0y4"

    if (ok:=FindText(&X, &Y, 881-150000, 184-150000, 881+150000, 184+150000, 0, 0, Yes))
    {
        return true
    }
    else
    {
        SendClick(971, 930)
        return false
    }
}

ImagesFound_Yes_2()
{
    Yes:="|<>**50$39.60M0003s7k000tVb0006CMM000kn300063kzs7sMS7znznVVs7s7A8S0S0Mk3U1U770sAATkMD3lUy1Vs0C0sA/01s31VMTzsMA93vrX1Vg0A0MA9k1U31n70T1k7sTyTw0A0T0y4"

    if (ok:=FindText(&X, &Y, 881-150000, 184-150000, 881+150000, 184+150000, 0, 0, Yes))
    {
        SendClick(X, Y)
        SendClick(X, Y)
        SendClick(X, Y)
        return true
    }
    else
    {
        return false
    }
}

; Function to check if both images are found on the screen within the specified region
ImageFound_unit_maxed()
{
    Maxed:="|<>**50$81.Dw00Ts00000003zk07zU0000000zz01zy000000070s0C1k0000000s3U3UC000000070S0w1k0000000s1sD0C00000007073k1k31sD07Us0QQ0C7zzny1z703rU1lzzzzsTws0Ds0CT7kr7bXr00q01rU42kTsCs03U0Ds00Q1y1r00Q01i003U7U7s400EBU00Q0M1r0k061s002k00Ss601kD0A0L007b0s0C1s7s2Q01sU"

    Max_:="|<>**50$47.y1z3wDkSC366MMlkAAAMMkr0AkMklUw0DUn0lUkUS1a1VV30M3M1VU6816lX3UMM6D3331ksAS66A1lkss06k1Xnlk0DVV6zX3wC7UA367wMT0M6AMMln4k4MUNb3D0Dz0zw3k"

    if (ok:=FindText(&X, &Y, 416-150000, 648-150000, 416+150000, 648+150000, 0, 0, Maxed)) && (ok:=FindText(&X, &Y, 442-150000, 391-150000, 442+150000, 391+150000, 0, 0, Max_))
    {
        SendClick(552, 354)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_mansion()
{
    Text:="|<>**50$329.00000003y3s00003s0000000000000000000000000007k0000000000000000TyTw0000Tw000000000000000000000000000zs000000000zU00003UAkM0000UM000000000zU00Ds0000000000010k000000003bU0000C090E00010EDk0000003rU01ts0000000000020U000000004100000M0G0U00060Uzs00000041U030k00000000000A1000000000M200001U0Y10000A130k000000M3U0A0U00000000000M2000000000k40000201820000M261U000000k300k1000000000000k4000000001U80000A02E40000EAA10000001U303U2000000000000UM0000000030E0000M0Qss0000ssM20000003030604000000000001lk0000000060U0000k7lzU0000zUk40000006070M08000000000001z000000000A100001U8000000001U81sED00A061U0E000000000zU0003y000000M2TvzUD0TryDxzk7yT0TjsVzU0M06700U7yznzTw0DzwDw0zzUDxzk0k4kS3Uk01g6MD1kA6k01sM31U0k06A010wD1a3kQ1s0QMA3U3UMD1k1U90E1l001E4U80sE5001UMC1U1U0Ck023U41c20C300AU8A01kU80s30K001a002U/000lUC0020sM3U300D004A003k00AA00P0Ek01n000k60g001g0050K000n0Q0040tk7E600A008k007U00AE00q0X001a000kA1M001s00+0g000q0s0081n0C0A00800H000D000AU01g1A001g000ls2k003k00I1M001g1k00M1y0M0M20060a000S000N0S6M2M001s001kk5U002k01c2k001M2U01s1w1k0k600Q1M000w000G1zwk5U003k001VU/07U7w1zE5U3k3k5w1zk3k301UC00s2k3k1s0w0o1zlU/0DU7U3k330K0TUAM20U/0Dk7U8M20k3UC030Q03k5UDk3k3w1c07n0I0tU70Dk760g1X0Mk410K0lUD0Ek41U60M060g0BU+0Mk7UAM3M03a0c31UC0zUCA1M230FU820g11UC0VU81U41k0A1A0P0I1VUD0EM2k01g1E630Q1XUAM2k460X0E41M230Q130E1U0300M2A1a0c330S0Uk4k03M2UA60s370Mk5U8A160U82k460s260U300C00k4M6A1E3C0w11U8k03k50AA1k6C0lU/0EM2A10E5U8A1k4A10300Q01U8QQM2k7s1s230Hw07U/0Rk3UAQ1X0K0Uk4M20U/0EM3U8M3s600k030ETlk5U303k460jzUD0K0T0D0Ms360g11U8k410K0Uk70Ek0M603U060Uz3U/0007UAA1MTUS0g000S0lk6A1M230FU820g11UC0VU0E40600A10070H000D0MM3UC0w1A001g1XUAM2k460X0E41M230Q1100UA0Q00M200C0a000S0kk6001s3M003M370Ek5U8A160U82k460s23010Q0k00k440Q16000w1VUA002k6s00Ck6C0UU90EM2A10E4U8A1E47020M3U00U800s26001c330Q00AUAs00tUAQ110G0UkAM60U90EM6U87041U60010E01kA70A2E461w00l0Mw03X0EM633a70ksMQ1Un3UMRVk7UM30Q0033U01ks7VwAks67S07X3ky0y73UMQ3y7w1zUzk1z3y0zlz03zUA0k003y003zU3zTkzUDwDzz7z0TzU3y0zk000000000000000000000M1U000000300000000007zk7w0Ds000000000000000000000000000k70000000000000000007k0000000000000000000000000000000030A000000000000000000000000000000000000000000000000000060s000000000000000000000000000000000000000000000000000081U0000000000000000000000000000000000000000000000000000k700000000000000000000000000000000000000000000000000001UA00000000000000000000000000000000000000000000000000001Us00000240000000000000000000000000000000000000000000001nk00000000000000000000000000000000000000000000000000001z00000000E000000000000000000000000000000000000000000001s000000000000000000000000000000008"

    if (ok:=FindText(&X, &Y, 778-150000, 548-150000, 778+150000, 548+150000, 0, 0, Text))
    {
        Loop 5 {
            SendClick(X, Y)
            Sleep(500)
        }
        return true
    }
    else
    {
        return false
    }
}

ImageFound_next()
{
    Next:="|<>**50$94.Dk07k00000000001zU0zk00000000y0C3063000000007y0k60M600000000kM30Q10M000000030kA0k41U0000000A30k1UE600000000kA30310M000000030kA0C41U7z0703kQ3sk0ME61zz1z0TbkDv00l0MS0SCC3Xs01g03Y1XU0QkQQ7003k07E6Q00y0vUQ00D00B0PU01s1w0k00w00Q1g003U3U7003kA1k7U00D040Q00D0s30K0T0q003s01g3U41M3g1w00Nw3ykD0050Tk6s031kDW"
    Gem:="|<>**50$63.7U0001zU000g00bzy7400Bk0lk00C801rkEs000QE0w68Q0001kU71kD00003W0gQ7U0010747n3k00000S07Ms000000s0OQ0000U0103q0000200M02k000080300IU000EU0E00V000740200A2101iE0E010AE0Mt0200c0m06340E01AG01U00600M0E0M000U020W06000400E4E1U000c021208000A00kME30101006620k100+00UUE41003E04861k0N0O01U0kS078600A0630En0o0101U0S6M4U08Tw0SUp1U01000SAAcA00CTw71Vb1804QTss8NsM000sPnX3+2000VVr7MNEk0013byS6C41c0277wkmlUT007DDs4I8Ds004D7VWXFvU000C7AgmAC0000QAB6Xkk0000sEtYCQ0000kw390rs0000ky383k00000sTm0Q000000MQ00000000008004"

    if (ok:=FindText(&X1, &Y1, 769-150000, 738-150000, 769+150000, 738+150000, 0, 0, Next)) || (ok:=FindText(&X2, &Y2, 731-150000, 656-150000, 731+150000, 656+150000, 0, 0, Gem))
    {
        Loop 3 {
            SendClick(769, 744)
            Sleep(500)
        }
        return true
    }
    else
    {
        return false
    }
}

ImageFound_ability()
{
    Off:="|<>**50$35.0z0Dzw7zUkw8Q1X1kFU1a30a01cS7AD1kwSEz3007X3600D66400SA4AC3wMMsSDMNlkgMEz3VMkkMB2lVk0O5X1k1Y/61kCAqA0zsTbkU"

    if (ok:=FindText(&X, &Y, 638-150000, 438-150000, 638+150000, 438+150000, 0, 0, Off))
    {
        SendClick(X,Y)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_snowy_town()
{
    Text:="|<>**50$199.00000000000000000000003zzzzzzzzz000000000000000000000003k00000001k00000000000000000000001U00000000A00000000000000000000001U00000000200000000000000000000000k00000000100000000000000000000000M000000000k00000000000000000000008000000000M00000000000000000000004000000000A00000000000000000000002000000000600000000000000000000001U00000000300000000000000000000000k000000001000000000000000000000008000000001U00000000000000000000007000000001k00000000000000000000001zzzk03zzzk00000000000000000000000000801U00000000000000000000000000000400k0000000000000007k000700000000200M0000Tw00Tk00zk0Tw000Dy0000000100A0000w300QS00sC0Q3000A3k0000000U060000M0k0M1U0k1ks0k00A0Q0000000E030000k080M0M0E0Qs0A006030000000801U000s060M060M06M0600600k000000400k001k0308030801s01U0300M000000200M001k00kA00UA00w00k03004000000100A001k00M600M600Q00A01U020000000U06001U0042004200D00301U010000000E03001k00330033007U01U0k01U000000801U00k001VU01V002M00M0E00U000000400k00k000EU00FU03A00A0M00k000000200M00k000Ak00Ak01X0030800M000000100A00M0U06E006E01VU00UA00M0000000U060080E01s001M00kM00M400A0000000E0300A0800w000w00E400660040000000801U040600A000Q00M300330060000000400k020300600060080k00n0020000000200M0300k03000300A0M009U030000000100A01U0M00000000606007U0100000000U0600k0400000000201001k01U0000000E0300E0300000000300k00k00k0000000801U0800U0000000100A00800k0000000400k0400M00000001U0600000M0000000200M0200A00000000k01U0000M0000000100A0100200000000k00E0000A00000000U0600U01U0000000M00A0000400000000E0300E00E000E00080030000600000000801U0A00A000A000A001U000200000000400k0600600060006000M000300000000200M01001U007U00600040001U0000000100A00U00k003k00300030001U00000000U0600M00800180010000k000k00000000E03004006001a001U000M000k00000000801U03003000X000U0006000M00000000400k00U00k00kU00k0001000800000000200M00M00M00MM00M0000k00A00000000100A00600400840080000A004000000000U06001U0300A300A00006006000000000E03000k00U061U0400001002000000000801U00A00M020E0600001U03000000000400k003U0A030A0300000U01U00000000300M000s0303030300000k01U000000001U08000700k3U1k300000M00k000000000M0A0001U0Q3U0Q300000M00E00000000070Q0000003z003z00000A00M0000000001zw00000000000000000A00800000000000000000000000000000600A000000000000000000000000000002004000000000000000000000000000003006000000000000000000000000000001003000000000000000000000000000001U03000000000000000000000000000000k01U00000000000000000000000000000k00U00000000000000000000000000000M00k00000000000000000000000000000800E00000000000000000000000000000A00M00000000000000000000000000000600800000000000000000000000000000300A000000000000000000000000000001U06000000000000000000000000000000E06000000000000000000000000000000A030000000000000000000000000000003U30000000000000000000000000000000w3U0000000000000000000000000000007zU0000000000000000000000000000000T0000000000000000001"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_sand_village()
{
    Text:="|<>**50$199.00000000000000000000000000000000y00000000007zs000000000000000Tz07zk00000000070C000000000000000w0s700000000000601U00000000000000M0A300000000000300k0000Dw000003zUM0330000000000010080000S3000003UwA01VU00000000000U040000Q0k00001U7600Ek00000000000E020000s0A00001U0v008E000000000008010000M0600000k0B004800000000000400U000M0100000k03U02400000000000200E000A00k0000M01s01200000000000100800040080000800Q00V000000000000U0400030060000A00S00kU00000000000E020001U010000400D00ME000000000008010000E00k0006004k08800000000000400U000A00M0003006Q0Q400000000000200E000600600030037zw20000000000010080001U030001U030701000000000000U040000k00k001U01U000U00000000000E020000A00M000k01U000E0000000000080100006004000k00k000800zk00000Dw400U0001U03000M00k3zU403szU0000zzm00E0000k00U00800M7vw201U0w0001s0D0080000A00M00A00M6031000070003U03U040000600400400A200kU0000k003U00E0200001U0300600A300ME0000C00300000100000k01U020061U04800003003000000U0000A00M030060k02400000k03000000E0000600A01U030E01200000A03000000800001U0301U030800V00000303000000400000k01U0k01U400EU00001U1U00000200000A00M0k01U2008E00000M1U00000100000600A0M00k100480000040U000000U00001U020800k0U0240000030k000000E00000k01UA00M0E012000001UE000000800000A00E400M0800V000000EM000000400000600A600A0400EU0Ds00AA007w002000001U02200A02008E0AC00640077001000000k01X006010048001U0320060k00U00000A00lU0600U024000M00V0060A00E00000600BU0300E012000400FU0606008000001006k0300800V0002008k0301004000000k01k01U0400EU001004M0100k02000000800s00U02008E000U02A00U0M01000000600800k010048000M01600M0A00U00000100000E00U024000800X00A0400E000000k0000M00E012000400FU030600800000080000800800V0003008E00k600400000060000A00400EU001004800Q6002000000100004002008E000U026003y0010000000k00060010048000M0130000000U00000080002000U026000800UU000000E00000060003000E013000400EM000000800000010001000800VU002008A00000040000000k001U00400EE0010043000000200000008000U0020088000U020U00000100000006000k0010044000E010M000000U0000001000E000U023000800U6000000E0000000k00M000E011U00600E1U00000800000008008000800UE0030080M0000040000000600A000400EA001U04060000020000000100400030083000k0201U0080100000000k060001U0A1k0080300Q00C01U0000000A060000E060Q00603003U0TU0k00000003060000A0603U01k7U00T1ww3k00000000sC00003UD00z00Dz0001zk7zU00000000Dy00000zy001k"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_navy_bay()
{
    Text:="|<>**50$199.00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000zzzzzU000000000000000000000000001k0000y000000000000000000000000001U00001k00000000000000000000000000U00000A00000000000000000000000000k000003U0000000000000000000000000M000000s00000000000000000000000008000000C000000000000000000000000040000003000000000000000000000000020000000U0000000000000000000000001000000000000000000000000000000000U00000000000000000000000000000000E0000000000000000000000000000000080000000000000000000000000000000040000000000000000000000000000000020000000000000000000000000000000010000000000000DU0001s00T0000Q00000U03zzk07s1zs0Ts0003z01zk000zs0000E0100Q03zXsT0s600030s1kA000kD0000800U06000vU1Uk1U003063U3000k1k000400E010007U0Mk0M00301XU0k00E0A000200800U001U04k0A001U0NU0M00M03000100400E000E02k03001U07U0600A01U000U0200M000001M01U00k03k0300A00E000E010Ds000000c00M00k00k00k06008000800US0000000I00A00M00w00806004000400EM0000000/00300M00S006030060002008M00000005U01U0A00BU01U10020001004A00000002M00M0A00Ak00k1U030000U02400000001A00A06006A00A0U01U000E01200000000X0030600660020k01U000800V00000000FU01U20021U01UE00k000400EU00000008M00M30030E00MM00E0002008M000Dk004400410030A00AA00M0001004A000AC00230031U01U3003A0080000U02200003U010k00UU01U1U00a00A0000E011k0000k00UM00Mk00k0M00O0040000800UDw000A00E6004E00k040070060000400E03U0060081003M00E030030030000200800E0010040k00c00M00k00U030000100400A000U020A00Q00M00M00001U0000U02002000E010600400A00600000U0000E01001000M00U1U0000A00100000k0000800U00U00M00E0E00004000k0000E0000400E00k00Q0080A00006000A0000M0000200800E0MQ00402000060006000080000100400M0Ds00201U00030001U000A00000U03zzs00000100M00030000E000400000E00000000000U0A0001U000A000600000800000000000E030001U0003000300000400000000000800U000U0001U00100000200000000000400M000k0000M001U00001000000000002006000k00004000U00000U00000000001003000M00003000k00000E00000000000U00k00M00000k00E00000800000000000E00800800000M00M00000400000000000800600A0000040080000020000000U000400100400000600A000001U000000k0E02000k06000002006000000k000001k0Q03000A060000030060000008000001U0y03000306000001U030000006000003U7ls7U000k6000001U010000001k0000T0zUDz0000Dy000000k01U000000Dzzzzw00000000000000000E00U00000000000000000000000000000M00k00000000000000000000000000000800E00000000000000000000000000000A00M00000000000000000000000000000400A00000000000000000000000000000600A000000000000000000000000000003006000000000000000000000000000001002000000000000000000000000000001U03000000000000000000000000000000U01000000000000000000000000000000k01U00000000000000000000000000000M00U00000000000000000000000000000A00k00000000000000000000000000000600M00000000000000000000000000000100M000000000000000000000000000000k0A000000000000000000000000000000C0A0000000000000000000000000000001k60000000000000000000000000000000Ty00000000000000000000000000000001w0000000000000004"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))    
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_fiend_city()
{
    Text:="|<>**50$199.0000000000001zy00000000000000DzU00000000000001k3U0000000000000S0Q00000000000001U0M000000007w000A0600000000000000k0A00000001zzw00A01U0000000000000E0200000007k07k0600k00000000000008010000000T000T030080000000000000400U000000w0001s1U040000000000000200E000001s0000C0U0200000000000001008000001k00001kE0100000000000000U04000003U00000QA00U0000000000000E02000003U000003600E0000000000000801000003U000001X00M0000000000000400U000030000000FU0A0000000000000200E0000300000008M04000000000000010080000300000004C0C00000000000000U0400003000000023zy00000000000000E0200001U000000303k0000000000000080100001U0000001U0000000000000000400U0000U000Tk01U0000000000000000200E0000k001zz00k0000Dy0Dw000003z10080000E003k1s0k1zk0z7kzDs0000DzwU040000M00700C0k3zy1w0As0D0000S03k0200008007001lk301VU03k01k000w00s010000A006000Dk100MU01k00A000s00400U0006006000001U0Ak00k003U00k00000E0002006000000k02M000000k00k0000080001003000000M01A000000A00k0000040001U03000000800Y000000300k0000020000k01000000400G0000000k0k0000010000M01U0000020090000000M0M000000U000800k000001004U00000060M000000E000400E000000U02M00000010800000080002008000000E01A0000000kA00000040001004000000800a0000000M400000020000U02000000400FU0000004600000010000E010000002008s007y0033001z000U000800U0000010047U073U01V001lk00E000400E000000U0200060M00kU01UA008000200A000000E01000606008E01U30040001U06000000800U00301004M01U1U020000k01000000400E00100U02A00k0E010000M00k000002008000U0E01600E0A00U000400M000001004000E0A00X0080600E0002006000000U0200080600FU06030080001U01U00000E01000403008k03010040000E00s000S0800U00201U04M00k1U020000A00C001zk400E00100k02400Q1U0100006001k01kQ2008000U0M0120071U00U0001000S03U61004000E0A00VU00zU00E0000k003sDU1UU0200080600Ek000000800008000Dy00ME01000403008800000040000600000004800U00201U046000000200001U0000003400E00100k023000000100000k0000000W008000U0E010k000000U0000A0000000F004000E0800U8000000E0000300000008U0200080600E6000000800000k0000004E010004030081U00000400000A0000002800U00201U040M000002000003U000003400E00100k0206000001000000s0000032008000U0M0101U00000U0000060000071U04000k0A01U0M00200E000001k000070k06000M0200k07003U0M000000C0000C0803000M01U0k00s07s0Q0000001k000S0603020s00S1s007kTD0w0000000D001s01k7U1zs003zk000zw1zs00000001z0TU00Tz00000000000000000000000001zw0000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_spirit_world()
{
    Text:="|<>**50$199.00003zs0000000000000000000000000000007U7000000000000000000000000000000301U00000000000000000000000000000300M00000000007z0001z0001zs0000001U0A0000000000T1k003ls001kD0000000k0200Ts000000Q0M0030C000k1k000000M0101zzU00000M0600301U00k0A000000A00U0k0s00000M0300300E00M03000000400E0k0A00000A00U01U0A00801U0000030080E0200000400M00U0600A00k000001U04080100000200A00k0100600M000000k060400U00001U0200M00k0200A000000M030200E00000k01U0800M030060000006010100A00000800k0A00401U020000003U3U0U060000060080600300U030000000zzU0E0300000300602001U0k01U0000001w00801000000U0303000E0M00U0000000000400U00000M00U1U00A0800k0000000000200E00000A00M0U0060A00M0000000000100800000200A0k001060080003zs0Tw0TU07zU0001U020M000k200A01y70T0zzUTk03zw0000k01U8000M300603li01kk0MM000030000800kA00041U0207US00ME06800000k0006008600030U03070A006M03A00000M000300620001Uk01UC00003A01a0000040000U0330000EM01UC00001a00H0000020000M00VU000A800kC00000G0090000010000A00MU0006A00EA00000N004U00000U000200Ak0001600MC00000AU02E00000E0001U02M0000m00A6000006E0180000080000k01c0000P0046000002800a0000040000800w00005U066000003400H0000060000600C00003U033000001W009U000030000300600801k011000001V004M0000300000U0300A00M01VU001z1UU02C00007U0000M00U0700800kU001lzUE011y00Tz00000400003U0400EE001U00800U1008000000300003E0000MM00FU00400E0U040000001U0001g0000AA00MU0020080E020000000E0000a00004600ME00100408010000000A0000l00006200A8000U020400U00000060000Mk000310044000E010200E000000100008M00010U022000800U10080000000k000A40001UE011000400E0U040000000M000630000k800UU0020080E020000000400021U000E400ME00100408010000000300030E000M200A8000U020400k0000001U001UA000A1U034000E010200M0000000E000U600040k00W000800U10040000000A000k1000608001000400E0U03y0000006000M0k00204000U0020080E003k00000100080M00103000E00100408000A000000k00A04001U0U008000U02060003000000M00603000U0M004000E01030001U00000400201U00k04002000800U1U000k00000300300E00M03001000400E0E0008000001U01U0A00800k00U0020080A0004000000E00U0200A00A00E001004020002000000A00k01006006008000U0201U001000000200M00k02001U04000M0100M001U000001U0800803000Q06000A01U06000k000000k0A00601U00703000200k01k00E000000A0A00301U000s30001U0k00S00M00000030C000s1U000D3U000Q1s003w0s0000000sS000D3U0001t00007zk000Dzs0000000Dw0001zU0000DU"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_ant_kingdom()
{
    Text:="|<>**50$196.000000000000000000000000000000DzU000000000000000000000000000003k3U000000000000000000000000001w0A060000000000000000000000zs000Qw1U0A000000000000000000000D1s003UM600k0000000000003z0000001U0k00M0kM010000000000001yTU00000401U0301V004000000000000607000000k0200Q03400E000000000000k0A00000300801U06E01000000000000200E00000A00U0A009004000000000000801000000U0201U00a00E000000000000U040000020080A002M03000000000000200E00000800U1U009U0A000000000000801000000U020A001X00U000000000000U040000020081k004C0C000000000000200E00000800U6000kTzk000000000000801000000U020k0060000000000000000U040000020086000k000000000000000200E00000800Uk0060000000000000000801000000U026000s00080007z07y000DU07zU0002008k00700zUU001wT3szU03y00TzU000800a000s0T7n000A06Q07U0M000030000U02k0030301Y000U0D00701000006000200D000M0803M00600s0060A00000M000800s00301U0AU00M03000C0k00000U000U03000M0600H001U00000M3000002000200800300E01A004000000k8000008000800000M01004M00E000001UU00000U000U0000700400FU0100000032000002000200000s00E013004000000A8000008000800007001004A00E000000Mk00000U000U0000s00400EM010000000X000006000200007000E011U040000003A00000M00080000s001004300E000000AM000030000U0003000400EA010000000Fk0000w00020000C000E010M04001z001Vy00Tz000080000Q0010041U0E00QC0060801000000U0000s00400E3010030A00M0U0400000200001k00E010A040080M00U200E00000800003U010040M0E01U0U020801000000U0000700400E1U1004020080U0400000200000C00E01030400E0800U200E00000800U00Q010040A0E0100U020801000000U03000s0400E0E1004020080U0400000200C001k0E0101U400E0800U200E00000800g003U1004020E0100U020801000000U02k0070400E0A1004020080U06000002009U00C0E0100E400E0800U200M00000800X000M100401UE0100U020800U00000U026000k400E021004020080U03y00002008A001UE0100A400E0800U2000S0000800UM003100400EE0100U0208000A0000U020k006400E01V004020080U000E00020081U00AE01002400E0800U30001U000800U6000F00400AE0100U020400060000U020A001Y00M00l004020080E000800020080M002E01U01400E0800U1U000U000800U0k009006004E0100U020200020000U0201U00Y00Q00F004030080A0008000200803002E01E01600E0A00U0M001U000A00U0600NU05U0AM0300k0200k0060000k0200A03600m01UU0A0100M01k00E000100M00s0M803A0C301U0603003k030000603001U30k0MM3U70Q00C0w003w0s0000C0w003UM1k70ts0DzU00Dz0001zz00000Tz0007703zs1y00000000000000000000000007k0002"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_magic_town()
{
    Text:="|<>**50$199.0000000000zy0000000000000000000000000000001s1k000000000000000000000000000000k0M000000000000000000000000000000k0600000000000Dzzzzzzzzs000000000M0300000000000Q00000000C000000000A00U00000000008000000001000000000400E0000000000A0000000000000000002008000000000060000000000000000001004000000000020000000000000000000U02000000000010000000000000000000M0100000000000U000000000000000000A01U0000000000E000000000000000000600k0000000000A0000000000000000001U0E000000000060000000000000000000s0s000000000010000000008000000000Dzs00000000000s00000000A00000000000000000000000Dzzy00Tzzw00000000000000000000000000100A000000000000000000000000000000U06000000000000000000000000000000E030008000Ts1zs07z0001zzk00000000801U007001yDVkD0Drs003s0z00000000400k001U03k0RU0kA06007001s0000000200M000M03U03U0M401U0C000C0000000100A000407000k04600k0A0001k0000000U0600020700000230080Q0000Q0000000E030001060000011U040Q000060000000801U008U6000000UU020Q00001U000000400k00AE7000000EE010Q00000E000000200M00A830000008800UA000008000000100A006430000004400EA0000040000000U06006230000002200840000060000000E0300611U000001100460000030000000801U030UU000000UU0220000030000000400k010Ek000000EE013000001U000000200M01U8E0070008800V000001U000000100A00U4800Ts004400EU00Tk1U0000000U0600E2A00Q70022008k00sC1k0000000E0300M1600Q1U011004M00s3lk0000000801U0A0W00A0M00UU02800M0TU0000000400k040F00A0400EE01400M0000000000200M0208U0603008800W00A0000000000100A0104E0201U04400F00400000000000U0600U2801U0k022008U0200000000000E0300E1400k0E011004E0100000000000801U080W00A0M00UU02800k0000000000400k040FU030M00EE01400807U0000000200M0208k01kQ008800X0060Dw0000000100A01U4800Ds004400FU01kQ700000000U0600k24001k0022008E00Tw0k0000000E0300813000000110048001k0A0000000801U040UU000000UU0260000060000000400k030EM000000EE011000001U000000200M00U8A0000008800Uk00000M000000100A00M430000004400E800000A0000000U0600420k000002200860000020000000E0300310M00000110041U000010000000801U00kU6000000UU020k00000U000000400k00AE1U00000EE010A00000k000000200M00680Q000008800U3U0000k000000100A001407000U04600E0s0000s0000000U06000200k00k02300M060000s0000000M02000300D01s010U0A01k001k0000000A010003001yDY00UM0A00C001k0000000301U003U007y600E70S001s07U00000000s3U001003k030081zw000Dzz000000000DzU000007y030040000000700000000000000000063U30020000000000000000000000000060Q3U0300000000000000000000000000603zU01U00000000000000000000000003006000U00000000000000000000000003000000k00000000000000000000000001U00000M00000000000000000000000000U00000M00000000000000000000000000E00000800000000000000000000000000800000A00000000000000000000000000400000A00000000000000000000000000300000A000000000000000000000000000k0000A000000000000000000000000000C0000A0000000000000000000000000003U000Q0000000000000000000000000000Q000s00000000000000000000000000003k01s00000000000000000000000000000TUDU000000000000000000000000000000zy000000000000000000000000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_haunted_academy()
{
    Text:="|<>**50$199.0000000000000zz0000000000000000000000000000000s1k000000000000000000000000000000k0A000000000000000000000000000000M06000000007w0000000000000000000080100000000D7U0000000000000000000400U0000000C0M0000000000000000000200E0000000C06000000000000000000010080000000601U0000000000000000000U040000000600k0000000000000000000E020000000300A0000000000000000000801000000030060000000000000000000400U0000001U010000000000000000000200E0000001U00k00000000000000000010080000000k0080000000000000000000U040000000k0060000000000000000000E020000000M001000000000000000000080100000008000k000000000000000000400U000000A0008000000000000000000200E00000040006000000000Ty0000000100800000060001000000007zzw00001zUU0400000020000k00003s0D007U0007zyE020000003000080000DU0Q000Q000D01s010000001000060000Q00s0007000S00Q00U000001U00010000s00s0000k00Q00200E000000U0000k000k00k0000A00M000008000000k00008001k00k0000300M000004000000E00006001k00k00000k0M000002000000M00001001U00k00000M0M000001000000800000k00U00k0000060M000000U00000A00800800k00M0000010A000000E00000600600600k00M000000kA000000800000600700100E00A000000M40000004000003002k00k0M004000s00460000002000003003800M08002001zU0220000001000001U0160060A000003Us01X0000000U00001U01V00304000003UA00lU00zU00E00000k00Uk00U2001U030200MU00ss00800000k00k800M3001U01U300AE00k600400000M00E60041U01U00zzU06800k1U0200000M00Tz0030U01U0000003A00k0k0100000A0000000UE01U0000001600M0800U0000A0000000M800k0000000X0080600E0000600000004400E0000000lU0403008000020000000320080000000Ek0301U040000300000000V0040000000MM01U0U020000100000000MU030000000s400M0k0100001U00000004E00U000001s20060k00U0000U00000003A00M007zzzk1003Uk00E0000k00000000W00700300000k00Tk0080000E00000000N001k00k03s0M00000040000M000000004U00400C0D704000000200008000000003M002001zw1U300000010000A00DzzzU00Y001000000M1U000000U000400A000M00P000k0000060M000000E00060060004005U00800000304000000800020060003003M006000000U3000000400030030000U00a001U00000E0k0000020001U010000M00H000E0000080A0000010000U01U0004008k00A00000403000000U000E00U0003004A00300000200k00000E000A00k0000U023U00s0000300A001008000600E0000M030M00C00001U03U01k0A0001U0M000040307001k0003U00Q03w060000Q0M000030300s00C00070003sDbUS00007UA00000k7007U01w00y0000Dy0zw00000wQ00000AS000z007zzk000000000000003s000003w0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_magic_hills()
{
    Text:="|<>**50$197.000000001zw000000000000000000000200000000D0C000000000000000000000Q00000000M0A000000000000000000000k00000001U0A000000000003zU0003zk300000000300M00000000000S3k000D1s600000000600E00000000001U0k000k0MA00000000800U0000000000200k00300EE00000000E0100000000000A00U00600kU00000000U0200000000000M01000801V00000000100400000000000k02000E03200000000300800000000001004000U02600000000600k00000000002008001004A00000000A01U0000000000400E002008M00000000A0200000000000800U00400EM00000000Q0Q00000000000E01000800Us00000000Tzk00000000000U02000E010k0000000000000000000001004000U0200000000000000000000000200800100400000000000000000000000400E00200800000000000000000000000800U00400E000Dy0zw03zU000Tzs00000E01000800U003wT7US0Tjk007k1y00000U02000E010k0S03g061U0k00s00C00001004000U02301k01k0A200k0700070000200800100440C001U08A01U0M00030000400E002008M0s00000EM0103U0003U000800U00400Ek3000000Uk020C000030000E01000800V0A00000110040s000030000U03zzzk0120s00000220083U000020001007zzzU0241U000004400E60000040002000000004860000008800UM0000080004000000008EM000000EE010U00000k000800000000EUk000000UU023000001U000E00000000V10000001100440000060000U000000012600000022008M00000A000100000000248003U004400EU00000k00020000000048E00zk008800V000zU300004000000008FU03Us00EE0160071kC0000800000000EX00C0k00UU02A00Q1ss0000E00000000V400M0k011004E00k0z00000U000000012801U0U022008U03000000010000000024E0301U04400F0060000000200Dzzz0048U0403008800W0080000000400E002008F00A0600EE01400E0000000800U00400EW00M0800UU02800U0000000E01000800V400M0k011004E01U0000000U02000E012A00M30022008U0100w00001004000U024M00sA004400FU0307y000020080010048E00Tk008800X003UsC0000400E002008EU00C000EE012003zU60000800U00400EVU000000UU024000s060000E01000800V100000011004A00000A0000U02000E012300000022008800000A0001004000U02460000004400EM00000A0002008001004860000008800UE00000M000400E002008E6000000EE010k00000E000800U00400EUA000000UU020k00000U000E01000800V0A00000110041U000010000U02000E0120A00000220081U000060001004000U0240C000004400E1U0000M000200800100480C001008A00U1k0001k000600E00200ME0600600EM0300k00070000A00U00400kk07U0w00UE0600s000s0000803000A010U03wT8010k0M00Q003U0000M0A000A061U00zkk020s3k00D00w00000Q1k000C0s1U1s01U040zy0007zz000000Dz0000Dz010Dw0600800000000000000000000000000kQ0M00E000000000000000000000000030C1k01U0000000000000000000000000A07y00300000000000000000000000000M00k00400000000000000000000000001U00000M00000000000000000000000003000000k0000000000000000000000000400000300000000000000000000000000800000400000000000000000000000000E00000M00000000000000000000000000U00001U00000000000000000000000001U00006000000000000000000000000001U0000M000000000000000000000000001k0001U000000000000000000000000001k000C0000000000000000000000000000s001k0000000000000000000000000000S00D00000000000000000000000000000Dk7k000000000000000000000000000001zw0000000000000000000000000001"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_space_center()
{
    Text:="|<>**50$199.00000000000000000000000DU0000000000000000000000000000007zzk00000000000000000000000000000T00T00000000000000000000000000001w000w0000000000000000000000000003k00070000000000000000000000000007U0000s00000000000000000000000000700000700000000000000000000000000C000001k0000000000000000000000000C000000A0000000000000000000000000C00000060000000000000000000000000A00000010000000000000000000000000A0000000U000000000000000000000000A0000000E000000000000000000000000A0000000800000000000000000000000060000000400000000000000000000000060000000600000000000000000000000020001z0060000000000000000zw00000030007vw030007z0007zz0000Dzzs000001000C07U3001zXz00DU3w000S00D000001U00Q00s3003k01k0Q007U00s000s00000U00Q007700700000s000s01k000C00000k00M000z00C00000k000701k0001U0000M00M000000C00001k0001k1U0000M0000800M000000A00001k0000M1U000060000400A000000A00001k000061U00001U000600A000000A00001k000011U00000E0003004000000A00000k00000VU00000A0001U06000000A00000k00000Ek0000020000U03000000600000E00000Mk000001U000E01000000600000M00000AM000000k000800U00000300000800000AM001k008000400E000003000C0A000006A003z0040002008000001U00Ts400000640071k030001004000000U00sC2001z0620070M01U000U02000000E00k31003Us730060400k000E01000000M00k0UU03U771U030600M000800k00000A00M0k001U1y0U01zz00A000600M00000400Dzk001U000E0000004000300400000200000000k000800000020000U0300000100000000E000400000010000E01U00000U0000000800020000001U000800M00000E0000000400010000000U0006006000008000000030000U000000k0001001U001s400000000U0S0E000001k0000U00s003j200000400M0zkA000003k0000M0070071lU000020071kQ600DzzzU00004001s0C0Mk01zzz001zk31006000000003000DUy06800k00U00700kU01U07k00000U000zs01Y00A00s000008M00Q0SC00000M0000000H003U3o000006A003zs30000060000000BU00Tz3000001W000000k0000100000002E00000U00000lU00000A00000k0000001A00000M000008E00000600000A0000000W000006000004A0000010000030000000FU000030000023000000U00000k0000008M00000k000030U00000E00000C000000A400000A000030M000008000003U00000A3000003U0003U6000004000000M00000A0k00000M0003U1k00006000000700000Q0C000007000700Q000030000000s0000s03U00000s007003U0007000000070001k00Q000007U0S000Q000C00000000w007U003U00000zzs0003s03w000000003w1y0000T00A000000000Dzzk0000000007zk00001zzx"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_alien_spaceship()
{
    Text:="|<>**50$199.s000000000000000000000000000000007000000000000000000000000000000001U0000000000000000000000Dzs0000000M0000000000000000000000zUTk000000A0000000000000000000001s00T00000020000000000000000000003U001s00000100000000000000000000030000C000000U00000000000000000000300001U00000E00000000000000000000300000M000008000000000000000000003000006000004000000000000000000003000001U00006000000000000000000003000000k00003000000000000000000001U00000800001000000000000000000001U00000400003U00000000000000000000k00000600007U00000000000000000000E00000300000000000000000000000000M00000300000000000000000000000000A00Dw01U0000000000000000000000000600C701U000000001zw00000000000000200A0s1U0000A000Dzzs003zU3zU0000010040C1U07z0DU00S00D007lwDny000000U0201zU0DXswM00s000s0603C03k00000E0100D00A0Ds601k000C0200w00Q00000800k0000401k301k0001U300Q00300000600A0000600k1U1U0000M1U0A000s00003003k00030000E1U000060k00000C00001U00TU001U00081U00001UE00000300000E000zU00U00041U00000k8000000k0000A0001y00E00021U00000A4000000A0000600003k0800010k000002200000060000100000D040000Uk000001V0000001U0000k00001k20000EM000000kU000000E0000A00000A100008M001k008E000000A000070000030U0004A003z0048000000600001k00000kE000240071k034000000100000Q00000M8000120070M01W001zU00k00003U000064003UX0060400l001ks00M00000w000012003UFU030600MU01U600A000007k0000l00308U03zz00AE01U1U02000000S0000MU0304E0000006800k0k010000001w0004E01U280000002400E0800U0000007s002800U14000000120080400E0000000D001400E0W0000001V0040300800007s00s00W0080F0000000UU0201U040000CD00A00F00608U000000kE0100k020000C1k03008U0304E000001k800U0M010000A0Q01U04E00k2A000003k400E0A00U000A0300k02800A1600DzzzU20080600E000600k0k014003UX0060000100403008000600A0M00W000EEU01U0Dk0U0201U040002003Us00F00008M00Q0SC0E0100k020001000Tk00MU0004A003zs3U800U0M010000U000000AE00022000000k400E0A00U000M0000004800011U00000A20080600E000A000000640000UE0000061004030080003000000320000EA0000010U0201U040001U0000031000083000000UE0100k020000M0000030U00040k00000E800U0M0100006000001UE00020M000008400E0A00U0001U00001U800010600000430080600E0000M00001U40001U1k000061U0A0300M0000700003U200M0k0Q000030E0600U0A00001k0003U100D0k03U00070A0600M0A00000C000D00U06xs00Q000D03UC007US000001s00S00E037k003s03y00zy000zw000000Ds7w00801U0000Dzzk0000000000000000TzU00400k00000000000000000000000000000200M00000000000000000000000000000100A000000000000000000000000000000U06000000000000000000000000000000E03000000000000000000000000000000801U00000000000000000000000000000400k00000000000000000000000000000200M00000000000000000000000000000100A000000000000000000000000000000U06000000000000000000000000000000E03000000000000000000000000000000801U00000000000000000000000000000400k00000000000000000000000000000300M000000000000000000000000000001U0A4"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_fabled_kingdom()
{
    Text:="|<>**50$199.000000000007zs0000000000000Tz00000000000000070C0000000000000s0s00000000000000601U0000000003s0M0A00000000000000300k0000Dy000770M030000000000000010080000S3k0070kA01U00000000000000U040000M0A0060A600E00000000000000E020000803006032008000000000000008010000A00U0700l00400000000000000400U000600E0300AU0200000000000000200E000200803002E01000000000000001008000100403001A00U00000000000000U040000U0203000a00k00000000000000E020000E0103000H00M000000000000008010000800U3000Mk0800000000000000400U000400E30008Q0Q00000000000000200E00020081U00A7zw00000000000000100800010041U00A000000000000000000U040000U021U00A000000000000000000E020000E011U00A000000003zk00000008010000800VU00C00000000zzzU0000Dw400U000400FU00C01z00Tw1s00w0000zzm00E0002009U00C07lw0w7XU003U001s0D0080001005U00606030k0N0000s003U03U040000U02k0060200UE0500006003U00E020000E01k0060300MM03U0001U030000010000800k00601U04A01U0000M03000000U000400E00600U0240000000603000000E000200000600E01200000003030000008000100000600800V00000000k300000040000U0000C00400EU000000081U0000020000E0000C002008E000000061U000001000080000C0010048000000030U000000U00040000C000U02400007000Uk000000E00020000C000E0120000Dw00EE0000008000100006000800V0000Q700AM00000040000U0003U00400EU000Q1U06A007w0020000E0000s002008E000M0E0340077001000080000C0010048000A0M01W0060k00U000400003U00U0240087zw00l0060A00E000200000M00E01200400000NU0606008000100000600800V006000008k03010040000U00001U0400EU02000004M0100k020000E01000M02008E01000006A00U0M010000800k00601004800U00002600M0A00U000400Q001U0U02400E00003300A0400E000200/000M0E012008000071U03060080001005U00C0800V0040000D0E00k60040000U02M003U400EU020zzzy0800Q60020000E016000k2008E010M00006003y0010000800VU00A1004800U600T030000000U000400EM0030U02400E1k1ss0U000000E00020086000kE0120080DzUC0M000000800010041U00A800V004000030A00000040000U020M003400EU0200000k300000020000E010A000W008E0100000M0U0000010000800U3000N004800U000040M000000U000400E0k004U02400E0000206000000E00020080A002E0120080000101U000008000100403001800V00400000U0M0000040000U0200k00Y00EU0200000E060000020000M0100A00m008E0100000M01U008010000A00U0300lU0AA01U0000A00Q00C01U000200k01U0kE06200a0000Q003U0TU0k0001U0k00M0kA061U0lk000w000T1ww3k0000Q1s0070k3U60Q1kDU0Dk0001zk7zU00003zk001lk0zy03zU0zzz00000000000000000000DU0000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_ruined_city()
{
    Text:="|<>**50$199.0000000000000000zz000000000000007U000000000000000s1k000000000000060000000000000000k0A000000001w00060000000000000000M0600000000zzy006000000000000000080100000003s03s030000000000000000400U000000DU007U1U000000000000000200E000000S0000w0U0000000000000001008000000w000070E0000000000000000U04000000s00000s80000000000000000E02000001k00000C40000000000000000801000001k000001X0000000000000000400U00001k000000lU000000000000000200E00001U0000008k000000000000000100800001U0000004A0000000000000000U0400001U000000270000000000000000E0200001U00000011w00000000000000080100000k0000000U0000000000000000400U0000k0000000k0000000000000000200E0000E000Ds00k0000000Ty000000010080000M000zzU0M0000007zzw00001zUU0400008001s0w0M0w0000D007U0007zyE020000A003U070M1zU000Q000Q000D01s0100004003U00ss1Us000s0007000S00Q00U00060030007s0U6000s0000k00Q00200E0003003000000k1k00k0000A00M0000080001003000000M0Q00k0000300M0000040000U01U00000A0600k00000k0M0000020000k01U00000401U0k00000M0M0000010000M00U00000200M0k0000060M000000U000A00k00000100A0M0000010A000000E000400M000000U030M000000kA00000080002008000000E00UA000000M400000040001004000000800MA000s004600000020000U02000000400A6001zU02200000010000E0100000020022003Us01X0000000U000800U000001001V003UA00lU00zU00E000400E000000U00lU030200MU00ss0080002008000000E00Mk01U300AE00k60040001U060000008004E01zzU06M00k1U020000k03000000400280000003A00k0k010000M00U00000200140000001600M0800U000A00M000001000W0000000X0080600E000200A000000U00F0000000lU04030080001003000000E008U000000Ek0301U040000k00k000008004E000000MM01U0U020000800Q000D040028000000sA00M0k0100006007000zs20016000001s200C0k00U0003000s00sC1000X007zzzk1003Uk00E0000U00D01k30U00FU0300000k00Tk0080000M001w7k0kE008E00k07s0M0010004000040007z00A8004A00C0D7040000002000030000000240026001zw1k3000000100000k0000001W0011000000M1U000000U0000M0000000F000Uk0000060M000000E0000600000008U00E800000304000000800001U0000004E0086000000U3000000400000M000000280041U00000E0k000002000006000000140020M0000080A000001000001k000001W0010A00000403000000U00000Q000001V000U300000200k00000E000003000003Uk00k0s0000300A001008000000s00003UM00M0C00001U03U01k0A0000007000070400M01k0003U00Q03w0C0000000s000C0330w00C0007U003sDbUS00000007U00w00tzs001w01z0000Ty0zw00000000zUDk00D000007zzs000000000000000000zy0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_puppet_island()
{
    Text:="|<>**50$199.00000000000000000000000000000000TU0000000000000000000000000000000Q00000000000000000000000000000000A00000000000000000000003zk0000000A00000000000000000000007Uw0000000600000000000000Dw0000006030000000300000000000000zDk00000200k000000100000000000000M0Q00000300M0000000U0000000000000M06000001U040000000E0000000000000801000000k02000000080000000000000400U00000M01000000040000000000000200E00000800U00000020000000000000100800000400E000000100000000000000U040000020080000000U0000000000000E020000010040000000E0000000000000801000000U02000000080000000000000400U00000E01000000040000000000000200E00000800U00000020000000000000100800000400E000000100000000Tz0000U04000002008007zU00UDU00003zzy00Dk03zk000100401zzz00E7y00007U03k0Ds01zy0000U0203k01w0801k000C000C0A00001U000E01070003U400C000Q0003U400000M000800U70000Q2003U00Q0000M600000A000400E6000061000M00M0000630000020002008600001UU00600M00001VU000010001004300000kE001U0M00000MU00000U000U02300000M8000M0M00000AE00000E000E011U0000A400060M0000038000008000800UU00004200030A000000Y000004000400EE0000610000kA000000P0000020002008M000020U00086000000BU000030001004A01zk30E00066000Q002k00001U000U02600kS30800033000zk01A00001U000E01300M1z040000l001kQ00r00003k000800VU0DU0020s00MU01k600Mz00DzU000400EE01zU010C00Ak01U100A0U040000020088000y00U1U02M00k1U060E0200000100440001s0E0k01800zzk030801000000U0230000D080A00Y0000001U400U00000E011U0001k40200G0000000U200E00000800UE0000A2010090000000E100800000400EA00003100U04U000000M0U04000002008300001UU0k02E00000080E020000010041k0000ME0M018000000A0801000000U020Q0000A80M00Y000000Q0400U00000E0107U000240M00H000000w0200M00000800U0w000120s00NU03zzzs0100A00000400E07U000l0E00Ak01U00000U020000020083yz000MU0004800M03w00E01z0000100433lz00AM0006600707XU08001s0000U0230S1k06A00023000zy0s0400060000E011U3kM03600030U00000A030001U000800VU0Ds01X00030M00000301U000k000400EU00000UU001U4000001U0k000M0002008k00000EE001U3000000E0800040001004E0000088001U0k0000080600020000U02800000A6001U0A0000040100010000E0140000063001U0600000200k000U000800W0000060U01U01U0000100A000k000600FU000020M03U00Q00001U03000M0003008Q000030607U00700000k00s0080000U0A70000703UT0000s0001k00D00A0000M0A0w000D00zw000070003k001y0Q000070S07U00y006000000y00zU0007zw00001zw00TUTs0000000003zzw00000000000000000zy0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_virtual_dungeon()
{
    Text:="|<>**50$199.000000000000zzU000000000000000000000000000000s0s000000000000000000000000000000M0A000000000000000000000000000000M03000003zzzzk0000000000000000000A01U00003k001zU000000000000000000600E0000300001w000000000000000000300800001000007U00000000000000000100400001U00000w000000000000000000U0200000k000007000000000000000000E0100000M000000s00000000000000000800U0000A000000C00000000000000000400E000040000003U00000000000000002008000020000000M00000000000000001004000010000000600000000000000000U0200000U0000001U0000000000000000E0100000E0000000M0000000000000000800U000080000000A0000000000000000400E0000400000003000000000000000020080000200000000k000000000000000100400001007zw000M00000zw0007y0Ty0U0200000U0207U0060Dy01sDU00zzsyDkE0100000E0100Q0030S3k1U0k01s0Cs0M800U0000800U07000kM0A0U0A01k01s06400E0000400E00k00M8030k0601U00M0120080000200800A004A01UM0103U00400V00400001004003003600EA00U3U00000EU0200000U02000k01X008600E1U000008E0100000E01000M00l00430081U000004800U0000800U006008U021U041U000002400E0000400E003004E010k021U000001200800002008000U02800UM010k000000V00400001004000M01400EA00Uk000000EU0200000U02000A00W008600EE0000008E0100000E01000600F0043008M0000004800U0000800U003008U021U04A0000002400E0000400E001U04E010k024007w001200800002008000k02800UM0160073U00V00400001004000M01400EA00X0060s00EU0200000U02000800W008600FU060A008E0100000E01000A00F0043008U0303004800U0000800U006008U021U04E0101U02400E0000400E00600AE010k02800U0E01200800002008003006800UM01400k0800V00400001004003002400E800W0080400EU0200000U020030033008400F00606008E0100000E01003001VU062008U0306004800U0000800U07000Uk030004M00k7002400E0000400E07000kM00k002A00C70012008000020080S000M400C0012003y000V00600001007zw000M2003k00VU000000Ek03y0000U000000081U00000Ek0000008M003U000E0000000A0k00000880000004A000E00080000000A08000004600000026000A00040000000A060000021000000110006000200000006030000010k000000UU00100010000000600k00000UA000000EE000U000U000000600800000E30000008A000E000E00000060060000081k000004600080008000000C001U000040Q000002100040006000000C000M00E02070000010k0020003000000Q000600M0301k00400UA0030001U00000Q0001U0A01U0C00700k7001U000E00000s0000Q0301U03k0DU0k1s00U000A00003k00007U0w3k00T1wS1s0Dk1k0003k000zU00000z07zU001zs3zk00zzk0000Tzzzw0000003zU"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_snowy_kingdom()
{
    Text:="|<>**50$199.000000000000000000000000000000000U00000000000000000000000000000001k000000000000000000000000000007k0k000000000000000000000000Ty000CS0k000000000000000000000000w7U00C1UM000000000000000000000000k0M00A0MA000000000000000000000000E0600A066000000000000000000000000M0300C01W000000000000000000000000A00U0600N000000000000000000000000600E06004k00000000000000000000000200806002M00000000000000000000000100406001A000000000000000000000000U0206000a000000000000000000000000E0106000lU00000000000000000000000800U7000Ms00000000000000000000000400E7000MA0000000000000000000000020083000M00000000000000000000000010043000M0000000000000000000000000U023000M00000000000000DU000C00000E013000Q000zs00TU01zU0zs000Tw0000800X000Q001s600sw01kQ0s6000M7U000400H000Q0A1k1U0k301U3Vk1U00M0s000200/U00Q0A1U0E0k0k0U0tk0M00A060001007U00Q041U0A0k0A0k0Ak0A00A01U000U03U00Q060k060E060E03k0300600k000E01U00Q030E01UM010M01s01U06008000800U00Q01Y800kA00kA00s00M03004000400000Q00W60084008400S00603002000200000Q00FX0066006600D00301U03000100000Q008MU0330032004k00k0U010000U0000Q0044M00V000X006M00M0k01U000E0000Q0023A00NU00NU0360060E00k00080000Q0010X00AU00AU0330010M00k00040000Q000UNU03k002k01Uk00k800M00020000A000EAE01s001s00U800AA00M00010000700082A00M000s00k6006600A0000U0001k0041600A000A00E1U01a0040000E0000Q0020lU06000600M0k00H00600008000070010Mk00000000A0A00B0020000400001k00UA800000000402003U030000200000Q00E2600000000601U01U01U00010000070081100000000200M00E01U0000U02001k040Uk0000000300A00000k0000E01U00Q020kM00000001U0300000k0000800s007010M400000000U00U0000M0000400S001k0UA300000000k00M000080000200/U00Q0E60U000U000E0060000A00001004k0070820M000M000M0030000400000U02A001k410A000A000A000k000600000E013000M21U2000D000A0008000300000800Uk00610k1U007U0060006000300000400EA001UUE0E002E0020001U001U000020083000MEM0A003A0030000k001U000010040k006880600160010000A000k00000U020Q0014A01U01V001U0002000E00000E0106000mA00k00kk00k0001U00M00000800U1U009400800E800E0000M00800000400E0M004W00600M600M0000A00A00000200806002E00100A30080000200400000100401U018000k040U0A00003006000000k0200M01a000M060M0600001003000000M0100601X000606060600001U03000000401U03U1UU001U703U600000k01U00000301U00k1UM000s700s600000k00U000000s3k00C1U60007y007y00000M00k0000007zU003XU100000000000000M00E000000000000T0000000000000000A00M00000000000000000000000000000400800000000000000000000000000000600A000000000000000000000000000002006000000000000000000000000000003006000000000000000000000000000001U03000000000000000000000000000001U01000000000000000000000000000000k01U00000000000000000000000000000E00U00000000000000000000000000000M00k00000000000000000000000000000A00E00000000000000000000000000000600M00000000000000000000000000000300A000000000000000000000000000000U0A000000000000000000000000000000M060000000000000000000000000000007060000000000000000000000000000000s70000000000000000000000000000000Dz00000000000000000000000000000000y000000000000000008"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_dungeon_throne()
{
    Text:="|<>**50$199.000000000000000000000000000000001U00000000000000000000000000000003k00000000000000000000000000000001U0000000000000000000003zzzzzzzzz1U0000000000000000000003k00000001kk0000000000000000000001U00000000AM0000000000000000000001U000000002A0000000000000000000000k000000001a0000000000000000000000M000000000m00000000000000000000008000000000N00000000000000000000004000000000AU00000000000000000000020000000006E0000000000000000000001U00000000380000000000000000000000k000000001400000000000000000000008000000001W00000000000000000000007000000001l00000000000000000000001zzzk03zzzkU0000000000000000000000000801U000E0000000000000000000000000400k000800000Ty000000000000000000200M000400003y7w000Dy0Dy000000000100A000200007U07U00T7kzDs000000000U0600012000D000w00M0As0D000000000E030000VU00C000700803k01k00000000801U000EM00Q0000s0A01k00A00000000400k0008600Q0000C0600k003U0000000200M00041U0Q00003U3000000k0000000100A00020M0M00000s1000000A00000000U0600010A0Q00000A0U00000300000000E030000U30A0000030E000000k0000000801U000E0UA000000k8000000M0000000400k00080MA0000008400000060000000200M00040A60000006200000010000000100A0002022000000110000000k0000000U0600010130000000kU000000M0000000E030000U0l000zU00ME00000040000000801U000E0MU00sQ0048007y0030000000400k00080Ak00k300240073U01U000000200M000406M00k0k01W0060M00k000000100A000203A00k0A00l006060080000000U06000101Y00M0600MU03010040000000E030000U0W0080100AE0100U020000000801U000E0F00400U02800U0E010000000400k00080MU0200E01400E0A00U000000200M000408E0100801W0080600E000000100A00020A800k0A00l004030080000000U0600010Q400M0400MU0201U040000000E030000Uw30060600AE0100k020000000801U000Es1U01UC004800U0M010000000400k000800E00QS002400E0A00U000000200M0004A08003w00320080600E000000100A00023U60000001V004030080000000U0600010s10000000UU0201U040000000E030000UA0k000000kE0100k020000000801U000E308000000E800U0M010000000400k00081U6000000M400E0A00U000000200M00040E1U00000M20080600E000000100A0002080M00000M1004030080000000U060001040A00000A0U0201U040000000E030000U20300000A0E0100k020000000801U000E100s0000Q0A00U0M010000000400k000A1U0C0000Q0600k0A01U000000300M00060k01k000s0100M0200k0000001U0800011k00S000s00k0M01U0k0000000M0A0000nk003k03k00C0s00S1s0000000D0Q0000DU000TkzU003zs003zk00000001zw0000300000zw00000000000000000000000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_mountain_temple()
{
    Text:="|<>**50$199.0000000007zk000000000000000000000000000000D0S000000000000000000000000000000603000000000000000000000000000000600k000000000001zzzzzzzzw00000000300M000000000001s00000000000000001U04000000000000k00000000000000000k02000000000000k00000000000000000M01000000000000M00000000000000000A00U00000000000A00000000000000000600E000000000004000000000000000003008000000000002000000000000000001U0A000000000001U00000000000000000k06000000000000k00000000000000000A02000000000000M000000000000000007070000000000004000000000000000001zz0000000000003U000000000000000003s0000000000000zzzs01zzy000000000000000000000000000400k00000000000000000000000000000200M00000000000000000000000000000100A000001zU7zU0zs07z07z0000000000U0600400DzyDXw1zz0DXsTbw000000000E0300300S03i061U0kA06Q07U00000000801U00k0Q00S01UU0A401s00s00000000400k00M0M00600Ek06600s00600000000200M0040s001008M03300M001k0000000100A0020s000004A00VU00000Q00000000U060010M000002400EU00000600000000E03000UM0000012008E000001U0000000801U00EM000000V0048000000M0000000400k008M000000EU024000000A0000000200M004A0000008E01200000030000000100A00KA0000004800V0000000U0000000U0600/40000002400EU000000M0000000E0300D600000012008E000000A0000000801U07X0000000V004800000020000000400k021001z000EU024003z001U000000200M011U01ks008E012003Vk00k000000100A01Uk01UC004800V0030A00M0000000U0600kM01U3002400EU03030040000000E0300M800k0k012008E01U1U020000000801U08400E0M00V004800U0E010000000400k0420080400EU02400E0800U000000200M02100A02008E0120080600E000000100A010U0201004800V004030080000000U0600UE01U1U02400EU0201U040000000E0300E800k1U012008E0100k020000000801U08600A1k00V004800U0M010000000400k063003Vk00EU02400E0A00U000000200M030U00zU008E0120080600E000000100A01UM0000004800V004030080000000U0600EA0000002400EU0201U040000000E0300A200000012008E0100k020000000801U071U000000V004800U0M010000000400k01UE000000EU02400E0A00U000000200M00kA0000008E0120080600E000000100A00830000004800V004030080000000U060040k000002400EU0201U040000000E030020Q0000012008E0100k020000000801U0107000000V004800U0M010000000400k00U1k00000Ek02600E0A00U000000200M00E0Q001008M03300M0600k0000001U0A00003U01k0A401UU0A0100M0000000k0400000w03w0A301UM0A00k0M0000000A06000007kT7US0s3k70Q00D0w00000007UC000000Ty0zw0DzU1zw001zs00000000zy000U"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_rain_village()
{
    Text:="|<>**50$199.0003zs000000000000000000000007zk1U007U700000000000000000000000D0C1k00301U00000000000000000000006030k00300M0000000000003z000000zs600kk001U0A0000000000007Uk00000sD300MM000k0200000000000070A00000M1lU04A000M01000000000000C0300000M0Ck026000A00U00000000000601U0000A03E012000400E00000000000600M0000A00w00V000300800000000000300A0000600S00EU001U0400000000000100200002007008E000k06000000000000k01U0003007U0A8000M03000000000000M00E0001003k064000601000000000000400A0001U01A0220003U3U0000000000030060000k01b0710000zzU000000000001U01U000k00lzz0U0001w0000000000000M00k000M00k1s0E000000000000000000A00A000M00M00080000000000000000003006000A00M00040000000000000000001U01U00A00A00023zk0Tw03zU3zU000000M00k00600A0zs17ly0zzU7lwDny000000A0080020061zz0X030k0M603C03k0000030060030061U0kF00kE06200w00Q000001U010010030U0A8008M03300Q003000000M00k01U030k064004A01VU0A000s00000A00M00U01UM012002600Ek00000C00000300600k01UA00V0012008E000003000001U0300M00k400EU00V0048000000k00000M00k0M00k2008E00EU024000000A00000A00M0A00M10048008E01200000060000030060A00M0U024004800V0000001U00001U030600A0E012002400EU000000E00000M00U200A0800V0012008E000000A00000A00M30060400EU00V00480000006000003004100602008E00EU0240000001000001U031U03010048008E012001zU00k00000M00UU0300U024004800V001ks00M00000A00Mk01U0E012002400EU01U600A00000300AM01U0800V0012008E01U1U02000001U03M00k0400EU00V004800k0k01000000M01g00k02008E00EU02400E0800U00000A00Q00M010048008E0120080400E00000200C00M00U024004800V00403008000001U0200A00E012002400EU0201U04000000E0000400800V0012008E0100k02000000A0000600400EU00V004800U0M01000000200002002008E00EU02400E0A00U000001U00030010048008E0120080600E000000E0001000U024004800V00403008000000A0001U00E012002400EU0201U0400000020000U00800VU012008E0100k020000001U000k00400Ek00V004800U0M010000000E000E002008M00EU02400E0A00U000000A000M001004A008E0120080400E00000020008000U022004800V004020080000001U00A000E011002400EU0201U040000000E004000800Uk012008E0100U020000000A006000400EM00V004800U0M01000000020020002008400EU02400E0A00U0000001U0300010043008M0130080600E0000000E010000k020U04A01VU0A0300M0000000A01U000M030M06200kE0600U0A0000000301U000401U6061U0kA0600M0A00000001k1k000301U3kD0Q1s3UC007US00000000C3U0000s3k0Ty07zk0zy000zw000000003zU0000DzU0U"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_storm_hideout()
{
    Text:="|<>**50$199.000000000000000000000000000zy0000000000000000000000000000001s1k000000000000000000000000000000k0M000000000000000000000zw0000zw0k06000000000000000000001sD0001w7UM03000000000000000000001U0k000k0MA00U00000000000000000000U0A000k06600E00000000000000000000k06000M03300800000000000000000000M01000801V00400000000000000000000A00U00400kk0200000000000000000000600E00200MM01000000000000000000002008001004A01U00000000000000000001004000U02600k00000000000000000000U02000E011U0E00000000000000000000E01000800Us0s00000000000000000000800U00400EDzs00000000000000000000400E0020080T0000000000000000000002008001004000000000000000000000001004000U02000000000000000000000000U02000E010000000C07z0Dy007z000000E01000800U7z0000zkDXsS7s0T3s00000800U00400EDzs003wQA06M0C0w0700000400E002008A06007U6401s01ks01k00002008001004401U0D01a00s00Qk00A00001004000U02600k0C00n00M006k00300000U02000E01300M0A00NU08001k000k0000E01000800VU040A004U00000E000A0000800zzzw00EU020A006E00000000060000400Tzzy008E010A0038000000000100002000000004800UA001Y0000000000k0001000000002400E6000W000000000080000U0000000120086000l000000000040000E00000000V0042000MU00000000030000800000000EU023000ME0000000001U0004000000008E011000M80000000000E0002000000004800VU00s4007s003s0080001000000002400Ek0002007C00360040000U000000012008E00E100230031U020000E00000000V004800M0U030k01UE010000800000000EU02A00M0E01UM00UA00U0004000000008E01600M0800U400E600E000200Dzzz004800X00A0400E200810080001004000U02400FU040200810040U040000U02000E012008k02010040U020E020000E01000800V004M01U0U020E0108010000800U00400EU02A00k0E010800U400U000400E002008E01600A0800U400E200E0002008001004800V0070400E200810080001004000U02400EU01U200810040U040000U02000E012008M00010040U020E020000E01000800V004A0000U020E0108010000800U00400EU0220000E010800U400U000400E002008E011U000800U400E200E0002008001004800Uk000400E200810080001004000U02400EA000200810040U040000U02000E012008200010040U020E020000E01000800V0041U000U020E0108010000800U00400EU020M000E010800U400U000400E002008E0106000800U400k200E0003008001004800U1U00600E200M10080001U04000U06600E0M00300M1U0A0U040000k06000M03300M06000U0A0k040M060000803000A010U0A01k00M0A0A060A030000603000301UM0A00C0070S07UC03k700001s7U000s3U70S001w01zw00zy00Ty00000Dz0000DzU1zw000DU"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_haunted_mansion()
{
    Text:="|<>**50$199.000000000000000003zw0000000000000000000000000000003U7000000000000000000000000000000300k000000000000000000000000000001U0M00007z000000000000000000000000U040000Dns000000zk000000000000000E020000A06000001zz0000000000000008010000401U00001U1k00000000000000400U000600M00001U0M00000000000000200E000300600001U040000000000000010080001U0300000k02000000000000000U040000k00k0000k01000000000000000E020000E00A0000k00U00000000000000801000080030000k00E00000000000000400U0004001k000s00800000000000000200E0002000M000M00400000000000000100800010006000M002000000000000000U040000U001U00M001000000000000000E020000E000s00Q000U0000000000000080100008000A00A000E00003zs0000000400U0004000300A000Dz000Tzzk00007y200E00020000k0A0007zs00w00S0000Tzt00800010000A0A00000601k001k000w07U040000U000606000001U3U000Q001s01k020000E0001U6000000k3U0003001k00801000080000M60000008300000k01U00000U00040000660000004300000A01U00000E00020000330000002300000301U000008000100000n00000013000001U1U0000040000U0000D0000000X000000M1U0000020000E000030000000FU0000040k0000010000800U01U0100009U0000030k000000U000400E00000U000Ak000001UE000000E000200A00000k0006k003U00EM0000008000100700000s0006M007y008800000040000U02k0000o000D800C3U06A00000020000E01M0000O00zy400C0k036003y0010000800a0000N00E0600A0801W003XU00U000400FU000MU08030060A00l0030M00E0002008k000AE0401007zy00MU03060080001004A000A80200U000000Ak03030040000U023000A40100E0000004M01U0U020000E010k00A200U080000002A00U0M010000800UM006100E040000003600E0A00U000400E60060U08020000001300A0600E00020081U060E04010000001VU060200800010040M07080200U000003Uk01U30040000U020A030401U0M000007U800s30020000E0103030200k0A00Tzzz0400C30010000800U0s7010080600A00003001z000U000400E07z00U07w100300TU1U004000E000200800000E007Uk00s0wQ0E00000080001004000008000MM007zk70A00000040000U0200000400064000001U600000020000E0100000200033000000M1U0000010000800U000010001Uk00000A0E000000U000400E00000U000EM0000020A000000E000200800000E00086000001030000008000100400000800041U00000U0k0000040000U0200000500020k00000E0A0000020000E01000002k0030A000008030000010000A00U00001A001U3U0000A00k00400U000600k00000nU00U0s0000600C00700k000100M00000Mw00k070000C001k0Dk0s0000k0M0000047s1k00s000S000DUyS1s0000D0s0000000Tzk007k07w0001zs3zk00001zs0000000000000TzzU0000000000000000000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_nightmare_train()
{
    Text:="|<>**50$199.000000000000000000000000zzzzzzzzzU00000000000000000000000w00000000E00000000000000000000000M00000000000000000000000000000000M00000000000000000000000000000000A000000000000000000000000000000006000000000000000000000000000000002000000000000000000000000000000001000000000000000000000000000000000k00000000000000000000000000000000M00000000000000000000000000000000A000000000000000000000000000000002000000000000000000000000000000001k00000000000000000000000000000000Tzzw00zzzk00000000000000000000000000200M00000000000000000000000000000100A000000000000000000Tz0000000000U060000zk3zk0Tw0zy003zzy000000000E030007zz7ly0yDVk7k07U03k00000000801U01j01r030k0PU0Q0C000C00000000400k01i00D00kE07U060Q0003U0000000200M00Y003008M03001UQ0000M0000000100A00k000U04A00000kM0000600000000U0600M000002600000MM00001U0000000E0300A0000012000004M00000M0000000801U04000000V000006M00000A0000000400k02000000EU00003M0000030000000200M010000008E00001g000000U000000100A00U000004800000g000000M0000000U0600E000002400000q000000A0000000E03008000001200000S000Q0020000000801U04000000V00000P000zk010000000400k02000000EU00TkN001kQ00k000000200M0100zU008E00QTsU01k600M000000100A00U0sQ004800M00k01U100A0000000U0600E0k7002400M00M00k1U060000000E030080k1U01200800800zzk030000000801U040M0M00V0040040000001U000000400k02080A00EU020020000000U000000200M010402008E010010000000E000000100A00U601004800U00U000000M0000000U0600E100U02400E00E00000080000000E030080k0k012008008000000A0000000801U040M0k00V004004000000Q0000000400k02060s00EU02003000000w0000000200M0101ks008E01001U03zzzs0000000100A00U0Tk004800U00k01U00000000000U0600E000002400E00800M03w00000000E03008000001200800600707XU0000000801U04000000V004003000zy0s0000000400k02000000EU02000U00000A0000000200M010000008E01000M0000030000000100A00U000004800U006000001U0000000U0600E000002400E003000000E0000000E030080000012008000k0000080000000801U04000000V004000A0000040000000400k02000000EU0200060000020000000200M010000008M010001U000010000000100A00m000U04A01U000Q00001U0000000k0600Nk00s06600k000700000k0000000M0200AS01y061U0k0000s0001k00000006030033sDXkD0Q1s000070003k00000003k7000kDz0Ty07zk00000y00zU00000000Tz0008000000000000003zzw000000000000002"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_future_city()
{
    Text:="|<>**50$199.000000000000000000000000000001zw0000000000000000000000000000003U3U0000000000000000000000000C0001U0k000000000000000000000000DzzU00U0A000000000000000000000000y00y00k06000000000000000000000003k001s0M01000000000000000000000007U000C0800U0000000000000000000000700001k400E0000000000000000000000C00000C20080000000000000000000000Q000003V0040000000000000000000000Q000000MU020000000000000000000000M000000AM010000000000000000000000M0000002A01U000000000000000000000M0000001300U000000000000000000000M0000000Vk1k000000000000000000000M0000000ETzk000000000000000000000A00000008000000000000000000000000A0000000A00000000000000000000000040003y00A0000000000000001zk0000006000Drs060000Dy03zU7zU00Tszk000002000Q0D0607w047U7kwC0S00w00S000003000s01k60T7kA0M603Q03U1k001k00001000s00CC0M0AA06200s00E3U000A00001U00k001w0802403300M00A3U000300000k00k00000A01a00VU00006300000k0000E00k00000600H00EU00001300000A0000800E000002009008E00000X0000030000A00M000001004U04800000n000000U0006008000000U02E02400000P000000M000300A000000E01801200000BU0000040001006000000800Y00V000005U0000030000U02000000400G00EU00006k000000U000E010000002009U08E00003k003U00E000800U000001004k04800003M007y008000400E000000U02A024003y3800C3U040002008000000E017012003Xz400C0k030001004000000800UU0V00300600A0801U000U02000000400E00EU030030060A00k000E010000002008008E01001003zw00M000A00k000001004004800U00U00000080006008000000U02002400E00E00000040001006000000E01001200800800000020000U01000000800U00V00400400000030000E00k00000400E00EU0200200000010000A00A000002008008E010010000001U00020030003k1004004800U00U000001U0001000k007C0U02002400E00M000007U0000k00A00C3UE01001200800A00Tzzz000008003U0Q0k800U00V00400200A000000006000S1w0A400E00EU0200100300DU000010001zk032008008E01000k00s0wQ00000k0000000V004004800U00M007zk600000A0000000MU02002400E004000001U0000200000004E010012008003000000M00001U0000002800U00V004000U00000A00000M0000001400E00EU02000M0000020000060000000W008008E010006000001000001U000000F004004800U001000000U00000M000000MU02002400E000k00000E000007000000ME010012008000A000008000000k00000M800U00VU0A0003U0000A000000C00000s600k00kE060000s000060000001k0001k100M00kA06000070000C0000000C0003U0k0M01k3UC00000s000Q00000001s00D00C0M1zk0zy000007k03s000000007s1w003zs000000000000Tzz0000000000DzU000000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_walled_city()
{
    Text:="|<>**50$199.s000000000000000TzU00000000000003i000000000000000Q0s00000000000007VU00000000000000M06000000000z00030k00000000000000A0300000000Tzz0030800000000000000400U0000001w01w01U400000000000000200E0000007k007k0k2000000000000001008000000D0000S0M1000000000000000U04000000S00003UA0U00000000000000E02000000Q00000Q40E00000000000000801000000s00000730800000000000000400U00000s000000lU400000000000000200E00000s000000Mk200000000000000100800000k0000004M1000000000000000U0400000k000000260U00000000000000E0200000k00000013UE0000000000000080100000k0000000Uw800000000000000400U0000M0000000k0400000000000000200E0000M0000000M02000000000000001008000080007w00M0100000Dz00000000U040000A000Tjk0A00U0003zjy00000zkE0200004000s0S0A0ME0007U03k0003yz80100006001k03UA0w8000C000C0007U0w00U0002001k00QQ0k4000Q0003U00C00C00E0003001U003w0E2000Q0000M00C0010080001U01U00000M1000M0000600A0000060000U01U00000A0U00M00001U0A0000020000E00U0000060E00M00000M0A0000010000M00k0000020800M0000040A000000U000A00E0000010400M0000030A000000E000600M000000U200A000000U60000008000200A000000E100A000000M60000004000100400000080U06000000A200000020000U0200000040E06000Q002300000010000E0100000020803000zk0110000000U000800U0000010401001kQ00lU000000E000400E000000U200U01k600Mk00Tk0080002008000000E100k01U100AE00QQ004000100400000080U0M00k1U06800M30020000U0300000040E0800Tzk03400M0k010000M01U00000208040000001600M0M00U000A00E00000104020000000X00A0400E000200A000000U2010000000FU04030080001002000000E100U000000Mk0201U040000U01U0000080U0E0000008M01U0k020000M00M0000040E08000000AA00k0E01000040060007U20804000000Q600A0M00U0002001U00Tw10403000000w10030M00E0001U00Q00Q70U301U03zzzs0U01kM0080000E007U0s1UE0zUE01U0000M00Ds0040000A000w3s0M801w800M01w0A0000002000020003zU064007600707XU2000000100001U00000012001X000zy0k1U000000U0000M0000000l000EU00000A0k000000E0000400000008U00AM0000030A00000080000300000004E0064000001U2000000400000k000000280013000000E1U00000200000A00000014000Uk0000080M0000010000030000000W000EA00000406000000U00000k000000l000M600000201U00000E00000C000000kU00A1U0000100M000008000001U00001kE0040Q00001U06000U04000000Q00001kA0060700000k01k00s060000003U0003U200700s0001k00C01y030000000Q000701XUD0070003U001w7nkD00000003k00S00Qzy000y00T00007z0Ty00000000Dk7s007000003zzw000000000000000000Tz0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_cursed_festival()
{
    Text:="|<>**50$199.000000001zy0000000000000000000000000000001k3U000000000000000000000000000001U0M000000000000000000000000000000k0A00003zzzzzzy000000000000000000E0200007U000003U00000000000000000801000060000000M00000000000000000400U00030000000600000000000000000200E0003000000030000000000000000010080001U0000001U00000000000000000U040000k0000000E00000000000000000E020000M0000000800000000000000000801000080000000400000000000000000400U00040000000200000000000000000200E000200000001000000000000000001008000100000001U00000000000000000U040000U0000000k00000000000000000E020000E0000000M00000000000000000801000080000000M00000000000000000400U00040000000s000000000Q0000000200E000200Dzzzzs00Tz00000Ds00003z100800010040000003zzy0001sD0000DzwU040000U020000007U03k003k0s000S03k020000E01000000C000C00700C000w00s010000800U00000Q0003U07001U00s00400U000400E00000Q0000M06000M00k00000E000200800000M0000606000600k0000080001007zzz00M00001U30001U0k0000040000U00001s0M00000M30000k0k0000020000E0000060M00000A1U000A0k000001000080000010M0000030U00020M000000U0004000000kA000000UE0001UM000000E0002000000MA000000MM0000k800000080001000000A6000000AA00008A00000040000U0000066000Q002603004400000020000E0000013000zk01301k036000000100008000001V001kQ00lU0M01X001z000U0004000000kU01k600ME0400l001lk00E0002000000Mk01U100A80600MU01UA0080001000000AM00k1U0640700AE01U30040000U000004800zzk03300006M01U1U020000E00000640000001VU0002A00k0E010000800000C20000000UM0001600E0A00U000400Tzzy10000000EA0001X0080600E00020080000U000000M30000VU060300800010040000E00000081k000kk03010040000U0200008000000A0Q001kM00k1U020000E0100004000000Q07U03k400Q1U010000800U0003000000w00wzzU20071U00U000400E0001U03zzzs007U001U00zU00E00020080000k01U00003ykDk0k002000800010040000800M03w033kSC0800000040000U020000600707XU30Ts3U600000020000E0100003000zy0s1U200k300000010000800U0000U00000A1U000A0k000000U000400E0000M0000030U000608000000E000200800006000001Uk0001060000008000100400003000000EM0000U1U0000040000U0200000k00000880000E0M0000020000E0100000A000004400008060000010000A00U0000600000230000401U00000U000600E00001U000011U000600M00200E000300800000Q00001UQ0003007003U0M0000U0A00000700000k70007000s07s0Q0000M0A000000s0001k0w00D0007kTD0w000070S00000070003k07U3y0000zw1zs00001zw0000000y00zU00Tzk000000000000000000000003zzw0000k"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_spirit_town()
{
    Text:="|<>**50$199.007zk000000000000000000000000000000D0C000000000000000000000000000000603000000000000000000000000000000600k0000000001zzzzzzzzz0000000000300M0000000003k00000001k0000000001U0400zk000001000000000A0000000000k0203wz000001U0000000020000000000E0101U1k00000k0000000010000000000800U1U0M00000E000000000k000000000600E0U04000008000000000M00000000030080E02000004000000000A0000000001U0A080100000200000000060000000000k060400U00001U0000000020000000000A020200E00000k000000001000000000070701008000008000000001U0000000001zz00U04000007000000001k00000000000000E02000001zzzk03zzzk00000000000000801000000000801U00000000000000000400U00000000400k00000000000000000200E00000000200M00001zs0000Dk0zs0T00Dz0000000100A0000DsTk003sS1yz0zU07zs0000000U060000S00S00D03VU0kk000060000000E030000s001k0C00kU0AE00001U000000801U000s000Q0A00Ak06M00000k000000400k001k0003UA006M01A000008000000200M001k0000s6003A00a000004000000100A001U0000C2000Y00G0000020000000U06001U00003V000m0090000010000000E03001U00000kk00N004U00000U000000801U00k00000AM00AU02E00000E000000400k00k0000034004E01A000008000000200M00k000000X006800a00000A000000100A00M000000NU03400H0000060000000U060080000004E032008k000060000000E0300A0000003A031004Q0000D0000000801U04001y001W0z0U023w00zy0000000400k02003Vk00FU00E010200E00000000200M030030A008E00800U100800000000100A01U0303006A00400E0U04000000000U0600U0300U0360020080E02000000000E0300E01U0M01V0010040801000000000801U0800U0400Ek00U020400U00000000400k0400E02008800E010200E00000000200M0200801004600800U100800000000100A0100400U02300400E0U04000000000U0600U0300k030U020080E02000000000E0300E01U0E01UM010040801U00000000801U0A00M0M00k400U020400k00000000400k060060M00E300E010200800000000200M01001ks0081U0800U1007w0000000100A00U00Dk00A0E0400E0U007U0000000U0600M00000060A020080E000M0000000E03004000000202010040800040000000801U0300000030100U020600030000000400k00U0000010000E01010000U000000200M00M000001U000800U0U000E000000100A006000001U000400E0M00080000000U06001000001U00020080400040000000E03000k00000k00010040300020000000801U00A00000k0000k0200k0030000000400k003U0001k0000M0300A001U000000300E000s0001k0000401U03000U0000001U0800060001U0000301U00w00k0000000M0A0001k003U00000s3k007k1k000000060Q0000D00D000000DzU000Tzk00000001zw00001y1y0000000000000000000000000000003zk0000E"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_hellish_city()
{
    Text:="|<>**50$197.7zk00000001zw0000000000000000000yw0s0000000D0C0000000000000000007VU0k0000000M0A00000000000007w000A600k0000001U0A0000000000007zzk00kA01U000000300M000000000001w01w01UM010000000600E00000000000T000T030k020000000A00U00000000003k0007U61U040000000E0100000000000S00003U820080000000U0200000000001k00001kE600E00000010040000000000C000001kkA00U00000020080000000000s000000lUM030000000400E0000000003U000001X0k060000000800U000000000A000000160k080000000E010000000000k000000261k1k0000000U02000000000300000004C1zz00000001004000000000A00000008DkDU00000002008000000000M0000000k0U000000000400E000000001U0000001U00000000000800U0000000020001z00600000003zk00E01000000000A000Tzk0A00Dy003zzy00U023z0000000E003k1s0k1tzz00S00DU1004zzk000001U00Q00s30Dq0303U003k200/U1s000002001k00QQ0k8030C0000s400Q00Q00000A006000Dk10k060k0000k800k00A00000M00M0000061U0A300000kE01000A00000U01U00000A3008600001UU00000A00001003000000M400EM000031000000A0000600A000000U800Uk000062000000A0000A00E0000010E0110000084000000A0000M01U0000020U02200000k8000000M0000U0300000041004A000010E000000M000100400000082008M03zU60U000000k0002008000000E400Ek063sM10000000k000400E000000U800VU0A0zU20000001U000800U0000010E01300T000400000010000E0100000020U02200Dw008003y0020000U02000000410044000T00E00SC00600010040000008200880003k0U01k600A000200A000000E400EM0001s10030600M000600M000000U800Uk0000s200A0A00E000A00E0000010E010U0000M400E0800U000M00k0000020U021U0000M800U0E010000E01U00000410041U0000kE0100k020000U01U00000820083U0000kU0201U040001U01U00000E400E3U0001V004030080001003U001s0U800U3k000120080600E0003003U00Tw10E0101s0002400E0A00U0006001k01kQ20U0200w0006800U0M0100004001s0C0M410041zTU00AE0100k020000A000y3s0M8200867Xy00MU0201U0400008000Dy00ME400EM3kC00l004030080000M0000000EU800Uk1sA01W0080600E0000M0000000l0E01300Tk03400E0A00U0000k0000000W0U024000006800U0M0100000k000000141004M000008E0100k0200000k000000282008k00000EU0201U0400000k0000004E400F000001V0040300800000k0000008U800W00000320080600E00000s000000l0E01400000A400E0A00U00000s00000320k02A00000EA00U0M01000000M00000Q61U0AC00001UM0300k06000000Q00001kA100MC0000C0E0600U0A000000C0000C08301U7U001s0k0M01U0k00000070001s0M3UD03k00T00s3k01k7U0000003k00S00Q3zs00zUzk00zy001zw00000001z0TU00T000007zk0000000000000000007zk0001"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_strange_town()
{
    Text:="|<>**50$199.00000000000000000000000Dzzzzzzzzs00000000000000000000000Q000000006000000000000000000000008000000001U0000000000000000000000A000000000E00000000000000000000006000000000800000000000000000000002000000000400000000000000000000001000000000200000000000000000000000U00000000100000000000000000000000E000000000U0000000000000000000000A000000000E00000000000000000000006000000000800000000000000000000001000000000A00000000000000000000000s00000000C00000000000000000000000Dzzy00Tzzw00000000000000000000000000100A000000000000000000000000000000U060000000000000000007z0000000000E030001000001zU7zU001zXz000000000801U000y00007sy70w003k01s00000000400k0003k000D01q03007000700000000200M0000Q000C00C01U0C0000k0000000100A00003000Q00300E0C0000A00000000U06000A0s00Q0000080A0000300000000E03000C0A00M0000040A00000k0000000801U00A0300M0000020A00000A0000000400k00A00k0Q0000010A0000020000000200M00400A0A000000UA000001U000000100A0060060A000000E6000000E0000000U06006001UA00000086000000A0000000E03002000E60000004300000020000000801U03000A200000023000C0010000000400k010006300000011U00Ts00U000000200M01U0011000Q000UU00sC00E000000100A00U000UU01zU00EE00s300A0000000U0600E000Mk01kQ008M00k0U060000000E0300M000AM01k6004A00M0k030000000801U0A0U02800k1U02400Dzs01U000000400k040E01400E0E0120000000U000000200M020800W00M0A00V0000000E000000100A010400F0080600EU00000080000000U0600U2008U0603008E000000A0000000E0300E1004E0301004800000040000000801U080U02800k1U02400000060000000400k040E01600A1U01200000060000000200M020800X0071U00VU00000S0000000100A01U400EU00zU00Ek01zzzw00000000U0600E2008E0070008800k00000000000E030081004A0000004400A00y00000000801U040U02200000023003U3lk0000000400k030E011U0000011U00Tz0M0000000200M00U800Uk000000UE0000060000000100A00M400EA000000EA000001U0000000U060042008300000082000000k0000000E0300310041U0000041U0000080000000801U00kU020M0000020M0000040000000400k008E0106000001040000020000000200M006A00U1k00000U30000010000000100A001a00E0Q00200E0k00000U0000000U04000T008030030080C00000k0000000M020006U0A00s07U0403U0000M0000000A010000M0A007kyE0200Q0000s0000000301U00070S000TsM01003U001k00000000k3U0000zw00D00A00U00T00DU00000000Dz000000000Ts0A00E001zzw00000000000000000000MC0A00800000000000000000000000000M1kC00A00000000000000000000000000M0Dw00600000000000000000000000000A00E00200000000000000000000000000A000003000000000000000000000000004000001000000000000000000000000002000001U00000000000000000000000001000000U00000000000000000000000000U00000k00000000000000000000000000E00000k00000000000000000000000000A00000k00000000000000000000000000300000k000000000000000000000000000s0000k000000000000000000000000000C0001k0000000000000000000000000001k003U0000000000000000000000000000D007U00000000000000000000000000001y0y0000000000000000000000000000003zs0000000000000000000000002"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

ImageFound_planet_greenie()
{
    Text:="|<>**50$199.00000000000000000001zzU00000000000000000000000000000Ds1z00000000000000000000000000000S001s00000000000000000Dw000000000s000700000000000000000zDk00000001k0000s0000000000000000M0Q00000003U0000C0000000000000000M0600000003U00001k00000000000000080100000003000000A000000000000000400U00000030000003000000000000000200E00000030000001U00000000000000100800000030000000E000000000000000U04000000300000008000000000000000E02000000300000004000000000000000801000000300000006000000000000000400U000001U0000003000000000000000200E000001U00000030000000000000001008000001U001zs01U000000000Dz0000U04000000k007UD01U000000003zjy007k03zk0000k00700s1U0Dy0Ty007U03k0Ds01zy0000M00C0073U0S3ks1s0C000C0A00001U000800C001zU0M0Bk0C040003U400000M000A00C000000803U010A0000M600000A000600C000000A01U00kC0000630000020002006000000600000MA00001VU0000100010060000002000004A00000MU00000U001U0301zzzs1000002A000004E00000E000k0303s00T0U00003A0000038000008000M01U1U000kE00001g000000Y000004000800U1U000A800000q000000O000002000400E0k0006400000K000000BU0000300020080M0001200000P000Q002k00001U001004080000V00000D000zk01A00001U000U02040000EU0000BU01kQ00r00003k000E010200008E00DsAU01k600Mz00DzU000800U1U0004800CDwE01U100A0U0400000400E0k0002400A00M00k1U060E0200000200A0M0001200A00A00Tzk030801000001U02060000V00400400000010400U00000k01U1zw00EU020020000000U200E00000800k0Dy008E010010000000E100800000400A001004800U00U000000M0U04000003002000U02400E00E00000080E02000001U01U00E012008008000000A0801000000E00M00800V004004000000Q0400U00000A00600400EU02002000000w0200M000006001k02008E01001U03zzzs0100A000001U00C01004800U00k01U00000U02000000k003k7U02400E00800M01w00E01z00000A000Dz001200800400707XU08001s0000600000000V004003000zy0k04000600001U0000000EU02001U00000A02000100000M00000008E01000E00000301U000k0000400000004800U00A000001U0E00080000300000002400E002000000E08000400000k00000032008001U00000806000200000A00000031004000M0000040100010000030000001UU02000400000200k000U00000s000001UE01000300000100A000k00000C000003U800U000k00001U03000M000001k00003U600E000C00000k00k008000000Q000070100M0003s0001k00D00A0000003U000C00k0M0000L0003U001w0Q0000000S000w00C0s00000y00T00007zw00000001y0Ts003zs000003zzw0000000000000003zy00000000001"

    if (ok:=FindText(&X, &Y, 0, 0, 997, 403, 0, 0, Text))
    {
        return true
    }
    else
    {
        return false
    }
}

Place_Unit_Slot_1(x1, y1, x2, y2, x3, y3) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    Loop 7 {
        Send("{1}") 
        SendClick(x1, y1)
        Sleep(100)
        Send("{1}") 
        SendClick(x2, y2)
        Sleep(100)
        Send("{1}") 
        SendClick(x3, y3)
        Sleep(100)
    }
}

Place_Unit_Slot_2(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_2 != 0) {
        if (Unit_Slot_2 >= 1) {
            Send("{2}") 
            SendClick(x1, y1)
            Send("{q}") 
            Sleep(100)
            if (Unit_Slot_2 >= 2) {
                Send("{2}") 
                SendClick(x2, y2)
                Send("{q}") 
                Sleep(100)
                if (Unit_Slot_2 >= 3) {
                    Send("{2}") 
                    SendClick(x3, y3)
                    Send("{q}") 
                    Sleep(100)
                    if (Unit_Slot_2 >= 4) {
                        Send("{2}") 
                        SendClick(x4, y4)
                        Send("{q}") 
                        Sleep(100)
                        if (Unit_Slot_2 >= 5) {
                            Send("{2}") 
                            SendClick(x5, y5)
                            Send("{q}") 
                            Sleep(100)
                            if (Unit_Slot_2 >= 6) {
                                Send("{2}") 
                                SendClick(x6, y6)
                                Send("{q}") 
                                Sleep(100)
                            }
                        }
                    }
                }
            }
        }
        Sleep(1000)
    }
}

Place_Unit_Slot_3(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_3 != 0) {
        if (Unit_Slot_3 >= 1) {
            Send("{3}") 
            SendClick(x1, y1)
            Send("{q}") 
            Sleep(100)
            if (Unit_Slot_3 >= 2) {
                Send("{3}") 
                SendClick(x2, y2)
                Send("{q}") 
                Sleep(100)
                if (Unit_Slot_3 >= 3) {
                    Send("{3}") 
                    SendClick(x3, y3)
                    Send("{q}") 
                    Sleep(100)
                    if (Unit_Slot_3 >= 4) {
                        Send("{3}") 
                        SendClick(x4, y4)
                        Send("{q}") 
                        Sleep(100)
                        if (Unit_Slot_3 >= 5) {
                            Send("{3}") 
                            SendClick(x5, y5)
                            Send("{q}") 
                            Sleep(100)
                            if (Unit_Slot_3 >= 6) {
                                Send("{3}") 
                                SendClick(x6, y6)
                                Send("{q}") 
                                Sleep(100)
                            }
                        }
                    }
                }
            }
        }
        Sleep(1000)
    }
}

Place_Unit_Slot_4(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_4 != 0) {
        if (Unit_Slot_4 >= 1) {
            Send("{4}") 
            SendClick(x1, y1)
            Send("{q}") 
            Sleep(100)
            if (Unit_Slot_4 >= 2) {
                Send("{4}") 
                SendClick(x2, y2)
                Send("{q}") 
                Sleep(100)
                if (Unit_Slot_4 >= 3) {
                    Send("{4}") 
                    SendClick(x3, y3)
                    Send("{q}") 
                    Sleep(100)
                    if (Unit_Slot_4 >= 4) {
                        Send("{4}") 
                        SendClick(x4, y4)
                        Send("{q}") 
                        Sleep(100)
                        if (Unit_Slot_4 >= 5) {
                            Send("{4}") 
                            SendClick(x5, y5)
                            Send("{q}") 
                            Sleep(100)
                            if (Unit_Slot_4 >= 6) {
                                Send("{4}") 
                                SendClick(x6, y6)
                                Send("{q}") 
                                Sleep(100)
                            }
                        }
                    }
                }
            }
        }
        Sleep(1000)
    }
}

Place_Unit_Slot_5(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_5 != 0) {
        if (Unit_Slot_5 >= 1) {
            Send("{5}") 
            SendClick(x1, y1)
            Send("{q}") 
            Sleep(100)
            if (Unit_Slot_5 >= 2) {
                Send("{5}") 
                SendClick(x2, y2)
                Send("{q}") 
                Sleep(100)
                if (Unit_Slot_5 >= 3) {
                    Send("{5}") 
                    SendClick(x3, y3)
                    Send("{q}") 
                    Sleep(100)
                    if (Unit_Slot_5 >= 4) {
                        Send("{5}") 
                        SendClick(x4, y4)
                        Send("{q}") 
                        Sleep(100)
                        if (Unit_Slot_5 >= 5) {
                            Send("{5}") 
                            SendClick(x5, y5)
                            Send("{q}") 
                            Sleep(100)
                            if (Unit_Slot_5 >= 6) {
                                Send("{5}") 
                                SendClick(x6, y6)
                                Send("{q}") 
                                Sleep(100)
                            }
                        }
                    }
                }
            }
        }
        Sleep(1000)
    }
}

Place_Unit_Slot_6(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_6 != 0) {
        if (Unit_Slot_6 >= 1) {
            Send("{6}") 
            SendClick(x1, y1)
            Send("{q}") 
            Sleep(100)
            if (Unit_Slot_6 >= 2) {
                Send("{6}") 
                SendClick(x2, y2)
                Send("{q}") 
                Sleep(100)
                if (Unit_Slot_6 >= 3) {
                    Send("{6}") 
                    SendClick(x3, y3)
                    Send("{q}") 
                    Sleep(100)
                    if (Unit_Slot_6 >= 4) {
                        Send("{6}") 
                        SendClick(x4, y4)
                        Send("{q}") 
                        Sleep(100)
                        if (Unit_Slot_6 >= 5) {
                            Send("{6}") 
                            SendClick(x5, y5)
                            Send("{q}") 
                            Sleep(100)
                            if (Unit_Slot_6 >= 6) {
                                Send("{6}") 
                                SendClick(x6, y6)
                                Send("{q}") 
                                Sleep(100)
                            }
                        }
                    }
                }
            }
            Sleep(1000)
        }
    }
}

Upgrade_Unit_Slot_1(x1, y1, x2, y2, x3, y3) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global ceo_maxed_1, ceo_maxed_2, ceo_maxed_3

    Loop {
        SendClick(x1, y1)
        if (!ImageFound_unit_maxed()) {
            Sleep(200)
            SendClick(510, 673)
            SendClick(510, 673)
            SendClick(510, 673)
            SendClick(510, 673)
            Sleep(200)
            SendClick(552, 354)
            Sleep(200)
        } else {
            ceo_maxed_1 := 1
        }

        SendClick(x2, y2)
        if (!ImageFound_unit_maxed()) {
            Sleep(200)
            SendClick(510, 673)
            SendClick(510, 673)
            SendClick(510, 673)
            SendClick(510, 673)
            Sleep(200)
            SendClick(552, 354)
            Sleep(200)
        } else {
            ceo_maxed_2 := 1
        }

        SendClick(x3, y3)
        if (!ImageFound_unit_maxed()) {
            Sleep(200)
            SendClick(510, 673)
            SendClick(510, 673)
            SendClick(510, 673)
            SendClick(510, 673)
            Sleep(200)
            SendClick(552, 354)
            Sleep(200)
        } else {
            ceo_maxed_3 := 1
        }

        if ceo_maxed_1 == 1 && ceo_maxed_2 == 1 && ceo_maxed_3 == 1{
            break
        }
    }
}

Upgrade_Unit_Slot_2(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_2 != 0) {
        if (Unit_Slot_2 >= 1) {
            SendClick(x1, y1)
            ImageFound_ability()
            if (!ImageFound_unit_maxed()) {
                Sleep(200)
                SendClick(510, 673)
                Sleep(200)
                SendClick(552, 354)
                Sleep(200)
            }
            if (Unit_Slot_2 >= 2) {
                SendClick(x2, y2)
                ImageFound_ability()
                if (!ImageFound_unit_maxed()) {
                    Sleep(200)
                    SendClick(510, 673)
                    Sleep(200)
                    SendClick(552, 354)
                    Sleep(200)
                }
                if (Unit_Slot_2 >= 3) {
                    SendClick(x3, y3)
                    ImageFound_ability()
                    if (!ImageFound_unit_maxed()) {
                        Sleep(200)
                        SendClick(510, 673)
                        Sleep(200)
                        SendClick(552, 354)
                        Sleep(200)
                    }
                    if (Unit_Slot_2 >= 4) {
                        SendClick(x4, y4)
                        ImageFound_ability()
                        if (!ImageFound_unit_maxed()) {
                            Sleep(200)
                            SendClick(510, 673)
                            Sleep(200)
                            SendClick(552, 354)
                            Sleep(200)
                        }
                        if (Unit_Slot_2 >= 5) {
                            SendClick(x5, y5)
                            ImageFound_ability()
                            if (!ImageFound_unit_maxed()) {
                                Sleep(200)
                                SendClick(510, 673)
                                Sleep(200)
                                SendClick(552, 354)
                                Sleep(200)
                            }
                            if (Unit_Slot_2 >= 6) {
                                SendClick(x6, y6)
                                ImageFound_ability()
                                if (!ImageFound_unit_maxed()) {
                                    Sleep(200)
                                    SendClick(510, 673)
                                    Sleep(200)
                                    SendClick(552, 354)
                                    Sleep(200)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

Upgrade_Unit_Slot_3(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_3 != 0) {
        if (Unit_Slot_3 >= 1) {
            SendClick(x1, y1)
            ImageFound_ability()
            if (!ImageFound_unit_maxed()) {
                Sleep(200)
                SendClick(510, 673)
                Sleep(200)
                SendClick(552, 354)
                Sleep(200)
            }
            if (Unit_Slot_3 >= 2) {
                SendClick(x2, y2)
                ImageFound_ability()
                if (!ImageFound_unit_maxed()) {
                    Sleep(200)
                    SendClick(510, 673)
                    Sleep(200)
                    SendClick(552, 354)
                    Sleep(200)
                }
                if (Unit_Slot_3 >= 3) {
                    SendClick(x3, y3)
                    ImageFound_ability()
                    if (!ImageFound_unit_maxed()) {
                        Sleep(200)
                        SendClick(510, 673)
                        Sleep(200)
                        SendClick(552, 354)
                        Sleep(200)
                    }
                    if (Unit_Slot_3 >= 4) {
                        SendClick(x4, y4)
                        ImageFound_ability()
                        if (!ImageFound_unit_maxed()) {
                            Sleep(200)
                            SendClick(510, 673)
                            Sleep(200)
                            SendClick(552, 354)
                            Sleep(200)
                        }
                        if (Unit_Slot_3 >= 5) {
                            SendClick(x5, y5)
                            ImageFound_ability()
                            if (!ImageFound_unit_maxed()) {
                                Sleep(200)
                                SendClick(510, 673)
                                Sleep(200)
                                SendClick(552, 354)
                                Sleep(200)
                            }
                            if (Unit_Slot_3 >= 6) {
                                SendClick(x6, y6)
                                ImageFound_ability()
                                if (!ImageFound_unit_maxed()) {
                                    Sleep(200)
                                    SendClick(510, 673)
                                    Sleep(200)
                                    SendClick(552, 354)
                                    Sleep(200)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

Upgrade_Unit_Slot_4(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_4 != 0) {
        if (Unit_Slot_4 >= 1) {
            SendClick(x1, y1)
            ImageFound_ability()
            if (!ImageFound_unit_maxed()) {
                Sleep(200)
                SendClick(510, 673)
                Sleep(200)
                SendClick(552, 354)
                Sleep(200)
            }
            if (Unit_Slot_4 >= 2) {
                SendClick(x2, y2)
                ImageFound_ability()
                if (!ImageFound_unit_maxed()) {
                    Sleep(200)
                    SendClick(510, 673)
                    Sleep(200)
                    SendClick(552, 354)
                    Sleep(200)
                }
                if (Unit_Slot_4 >= 3) {
                    SendClick(x3, y3)
                    ImageFound_ability()
                    if (!ImageFound_unit_maxed()) {
                        Sleep(200)
                        SendClick(510, 673)
                        Sleep(200)
                        SendClick(552, 354)
                        Sleep(200)
                    }
                    if (Unit_Slot_4 >= 4) {
                        SendClick(x4, y4)
                        ImageFound_ability()
                        if (!ImageFound_unit_maxed()) {
                            Sleep(200)
                            SendClick(510, 673)
                            Sleep(200)
                            SendClick(552, 354)
                            Sleep(200)
                        }
                        if (Unit_Slot_4 >= 5) {
                            SendClick(x5, y5)
                            ImageFound_ability()
                            if (!ImageFound_unit_maxed()) {
                                Sleep(200)
                                SendClick(510, 673)
                                Sleep(200)
                                SendClick(552, 354)
                                Sleep(200)
                            }
                            if (Unit_Slot_4 >= 6) {
                                SendClick(x6, y6)
                                ImageFound_ability()
                                if (!ImageFound_unit_maxed()) {
                                    Sleep(200)
                                    SendClick(510, 673)
                                    Sleep(200)
                                    SendClick(552, 354)
                                    Sleep(200)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

Upgrade_Unit_Slot_5(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_5 != 0) {
        if (Unit_Slot_5 >= 1) {
            SendClick(x1, y1)
            ImageFound_ability()
            if (!ImageFound_unit_maxed()) {
                Sleep(200)
                SendClick(510, 673)
                Sleep(200)
                SendClick(552, 354)
                Sleep(200)
            }
            if (Unit_Slot_5 >= 2) {
                SendClick(x2, y2)
                ImageFound_ability()
                if (!ImageFound_unit_maxed()) {
                    Sleep(200)
                    SendClick(510, 673)
                    Sleep(200)
                    SendClick(552, 354)
                    Sleep(200)
                }
                if (Unit_Slot_5 >= 3) {
                    SendClick(x3, y3)
                    ImageFound_ability()
                    if (!ImageFound_unit_maxed()) {
                        Sleep(200)
                        SendClick(510, 673)
                        Sleep(200)
                        SendClick(552, 354)
                        Sleep(200)
                    }
                    if (Unit_Slot_5 >= 4) {
                        SendClick(x4, y4)
                        ImageFound_ability()
                        if (!ImageFound_unit_maxed()) {
                            Sleep(200)
                            SendClick(510, 673)
                            Sleep(200)
                            SendClick(552, 354)
                            Sleep(200)
                        }
                        if (Unit_Slot_5 >= 5) {
                            SendClick(x5, y5)
                            ImageFound_ability()
                            if (!ImageFound_unit_maxed()) {
                                Sleep(200)
                                SendClick(510, 673)
                                Sleep(200)
                                SendClick(552, 354)
                                Sleep(200)
                            }
                            if (Unit_Slot_5 >= 6) {
                                SendClick(x6, y6)
                                ImageFound_ability()
                                if (!ImageFound_unit_maxed()) {
                                    Sleep(200)
                                    SendClick(510, 673)
                                    Sleep(200)
                                    SendClick(552, 354)
                                    Sleep(200)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

Upgrade_Unit_Slot_6(x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6) 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6

    if (Unit_Slot_6 != 0) {
        if (Unit_Slot_6 >= 1) {
            SendClick(x1, y1)
            ImageFound_ability()
            if (!ImageFound_unit_maxed()) {
                Sleep(200)
                SendClick(510, 673)
                Sleep(200)
                SendClick(552, 354)
                Sleep(200)
            }
            if (Unit_Slot_6 >= 2) {
                SendClick(x2, y2)
                ImageFound_ability()
                if (!ImageFound_unit_maxed()) {
                    Sleep(200)
                    SendClick(510, 673)
                    Sleep(200)
                    SendClick(552, 354)
                    Sleep(200)
                }
                if (Unit_Slot_6 >= 3) {
                    SendClick(x3, y3)
                    ImageFound_ability()
                    if (!ImageFound_unit_maxed()) {
                        Sleep(200)
                        SendClick(510, 673)
                        Sleep(200)
                        SendClick(552, 354)
                        Sleep(200)
                    }
                    if (Unit_Slot_6 >= 4) {
                        SendClick(x4, y4)
                        ImageFound_ability()
                        if (!ImageFound_unit_maxed()) {
                            Sleep(200)
                            SendClick(510, 673)
                            Sleep(200)
                            SendClick(552, 354)
                            Sleep(200)
                        }
                        if (Unit_Slot_6 >= 5) {
                            SendClick(x5, y5)
                            ImageFound_ability()
                            if (!ImageFound_unit_maxed()) {
                                Sleep(200)
                                SendClick(510, 673)
                                Sleep(200)
                                SendClick(552, 354)
                                Sleep(200)
                            }
                            if (Unit_Slot_6 >= 6) {
                                SendClick(x6, y6)
                                ImageFound_ability()
                                if (!ImageFound_unit_maxed()) {
                                    Sleep(200)
                                    SendClick(510, 673)
                                    Sleep(200)
                                    SendClick(552, 354)
                                    Sleep(200)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

; Function to search for a specific pixel color
SearchPixelColor(color, x1, y1, x2, y2)
{
    if PixelSearch(&Px, &Py, x1, y1, x2, y2, color, 10) {
        return true
    } else {
        return false
    }
}

Snowy_Town()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{Space down}") ; Hold "Space" key down
    Send("{a down}") ; Hold "a" key down
    Sleep(1000)
    Send("{a up}") ; Hold "a" key up
    Send("{Space up}") ; Hold "Space" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(900)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(1500)
    Send("{a up}") ; Hold "a" key up
    Sleep(200) ; Made by @thuy__ on Discord
 
    Send("{s down}") ; Hold "s" key down
    Sleep(1000)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(1000)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(450)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(3500)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(500)
    Send("{w up}") ; Hold "w" key up

    if (!ImagesFound_Yes_2()) {
        Sleep(5500)
    }

    Place_Unit_Slot_1(1146, 540, 1146, 440, 1146, 340) 

    Loop 8 {
        Place_Unit_Slot_2(1046, 540, 1046, 440, 1046, 340, 1046, 240, 946, 240, 746, 240) 

        Place_Unit_Slot_6(581, 492, 723, 510, 714, 626, 451, 431, 339, 415, 654, 593)

        Place_Unit_Slot_3(846, 540, 846, 440, 746, 440, 746, 340, 646, 340, 646, 440)

        Place_Unit_Slot_4(846, 640, 946, 740, 946, 840, 1046, 840, 1146, 840, 946, 940)

        Place_Unit_Slot_5(546, 340, 546, 240, 446, 240, 446, 340, 546, 100, 446, 100)
    }

    Upgrade_Unit_Slot_1(1146, 540, 1146, 440, 1146, 340)

    Loop {
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_6(581, 492, 723, 510, 714, 626, 451, 431, 339, 415, 654, 593)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        } ; Made by @thuy__ on Discord
        Upgrade_Unit_Slot_2(1046, 540, 1046, 440, 1046, 340, 1046, 240, 946, 240, 746, 240)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_3(846, 540, 846, 440, 746, 440, 746, 340, 646, 340, 646, 440)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_4(846, 640, 946, 740, 946, 840, 1046, 840, 1146, 840, 946, 940)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_5(546, 340, 546, 240, 446, 240, 446, 340, 546, 100, 446, 100)
    }
}

Sand_Village()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(500)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(1750)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(200)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(900)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(150)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(250)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(2250)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(150)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1500)
    Send("{d up}") ; Hold "d" key up
    Sleep(200) ; Made by @thuy__ on Discord

    if (!ImagesFound_Yes_2()) {
        Sleep(8000)
    }

    Place_Unit_Slot_1(1530, 499, 1093, 505, 1755, 870) 

    Loop 8 {
        Place_Unit_Slot_6(807, 292, 1467, 374, 530, 719, 643, 705, 566, 813, 670, 822)

        Place_Unit_Slot_2(914, 448, 998, 459, 923, 377, 1010, 376, 831, 473, 911, 571) 

        Place_Unit_Slot_3(917, 308, 999, 314, 930, 240, 1003, 246, 930, 164, 1011, 165)

        Place_Unit_Slot_4(905, 58, 1004, 62, 1093, 77, 1162, 77, 1252, 78, 1381, 127)

        Place_Unit_Slot_5(1078, 155, 1153, 151, 1236, 152, 1323, 187, 1445, 267, 1533, 428)
    }

    Upgrade_Unit_Slot_1(1530, 499, 1093, 505, 1755, 870) 

    Loop {
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_6(807, 292, 1467, 374, 530, 719, 643, 705, 566, 813, 670, 822)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_2(914, 448, 998, 459, 923, 377, 1010, 376, 831, 473, 911, 571) 

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_3(917, 308, 999, 314, 930, 240, 1003, 246, 930, 164, 1011, 165)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_4(905, 58, 1004, 62, 1093, 77, 1162, 77, 1252, 78, 1381, 127)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_5(1078, 155, 1153, 151, 1236, 152, 1323, 187, 1445, 267, 1533, 428)
    }
}

Navy_Bay()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(250)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    if (!ImagesFound_Yes_2()) {
        Sleep(16000)
    }

    Place_Unit_Slot_1(232, 769, 332, 769, 432, 769) 

    Loop 8 {
        Place_Unit_Slot_6(1543, 1001, 635, 955, 453, 905, 1539, 880, 1521, 762, 1847, 911)

        Place_Unit_Slot_2(843, 658, 712, 641, 593, 673, 630, 747, 770, 738, 766, 860) 

        Place_Unit_Slot_3(258, 600, 365, 606, 497, 582, 638, 518, 258, 500, 365, 506) 

        Place_Unit_Slot_4(703, 525, 820, 533, 703, 425, 820, 433, 1138, 661, 1138, 561) 

        Place_Unit_Slot_5(1110, 791, 1105, 904, 1217, 917, 1354, 707, 1354, 807, 1354, 907)
    }

    Upgrade_Unit_Slot_1(232, 769, 332, 769, 432, 769)

    Loop { ; Made by @thuy__ on Discord
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_6(1543, 1001, 635, 955, 453, 905, 1539, 880, 1521, 762, 1847, 911)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_2(843, 658, 712, 641, 593, 673, 630, 747, 770, 738, 766, 860) 

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_3(258, 600, 365, 606, 497, 582, 638, 518, 258, 500, 365, 506) 

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_4(703, 525, 820, 533, 703, 425, 820, 433, 1138, 661, 1138, 561) 
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_5(1110, 791, 1105, 904, 1217, 917, 1354, 707, 1354, 807, 1354, 907)
    }
}

Fiend_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(100)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(3500)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    if (!ImagesFound_Yes_2()) {
        Sleep(11500) 
    } ; Made by @thuy__ on Discord

    Place_Unit_Slot_1(417, 796, 417, 696, 417, 596) 

    Loop 8 {
        Place_Unit_Slot_6(1811, 937, 1019, 741, 919, 741, 819, 741, 1019, 841, 919, 841)

        Place_Unit_Slot_2(826, 366, 826, 466, 826, 566, 726, 366, 726, 466, 726, 566) 

        Place_Unit_Slot_3(992, 349, 992, 449, 1092, 349, 1092, 449, 903, 505, 903, 605) 

        Place_Unit_Slot_4(1055, 608, 1452, 513, 1552, 513, 1652, 513, 1752, 513, 1852, 513) 

        Place_Unit_Slot_5(1440, 638, 1540, 638, 1640, 638, 1440, 738, 1540, 738, 1640, 738)
    }

    Upgrade_Unit_Slot_1(417, 796, 417, 696, 417, 596) 

    Loop {
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_6(1811, 937, 1019, 741, 919, 741, 819, 741, 1019, 841, 919, 841)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_2(826, 366, 826, 466, 826, 566, 726, 366, 726, 466, 726, 566) 

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_3(992, 349, 992, 449, 1092, 349, 1092, 449, 903, 505, 903, 605) 

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_4(1055, 608, 1452, 513, 1552, 513, 1652, 513, 1752, 513, 1852, 513) 
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        } ; Made by @thuy__ on Discord
        Upgrade_Unit_Slot_5(1440, 638, 1540, 638, 1640, 638, 1440, 738, 1540, 738, 1640, 738)
    }
}

Spirit_World()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(600)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{a down}") ; Hold "a" key down
    Sleep(3000)
    Send("{s up}") ; Hold "s" key up
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(2500)
    Send("{a up}") ; Hold "a" key up
    Sleep(200) ; Made by @thuy__ on Discord

    Send("{s down}") ; Hold "s" key down
    Sleep(2000)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(2000)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(750)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(250)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    if (!ImagesFound_Yes_2()) {
        Sleep(2000)
    }

    Place_Unit_Slot_1(749, 57, 471, 65, 555, 129) 

    Loop 12 {
        Place_Unit_Slot_6(704, 347, 756, 428, 716, 577, 1284, 487, 1195, 360, 1127, 176)

        Place_Unit_Slot_2(857, 866, 1002, 888, 1097, 902, 870, 771, 1015, 776, 1138, 778) 

        Place_Unit_Slot_3(872, 643, 873, 560, 1061, 643, 1073, 558, 873, 476, 1054, 476) 

        Place_Unit_Slot_4(869, 391, 1020, 387, 817, 320, 763, 249, 662, 242, 636, 158) 

        Place_Unit_Slot_5(820, 707, 920, 600, 917, 512, 904, 435, 1075, 842, 1073, 708)
    }

    Upgrade_Unit_Slot_1(749, 57, 471, 65, 555, 129) 

    Loop {
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_6(704, 347, 756, 428, 716, 577, 1284, 487, 1195, 360, 1127, 176)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_2(857, 866, 1002, 888, 1097, 902, 870, 771, 1015, 776, 1138, 778) 

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_3(872, 643, 873, 560, 1061, 643, 1073, 558, 873, 476, 1054, 476) 

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_4(869, 391, 1020, 387, 817, 320, 763, 249, 662, 242, 636, 158) 
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_5(820, 707, 920, 600, 917, 512, 904, 435, 1075, 842, 1073, 708)
    }
}

Ant_Kingdom()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200) ; Made by @thuy__ on Discord

    Send("{w down}") ; Hold "w" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(3250)
    Send("{w up}") ; Hold "w" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(2000)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(2200)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(500)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(1500)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(2000)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xA0FF00, 1277, 560, 1442, 573)) {
        SendClick(1714, 20)

        Sleep(200)
        if (!ImagesFound_Yes_2()) {
            Sleep(2000)
        }

        Place_Unit_Slot_1(342, 983, 522, 986, 533, 834) 

        Loop 8 {
            Place_Unit_Slot_6(681, 172, 1407, 795, 1270, 771, 1204, 891, 1050, 324, 821, 237)

            Place_Unit_Slot_2(1386, 616, 1292, 610, 1159, 648, 1022, 688, 942, 730, 954, 831) 

            Place_Unit_Slot_3(1396, 478, 1386, 367, 1286, 486, 1271, 380, 1162, 501, 1037, 531) 

            Place_Unit_Slot_4(794, 782, 654, 791, 523, 700, 467, 588, 381, 391, 351, 201) 

            Place_Unit_Slot_5(785, 636, 658, 609, 571, 505, 517, 396, 485, 300, 521, 124)
        } ; Made by @thuy__ on Discord

        Upgrade_Unit_Slot_1(342, 983, 522, 986, 533, 834) 

        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(681, 172, 1407, 795, 1270, 771, 1204, 891, 1050, 324, 821, 237)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1386, 616, 1292, 610, 1159, 648, 1022, 688, 942, 730, 954, 831) 

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1396, 478, 1386, 367, 1286, 486, 1271, 380, 1162, 501, 1037, 531) 

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(794, 782, 654, 791, 523, 700, 467, 588, 381, 391, 351, 201) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(785, 636, 658, 609, 571, 505, 517, 396, 485, 300, 521, 124)
        }
    } else {
        wrong_map := 1
        Go_Lobby()
    }
}

Magic_Town()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(3000)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(1300)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(5000)
    Send("{a up}") ; Hold "a" key up
    Sleep(200)

    if (!ImagesFound_Yes_2()) { ; Made by @thuy__ on Discord
        Sleep(7500)
    }

    Place_Unit_Slot_1(1678, 989, 1520, 986, 1585, 843) 

    Loop 8 {
        Place_Unit_Slot_6(1288, 318, 253, 369, 343, 373, 284, 447, 482, 346, 1286, 217)

        Place_Unit_Slot_2(344, 289, 362, 177, 446, 178, 429, 290, 521, 184, 520, 292) 

        Place_Unit_Slot_3(602, 295, 614, 188, 700, 296, 713, 193, 675, 847, 668, 961) 

        Place_Unit_Slot_4(857, 844, 932, 847, 1005, 851, 895, 790, 969, 798, 586, 834) 

        Place_Unit_Slot_5(799, 901, 798, 808, 808, 701, 813, 601, 822, 495, 722, 494)
    }

    Upgrade_Unit_Slot_1(1678, 989, 1520, 986, 1585, 843) 

    Loop {
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_6(1288, 318, 253, 369, 343, 373, 284, 447, 482, 346, 1286, 217)

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_2(344, 289, 362, 177, 446, 178, 429, 290, 521, 184, 520, 292) 

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_3(602, 295, 614, 188, 700, 296, 713, 193, 675, 847, 668, 961) 

        if (ImageFound_next() || ImagesFound_Return()) {
            break
        }
        Upgrade_Unit_Slot_4(857, 844, 932, 847, 1005, 851, 895, 790, 969, 798, 586, 834) 
        if (ImageFound_next() || ImagesFound_Return()) {
            break
        } ; Made by @thuy__ on Discord
        Upgrade_Unit_Slot_5(799, 901, 798, 808, 808, 701, 813, 601, 822, 495, 722, 494)
    }
}

Haunted_Academy()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn() 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xB3FA3A, 1326, 591, 1515, 615)) {
        SendClick(1714, 20)

        Send("{a down}") ; Hold "a" key down
        Sleep(4000)
        Send("{a up}") ; Hold "a" key up
        Sleep(200)
    
        if (!ImagesFound_Yes_2()) {
            Sleep(13500)
        }
    
        Place_Unit_Slot_1(1320, 1011, 1316, 900, 1310, 769) 
    
        Loop 8 {
            Place_Unit_Slot_6(461, 1017, 495, 793, 372, 759, 253, 763, 138, 834, 294, 915)
    
            Place_Unit_Slot_2(365, 555, 464, 559, 579, 562, 379, 439, 476, 436, 587, 440) 
    
            Place_Unit_Slot_3(718, 566, 791, 572, 872, 575, 723, 455, 800, 455, 878, 457) 
    
            Place_Unit_Slot_4(963, 568, 1064, 574, 1157, 579, 963, 464, 1063, 467, 1155, 464) 
    
            Place_Unit_Slot_5(1265, 475, 1270, 585, 1160, 657, 1157, 738, 1158, 822, 1155, 918)
        } ; Made by @thuy__ on Discord
    
        Upgrade_Unit_Slot_1(1320, 1011, 1316, 900, 1310, 769) 

        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(461, 1017, 495, 793, 372, 759, 253, 763, 138, 834, 294, 915)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(365, 555, 464, 559, 579, 562, 379, 439, 476, 436, 587, 440) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(718, 566, 791, 572, 872, 575, 723, 455, 800, 455, 878, 457) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(963, 568, 1064, 574, 1157, 579, 963, 464, 1063, 467, 1155, 464) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1265, 475, 1270, 585, 1160, 657, 1157, 738, 1158, 822, 1155, 918)
        }
    } else {
        wrong_map := 1
        Go_Lobby()
    }
}

Magic_Hills()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn() ; Made by @thuy__ on Discord
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(500)
    Send("{s up}") ; Hold "s" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(2000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(250)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(3000)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(1500)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xB6FF00, 1036, 541, 1116, 570)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(2750)
        Send("{d up}") ; Hold "d" key up
        Sleep(200) ; Made by @thuy__ on Discord

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(1000)
        Send("{s up}") ; Hold "s" key up
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Sleep(1250)
        Send("{s up}") ; Hold "s" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(1400)
        Send("{s up}") ; Hold "s" key up
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(750)
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(2300)
        Send("{s up}") ; Hold "s" key up
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(2250)
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(1000)
        Send("{w up}") ; Hold "w" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(3000)
        Send("{w up}") ; Hold "w" key up
        Send("{d up}") ; Hold "d" key up 
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(50)
        }

        Place_Unit_Slot_1(1523, 1017, 1516, 866, 1328, 833) 
    
        Loop 8 {
            Place_Unit_Slot_6(81, 699, 1453, 240, 1321, 209, 1276, 291, 1331, 360, 191, 517)
    
            Place_Unit_Slot_2(1223, 106, 1168, 159, 1112, 221, 1134, 62, 1029, 82, 1009, 190) 
    
            Place_Unit_Slot_3(1069, 314, 1051, 408, 1045, 509, 971, 285, 939, 388, 936, 474) 
    
            Place_Unit_Slot_4(1008, 615, 956, 715, 888, 806, 886, 601, 836, 692, 745, 760) 
    
            Place_Unit_Slot_5(1109, 467, 838, 406, 782, 574, 1090, 581, 1051, 694, 980, 808)
        }
    
        Upgrade_Unit_Slot_1(1523, 1017, 1516, 866, 1328, 833) 
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(81, 699, 1453, 240, 1321, 209, 1276, 291, 1331, 360, 191, 517)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1223, 106, 1168, 159, 1112, 221, 1134, 62, 1029, 82, 1009, 190) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1069, 314, 1051, 408, 1045, 509, 971, 285, 939, 388, 936, 474) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(1008, 615, 956, 715, 888, 806, 886, 601, 836, 692, 745, 760) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1109, 467, 838, 406, 782, 574, 1090, 581, 1051, 694, 980, 808)
        } ; Made by @thuy__ on Discord
    } else {
        wrong_map := 1
        Go_Lobby()
    }
}

Space_Center()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(2250)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Sleep(200)
    Send("{d down}") ; Hold "d" key down
    Sleep(1500)
    Send("{d up}") ; Hold "d" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xDCFF00, 1506, 991, 1532, 1070)) {
        SendClick(1714, 20)

        if (!ImagesFound_Yes_2()) {
            Sleep(12500)
        } 

        Place_Unit_Slot_1(87, 483, 277, 488, 88, 662) 
    
        Loop 10 {
            Place_Unit_Slot_6(1227, 827, 1287, 139, 1308, 54, 1137, 524, 1208, 571, 1308, 630)
    
            Place_Unit_Slot_2(1094, 140, 1103, 291, 1142, 374, 1192, 142, 1214, 276, 1242, 318) 
    
            Place_Unit_Slot_3(1302, 467, 1386, 530, 1428, 622, 1343, 371, 1487, 458, 1557, 629) 
    
            Place_Unit_Slot_4(1434, 732, 1438, 841, 1444, 957, 1574, 739, 1588, 847, 1596, 960) 
    
            Place_Unit_Slot_5(1010, 143, 1017, 290, 1057, 414, 1345, 221, 1432, 310, 1354, 764)
        }
    
        Upgrade_Unit_Slot_1(87, 483, 277, 488, 88, 662) 
    
        Loop { ; Made by @thuy__ on Discord
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(1227, 827, 1287, 139, 1308, 54, 1137, 524, 1208, 571, 1308, 630)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1094, 140, 1103, 291, 1142, 374, 1192, 142, 1214, 276, 1242, 318) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1302, 467, 1386, 530, 1428, 622, 1343, 371, 1487, 458, 1557, 629) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(1434, 732, 1438, 841, 1444, 957, 1574, 739, 1588, 847, 1596, 960) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1010, 143, 1017, 290, 1057, 414, 1345, 221, 1432, 310, 1354, 764)
        }
    } else {
        wrong_map := 1
        Go_Lobby()
    }
}

Alien_Spaceship() 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x62FF0C, 415, 850, 494, 772)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(500)
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(3000)
        Send("{s up}") ; Hold "s" key up
        Send("{d up}") ; Hold "d" key up 
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(12000) ; Made by @thuy__ on Discord
        } 

        Place_Unit_Slot_1(1660, 469, 1667, 636, 1509, 629) 
    
        Loop 10 {
            Place_Unit_Slot_6(1002, 140, 1032, 903, 939, 794, 788, 805, 1082, 372, 1361, 445)
    
            Place_Unit_Slot_2(1288, 908, 1289, 1016, 1132, 766, 1028, 674, 1088, 598, 1199, 686) 
    
            Place_Unit_Slot_3(834, 639, 733, 565, 685, 433, 902, 541, 818, 501, 794, 420) 
    
            Place_Unit_Slot_4(710, 307, 617, 180, 382, 79, 807, 317, 707, 134, 461, 39) 
    
            Place_Unit_Slot_5(1161, 849, 1304, 657, 963, 550, 737, 657, 884, 448, 615, 350)
        }
    
        Upgrade_Unit_Slot_1(1660, 469, 1667, 636, 1509, 629) 
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(1002, 140, 1032, 903, 939, 794, 788, 805, 1082, 372, 1361, 445)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1288, 908, 1289, 1016, 1132, 766, 1028, 674, 1088, 598, 1199, 686) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(834, 639, 733, 565, 685, 433, 902, 541, 818, 501, 794, 420) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(710, 307, 617, 180, 382, 79, 807, 317, 707, 134, 461, 39) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1161, 849, 1304, 657, 963, 550, 737, 657, 884, 448, 615, 350)
        }
    } else {
        wrong_map := 1
        Go_Lobby()
    }
}

Fabled_Kingdom()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(100)
    Send("{w up}") ; Hold "w" key up
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(900)
    Send("{w up}") ; Hold "w" key up
    Send("{d up}") ; Hold "d" key up 
    Sleep(200)

    SendClick(1714, 20) ; Made by @thuy__ on Discord

    if (SearchPixelColor(0x8FFF00, 1033, 510, 1148, 529)) {
        SendClick(1714, 20) 

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(1250)
        Send("{d up}") ; Hold "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(800)
        Send("{w up}") ; Hold "w" key up
        Sleep(200)

        Send("{a down}") ; Hold "a" key down
        Sleep(300)
        Send("{a up}") ; Hold "a" key up
        Sleep(200)

        Send("{Space down}") ; Hold "Space" key down
        Send("{w down}") ; Hold "w" key down
        Sleep(500)
        Send("{w up}") ; Hold "w" key up
        Send("{Space up}") ; Hold "Space" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(2000)
        Send("{w up}") ; Hold "w" key up
        Sleep(200)

        Send("{a down}") ; Hold "a" key down
        Sleep(500)
        Send("{a up}") ; Hold "a" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(8500)
        } 

        Place_Unit_Slot_1(1423, 488, 1428, 585, 1322, 553) 
    
        Loop 10 {
            Place_Unit_Slot_6(873, 725, 1182, 94, 1185, 476, 1288, 481, 1013, 726, 563, 849)
    
            Place_Unit_Slot_2(756, 57, 755, 142, 841, 146, 943, 149, 672, 53, 660, 144) 
    
            Place_Unit_Slot_3(991, 294, 990, 360, 990, 430, 915, 293, 908, 358, 912, 428) 
    
            Place_Unit_Slot_4(988, 491, 988, 552, 915, 551, 916, 490, 1106, 496, 1108, 561) 
    
            Place_Unit_Slot_5(1026, 77, 1092, 79, 1088, 157, 845, 551, 764, 550, 912, 646)
        }
    
        Upgrade_Unit_Slot_1(1423, 488, 1428, 585, 1322, 553) 
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(873, 725, 1182, 94, 1185, 476, 1288, 481, 1013, 726, 563, 849)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(756, 57, 755, 142, 841, 146, 943, 149, 672, 53, 660, 144) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(991, 294, 990, 360, 990, 430, 915, 293, 908, 358, 912, 428) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(988, 491, 988, 552, 915, 551, 916, 490, 1106, 496, 1108, 561) ; Made by @thuy__ on Discord
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1026, 77, 1092, 79, 1088, 157, 845, 551, 764, 550, 912, 646)
        }
    } else {
        wrong_map := 1
        Go_Lobby()
    }
}

Ruined_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6 ; Made by @thuy__ on Discord
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Send("{s down}") ; Hold "s" key down
    Sleep(900)
    Send("{a up}") ; Hold "a" key up
    Send("{s up}") ; Hold "s" key up 
    Sleep(200)
    
    Send("{s down}") ; Hold "s" key down
    Sleep(400)
    Send("{s up}") ; Hold "s" key up 
    Sleep(200)
    
    Send("{a down}") ; Hold "a" key down
    Sleep(3250)
    Send("{a up}") ; Hold "a" key up 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x89FF00, 1110, 563, 1185, 579)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) { ; Made by @thuy__ on Discord
            Sleep(12500)
        } 

        Place_Unit_Slot_1(1860, 576, 1748, 571, 1630, 568) 
    
        Loop 10 {
            Place_Unit_Slot_6(1188, 667, 468, 432, 399, 484, 862, 300, 760, 288, 170, 593)
    
            Place_Unit_Slot_2(297, 315, 383, 320, 470, 324, 312, 228, 393, 230, 481, 235) 
    
            Place_Unit_Slot_3(547, 334, 594, 384, 631, 435, 621, 284, 663, 336, 722, 435) 
    
            Place_Unit_Slot_4(624, 502, 616, 574, 661, 693, 714, 505, 705, 578, 747, 636) 
    
            Place_Unit_Slot_5(334, 369, 416, 367, 545, 503, 537, 573, 804, 468, 846, 659)
        }
    
        Upgrade_Unit_Slot_1(1860, 576, 1748, 571, 1630, 568) 
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(1188, 667, 468, 432, 399, 484, 862, 300, 760, 288, 170, 593)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(297, 315, 383, 320, 470, 324, 312, 228, 393, 230, 481, 235) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(547, 334, 594, 384, 631, 435, 621, 284, 663, 336, 722, 435) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(624, 502, 616, 574, 661, 693, 714, 505, 705, 578, 747, 636) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(334, 369, 416, 367, 545, 503, 537, 573, 804, 468, 846, 659)
        }
    } else {
        wrong_map := 1
        Go_Lobby()
    }
}

Puppet_Island()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(2000)
    Send("{s up}") ; Hold "s" key up 
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{d down}") ; Hold "d" key down
    Sleep(1250)
    Send("{s up}") ; Hold "s" key up
    Send("{d up}") ; Hold "d" key up 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xA4FF00, 1375, 554, 1482, 596)) {
        SendClick(1714, 20) ; Made by @thuy__ on Discord

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(11500)
        } 

        Place_Unit_Slot_1(447, 607, 566, 609, 458, 495) 
    
        Loop 10 {
            Place_Unit_Slot_6(953, 56, 1521, 387, 1423, 385, 1315, 384, 1211, 386, 1113, 327)
    
            Place_Unit_Slot_2(1415, 582, 1334, 581, 1250, 578, 1412, 491, 1331, 487, 1244, 483) 
    
            Place_Unit_Slot_3(1141, 576, 1056, 572, 1142, 483, 1058, 464, 1143, 645, 1057, 640) 
    
            Place_Unit_Slot_4(990, 528, 914, 462, 910, 525, 1009, 401, 987, 618, 899, 618) 
    
            Place_Unit_Slot_5(816, 457, 827, 367, 735, 428, 681, 371, 639, 291, 729, 281)
        }
    
        Upgrade_Unit_Slot_1(447, 607, 566, 609, 458, 495) 
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(953, 56, 1521, 387, 1423, 385, 1315, 384, 1211, 386, 1113, 327)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1415, 582, 1334, 581, 1250, 578, 1412, 491, 1331, 487, 1244, 483) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1141, 576, 1056, 572, 1142, 483, 1058, 464, 1143, 645, 1057, 640) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(990, 528, 914, 462, 910, 525, 1009, 401, 987, 618, 899, 618) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(816, 457, 827, 367, 735, 428, 681, 371, 639, 291, 729, 281)
        }
    } else {
        wrong_map := 1
        Go_Lobby()
    }
}

Virtual_Dungeon()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(2500)
    Send("{s up}") ; Hold "s" key up 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x82FE03, 620, 556, 710, 533)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(13000)
        } 

        Place_Unit_Slot_1(245, 404, 370, 403, 502, 406) 
    
        Loop 10 {
            Place_Unit_Slot_6(842, 147, 578, 347, 664, 347, 743, 378, 776, 294, 825, 346)
    
            Place_Unit_Slot_2(529, 930, 536, 773, 610, 692, 370, 929, 427, 757, 529, 638) 
    
            Place_Unit_Slot_3(691, 633, 822, 618, 968, 597, 632, 532, 797, 505, 921, 487) 
    
            Place_Unit_Slot_4(1058, 506, 1120, 425, 1137, 293, 969, 433, 1032, 369, 1032, 291) 
    
            Place_Unit_Slot_5(756, 629, 707, 706, 794, 698, 895, 609, 906, 683, 557, 490)
        } ; Made by @thuy__ on Discord
    
        Upgrade_Unit_Slot_1(245, 404, 370, 403, 502, 406) 
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(842, 147, 578, 347, 664, 347, 743, 378, 776, 294, 825, 346)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(529, 930, 536, 773, 610, 692, 370, 929, 427, 757, 529, 638) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(691, 633, 822, 618, 968, 597, 632, 532, 797, 505, 921, 487) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(1058, 506, 1120, 425, 1137, 293, 969, 433, 1032, 369, 1032, 291) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(756, 629, 707, 706, 794, 698, 895, 609, 906, 683, 557, 490)
        }
    } else {
        wrong_map := 1
        Go_Lobby()
    }
}

Snowy_Kingdom()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{a down}") ; Hold "a" key down
    Sleep(750)
    Send("{s up}") ; Release "s" key up
    Send("{a up}") ; Release "a" key up 
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(1650)
    Send("{s up}") ; Release "s" key up 
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Send("{a down}") ; Hold "a" key down
    Sleep(4000)
    Send("{s up}") ; Release "s" key up
    Send("{a up}") ; Release "a" key up 
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x86FF83, 437, 699, 637, 717)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(9000)
        } 

        Place_Unit_Slot_1(1098, 905, 1044, 789, 958, 719) 
    
        Loop 10 {
            Place_Unit_Slot_2(1210, 54, 621, 676, 616, 810, 691, 627, 711, 784, 778, 728) 

            Place_Unit_Slot_6(595, 1011, 653, 932, 742, 871, 829, 827, 927, 848, 850, 921)
            ; Made by @thuy__ on Discord
            Place_Unit_Slot_3(749, 579, 833, 678, 803, 530, 888, 625, 860, 485, 941, 578)
    
            Place_Unit_Slot_4(910, 429, 1030, 432, 912, 366, 1030, 368, 913, 302, 1036, 307) 
    
            Place_Unit_Slot_5(1105, 306, 1109, 371, 1112, 434, 1114, 502, 1017, 651, 520, 900)
        }
    
        Upgrade_Unit_Slot_1(1098, 905, 1044, 789, 958, 719)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1210, 54, 621, 676, 616, 810, 691, 627, 711, 784, 778, 728) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(595, 1011, 653, 932, 742, 871, 829, 827, 927, 848, 850, 921)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(749, 579, 833, 678, 803, 530, 888, 625, 860, 485, 941, 578) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(910, 429, 1030, 432, 912, 366, 1030, 368, 913, 302, 1036, 307) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1105, 306, 1109, 371, 1112, 434, 1114, 502, 1017, 651, 520, 900)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Dungeon_Throne()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xA5FB24, 733, 699, 754, 555)) {
        SendClick(1714, 20)

        Sleep(200)

        Send("{a down}") ; Hold "a" key down
        Send("{s down}") ; Hold "s" key down
        Sleep(1500)
        Send("{a up}") ; Release "a" key up
        Send("{s up}") ; Release "s" key up 
        Sleep(200) ; Made by @thuy__ on Discord

        Send("{a down}") ; Hold "a" key down
        Sleep(3500)
        Send("{a up}") ; Release "a" key up 
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(2750)
        Send("{w up}") ; Release "w" key up 
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(3500)
        Send("{w up}") ; Release "w" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(2000)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(6500)
        } 

        Place_Unit_Slot_1(1719, 846, 1710, 726, 1694, 604) 
    
        Loop 10 {
            Place_Unit_Slot_6(1374, 1011, 1286, 739, 1166, 770, 1034, 822, 1309, 884, 1220, 922)

            Place_Unit_Slot_2(1237, 297, 1188, 346, 1134, 401, 1332, 301, 1259, 402, 1209, 461) 
            
            Place_Unit_Slot_3(1080, 450, 1038, 491, 963, 494, 1152, 515, 1097, 562, 962, 589)
    
            Place_Unit_Slot_4(895, 493, 798, 493, 673, 568, 890, 581, 792, 583, 732, 634) 
    
            Place_Unit_Slot_5(1115, 292, 1063, 340, 1001, 398, 902, 399, 805, 398, 949, 334)
        }
    
        Upgrade_Unit_Slot_1(1719, 846, 1710, 726, 1694, 604)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(1374, 1011, 1286, 739, 1166, 770, 1034, 822, 1309, 884, 1220, 922)
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1237, 297, 1188, 346, 1134, 401, 1332, 301, 1259, 402, 1209, 461) 

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1080, 450, 1038, 491, 963, 494, 1152, 515, 1097, 562, 962, 589) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(895, 493, 798, 493, 673, 568, 890, 581, 792, 583, 732, 634) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1115, 292, 1063, 340, 1001, 398, 902, 399, 805, 398, 949, 334)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Mountain_Temple()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{w down}") ; Hold "w" key down
    Sleep(1500)
    Send("{w up}") ; Release "w" key up 
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(750)
    Send("{d up}") ; Release "d" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xC1FF2F, 1118, 671, 1226, 664)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(14000)
        } 

        Place_Unit_Slot_1(629, 1004, 642, 869, 773, 869) 
    
        Loop 10 {
            Place_Unit_Slot_6(1848, 1067, 535, 280, 565, 349, 582, 435, 578, 536, 453, 355)

            Place_Unit_Slot_2(751, 334, 840, 277, 793, 381, 875, 317, 858, 456, 940, 388) 
            ; Made by @thuy__ on Discord
            Place_Unit_Slot_3(935, 523, 1017, 449, 982, 580, 1078, 506, 1034, 633, 1124, 549)
    
            Place_Unit_Slot_4(1218, 700, 1215, 576, 1298, 702, 1292, 603, 1379, 705, 1369, 607) 
    
            Place_Unit_Slot_5(738, 433, 799, 501, 853, 594, 921, 640, 1111, 689, 1064, 772)
        }
    
        Upgrade_Unit_Slot_1(629, 1004, 642, 869, 773, 869)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(1848, 1067, 535, 280, 565, 349, 582, 435, 578, 536, 453, 355)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(751, 334, 840, 277, 793, 381, 875, 317, 858, 456, 940, 388) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(935, 523, 1017, 449, 982, 580, 1078, 506, 1034, 633, 1124, 549) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(1218, 700, 1215, 576, 1298, 702, 1292, 603, 1379, 705, 1369, 607) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(738, 433, 799, 501, 853, 594, 921, 640, 1111, 689, 1064, 772)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Rain_Village()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x95FF00, 548, 666, 870, 683)) {
        SendClick(1714, 20)

        Send("{d down}") ; Hold "d" key down
        Sleep(2000)
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(500)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(13500)
        } 

        Place_Unit_Slot_1(610, 874, 745, 800, 894, 767) 
    
        Loop 10 {
            Place_Unit_Slot_2(74, 676, 1328, 329, 1322, 402, 1259, 471, 1228, 317, 1189, 391) 

            Place_Unit_Slot_6(931, 364, 1038, 359, 1162, 171, 1516, 387, 1520, 470, 143, 512)
            
            Place_Unit_Slot_3(1201, 522, 1076, 623, 970, 624, 1126, 446, 1048, 518, 973, 513)
    
            Place_Unit_Slot_4(870, 620, 768, 619, 670, 617, 875, 509, 770, 502, 677, 502) 
    
            Place_Unit_Slot_5(1416, 334, 1329, 523, 1269, 585, 1079, 723, 967, 722, 864, 722)
        }
    
        Upgrade_Unit_Slot_1(610, 874, 745, 800, 894, 767)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(74, 676, 1328, 329, 1322, 402, 1259, 471, 1228, 317, 1189, 391) 

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(931, 364, 1038, 359, 1162, 171, 1516, 387, 1520, 470, 143, 512)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1201, 522, 1076, 623, 970, 624, 1126, 446, 1048, 518, 973, 513) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(870, 620, 768, 619, 670, 617, 875, 509, 770, 502, 677, 502) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1416, 334, 1329, 523, 1269, 585, 1079, 723, 967, 722, 864, 722)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Storm_Hideout()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x98F901 || 0xEDF800, 1784, 799, 1911, 834)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{s down}") ; Hold "s" key down
        Sleep(1900)
        Send("{s up}") ; Release "s" key up 
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(500)
        Send("{s up}") ; Release "s" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(100)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(200)
        Send("{s up}") ; Release "s" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(400)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(700)
        Send("{s up}") ; Release "s" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Sleep(900)
        Send("{s up}") ; Release "s" key up 
        Sleep(200) ; Made by @thuy__ on Discord

        Send("{a down}") ; Hold "a" key down
        Sleep(1000)
        Send("{a up}") ; Release "a" key up 
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{a down}") ; Hold "a" key down
        Sleep(1500)
        Send("{s up}") ; Release "s" key up
        Send("{a up}") ; Release "a" key up 
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(7000)
        } 

        Place_Unit_Slot_1(1510, 268, 1408, 184, 1146, 241) 
    
        Loop 10 {
            Place_Unit_Slot_6(1333, 84, 214, 582, 349, 454, 331, 716, 473, 678, 489, 541)

            Place_Unit_Slot_2(139, 804, 131, 908, 176, 1006, 316, 924, 397, 974, 505, 950) 
            
            Place_Unit_Slot_3(710, 906, 712, 827, 738, 746, 797, 693, 864, 697, 941, 694)
    
            Place_Unit_Slot_4(669, 620, 726, 574, 802, 563, 870, 565, 956, 528, 1033, 634) 
    
            Place_Unit_Slot_5(650, 524, 736, 477, 986, 453, 1115, 459, 1166, 364, 1245, 306)
        }
    
        Upgrade_Unit_Slot_1(1510, 268, 1408, 184, 1146, 241)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(1333, 84, 214, 582, 349, 454, 331, 716, 473, 678, 489, 541)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(139, 804, 131, 908, 176, 1006, 316, 924, 397, 974, 505, 950) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(710, 906, 712, 827, 738, 746, 797, 693, 864, 697, 941, 694) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(669, 620, 726, 574, 802, 563, 870, 565, 956, 528, 1033, 634) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(650, 524, 736, 477, 986, 453, 1115, 459, 1166, 364, 1245, 306)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Haunted_Mansion()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x73E60B, 1382, 730, 1507, 658)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{s down}") ; Hold "s" key down
        Sleep(500)
        Send("{s up}") ; Release "s" key up
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(1750)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(2500)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        Send("{a down}") ; Hold "a" key down
        Sleep(1000)
        Send("{a up}") ; Release "a" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(500)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(9000)
        } 

        Place_Unit_Slot_1(1495, 1020, 1421, 928, 1359, 804) 
    
        Loop 10 {
            Place_Unit_Slot_6(1273, 521, 610, 185, 598, 259, 701, 301, 87, 388, 149, 516)

            Place_Unit_Slot_2(434, 158, 451, 217, 477, 282, 313, 192, 327, 259, 360, 337) 
            
            Place_Unit_Slot_3(524, 328, 583, 380, 650, 403, 430, 422, 521, 487, 620, 520)
    
            Place_Unit_Slot_4(769, 427, 844, 462, 921, 497, 722, 543, 790, 577, 861, 617) 
    
            Place_Unit_Slot_5(1000, 539, 1089, 591, 1171, 656, 949, 662, 1026, 715, 1106, 783)
        }
    
        Upgrade_Unit_Slot_1(1495, 1020, 1421, 928, 1359, 804)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(1273, 521, 610, 185, 598, 259, 701, 301, 87, 388, 149, 516)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(434, 158, 451, 217, 477, 282, 313, 192, 327, 259, 360, 337) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(524, 328, 583, 380, 650, 403, 430, 422, 521, 487, 620, 520) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(769, 427, 844, 462, 921, 497, 722, 543, 790, 577, 861, 617) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1000, 539, 1089, 591, 1171, 656, 949, 662, 1026, 715, 1106, 783)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Nightmare_Train()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x2CFF0E, 1734, 653, 1915, 647)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{d down}") ; Hold "d" key down
        Sleep(5500)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{s down}") ; Hold "s" key down
        Send("{d down}") ; Hold "d" key down
        Sleep(2500)
        Send("{s up}") ; Release "s" key up
        Send("{d up}") ; Release "d" key up 
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(2000)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(2000)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(3500)
        } 

        Place_Unit_Slot_1(222, 137, 196, 270, 351, 205) 
    
        Loop 10 {
            Place_Unit_Slot_6(416, 868, 1516, 485, 1398, 448, 1338, 527, 1298, 640, 1220, 753)

            Place_Unit_Slot_2(1525, 223, 1440, 223, 1359, 242, 1523, 127, 1429, 119, 1319, 146) 
            
            Place_Unit_Slot_3(1267, 281, 1189, 326, 1133, 382, 1091, 447, 1064, 286, 979, 390)
    
            Place_Unit_Slot_4(1049, 516, 1004, 591, 955, 666, 931, 463, 885, 533, 842, 606) 
    
            Place_Unit_Slot_5(1531, 313, 1443, 307, 1362, 331, 1274, 362, 1214, 425, 1169, 503)
        }
    
        Upgrade_Unit_Slot_1(222, 137, 196, 270, 351, 205)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(416, 868, 1516, 485, 1398, 448, 1338, 527, 1298, 640, 1220, 753)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1525, 223, 1440, 223, 1359, 242, 1523, 127, 1429, 119, 1319, 146) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1267, 281, 1189, 326, 1133, 382, 1091, 447, 1064, 286, 979, 390) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(1049, 516, 1004, 591, 955, 666, 931, 463, 885, 533, 842, 606) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1531, 313, 1443, 307, 1362, 331, 1274, 362, 1214, 425, 1169, 503)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Future_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(3000)
    Send("{s up}") ; Release "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(350)
    Send("{a up}") ; Release "a" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(1500)
    Send("{s up}") ; Release "s" key up
    Sleep(200)

    Send("{a down}") ; Hold "a" key down
    Sleep(700)
    Send("{a up}") ; Release "a" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(1900)
    Send("{s up}") ; Release "s" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xFFFF00, 918, 721, 1092, 767)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(9000)
        } 

        Place_Unit_Slot_1(110, 546, 255, 549, 407, 552) 
    
        Loop 11 {
            Place_Unit_Slot_6(1450, 74, 1396, 1026, 1438, 936, 1547, 927, 1660, 955, 1523, 1029)

            Place_Unit_Slot_2(1060, 749, 943, 747, 1059, 666, 952, 662, 1057, 563, 953, 562) 
            
            Place_Unit_Slot_3(1144, 667, 1144, 569, 1234, 671, 1229, 574, 1319, 674, 1314, 572)
    
            Place_Unit_Slot_4(1145, 752, 1234, 755, 1324, 758, 1062, 843, 1147, 846, 1236, 848) 
    
            Place_Unit_Slot_5(1413, 679, 1406, 571, 1418, 762, 1514, 685, 1509, 574, 1519, 767)
        }
    
        Upgrade_Unit_Slot_1(110, 546, 255, 549, 407, 552)  
    
        Loop {
            Loop 2 {
                if (ImageFound_next() || ImagesFound_Return()) {
                    break
                }
                Upgrade_Unit_Slot_6(1450, 74, 1396, 1026, 1438, 936, 1547, 927, 1660, 955, 1523, 1029)
            }

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1060, 749, 943, 747, 1059, 666, 952, 662, 1057, 563, 953, 562) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1144, 667, 1144, 569, 1234, 671, 1229, 574, 1319, 674, 1314, 572) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(1145, 752, 1234, 755, 1324, 758, 1062, 843, 1147, 846, 1236, 848) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1413, 679, 1406, 571, 1418, 762, 1514, 685, 1509, 574, 1519, 767)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Walled_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xC2F600, 208, 676, 252, 768)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(17000)
        } 

        Place_Unit_Slot_1(198, 797, 279, 874, 431, 878) 
    
        Loop 10 {
            Place_Unit_Slot_6(422, 337, 1194, 285, 1289, 292, 1377, 67, 1470, 69, 439, 248)

            Place_Unit_Slot_2(1557, 309, 1562, 217, 1572, 386, 1562, 142, 1587, 463, 1563, 58) 
            
            Place_Unit_Slot_3(1467, 288, 1355, 271, 1463, 199, 1356, 188, 1134, 158, 1043, 156)
    
            Place_Unit_Slot_4(942, 296, 928, 371, 914, 449, 897, 531, 1056, 434, 1028, 506) 
    
            Place_Unit_Slot_5(1004, 628, 884, 605, 996, 724, 863, 702, 960, 815, 765, 773)
        }
    
        Upgrade_Unit_Slot_1(198, 797, 279, 874, 431, 878)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(422, 337, 1194, 285, 1289, 292, 1377, 67, 1470, 69, 439, 248)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1557, 309, 1562, 217, 1572, 386, 1562, 142, 1587, 463, 1563, 58) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1467, 288, 1355, 271, 1463, 199, 1356, 188, 1134, 158, 1043, 156) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(942, 296, 928, 371, 914, 449, 897, 531, 1056, 434, 1028, 506) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1004, 628, 884, 605, 996, 724, 863, 702, 960, 815, 765, 773)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Cursed_Festival()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    Send("{d down}") ; Hold "d" key down
    Sleep(1800)
    Send("{d up}") ; Release "d" key up
    Sleep(200)

    Send("{s down}") ; Hold "s" key down
    Sleep(1500)
    Send("{s up}") ; Release "s" key up
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xCAFF2C, 25, 785, 388, 802)) {
        SendClick(1714, 20)

        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(12500)
        } 

        Place_Unit_Slot_1(989, 908, 991, 777, 355, 927) 
    
        Loop 10 {
            Place_Unit_Slot_6(173, 560, 786, 313, 778, 407, 766, 509, 670, 578, 549, 575)

            Place_Unit_Slot_2(896, 52, 812, 52, 1017, 66, 980, 146, 925, 392, 1008, 400) 
            
            Place_Unit_Slot_3(922, 455, 1008, 455, 922, 530, 1008, 530, 828, 344, 827, 412)
    
            Place_Unit_Slot_4(881, 602, 949, 602, 1013, 602, 881, 670, 949, 670, 1013, 670) 
    
            Place_Unit_Slot_5(792, 703, 654, 700, 499, 656, 362, 759, 261, 762, 376, 669)
        }
    
        Upgrade_Unit_Slot_1(989, 908, 991, 777, 355, 927)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(173, 560, 786, 313, 778, 407, 766, 509, 670, 578, 549, 575)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(896, 52, 812, 52, 1017, 66, 980, 146, 925, 392, 1008, 400) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(922, 455, 1008, 455, 922, 530, 1008, 530, 828, 344, 827, 412) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(881, 602, 949, 602, 1013, 602, 881, 670, 949, 670, 1013, 670) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(792, 703, 654, 700, 499, 656, 362, 759, 261, 762, 376, 669)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Spirit_Town()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x95FF00, 1211, 642, 1611, 661)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{w down}") ; Hold "w" key down
        Sleep(3000)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(2500)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(10500)
        } 

        Place_Unit_Slot_1(195, 481, 173, 624, 323, 563) 
    
        Loop 10 {
            Place_Unit_Slot_6(303, 327, 1303, 78, 1308, 177, 1308, 293, 1214, 375, 1067, 372)

            Place_Unit_Slot_2(1572, 163, 1496, 83, 1529, 255, 1406, 252, 1534, 327, 1420, 327) 
            
            Place_Unit_Slot_3(1542, 394, 1428, 390, 1539, 462, 1423, 450, 1505, 546, 1399, 498)
    
            Place_Unit_Slot_4(1462, 632, 1351, 569, 1363, 715, 1282, 604, 1208, 763, 1198, 648) 
    
            Place_Unit_Slot_5(1109, 764, 1109, 639, 1017, 761, 1016, 637, 924, 760, 926, 633)
        }
    
        Upgrade_Unit_Slot_1(195, 481, 173, 624, 323, 563)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(303, 327, 1303, 78, 1308, 177, 1308, 293, 1214, 375, 1067, 372)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1572, 163, 1496, 83, 1529, 255, 1406, 252, 1534, 327, 1420, 327) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1542, 394, 1428, 390, 1539, 462, 1423, 450, 1505, 546, 1399, 498) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(1462, 632, 1351, 569, 1363, 715, 1282, 604, 1208, 763, 1198, 648) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1109, 764, 1109, 639, 1017, 761, 1016, 637, 924, 760, 926, 633)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Hellish_City()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x89FF00, 1381, 345, 1500, 195)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{w down}") ; Hold "w" key down
        Sleep(1000)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(2500)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        Send("{w down}") ; Hold "w" key down
        Sleep(1200)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        Send("{d down}") ; Hold "d" key down
        Sleep(600)
        Send("{d up}") ; Release "d" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(10500)
        } 

        Place_Unit_Slot_1(164, 991, 319, 996, 546, 1010) 
    
        Loop 10 {
            Place_Unit_Slot_6(491, 763, 1064, 706, 1093, 831, 1024, 778, 941, 712, 980, 924)

            Place_Unit_Slot_2(1732, 929, 1717, 796, 1645, 921, 1634, 790, 1551, 913, 1532, 781) 
            
            Place_Unit_Slot_3(1454, 902, 1443, 774, 1353, 887, 1361, 754, 1279, 855, 1291, 724)
    
            Place_Unit_Slot_4(1275, 628, 1375, 633, 1480, 645, 1373, 554, 1006, 602, 1011, 475) 
    
            Place_Unit_Slot_5(923, 611, 922, 494, 841, 626, 841, 508, 758, 709, 712, 584)
        }
    
        Upgrade_Unit_Slot_1(164, 991, 319, 996, 546, 1010)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(491, 763, 1064, 706, 1093, 831, 1024, 778, 941, 712, 980, 924)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1732, 929, 1717, 796, 1645, 921, 1634, 790, 1551, 913, 1532, 781) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1454, 902, 1443, 774, 1353, 887, 1361, 754, 1279, 855, 1291, 724) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(1275, 628, 1375, 633, 1480, 645, 1373, 554, 1006, 602, 1011, 475) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(923, 611, 922, 494, 841, 626, 841, 508, 758, 709, 712, 584)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Strange_Town()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0xE9FF7A, 785, 658, 806, 501)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{a down}") ; Hold "a" key down
        Sleep(750)
        Send("{a up}") ; Release "a" key up
        Sleep(200)
        
        Send("{w down}") ; Hold "w" key down
        Sleep(750)
        Send("{w up}") ; Release "w" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(14500)
        } 

        Place_Unit_Slot_1(1542, 425, 1421, 477, 1290, 532) 
    
        Loop 10 {
            Place_Unit_Slot_2(1057, 890, 298, 620, 404, 625, 288, 732, 391, 733, 514, 628) 

            Place_Unit_Slot_6(187, 897, 256, 937, 329, 980, 407, 1016, 1738, 671, 1771, 559)
            
            Place_Unit_Slot_3(314, 539, 332, 467, 344, 396, 417, 542, 427, 474, 436, 399)
    
            Place_Unit_Slot_4(515, 258, 607, 258, 507, 350, 601, 353, 429, 262, 358, 325) 
    
            Place_Unit_Slot_5(511, 507, 522, 429, 605, 431, 689, 436, 772, 439, 861, 443)
        }
    
        Upgrade_Unit_Slot_1(1542, 425, 1421, 477, 1290, 532)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1057, 890, 298, 620, 404, 625, 288, 732, 391, 733, 514, 628) 

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(187, 897, 256, 937, 329, 980, 407, 1016, 1738, 671, 1771, 559)
            
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(314, 539, 332, 467, 344, 396, 417, 542, 427, 474, 436, 399)
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(515, 258, 607, 258, 507, 350, 601, 353, 429, 262, 358, 325) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(511, 507, 522, 429, 605, 431, 689, 436, 772, 439, 861, 443)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

Planet_Greenie()
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6
    global Dropdown1, Dropdown2, Dropdown3, Dropdown4, Dropdown5, Dropdown6
    global wrong_map
    Go_Spawn()
    Sleep(200)

    SendClick(1714, 20)

    if (SearchPixelColor(0x96FF42, 1484, 814, 1515, 1060)) {
        SendClick(1714, 20)

        Sleep(200)
        Send("{s down}") ; Hold "s" key down
        Sleep(750)
        Send("{s up}") ; Release "s" key up
        Sleep(200)

        if (!ImagesFound_Yes_2()) {
            Sleep(15500)
        } 

        Place_Unit_Slot_1(242, 776, 369, 778, 514, 781) 
    
        Loop 10 {
            Place_Unit_Slot_6(1097, 839, 1365, 241, 1381, 331, 1473, 386, 1501, 284, 524, 151)

            Place_Unit_Slot_2(1120, 370, 1040, 367, 961, 364, 1120, 450, 1040, 450, 961, 450) 
            
            Place_Unit_Slot_3(1123, 530, 1039, 527, 963, 527, 1123, 610, 1039, 610, 963, 610)
    
            Place_Unit_Slot_4(1227, 375, 1230, 442, 1232, 511, 1308, 447, 1309, 514, 1405, 516) 
    
            Place_Unit_Slot_5(1277, 620, 1354, 623, 1356, 700, 1279, 695, 1361, 779, 1364, 858)
        }
    
        Upgrade_Unit_Slot_1(242, 776, 369, 778, 514, 781)  
    
        Loop {
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_6(1097, 839, 1365, 241, 1381, 331, 1473, 386, 1501, 284, 524, 151)

            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_2(1120, 370, 1040, 367, 961, 364, 1120, 450, 1040, 450, 961, 450) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_3(1123, 530, 1039, 527, 963, 527, 1123, 610, 1039, 610, 963, 610) 
    
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_4(1227, 375, 1230, 442, 1232, 511, 1308, 447, 1309, 514, 1405, 516) 
            if (ImageFound_next() || ImagesFound_Return()) {
                break
            }
            Upgrade_Unit_Slot_5(1277, 620, 1354, 623, 1356, 700, 1279, 695, 1361, 779, 1364, 858)
        }
    } else {
        wrong_map := 1
        Go_Lobby() 
    }
}

; Hotkey to trigger the pixel color check and clicking loop
^F4:: ; Ctrl+F4 to start the pixel scan and clicking loop
{
    global wrong_map 
    global return_click
    global Checkbox8
    Global Go_To_Infinity_Mansion_Check

    Unit_GUI_Save() 
    Loop {
        if Go_To_Infinity_Mansion_Check == true {
        Go_To_Infinity_Mansion() 
        }
        Find_Maps()
        if wrong_map == 0{
            Loop {
                return_click := 1
                if (ImagesFound_Return_2()) {
                    break 
                }
                ImageFound_next()
            }
        }
    }
}
        
; Stop button to close the script
^F3:: ; Ctrl+F3 to stop the script
{
    Unit_GUI_Save()
    ExitApp
}