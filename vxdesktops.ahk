;; AutoHotkey script for fast switching between Windows 10/11 desktops using hotkeys

;; NOTE:
; - if you have different wallpapers on different desktops (happens with bing
;   wallpapers) you'll get heavy flashing when switching. if wallpapers are the
;   same, switching is really quick! See also:
;   https://techcommunity.microsoft.com/t5/microsoft-bing/bing-wallpaper-app-issue-on-win-11-with-multiple-desktops/m-p/2969683

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
ListLines Off
SetBatchLines -1
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#KeyHistory 0
#WinActivateForce

Process, Priority,, H

SetWinDelay -1
SetControlDelay -1

#Include ./VD.ahk/VD.ahk
; the VD class is super-global so available everywhere
VD.createUntil(7) ;create until we have at least 7 VD

; make ni (instance of Notify that will be created in traynum.ahk) available everywhere
global ni
#include traynum.ahk

global displayedNum := -1
displayCurrentDesktop() {
    ;; get the current desktop number
    curDN := VD.getCurrentDesktopNum()
    ;; we're only going to do anything if the cur desktop number is different than what's currently displayed
    if (curDN != displayedNum) {
        displayedNum := curDN 
        ;ToolTip, % curDN
        ni.SetText(curDN)
    }
}

displayCurrentDesktop()
;; if user alt-tabs to window on different desktop, make sure desktop num
;; reflects this switch
SetTimer displayCurrentDesktop, 200

goToDesktopAndUpdateDisp(desktopNum) {
    ;; switch to requested desktop
    VD.goToDesktopNum(desktopNum)
    displayCurrentDesktop()
}

; - Started with LWin & ... but that would often not trigger, or interfere with
;   the built-in Windows taskbar app shortcuts.
; - RAlt seemed to be more reliable, but would not work for example if task
;   manager was active.
; - Now trying Ctrl Alt N
^!1::goToDesktopAndUpdateDisp(1)
^!2::goToDesktopAndUpdateDisp(2)
^!3::goToDesktopAndUpdateDisp(3)
^!4::goToDesktopAndUpdateDisp(4)
^!5::goToDesktopAndUpdateDisp(5)
^!6::goToDesktopAndUpdateDisp(6)
^!7::goToDesktopAndUpdateDisp(7)
