; *** environment configuration ***
#Persistent
;	#NoEnv
#SingleInstance Force
;	SetWorkingDir, %A_ScriptDir%
;	SetTitleMatchMode, 2
;	#NoTrayIcon
;	DetectHiddenWindows, On
;	SetBatchLines -1

SysTrayIcon:
	xICON := FetchMyIcon("ThisScriptsTrayIcon")
		If FileExist(xICON.File)
			{
				Menu, Tray, Icon, % xICON.File, % xICON.Index
			}

Menu, Tray, NoStandard
Menu, Tray, Color, b1b1b1

Menu, Tray, Add, % xSEPARATOR(), Separator1

xINFO := "AHK v." . A_AhkVersion . A_Space . ((A_PtrSize=8) ? "(64" : "(32") . "-bit)"

xPURPOSE := "... some script purpose ..."

SplitPath, A_ScriptName, xNAME, xDIR, xEXT, xNAME_NO_EXT, xDRIVE

xSTATS := xNAME_NO_EXT . "`n`n" . xPURPOSE . "`n`n" . xINFO

Menu, Tray, Add, %xINFO%, AHKversionSHOW

xICON := FetchMyIcon("BlueInfoIcon")

If FileExist(xICON.File)
	Menu, Tray, Icon, % xINFO, % xICON.File, % xICON.Index ; <-- using "xINFO" variable here does NOT work

Menu, Tray, Tip, %xSTATS%

Menu, Tray,	Add, % xSEPARATOR(), Separator2

Return

F1::Reload
F2::ExitApp

AHKversionSHOW:
	Run, https://github.com/AutoHotkey/AutoHotkey/releases
Return

ButtonExit:
ExitApp

xSEPARATOR()
	{
		static nbsp := Chr(160), cnt := 0
		sep := "---------------"
		loop % cnt++
			sep .= nbsp
		return, sep
	}

LineSeparators:
	Separator1:
	Separator2:
Return

FetchMyIcon(GuiMenuItem)
	{
		EnvGet, xSYSTEMROOT, SystemRoot
		Icon := xSYSTEMROOT . "\SYSTEM32\shell32.dll"
		If (GuiMenuItem = "ThisScriptsTrayIcon")
			{
				Number := 44
			}

		If (GuiMenuItem = "RedXIcon")
			{
				Number := 240
			}

		If (GuiMenuItem = "RedPowerIcon")
			{
				Number := 329
			}

		If (GuiMenuItem = "BluePowerIcon")
			{
				Number := 221
			}

		If (GuiMenuItem = "BlueInfoIcon")
			{
				Number := 16783
			}
		Return, {File: Icon, Index: Number}
	}
