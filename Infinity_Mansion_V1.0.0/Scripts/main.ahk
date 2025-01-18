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

global ceo_maxed_1 := 0
global ceo_maxed_2 := 0
global ceo_maxed_3 := 0

global return_click := 0

; Create the main GUI
main := Gui("+AlwaysOnTop", "Inf Mansion Macro V1.0.0")

; Create the options GUI
options := Gui("+AlwaysOnTop", "Options")

main.Show("w300 h300 x1610 y50")

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

main.SetFont("bold")
main.add("Text", "x10 y210 w200", "Don't Use Oshy/Idol <-- READ")

; Check if the settings file exists
if !FileExist("..\Settings\settings.ini") {
    ; Create a new settings.ini file with default values
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
}

; Define the function to open the options tab
OpenOptions() {
    global Checkbox7
    global options

    options := Gui("+AlwaysOnTop", "Options")
    options.Show("w300 h300 x1610 y50")
    
    Checkbox7 := options.add("Checkbox", "x10 y30 w150", "Do Hardmode")
    Checkbox7.Value := IniRead("..\Settings\settings.ini", "Options", "Hardmode")

    CloseButton := options.add("Button", "x10 y270 w100", "Close")
    CloseButton.OnEvent("Click", (*) => options.Hide())
    CloseButton.OnEvent("Click", (*) => Unit_GUI_Save())

    options.OnEvent("Close", (*) => options.Hide())
    options.OnEvent("Close", (*) => Unit_GUI_Save())
}

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

Unit_GUI_Save() 
{
    global Unit_Slot_1, Unit_Slot_2, Unit_Slot_3, Unit_Slot_4, Unit_Slot_5, Unit_Slot_6
    global Checkbox1, Checkbox2, Checkbox3, Checkbox4, Checkbox5, Checkbox6, Checkbox7
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

    return
}

; Get the directory of the current script
ScriptDir := A_ScriptDir

OCRScriptDir := A_ScriptDir . "\..\Scripts\scan_text.ahk"

; Define the paths to images
ImagePath1 := ScriptDir . "\..\Images\return.png"
ImagePath2 := ScriptDir . "\..\Images\return_2.png"
ImagePath3 := ScriptDir . "\..\Images\yes.png"
ImagePath4 := ScriptDir . "\..\Images\no.png"
ImagePath5 := ScriptDir . "\..\Images\unit_exit.png"
ImagePath6 := ScriptDir . "\..\Images\unit_maxed.png"
ImagePath7 := ScriptDir . "\..\Images\mansion.png"
ImagePath8 := ScriptDir . "\..\Images\next.png"
ImagePath9 := ScriptDir . "\..\Images\ability.png"
ImagePath10 := ScriptDir . "\..\Images\unit.png"
ImagePath11 := ScriptDir . "\..\Images\reconnect.png"

Snowy_Town_Path := ScriptDir . "\..\Images\snowy_town.png"
Sand_Village_Path := ScriptDir . "\..\Images\sand_village.png"
Navy_Bay_Path := ScriptDir . "\..\Images\navy_bay.png"
Fiend_City_Path := ScriptDir . "\..\Images\fiend_city.png"
Spirit_World_Path := ScriptDir . "\..\Images\spirit_world.png"
Ant_Kingdom_Path := ScriptDir . "\..\Images\ant_kingdom.png"
Magic_Town_Path := ScriptDir . "\..\Images\magic_town.png"
Haunted_Academy_Path := ScriptDir . "\..\Images\haunted_academy.png"
Magic_Hills_Path := ScriptDir . "\..\Images\magic_hills.png"
Space_Center_Path := ScriptDir . "\..\Images\space_center.png"
Alien_Spaceship_Path := ScriptDir . "\..\Images\alien_spaceship.png"
Fabled_Kingdom_Path := ScriptDir . "\..\Images\fabled_kingdom.png"
Ruined_City_Path := ScriptDir . "\..\Images\ruined_city.png"
Puppet_Island_Path := ScriptDir . "\..\Images\puppet_island.png"
Virtual_Dungeon_Path := ScriptDir . "\..\Images\virtual_dungeon.png"
Snowy_Kingdom_Path := ScriptDir . "\..\Images\snowy_kingdom.png"
Dungeon_Throne_Path := ScriptDir . "\..\Images\dungeon_throne.png"

return_check := 0
reconnect_check := 0
wrong_map := 0

; Hotkeys to start and stop the OCR script
^+1:: ; Ctrl+Shift+1 to start the OCR script
{
    Run(OCRScriptDir)
}

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
    global Checkbox7
    global return_click
    global ceo_maxed_1
    global ceo_maxed_2
    global ceo_maxed_3

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
    Send("{a down}") ; Hold "a" key down
    Sleep(3000)
    Send("{a up}") ; Hold "a" key up
    Sleep(500)
    Send("{w down}") ; Hold "w" key down
    Sleep(500)
    Send("{w up}") ; Hold "w" key up
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
}

Go_Lobby()
{
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
    }
}

; Function to check if both images are found on the screen within the specified region
ImagesFound_Return()
{
    global return_check
    global ImagePath1
    global return_click

    ImageSearchResult1 := ImageSearch(&x1, &y1, 0, 0, 1920, 1080, "*50 " . ImagePath1)
    if (ImageSearchResult1 = 1)
    {
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
    global return_check
    global ImagePath1
    global return_click

    ImageSearchResult1 := ImageSearch(&x1, &y1, 0, 0, 1920, 1080, "*50 " . ImagePath1)
    if (ImageSearchResult1 = 1)
    {
        if (return_click == 1) {
            Loop 10 {
                SendClick(x1, y1)
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

ImagesFound_Yes()
{
    global ImagePath3, ImagePath4
    ImageSearchResult3 := ImageSearch(&x3, &y3, 0, 0, 1920, 1080, "*50 " . ImagePath3)
    ImageSearchResult4 := ImageSearch(&x4, &y4, 0, 0, 1920, 1080, "*50 " . ImagePath4)
    if (ImageSearchResult3 = 1 && ImageSearchResult4 = 1)
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
    global ImagePath3, ImagePath4
    ImageSearchResult3 := ImageSearch(&x3, &y3, 0, 0, 1920, 1080, "*50 " . ImagePath3)
    ImageSearchResult4 := ImageSearch(&x4, &y4, 0, 0, 1920, 1080, "*50 " . ImagePath4)
    if (ImageSearchResult3 = 1 && ImageSearchResult4 = 1)
    {
        SendClick(x3, y3)
        SendClick(x3, y3)
        SendClick(x3, y3)
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
    global ImagePath6
    ImageSearchResult6 := ImageSearch(&x6, &y6, 0, 0, 1920, 1080, "*50 " . ImagePath6)
    if (ImageSearchResult6 = 1)
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
    global ImagePath7
    ImageSearchResult7 := ImageSearch(&x7, &y7, 0, 0, 1920, 1080, "*50 " . ImagePath7)
    if (ImageSearchResult7 = 1)
    {
        Loop 3 {
            SendClick(x7, y7)
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
    global ImagePath8
    ImageSearchResult8 := ImageSearch(&x8, &y8, 0, 0, 1920, 1080, "*50 " . ImagePath8)
    if (ImageSearchResult8 = 1)
    {
        Loop 5 {
            SendClick(x8, y8)
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
    global ImagePath9
    ImageSearchResult9 := ImageSearch(&x9, &y9, 0, 0, 1920, 1080, "*50 " . ImagePath9)
    if (ImageSearchResult9 = 1)
    {
        SendClick(x9,y9)
        return true
    }
    else
    {
        return false
    }
}

ImageFound_snowy_town()
{
    global Snowy_Town_Path
    ImageSearchResult12 := ImageSearch(&x12, &y12, 0, 0, 1920, 1080, "*5 " . Snowy_Town_Path)
    if (ImageSearchResult12 = 1)
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
    global Sand_Village_Path
    ImageSearchResult13 := ImageSearch(&x13, &y13, 0, 0, 1920, 1080, "*5 " . Sand_Village_Path)
    if (ImageSearchResult13 = 1)
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
    global Navy_Bay_Path
    ImageSearchResult14 := ImageSearch(&x14, &y14, 0, 0, 1920, 1080, "*5 " . Navy_Bay_Path)
    if (ImageSearchResult14 = 1)
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
    global Fiend_City_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Fiend_City_Path)
    if (ImageSearchResult = 1)
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
    global Spirit_World_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Spirit_World_Path)
    if (ImageSearchResult = 1)
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
    global Ant_Kingdom_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Ant_Kingdom_Path)
    if (ImageSearchResult = 1)
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
    global Magic_Town_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Magic_Town_Path)
    if (ImageSearchResult = 1)
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
    global Haunted_Academy_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Haunted_Academy_Path)
    if (ImageSearchResult = 1)
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
    global Magic_Hills_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Magic_Hills_Path)
    if (ImageSearchResult = 1)
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
    global Space_Center_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Space_Center_Path)
    if (ImageSearchResult = 1)
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
    global Alien_Spaceship_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Alien_Spaceship_Path)
    if (ImageSearchResult = 1)
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
    global Fabled_Kingdom_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Fabled_Kingdom_Path)
    if (ImageSearchResult = 1)
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
    global Ruined_City_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Ruined_City_Path)
    if (ImageSearchResult = 1)
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
    global Puppet_Island_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Puppet_Island_Path)
    if (ImageSearchResult = 1)
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
    global Virtual_Dungeon_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Virtual_Dungeon_Path)
    if (ImageSearchResult = 1)
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
    global Snowy_Kingdom_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Snowy_Kingdom_Path)
    if (ImageSearchResult = 1)
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
    global Dungeon_Throne_Path
    ImageSearchResult := ImageSearch(&x, &y, 0, 0, 1920, 1080, "*5 " . Dungeon_Throne_Path)
    if (ImageSearchResult = 1)
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
    if PixelSearch(&Px, &Py, x1, y1, x2, y2, color, 5) {
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
            Sleep(9000)
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

; Hotkey to trigger the pixel color check and clicking loop
^F4:: ; Ctrl+F4 to start the pixel scan and clicking loop
{
    global wrong_map 
    global return_click

    Unit_GUI_Save() 
    Loop {
        Go_To_Infinity_Mansion() 
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