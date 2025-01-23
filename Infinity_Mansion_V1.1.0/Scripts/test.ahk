#Requires AutoHotkey v2.0

Sleep(5000)

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