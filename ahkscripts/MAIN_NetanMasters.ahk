#SingleInstance Force
#MaxThreadsPerHotkey 2
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

global XTime := 2000
global TPUser := "Fredtaro"
global Running := false
global TPKey := "7"
global transformKey := "G"
global formList := {}                                         ; Mainloop near bottom
global formDisplayList := ""
global TPhaseC := "After TP"
global startHOTKEY := "F1"
global stopHOTKEY := "F2"
global addFormHOTKEY := "j"
global addSlotHOTKEY := "u"
global combatLogNAcount := 0
global WaiterWaiterMoreMastery = false 
global PresetDefault := "[COMING SOON]||"
global slotList := {}
global slotDisplayList := ""  
global modifyingSlots := false 
global modifyingForms := false  
global HotkeySet := []

IniRead, XTime, settings.ini, tSettings, XholdTime, %XTime%
IniRead, transformKey, settings.ini, tSettings, transKey, %transformKey%
IniRead, TPUser, settings.ini, UserSettings, User, %TPUser%
IniRead, TPKey, settings.ini, UserSettings, tpKEY, %TPKey%
IniRead, TPhaseC, settings.ini, UserSettings, Phases, %TPhaseC%  

IniRead, startHOTKEY, settings.ini, UserSettings, startk, %startHOTKEY%
IniRead, stopHOTKEY, settings.ini, UserSettings, stopk, %stopHOTKEY%
IniRead, addFormHOTKEY, settings.ini, UserSettings, addformk, %addFormHOTKEY%
IniRead, addSlotHOTKEY, settings.ini, UserSettings, addslotk, %addSlotHOTKEY%

Hotkey, %startHOTKEY%, StartMacro
Hotkey, %stopHOTKEY%, StopMacro
Hotkey, %addFormHOTKEY%, CoordRetriever
Hotkey, %addSlotHOTKEY%, CoordRetriever


IniRead, forms, settings.ini, FORMlist
if (forms != "ERROR"){     ;Parsing the string of block text into an actual dictionary to work with 
    Loop, Parse, forms, `n
    {
        formParts := StrSplit(A_LoopField, "=")
        coords := StrSplit(formParts[2], ",")
        formList[formParts[1]] := [coords[1]+0, coords[2]+0]
        formDisplayList .= formParts[1] . "|"
    }
}

IniRead, selectedForm, settings.ini, UserSettings, currentForm, ""   ;for user convenience, displays the selected form upon reopening 
;MsgBox % formDisplayList
;MsgBox % selectedForm
if (selectedForm != ""){   
    formDisplayList := StrReplace(formDisplayList, selectedForm, selectedForm . "|")
}
;MsgBox % formDisplayList


IniRead, slots, settings.ini, SLOTlist  
if (slots != "ERROR"){     ;Parsing the string of block text into an actual dictionary to work with 
    Loop, Parse, slots, `n
    {
        slotParts := StrSplit(A_LoopField, "=")
        coords := StrSplit(slotParts[2], ",")
        slotList[slotParts[1]] := [coords[1]+0, coords[2]+0]
        slotDisplayList .= slotParts[1] . "|"
    }
}
IniRead, selectedSlot, settings.ini, UserSettings, currentSlot, "" 
if (selectedSlot != ""){
    slotDisplayList := StrReplace(slotDisplayList, selectedSlot, selectedSlot . "|")
}


Gui, +AlwaysOnTop +Caption +Border +Resize MinSize300x275 +OwnDialogs

Gui, Add, Text,, X Hold Time (ms):
Gui, Add, Edit, vXTimeEdit w120  gSaveSettings, %XTime%

Gui, Add, Text,, Forms:
Gui, Add, DropDownList, vformEdit w120 gSaveSettings, %formDisplayList% 

Gui, Add, Text,, Tranformation Key: 
if (transformKey = "G")
    transformKeySet := "G||H|None"
else if (transformKey = "H")
    transformKeySet := "G|H||None"
else if (transformKey = "None")
    transformKeySet := "G|H|None||"
Gui, Add, DropDownList, vTransKeyEdit w120 gSaveSettings, %transformKeySet%

Gui, Add, Text, xs180 ys, TP to Player:
Gui, Add, Edit, vTPUserEdit w120 gSaveSettings, %TPUser%

Gui, Add, Text,xs180 ys42.5, I.T Key:
Gui, Add, Hotkey, vTPKeyEdit w120 gSaveHotkeys, %TPKey%
global TPKeyPrev := TPKey


;-------
Gui, Add, Text, xs180 ys92.5, Transformation Phase:
if (transformKey != "None"){
    if (TPhaseC = "Before TP")
        TPhaseSet := "Before TP||After TP"
    else if (TPhaseC = "After TP")
        TPhaseSet := "Before TP|After TP||"
}
else{
    TPhaseSet := ""
}

Gui, Add, DropDownList, vTPhaseEdit w120 gSaveSettings, %TPhaseSet%

Gui, Add, Text, xs ys142.5, Preset: 
Gui, Add, DropDownList, vPresetEdit w120 gSaveSettings, %PresetDefault%

Gui, Add, Text, xs180 ys142.5, Slot: 
Gui, Add, DropDownList, vslotEdit w120 gSaveSettings, %slotDisplayList%  


Gui, Add, Button, vstartB gStartMacro w100 xs ys202.5, %startHOTKEY% (Start) 
Gui, Add, Button, vstopB gStopMacro w100 xs100 ys202.5, %stopHOTKEY% (Stop)
Gui, Add, Button, gHotkeySettingsGUI w100 xs200 ys202.5, Hotkeys 
Gui, Add, Button, gHelpInfoGUI w100 xs100 ys225.5, Help 
Gui, Show, Center, NetanMastersYu

Menu, FormMenu, Add, Rename, MenuRenameHandler
Menu, FormMenu, Add, Delete, MenuDeleteHandler

Gui, 2:New, +AlwaysOnTop +Caption +Border +Resize MinSize225x125  ;Hotkey GUI
Gui, 2:Add, Text,, Start Hotkey: 
Gui, 2:Add, Hotkey, vStartHotkey gSaveHotkeys w80, %startHOTKEY%
Gui, 2:Add, Text,, Stop Hotkey: 
Gui, 2:Add, Hotkey, vStopHotkey gSaveHotkeys w80, %stopHOTKEY%
Gui, 2:Add, Text,, Add Form Hotkey: 
Gui, 2:Add, Hotkey, vaddFormHotkey gSaveHotkeys w80, %addFormHOTKEY%
Gui, 2:Add, Text,, Add Slot Hotkey: 
Gui, 2:Add, Hotkey, vaddSlotHotkey gSaveHotkeys w80, %addSlotHOTKEY%

global startHOTKEYPrev := startHOTKEY
global stopHOTKEYPrev := stopHOTKEY 
global addFormHOTKEYPrev := addFormHOTKEY 
global addSlotHOTKEYPrev := addSlotHOTKEY 
SetTimer, UglyCode, 100

GuiIcon := DllCall("LoadImage", "Ptr", 0, "Str", "../macro_images/MacroStarIcon.ico","UInt",1, "Int", 64, "Int", 64, "UInt", 0x10, "Ptr") ; Rewrite these to something simpler in AHK v2 
TaskbarIcon := DllCall("LoadImage", "Ptr", 0, "Str", "../macro_images/MacroStarFlameIcon.ico","UInt",1, "Int", 64, "Int", 64, "UInt", 0x10, "Ptr")

SendMessage, 0x80, 0, GuiIcon,, A
SendMessage, 0x80, 1, TaskbarIcon,, A
Menu, Tray, Icon, ../macro_images/MacroStarFlameIcon.ico

return                                                                    ; SET-UP CREATION PROCESS ENDS HERE

HotkeyStates(State){
    Hotkey, %startHOTKEY%, %State% 
    Hotkey, %stopHOTKEY%, %State% 
    Hotkey, %addFormHOTKEY%, %State% 
    Hotkey, %addSlotHOTKEY%, %State% 
}

UglyCode: ; This label is singlehandingly the worst one I've coded as of 19/07, genuinely hate ahk v1 for not having a convenient way of detecting GUI elements. 
    CoordMode, Mouse, Window 
    MouseGetPos, RnX, RnY 
    ;GuiControlGet, formEdit, Pos
    ;GuiControlGet, slotEdit, Pos
    ;GuiControlGet, PresetEdit, Pos 
    GuiControlGet, XTimeEdit, Pos 
    GuiControlGet, TPKeyEdit, Pos 
    GuiControlGet, TPUserEdit, Pos
    ;uiControlGet, TransKeyEdit, Pos
    ;GuiControlGet, TPhaseEdit, Pos   
    RnX -= 10
    RnY -= 35    
    
    OnGuiElement(RnX, RnY, elementEditX, elementEditY, elementEditW, elementEditH) {
        if ((RnX - elementEditX) < (elementEditW +45) && (RnX - elementEditX) > (-45) && (RnY - elementEditY) < (elementEditH + 45) && (RnY - elementEditY) > (-45)){
            ;MsgBox,0x40000,, % "Touching GUI element"
            ;HotkeyStates("Off")
            return true      
 
        } else {
            ;HotkeyStates("On")
            return false 
        }
    }

    if  OnGuiElement(RnX, RnY, XTimeEditX, XTimeEditY, XTimeEditW, XTimeEditH) || OnGuiElement(RnX, RnY, TPKeyEditX, TPKeyEditY, TPKeyEditW, TPKeyEditH) || OnGuiElement(RnX, RnY, TPUserEditX, TPUserEditY, TPUserEditW, TPUserEditH) {
        ;MsgBox,0x40000,, % "Touching GUI element"
        HotkeyStates("Off")
    } else {
        HotkeyStates("On")
    }         
return 


HotkeySettingsGUI:
     SetTimer, UglyCode, Off 
     Gui, 2:Show,, Hotkeys
     HotkeyStates("Off") 
return 

2GuiClose:
    Gui, 2:Hide
    HotkeyStates("On") 
    SetTimer, UglyCode, On   
return 

RevertHotkeys:  
    GuiControl, 2:, StartHotkey, %StartHOTKEYPrev%
    startHOTKEY := StartHOTKEYPrev 
    GuiControl, 2:, StopHotkey, %stopHOTKEYPrev%
    stopHOTKEY := StopHOTKEYPrev
    GuiControl, 2:, addFormHotkey, %addFormHOTKEYPrev%
    addFormHOTKEY := addFormHOTKEYPrev
    GuiControl, 2:, addSlotHotkey, %addSlotHOTKEYPrev%
    addSlotHOTKEY := addSlotHOTKEYPrev
    GuiControl 1:, TPKeyEdit, %TPKey% 
    TPKey := TPKeyPrev
return 


SaveHotkeys:        
    Gui, 2:Submit, NoHide
    Gui, 1:Submit, NoHide   ; Need this here for TPKeyEdit to be read. SaveSettings doesnt need specific mentions strangely.
    HotkeySet := [StartHotkey, StopHotkey, addFormHotkey, addSlotHotkey] 
    for _,hkey in HotkeySet {
        if (hkey = "" or hkey = " ") || (hkey = "!" or hkey = "^" or hkey = "+" or hkey = "^!"){
            Goto, RevertHotkeys 
            ;MsgBox,0x40000, % " "

        }
    }  
    ;no native AlphaNum checker, so gotta do it myself 
    if (!RegExMatch(TPKeyEdit, "[A-Za-z0-9]")) or (StrLen(TPKeyEdit) > 1) { 
        GuiControl, 1:, TPKeyEdit, %TPKeyPrev% 
        TPKey := TPKeyEdit 
        return 
    }
    ;MsgBox,0x40000,, % StartHotkey 
    HotkeySetAll := [StartHotkey, StopHotkey, addFormHotkey, addSlotHotkey, TPKeyEdit]
    i_start := 1   ; works based on a (n(n-1))/ 2 formula of comparisons for checking duplicates rather than doing n^2 (Basically sigma summmation)  
    while (i_start < (HotkeySetAll.Length())){
        i_end := HotkeySetAll.Length()
        while (i_end > i_start) {
            if HotkeySetAll[i_start] = HotkeySetAll[i_end] {
                Gosub, RevertHotkeys
                Gui +Disabled 
                MsgBox,0x40030,% "Duplicate Hotkey", % "Hotkey already in use!", 1.3
                Gui -Disabled 
                return 
            }  
            i_end -= 1
        }
        i_start += 1
    }
    
    startHOTKEY := StartHotkey
    stopHOTKEY := StopHotkey 
    addFormHOTKEY := addFormHotkey
    addSlotHOTKEY := addSlotHotkey
    TPKey := TPKeyEdit

    StartHOTKEYPrev := startHOTKEY 
    StopHOTKEYPrev := stopHOTKEY 
    addFormHOTKEYPrev := addFormHOTKEY 
    addSlotHOTKEYPrev := addSlotHOTKEY
    TPKeyPrev := TPKey 
    

    
    IniWrite, %startHOTKEY%, settings.ini, UserSettings, startk
    IniWrite, %stopHOTKEY%, settings.ini, UserSettings, stopk
    IniWrite, %addFormHOTKEY%, settings.ini, UserSettings, addformk
    IniWrite, %addSlotHOTKEY%, settings.ini, UserSettings, addslotk
    IniWrite, %TPKey%, settings.ini, UserSettings, tpKEY

    Hotkey, %startHOTKEY%, StartMacro, Off 
    Hotkey, %stopHOTKEY%, StopMacro, Off 
    Hotkey, %addFormHOTKEY%, CoordRetriever, Off
    Hotkey, %addSlotHOTKEY%, CoordRetriever, Off
    GuiControl, 1:, startB, %startHOTKEY% (Start)
    GuiControl, 1:, stopB, %stopHOTKEY% (Stop)
 
return 

HelpInfoGUI:
    Gui, 3:New, +AlwaysOnTop +Caption +Border +Resize MinSize200x125
    Gui, 3:Add, Text,,  
    (   
    -----------MAIN USE OF THE MACRO--------- (IF ANYTHING IS UNCLEAR VISIT THE MAIN MACRO PAGE) 
        1) Open FSR on your ALT account FIRST and keep it open. 
        
        2) Launch another roblox instance on your MAIN account (The account you want mastery on) 
           To have multiple instances, use ProcessExplorer (tutorials online and on the macro page)
        
        3) With both in the server, find a spot where it's tight enough for both your alt and main to fit and you can be reliably m1ed  
           - or create a spot by digging a hole in a ground
        
        4) On your alt, hold down LMB (left mouse button) whilst in the tight space, and at the same time press ESC and your alt should 
           be m1ing on its own. Do not pull down the ESC menu. 
        
        5) Go back to your main and start the macro using the start hotkey (whilst ensuring the settings are right for you)
 -----------------------------------------
        Additional helpful info: 

        Q: How do I repeatedely transform and detransform? I'm a human that wants to master kaioken!    
        A: Simply blank out the TP User field and the macro will  have you repeatedly transformed into the form you have chosen. 

        Q: How do I master FSSJ as a saiyain? 
        A: On the TransformKey setting, simply select "None", and by the process of the main section you'll be revived. 

        Q: I'm a frieza/a user of chrome, how do I master it since I remain in form after death? 
        A: A method for permitting this will be implemented in a future update, relatively soon... 
    )  
         
    Gui, 3:Show, Center, InfoHelp
return   

SaveSettings:
    Gui, Submit, NoHide
    ;
    if !RegExMatch(XTimeEdit, "^\d*$") { ;permits ONLY digits and an empty field if the user wants to instant transform 
        GuiControl, 1:, XTimeEdit, %XTime%
        ;MsgBox,0x40000,,% XTime 
        return 
    }

    XTime := XTimeEdit
    TPUser := TPUserEdit
    transformKey := TransKeyEdit
    TPhaseC :=  (TPhaseEdit != "") ? TPhaseEdit : TPhaseC  
    selectedForm := formEdit
    selectedSlot := slotEdit 
 
    if (transformKey != "None"){
            if (TPhaseC = "Before TP")
                TPhaseSet := "Before TP||After TP"
            else if (TPhaseC = "After TP")
                TPhaseSet := "Before TP|After TP||"
        }
    else {
            TPhaseSet := ""
    }

    GuiControl,, TPhaseEdit, |%TPhaseSet%

    IniWrite, %XTime%, settings.ini, tSettings, XholdTime
    IniWrite, %TPUser%, settings.ini, UserSettings, User
    IniWrite, %transformKey%, settings.ini, tSettings, transKey
    IniWrite, %selectedForm%, settings.ini, UserSettings, currentForm
    IniWrite, %TPhaseC%, settings.ini, UserSettings, Phases
    IniWrite, %selectedSlot%, settings.ini, UserSettings, currentSlot
return

F3::
    for key, value in formList
    {
        MsgBox % "Form: " key "`nX: " value[1] "`nY: " value[2]
    }
return 

~RButton::
    CoordMode, Mouse, NetanMastersYu 
    MouseGetPos, mx, my 
    GuiControlGet, formEdit, Pos
    GuiControlGet, slotEdit, Pos  
    if ((mx - formEditX) < formEditW && (mx - formEditX) > 0 && (my - formEditY) < formEditH && (my - formEditY) > 0){
        modifyingForms := true
        modifyingSlots := false
        Menu, FormMenu, Show    
    }
    if ((mx - slotEditX) < slotEditW && (mx - slotEditX) > 0 && (my - slotEditY) < slotEditH && (my - slotEditY) > 0){
        modifyingSlots := true
        modifyingForms := false
        Menu, FormMenu, Show   
    }
    
    ;ToolTip % "MouseX:" mx  "MouseY:" my "`nFormX:" formEditX "FormY:" formEditY    


return

MenuRenameHandler:  ; Renames the current form/slot thats selected on the GUI 
    Gui, Submit, NoHide
    if  (modifyingForms) {
        oldName := formEdit
        component := "Form"
    }
    if (modifyingSlots) {
        oldName := slotEdit
        component := "Slot"
    }
    if (oldName = "")
        return
    
    WinSet, AlwaysOnTop, Off, NetanMastersYu ; Perhaps make a function of this in the future?  
    Gui, +Disabled
    HotkeyStates("Off")
    InputBox, newName, % "Rename " component, Enter new name for "%oldName%":,, 200, 125
    HotkeyStates("On")
    Gui, -Disabled
    WinSet, AlwaysOnTop, On, NetanMastersYu

    if (ErrorLevel)
        return
    
    if (modifyingForms){
        if (InStr(formDisplayList, newName . "|")){
            MsgBox,0x40030, % "STOP RIGHT THERE", % "DUPLICATES ARE DISALLOWED", 1
            Goto, MenuRenameHandler 
            return 
        }
    } 
    if (modifyingSlots){
        if (InStr(slotDisplayList, newName . "|")){
            MsgBox,0x40030, % "STOP RIGHT THERE", % "DUPLICATES ARE DISALLOWED", 1
            Goto, MenuRenameHandler 
            return 
        }
    }
    HotkeyStates("On")
    Gui, -Disabled
    WinSet, AlwaysOnTop, On, NetanMastersYu

    if (modifyingForms){        ; I tried making a function for this block of code but Ahk v1 is just ":(" , need to rewrite in v2 after implementing presets...
        coords := formList[oldName]
        formList.Delete(oldName)
        formList[newName] := coords

        IniDelete, settings.ini, FORMlist, %oldName%
        IniWrite, % coords[1] . "," . coords[2], settings.ini, FORMlist, %newName%
        IniWrite, %newName%, settings.ini, UserSettings, currentForm
        ;MsgBox % formDisplayList 
        formDisplayList := StrReplace(formDisplayList, "||", "|") ; this DEMOTES the now PREVIOUS selectedForm 
        ;MsgBox % formDisplayList
        formDisplayList := StrReplace(formDisplayList, oldName, newName . "|")
        ;MsgBox % formDisplayList
        GuiControl,, formEdit, |%formDisplayList%
    }
    if (modifyingSlots){
        coords := slotList[oldName]
        slotList.Delete(oldName)
        slotList[newName] := coords

        IniDelete, settings.ini, SLOTlist, %oldName%
        IniWrite, % coords[1] . "," . coords[2], settings.ini, SLOTlist, %newName%
        IniWrite, %newName%, settings.ini, UserSettings, currentSlot
        ;MsgBox % slotDisplayList 
        slotDisplayList := StrReplace(slotDisplayList, "||", "|") ; demotion 
        ;MsgBox % slotDisplayList
        slotDisplayList := StrReplace(slotDisplayList, oldName, newName . "|") ; promoted
        ;MsgBox % slotDisplayList
        GuiControl,, slotEdit, |%slotDisplayList%
    }
return

MenuDeleteHandler:   ; Deletes the current form/slot thats selected on the GUI
    Gui, Submit, NoHide
    if (modifyingForms)
        selected := formEdit
    if (modifyingSlots)
        selected := slotEdit 
    
    
    if (selected = "")
        return
    if (modifyingForms) { 
        formList.Delete(selected)
        IniDelete, settings.ini, FORMlist, %selected%

       ; MsgBox % formDisplayList                 ; Because of the variable evaluation quirks of ahkv1, its best NOT to use a function here.  
        if InStr(formDisplayList, selected . "||"){  ; Prevents the top item from being blank       
            if InStr(formDisplayList, "|" . selected . "||"){  ; the condition to decide who gets PROMOTED
                formDisplayList := StrReplace(formDisplayList, selected . "||")
                formDisplayList := StrReplace(formDisplayList, formDisplayList, formDisplayList . "|")
            } else { ; if the selected item is at the bottom or not at the top of the list
                formDisplayList := StrReplace(formDisplayList, selected . "||")
                formDisplayList := StrReplace(formDisplayList, "|", "||",,1)  ; StrReplaces from L -> R , so first occurence is the the one at front 
            }
        } else {
            formDisplayList := StrReplace(formDisplayList, "||", "|")
            if InStr(formDisplayList, "|" . selected . "|"){ ; if its not the top item
                formDisplayList := StrReplace(formDisplayList, selected . "|", "|")
            } else {
                formDisplayList := StrReplace(formDisplayList, selected . "|")
                formDisplayList := StrReplace(formDisplayList, "|","||",,1)
            
            }
        } 

        ;MsgBox % formDisplayList
        GuiControl,, formEdit, |%formDisplayList%
        RegExMatch(formDisplayList, "([^|]+)\|\|", m) ; pulling out the selected form and so it can be written into the ini file     
        formEdit := m1 
       ; MsgBox % m1 
        IniWrite, %formEdit%, settings.ini, UserSettings, currentForm
    } 
    
    if (modifyingSlots) {
        slotList.Delete(selected)
        IniDelete, settings.ini, SLOTlist, %selected%

        ;MsgBox % slotDisplayList
        if InStr(slotDisplayList, selected . "||"){  ; Prevents the top item from being blank
            if InStr(slotDisplayList, "|" . selected . "||"){  ; the condition to decide who gets PROMOTED
                slotDisplayList := StrReplace(slotDisplayList, selected . "||")
                slotDisplayList := StrReplace(slotDisplayList, slotDisplayList, slotDisplayList . "|")
            } else { ; if the selected item is at the bottom or not at the top of the list
                slotDisplayList := StrReplace(slotDisplayList, selected . "||")
                slotDisplayList := StrReplace(slotDisplayList, "|", "||",,1)  ; StrReplaces from L -> R , so first occurence is the the one at front 
            }
        } else {
            slotDisplayList := StrReplace(slotDisplayList, "||", "|")
            if InStr(slotDisplayList, "|" . selected . "|"){
                slotDisplayList := StrReplace(slotDisplayList, selected . "|", "|")
            } else {
                slotDisplayList := StrReplace(slotDisplayList, selected . "|")
                slotDisplayList := StrReplace(slotDisplayList, "|","||",,1)
            
            }
        } 

       ; MsgBox % slotDisplayList
        GuiControl,, slotEdit, |%slotDisplayList%
        RegExMatch(slotDisplayList, "([^|]+)\|\|", m)  ; pulling out the selected form and so it can be written into the ini file   
        slotEdit := m1 
       ; MsgBox % m1 
        IniWrite, %slotEdit%, settings.ini, UserSettings, currentSlot 

    }
return


CoordRetriever:
    CoordMode, Mouse, Screen 
    MouseGetPos, mx, my
    MsgBox,0x40000, SUCCESS, Coords Saved!,1.25  ; 0x40000 means AlwaysOnTop
    LastHotkey := A_ThisHotkey
   ; MsgBox % "You pressed: " LastHotkey 
    if (LastHotkey = addFormHOTKEY){
        name_component :=  "form"
    } else if (LastHotkey = addSlotHOTKEY) {
        name_component := "slot"
    }
    ;MsgBox % name_component
    Goto, CoordAssigner
return 

CoordAssigner:    
    WinSet, AlwaysOnTop, Off, NetanMastersYu
    Gui, +Disabled
    HotkeyStates("Off")
    InputBox, addedName, Name Confirmation, % "Name your " name_component,, 200, 125
    HotkeyStates("On")
    Gui, -Disabled
    WinSet, AlwaysOnTop, On, NetanMastersYu
    

    if (ErrorLevel = 1) {
        ; clicked Cancel
        return
    }

    if (addedName = "") {
        ; clicked OK but left it blank
        MsgBox,0x40030,, % "Please enter a name", 1
        Goto, CoordAssigner
        return
    }

    if (LastHotkey = addFormHOTKEY){
        if (InStr(formDisplayList, addedName . "|")){
            MsgBox,0x40000, Moron Detected, % "DUPLICATES ARE DISALLOWED FOOL", 1
            Goto, CoordAssigner
            return 
        } 
                        
        formList[addedName] := [mx,my]
        IniWrite, % formList[addedName][1] . "," . formList[addedName][2], settings.ini, FORMlist, %addedName%
        ;MsgBox % formDisplayList
        formDisplayList .= addedName . "|"
        ;MsgBox % formDisplayList
        GuiControl,, formEdit, |%formDisplayList%
    
    } else if (LastHotkey = addSlotHOTKEY) {
        if (InStr(slotDisplayList, addedName . "|")){
            MsgBox,0x40000, Moron Detected, % "DUPLICATES ARE DISALLOWED FOOL", 1
            Goto, CoordAssigner
            return 
        }

        slotList[addedName] := [mx,my]
        IniWrite, % slotList[addedName][1] . "," . slotList[addedName][2], settings.ini, SLOTlist, %addedName%
        ;MsgBox % formDisplayList
        slotDisplayList .= addedName . "|"
        ;MsgBox % formDisplayList
        GuiControl,, slotEdit, |%slotDisplayList%

    }
return 


StartMacro: 
    Gui, Minimize
    if (Running)
        return
    if !WinExist("Roblox"){
        MsgBox, Please have the roblox window open.
        return
    }
    SetTimer, UglyCode, Off
    SetTimer, Resetto, 600000
    WinActivate, Roblox
    combatLogNAcount := 0
    SetTimer, MacroFixer, 1000
    Running := true
    SetTimer, MainLoop, 50
return 

StopMacro:
    running := false  
    SetTimer, MainLoop, Off
    SetTimer, MacroFixer, Off
    combatLogNAcount := 0
    SetTimer, DeathWatcher, Off
    SetTimer, HPZenkai, Off 
    SetTimer, RespawnDetector, Off   
    Gui, Show
    SetTimer, UglyCode, 100 
return 

FindForm:
    formCoords := formList[selectedForm]
    MouseMove, formCoords[1], formCoords[2]
return 

transformSeq: 
    Send, {x down}
    Send, {%transformKey% down}
    Sleep, %XTime% 
    Gosub, FindForm
    Send, {%transformKey% up}
    Send, {x up}
return 

MainLoop:   ;----------------------------------------------  MAIN -------------------------------------------------------------------------------------
    if (!Running)
        return 

    if (transformKey != "None" && TPhaseC = "Before TP") {
        GoSub, transformSeq  

    }
    if (TPUser != ""){
        SetTimer, MainLoop, Off 
        Sleep, 150
        Send, %TPKey% 
        WinGetPos,,,WinW,WinH, Roblox 
        ITx := (0.5 * WinW)
        ITy := (0.7525 * WinH)
        Sleep, 1000
        MouseMove, ITx, ITy 
        Sleep, 500
        MouseClick, left
        Sleep, 500 
        Send, %TPUser%
        Sleep, 500 
        Send, {Enter}
        Sleep, 1500
        MouseGetPos, cx, cy 
        MouseMove, cx, cy+400 
        SetTimer, DeathWatcher, 100
        if (transformKey != "None" && TPhaseC = "After TP"){
            SetTimer, HPZenkai, 10 
        } 
    }  

    Sleep, 1000 
return 


DeathWatcher:

    if (!Running)
        return

    if !WinExist("Roblox")
        return

    WinGetPos, winX, winY, winW, winH, Roblox

    TargetColor := 0xBE0606 

    PixelSearch, px, py
        , winX + (winW * 0.8), winY + (winH* 0.8)
        , winX + winW, winY + winH
        , TargetColor
        , 0
        , Fast RGB

    if (ErrorLevel = 0)
    {       
            MsgBox,0x40000,, Found deathpixel, 1
            SetTimer, DeathWatcher, Off
            SetTimer, RespawnDetector, 1000 
    }

return

RespawnDetector:
    if (!Running)
        return

    if !WinExist("Roblox")
        return
    WinGetPos, winX, winY, winW, winH, Roblox
    HPPixelYellow := 0xCBA300                         ; old pixels 0xCEA500, CEA200 CFA300

    PixelSearch, px, py
    , winX, winY
    , winX + (winW * 0.45), winY + (winH * 0.33) 
    , HPPixelYellow 
    , 3
    , Fast RGB
    if (ErrorLevel = 0){
        MsgBox,0x40000,, Found ALIVE pixel, 1
        Sleep, 1000
        SetTimer, RespawnDetector, Off
        if  (WaiterWaiterMoreMastery){
            MsgBox,0x40000,, % "INITIATE REJOIN", 1
            LoggerPixel := 0xD90005
            AssuranceCount := 0
            loop {                        ; unfortunately need this since your corpse can occasionally be punched, setting you in combat even after you respawn. 
                PixelSearch, px, py
                , winX, winY + (winH * 0.15)
                , winX + (winW * 0.15), winY + (winH * 0.33)
                , LoggerPixel 
                , 3
                , Fast RGB
                if (ErrorLevel = 1){
                    if (AssuranceCount = 3){
                        break 
                    }
                    AssuranceCount += 1 
                    Sleep, 3000
                }
            }   
            Running := false 
            SetTimer, MainLoop, Off
            SetTimer, MacroFixer, Off
            SetTimer, DeathWatcher, Off
            SetTimer, HPZenkai, Off 
            ;SetTimer, Resetto, Off      
            combatLogNAcount := 0
            WaiterWaiterMoreMastery := false
            Sleep, 500
            Run, roblox://placeID=7922773201
            Sleep, 500  
            TargetPixel := 0xE5EAEA  ; pixel of START and PLAY :)  
            WinGetPos, winX, winY, winW, winH, Roblox
            IsDone := false
            Twicer := 0  
            loop {     ; Using a loop here was better than using a function because this just targets the main menu. 
                if (Twicer = 2){
                    break 
                } 
                CoordMode, Pixel, Window     
                PixelSearch, px, py
                , winX, winY + (winH * 0.5)
                , winX + (winW * 0.3), winY + winH  
                , TargetPixel 
                , 0
                , Fast RGB Alt 
                if (ErrorLevel = 0){ 
                    MouseMove, px, py
                    Sleep, 250 
                    MouseClick, left 
                    Sleep, 1200
                    Twicer += 1
                    if !IsDone {
                        slotCoords := slotList[selectedSlot]
                        MouseMove, slotCoords[1], slotCoords[2]
                        Sleep, 250
                        MouseClick, left
                        IsDone := true 
                    } 
                } 
            }
            loop {
                PixelSearch, px, py
                , winX, winY
                , winX + (winW * 0.45), winY + (winH * 0.33) 
                , HPPixelYellow 
                , 3
                , Fast RGB
                if (ErrorLevel = 0){
                   ; MsgBox,0x40000,, % "Found ALIVE Pixel",1
                    break 
                }
            }
            Sleep, 5000
            SetTimer, MacroFixer, 1000
            Running := true  
            SetTimer, Resetto, 600000   
        }
        ;MsgBox, 0x40000,, % "are we RUNNING", 1
        SetTimer, MainLoop, 50       
    }   
return 

moveMouseClick(width_mult, height_mult){
        MouseMove, (A_ScreenWidth * width_mult), (A_ScreenHeight * height_mult)
        Sleep, 250 
        MouseClick, Left 
}

windowTransistion(width_mult, height_mult){   ; pressing M opens up the menu ingame which permits free mouse movement, could've accomplished the same thing with k, but this feels safer since it blocks other inputs
        Send, {m} 
        Sleep, 250
        MouseMove, (A_ScreenWidth * width_mult),(A_ScreenHeight * height_mult)          
        Sleep, 250
        MouseClick, Left
        Sleep, 250 
        Send, {m}
}


HPZenkai:
    if (!Running)
        return

    if !WinExist("Roblox")
        return

    WinGetPos, winX, winY, winW, winH, Roblox
    HPPixelRed := 0xCD3B00                 

    PixelSearch, px, py
    , winX, winY
    , winX + (winW * 0.35), winY + (winH * 0.3)
    , HPPixelRed 
    , 3
    , Fast RGB
    if (ErrorLevel = 0){
        SetTimer, HPZenkai, Off 
        MsgBox,0x40000,,DetectedHP, 1
        SetTimer, DeathWatcher, Off     ;i aint taking chances of it detecting some random pixel from the other screen 
        Send, {m}    
        Sleep, 250                      
        moveMouseClick(0.95, 0.25) ; go to alt
        Sleep, 250  
        Send, {Esc}
        Sleep, 1500
        MouseClick, Left  ; stop m1ing 
        Sleep, 250     
        
        windowTransistion(0.25, 0.25) ; go back to original 
        
        Sleep, 250
        GoSub, transformSeq 
        Sleep, 250
        
        windowTransistion(0.95, 0.25) ; go back to alt 
        
        Sleep, 250
        Send, {LButton down} 
        Sleep, 250
        Send, {Esc}
        Sleep, 600
        Send, {LButton up} 
        Sleep, 250
        moveMouseClick(0.25, 0.25) ; return to main
        Sleep, 250
        Send, {m}
        Sleep, 250
        SetTimer, DeathWatcher, 100 
    }
return 

MacroFixer:
    CombatPixel := 0xD90005                         ; old pixel: CB0201
    WinGetPos, winX, winY, winW, winH, Roblox
    PixelSearch, px, py
    , winX, winY + (winH * 0.15)
    , winX + (winW * 0.15), winY + (winH * 0.33)
    , CombatPixel 
    , 3
    , Fast RGB
    if (ErrorLevel = 0){
        combatLogNAcount := 0
    } else {
        combatLogNAcount += 1
        if (combatLogNAcount = 90){
            SetTimer, HPZenkai, Off 
            SetTimer, MainLoop, Off 
            SetTimer, DeathWatcher, Off  
            Send, {Esc}
            Sleep, 350
            Send, {r}  
            Sleep, 350
            Send, {Enter}
            SetTimer, DeathWatcher, 100
            combatLogNAcount := 0
        }
    }
return 

Resetto:
    WaiterWaiterMoreMastery = true
    SetTimer, Resetto, Off 
return

GuiClose:
ExitApp
