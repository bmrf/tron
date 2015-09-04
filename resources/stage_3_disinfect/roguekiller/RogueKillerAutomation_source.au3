; Purpose:       Automates RogueKillerCMD cleaning
; Requirements:  RogueKillerCMD.exe placed in the same directory as this compiled file
; Author:        reddit.com/user/SleepyDoge
; Version:       1.0.0-TRON
; Misc:          Included for use with Tron by reddit.com/user/vocatus

#include <MsgBoxConstants.au3>
#include <TrayConstants.au3>
#include <Array.au3>
#include <Constants.au3>

sleep(1000)
;Wait for RogueKiller to Start, timeout of 3 minutes
ProcessWait( "RogueKillerCMD.exe", 180 )

;Activate Tron Window and send keystrokes until RogueKillerCMD.exe isn't running
do
sleep(30000)
ControlSend("[stage_3_disinfect] [RogueKiller]", "", "", "remove{ENTER}")
$errorCheck = ProcessExists("RogueKillerCMD.exe")
until $errorCheck = 0

Exit
