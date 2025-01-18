#Requires AutoHotkey v2.0

Sleep(5000)

Send("{a down}") ; Hold "a" key down
Send("{s down}") ; Hold "s" key down
Sleep(1500)
Send("{a up}") ; Release "a" key up
Send("{s up}") ; Release "s" key up 
Sleep(200)

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