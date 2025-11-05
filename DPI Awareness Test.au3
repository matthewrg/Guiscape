; AutoIt GUI Example
; Created: 17/01/2005 - CyberSlug
; Modifed: 05/12/2011 - guinness
; Modifed: 09/06/2014 - mLipok
; Modifed: 15/10/2018 - mLipok
; Modifed: 14/08/2023 - UEZ

#AutoIt3Wrapper_Change2CUI=n
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#AutoIt3Wrapper_Res_HiDpi=n  ;must be n otherwise _WinAPI_SetDPIAwareness() function will fail!
#AutoIt3Wrapper_UseX64=n

#Region INCLUDE
#include <AVIConstants.au3>
#include <GuiConstantsEx.au3>
#include <TreeViewConstants.au3>

#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdiDC.au3>
#include <WindowsConstants.au3>
#include "_WinAPI_DPI.au3"
#EndRegion INCLUDE

#Region INITIALIZATION and EXIT
Global $aCtrl[43][6], $ahWnd[2][10], $g_iDPI_ratio1, $g_iDPI_ratio2, $iw = 400, $ih = 200

_Example()
; Finished!
#EndRegion INITIALIZATION and EXIT

Func _Example()
	Local $AWARENESS
	
	Switch @OSBuild
		Case 9200 To 13999
			$AWARENESS = $DPI_AWARENESS_PER_MONITOR_AWARE
		Case @OSBuild > 13999
			$AWARENESS = $DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2
	EndSwitch

	Local $iDPI = _WinAPI_SetDPIAwareness($AWARENESS, 2), $iDPI_def = 96
	If $iDPI = 0 Then Exit MsgBox($MB_ICONERROR, "ERROR", "Unable to set DPI awareness!!!", 10)
	$g_iDPI_ratio1 = $iDPI / $iDPI_def
	$g_iDPI_ratio2 = $iDPI_def / $iDPI

	#Region GUI
	Local $sPath = RegRead("HKLM\SOFTWARE\" & (@AutoItX64 ? "WOW6432Node\" : "") & "AutoIt v3\AutoIt", "InstallDir")
	$sPath = ($sPath = "" ? @ProgramFilesDir & "\AutoIt3\" : $sPath & "\") ;assume default path

	$ahWnd[0][1] = 8.5 * $g_iDPI_ratio1
	$ahWnd[0][0] = GUICreate("DPI Sample GUI", 400 * $g_iDPI_ratio1, 400 * $g_iDPI_ratio1)
	GUISetIcon(@SystemDir & "\mspaint.exe", 0)
	GUISetFont($ahWnd[0][1] * $g_iDPI_ratio1, 400, 0, "Arial", $ahWnd[0][0], $CLEARTYPE_QUALITY)
	#EndRegion GUI

	#Region MENU
	$aCtrl[1][0] = GUICtrlCreateMenu("Menu &One")
	$aCtrl[2][0] = GUICtrlCreateMenu("Menu &Two")

	$aCtrl[3][0] = GUICtrlCreateMenu("Menu Th&ree")
	$aCtrl[4][0] = GUICtrlCreateMenu("Menu &Four")
	GUICtrlCreateMenuItem('SubMenu One &A', $aCtrl[1][0])
	GUICtrlCreateMenuItem('SubMenu One &B', $aCtrl[1][0])
	#EndRegion MENU

	#Region CONTEXT MENU
	$aCtrl[5][0] = GUICtrlCreateContextMenu()
	GUICtrlCreateMenuItem("Context Menu", $aCtrl[5][0])
	GUICtrlCreateMenuItem("", $aCtrl[5][0]) ; Separator
	GUICtrlCreateMenuItem("&Properties", $aCtrl[5][0])
	#EndRegion CONTEXT MENU

	#Region PIC
	$aCtrl[6][2] = 0    ;x
	$aCtrl[6][3] = 0    ;y
	$aCtrl[6][4] = 169  ;w
	$aCtrl[6][5] = 68   ;h
	$aCtrl[6][0] = GUICtrlCreatePic($sPath & "Examples\GUI\logo4.gif", $aCtrl[6][2] * $g_iDPI_ratio1, $aCtrl[6][3] * $g_iDPI_ratio1, $aCtrl[6][4] * $g_iDPI_ratio1, $aCtrl[6][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region PIC')
	$aCtrl[7][2] = 75
	$aCtrl[7][3] = 1
	$aCtrl[7][4] = 80
	$aCtrl[7][5] = 16
	$aCtrl[7][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[7][0] = GUICtrlCreateLabel("Sample Pic", $aCtrl[7][2] * $g_iDPI_ratio1, $aCtrl[7][3] * $g_iDPI_ratio1, $aCtrl[7][4] * $g_iDPI_ratio1, $aCtrl[7][5] * $g_iDPI_ratio1)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetFont(-1, $aCtrl[7][1] * $g_iDPI_ratio1)
	#EndRegion PIC

	#Region AVI
	$aCtrl[8][2] = 180
	$aCtrl[8][3] = 10
	$aCtrl[8][4] = 32
	$aCtrl[8][5] = 32
	$aCtrl[8][0] = GUICtrlCreateAvi($sPath & "Examples\GUI\SampleAVI.avi", 0, $aCtrl[8][2] * $g_iDPI_ratio1, $aCtrl[8][3] * $g_iDPI_ratio1, $aCtrl[8][4] * $g_iDPI_ratio1, $aCtrl[8][5] * $g_iDPI_ratio1, $ACS_AUTOPLAY)
	GUICtrlSetTip(-1, '#Region AVI') ; TODO
	$aCtrl[9][2] = 175
	$aCtrl[9][3] = 50
	$aCtrl[9][4] = 50
	$aCtrl[9][5] = 12
	$aCtrl[9][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[9][0] = GUICtrlCreateLabel("Sample avi", $aCtrl[9][2] * $g_iDPI_ratio1, $aCtrl[9][3] * $g_iDPI_ratio1, $aCtrl[9][4] * $g_iDPI_ratio1, $aCtrl[9][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region AVI - Label')
	GUICtrlSetFont(-1, $aCtrl[9][1] * $g_iDPI_ratio1)
	#EndRegion AVI

	#Region TAB
	$aCtrl[10][2] = 240
	$aCtrl[10][3] = 0
	$aCtrl[10][4] = 150
	$aCtrl[10][5] = 70
	$aCtrl[10][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[10][0] = GUICtrlCreateTab($aCtrl[10][2] * $g_iDPI_ratio1, $aCtrl[10][3] * $g_iDPI_ratio1, $aCtrl[10][4] * $g_iDPI_ratio1, $aCtrl[10][5] * $g_iDPI_ratio1)
	GUICtrlSetFont(-1, $aCtrl[10][1] * $g_iDPI_ratio1)
	$aCtrl[11][0] = GUICtrlCreateTabItem("One")
	GUICtrlSetTip(-1, '#Region TAB1')
	$aCtrl[12][2] = 244
	$aCtrl[12][3] = 35
	$aCtrl[12][4] = 140
	$aCtrl[12][5] = 24
	$aCtrl[12][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[12][0] = GUICtrlCreateLabel("Sample Tab with TabItems", $aCtrl[12][2] * $g_iDPI_ratio1, $aCtrl[12][3] * $g_iDPI_ratio1, $aCtrl[12][4] * $g_iDPI_ratio1, $aCtrl[12][5] * $g_iDPI_ratio1)
	GUICtrlSetFont(-1, $aCtrl[12][1] * $g_iDPI_ratio1)
	$aCtrl[13][0] = GUICtrlCreateTabItem("Two")
	GUICtrlSetTip(-1, '#Region TAB2')
	$aCtrl[14][0] = GUICtrlCreateTabItem("Three")
	GUICtrlSetTip(-1, '#Region TAB3')
	GUICtrlCreateTabItem("")
	#EndRegion TAB

	#Region COMBO
	$aCtrl[15][2] = 250
	$aCtrl[15][3] = 80
	$aCtrl[15][4] = 120
	$aCtrl[15][5] = 100
	$aCtrl[15][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[15][0] = GUICtrlCreateCombo("Sample Combo", $aCtrl[15][2] * $g_iDPI_ratio1, $aCtrl[15][3] * $g_iDPI_ratio1, $aCtrl[15][4] * $g_iDPI_ratio1, $aCtrl[15][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region COMBO')
	GUICtrlSetFont(-1, $aCtrl[15][1] * $g_iDPI_ratio1)
	#EndRegion COMBO

	#Region PROGRESS
	$aCtrl[16][2] = 60
	$aCtrl[16][3] = 80
	$aCtrl[16][4] = 150
	$aCtrl[16][5] = 20
	$aCtrl[16][0] = GUICtrlCreateProgress($aCtrl[16][2] * $g_iDPI_ratio1, $aCtrl[16][3] * $g_iDPI_ratio1, $aCtrl[16][4] * $g_iDPI_ratio1, $aCtrl[16][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region PROGRES')
	GUICtrlSetData(-1, 60)
	$aCtrl[17][2] = 5
	$aCtrl[17][3] = 82
	$aCtrl[17][4] = 50
	$aCtrl[17][5] = 18
	$aCtrl[17][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[17][0] = GUICtrlCreateLabel("Progress:", $aCtrl[17][2] * $g_iDPI_ratio1, $aCtrl[17][3] * $g_iDPI_ratio1, $aCtrl[17][4] * $g_iDPI_ratio1, $aCtrl[17][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region PROGRES - Label')
	GUICtrlSetFont(-1, $aCtrl[17][1] * $g_iDPI_ratio1)
	#EndRegion PROGRESS

	#Region EDIT
	$aCtrl[18][2] = 10
	$aCtrl[18][3] = 110
	$aCtrl[18][4] = 150
	$aCtrl[18][5] = 70
	$aCtrl[18][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[18][0] = GUICtrlCreateEdit(@CRLF & "  Sample Edit Control", $aCtrl[18][2] * $g_iDPI_ratio1, $aCtrl[18][3] * $g_iDPI_ratio1, $aCtrl[18][4] * $g_iDPI_ratio1, $aCtrl[18][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region EDIT')
	GUICtrlSetFont(-1, $aCtrl[18][1] * $g_iDPI_ratio1)
	#EndRegion EDIT

	#Region LIST
	$aCtrl[19][2] = 5
	$aCtrl[19][3] = 190
	$aCtrl[19][4] = 100
	$aCtrl[19][5] = 90
	$aCtrl[19][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[19][0] = GUICtrlCreateList("", $aCtrl[19][2] * $g_iDPI_ratio1, $aCtrl[19][3] * $g_iDPI_ratio1, $aCtrl[19][4] * $g_iDPI_ratio1, $aCtrl[19][5] * $g_iDPI_ratio1)
	GUICtrlSetFont(-1, $aCtrl[19][1] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region LIST')
	GUICtrlSetData(-1, "A.Sample|B.List|C.Control|D.Here", "B.List")
	#EndRegion LIST

	#Region ICON
	$aCtrl[20][2] = 175
	$aCtrl[20][3] = 120
	$aCtrl[20][4] = 32
	$aCtrl[20][5] = 32
	$aCtrl[20][0] = GUICtrlCreateIcon("explorer.exe", 0, $aCtrl[20][2] * $g_iDPI_ratio1, $aCtrl[20][3] * $g_iDPI_ratio1, $aCtrl[20][4] * $g_iDPI_ratio1, $aCtrl[20][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region ICON')
	$aCtrl[21][2] = 180
	$aCtrl[21][3] = 160
	$aCtrl[21][4] = 50
	$aCtrl[21][5] = 20
	$aCtrl[21][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[21][0] = GUICtrlCreateLabel("Icon", $aCtrl[21][2] * $g_iDPI_ratio1, $aCtrl[21][3] * $g_iDPI_ratio1, $aCtrl[21][4] * $g_iDPI_ratio1, $aCtrl[21][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region ICON - Label')
	GUICtrlSetFont(-1, $aCtrl[21][1] * $g_iDPI_ratio1)
	#EndRegion ICON

	#Region LIST VIEW
	$aCtrl[22][2] = 110
	$aCtrl[22][3] = 190
	$aCtrl[22][4] = 110
	$aCtrl[22][5] = 80
	$aCtrl[22][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[22][0] = GUICtrlCreateListView("Sample|ListView|", $aCtrl[22][2] * $g_iDPI_ratio1, $aCtrl[22][3] * $g_iDPI_ratio1, $aCtrl[22][4] * $g_iDPI_ratio1, $aCtrl[22][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region LIST VIEW')
	GUICtrlSetFont(-1, $aCtrl[22][1] * $g_iDPI_ratio1)
	GUICtrlCreateListViewItem("A|One", $aCtrl[22][0])
	GUICtrlCreateListViewItem("B|Two", $aCtrl[22][0])
	GUICtrlCreateListViewItem("C|Three", $aCtrl[22][0])
	#EndRegion LIST VIEW

	#Region GROUP WITH RADIO BUTTONS
	$aCtrl[23][2] = 230
	$aCtrl[23][3] = 120
	$aCtrl[23][4] = 110
	$aCtrl[23][5] = 80
	$aCtrl[23][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[23][0] = GUICtrlCreateGroup("Sample Group", $aCtrl[23][2] * $g_iDPI_ratio1, $aCtrl[23][3] * $g_iDPI_ratio1, $aCtrl[23][4] * $g_iDPI_ratio1, $aCtrl[23][5] * $g_iDPI_ratio1)
	GUICtrlSetFont(-1, $aCtrl[22][1] * $g_iDPI_ratio1)
	$aCtrl[24][2] = 250
	$aCtrl[24][3] = 140
	$aCtrl[24][4] = 80
	$aCtrl[24][5] = 32
	$aCtrl[24][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[24][0] = GUICtrlCreateRadio("Radio One", $aCtrl[24][2] * $g_iDPI_ratio1, $aCtrl[24][3] * $g_iDPI_ratio1, $aCtrl[24][4] * $g_iDPI_ratio1, $aCtrl[24][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region GROUP WITH RADIO BUTTONS- RADIO1')
	GUICtrlSetFont(-1, $aCtrl[24][1] * $g_iDPI_ratio1)
	GUICtrlSetState(-1, $GUI_CHECKED)
	$aCtrl[25][2] = 250
	$aCtrl[25][3] = 165
	$aCtrl[25][4] = 80
	$aCtrl[25][5] = 32
	$aCtrl[25][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[25][0] = GUICtrlCreateRadio("Radio Two", $aCtrl[25][2] * $g_iDPI_ratio1, $aCtrl[25][3] * $g_iDPI_ratio1, $aCtrl[25][4] * $g_iDPI_ratio1, $aCtrl[25][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region GROUP WITH RADIO BUTTONS- RADIO2')
	GUICtrlSetFont(-1, $aCtrl[25][1] * $g_iDPI_ratio1)
	GUICtrlCreateGroup("", -99, -99, 1, 1) ;close group
	#EndRegion GROUP WITH RADIO BUTTONS

	#Region UPDOWN
	$aCtrl[26][2] = 350
	$aCtrl[26][3] = 113
	$aCtrl[26][4] = 40
	$aCtrl[26][5] = 12
	$aCtrl[26][1] = 8 * $g_iDPI_ratio2
	$aCtrl[26][0] = GUICtrlCreateLabel("UpDown", $aCtrl[26][2] * $g_iDPI_ratio1, $aCtrl[26][3] * $g_iDPI_ratio1, $aCtrl[26][4] * $g_iDPI_ratio1, $aCtrl[26][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region UPDOWN - Label')
	GUICtrlSetFont(-1, $aCtrl[26][1] * $g_iDPI_ratio1)
	$aCtrl[27][2] = 350
	$aCtrl[27][3] = 130
	$aCtrl[27][4] = 40
	$aCtrl[27][5] = 20
	$aCtrl[27][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[27][0] = GUICtrlCreateInput("42", $aCtrl[27][2] * $g_iDPI_ratio1, $aCtrl[27][3] * $g_iDPI_ratio1, $aCtrl[27][4] * $g_iDPI_ratio1, $aCtrl[27][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region UPDOWN - Input')
	GUICtrlSetFont(-1, $aCtrl[27][1] * $g_iDPI_ratio1)
	$aCtrl[28][0] = GUICtrlCreateUpdown(-1)
	GUICtrlSetTip(-1, '#Region UPDOWN - Updown')
	#EndRegion UPDOWN

	#Region LABEL
	$aCtrl[29][2] = 350
	$aCtrl[29][3] = 165
	$aCtrl[29][4] = 40
	$aCtrl[29][5] = 40
	$aCtrl[29][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[29][0] = GUICtrlCreateLabel("Green" & @CRLF & "Label", $aCtrl[29][2] * $g_iDPI_ratio1, $aCtrl[29][3] * $g_iDPI_ratio1, $aCtrl[29][4] * $g_iDPI_ratio1, $aCtrl[29][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region LABEL')
	GUICtrlSetBkColor(-1, 0x00FF00)
	GUICtrlSetFont(-1, $aCtrl[29][1] * $g_iDPI_ratio1)
	#EndRegion LABEL

	#Region SLIDER
	$aCtrl[30][2] = 235
	$aCtrl[30][3] = 215
	$aCtrl[30][4] = 40
	$aCtrl[30][5] = 16
	$aCtrl[30][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[30][0] = GUICtrlCreateLabel("Slider:", $aCtrl[30][2] * $g_iDPI_ratio1, $aCtrl[30][3] * $g_iDPI_ratio1, $aCtrl[30][4] * $g_iDPI_ratio1, $aCtrl[30][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region SLIDER - Label')
	GUICtrlSetFont(-1, $aCtrl[30][1] * $g_iDPI_ratio1)
	$aCtrl[31][2] = 270
	$aCtrl[31][3] = 210
	$aCtrl[31][4] = 120
	$aCtrl[31][5] = 30
	$aCtrl[31][0] = GUICtrlCreateSlider($aCtrl[31][2] * $g_iDPI_ratio1, $aCtrl[31][3] * $g_iDPI_ratio1, $aCtrl[31][4] * $g_iDPI_ratio1, $aCtrl[31][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region SLIDER')
	GUICtrlSetData(-1, 30)
	#EndRegion SLIDER

	#Region INPUT
	$aCtrl[32][2] = 235
	$aCtrl[32][3] = 255
	$aCtrl[32][4] = 130
	$aCtrl[32][5] = 20
	$aCtrl[32][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[32][0] = GUICtrlCreateInput("Sample Input Box", $aCtrl[32][2] * $g_iDPI_ratio1, $aCtrl[32][3] * $g_iDPI_ratio1, $aCtrl[32][4] * $g_iDPI_ratio1, $aCtrl[32][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region INPUT')
	GUICtrlSetFont(-1, $aCtrl[32][1] * $g_iDPI_ratio1)
	#EndRegion INPUT

	#Region DATE
	$aCtrl[33][2] = 5
	$aCtrl[33][3] = 280
	$aCtrl[33][4] = 200
	$aCtrl[33][5] = 20
	$aCtrl[33][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[33][0] = GUICtrlCreateDate("", $aCtrl[33][2] * $g_iDPI_ratio1, $aCtrl[33][3] * $g_iDPI_ratio1, $aCtrl[33][4] * $g_iDPI_ratio1, $aCtrl[33][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region DATE')
	GUICtrlSetFont(-1, $aCtrl[33][1] * $g_iDPI_ratio1)
	$aCtrl[34][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[34][2] = 10
	$aCtrl[34][3] = 305
	$aCtrl[34][4] = 200
	$aCtrl[34][5] = 20
	$aCtrl[34][0] = GUICtrlCreateLabel("(Date control expands into a calendar)", $aCtrl[34][2] * $g_iDPI_ratio1, $aCtrl[34][3] * $g_iDPI_ratio1, $aCtrl[34][4] * $g_iDPI_ratio1, $aCtrl[34][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region DATE - Label')
	GUICtrlSetFont(-1, $aCtrl[34][1] * $g_iDPI_ratio1)
	#EndRegion DATE

	#Region BUTTON
	$aCtrl[35][2] = 10
	$aCtrl[35][3] = 330
	$aCtrl[35][4] = 100
	$aCtrl[35][5] = 30
	$aCtrl[35][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[35][0] = GUICtrlCreateButton("Click me :-)", $aCtrl[35][2] * $g_iDPI_ratio1, $aCtrl[35][3] * $g_iDPI_ratio1, $aCtrl[35][4] * $g_iDPI_ratio1, $aCtrl[35][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region BUTTON')
	GUICtrlSetFont(-1, $aCtrl[35][1] * $g_iDPI_ratio1)
	#EndRegion BUTTON

	#Region CHECKBOX
	$aCtrl[36][2] = 130
	$aCtrl[36][3] = 335
	$aCtrl[36][4] = 80
	$aCtrl[36][5] = 20
	$aCtrl[36][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[36][0] = GUICtrlCreateCheckbox("Checkbox", $aCtrl[36][2] * $g_iDPI_ratio1, $aCtrl[36][3] * $g_iDPI_ratio1, $aCtrl[36][4] * $g_iDPI_ratio1, $aCtrl[36][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region CHECKBOX')
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlSetFont(-1, $aCtrl[36][1] * $g_iDPI_ratio1)
	#EndRegion CHECKBOX

	#Region TREEVIEW ONE
	$aCtrl[37][2] = 210
	$aCtrl[37][3] = 290
	$aCtrl[37][4] = 80
	$aCtrl[37][5] = 80
	$aCtrl[37][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[37][0] = GUICtrlCreateTreeView($aCtrl[37][2] * $g_iDPI_ratio1, $aCtrl[37][3] * $g_iDPI_ratio1, $aCtrl[37][4] * $g_iDPI_ratio1, $aCtrl[37][5] * $g_iDPI_ratio1)
	GUICtrlSetTip(-1, '#Region TREEVIEW ONE')
	GUICtrlSetFont(-1, $aCtrl[37][1] * $g_iDPI_ratio1)
	$aCtrl[38][0] = GUICtrlCreateTreeViewItem("TreeView", $aCtrl[37][0])
	GUICtrlCreateTreeViewItem("Item1", $aCtrl[38][0])
	GUICtrlCreateTreeViewItem("Item2", $aCtrl[38][0])
	GUICtrlCreateTreeViewItem("Foo", -1)
	GUICtrlSetState($aCtrl[38][0], $GUI_EXPAND)
	#EndRegion TREEVIEW ONE

	#Region TREEVIEW TWO
	$aCtrl[39][2] = 295
	$aCtrl[39][3] = 290
	$aCtrl[39][4] = 103
	$aCtrl[39][5] = 80
	$aCtrl[39][1] = 8.5 * $g_iDPI_ratio2
	$aCtrl[39][0] = GUICtrlCreateTreeView($aCtrl[39][2] * $g_iDPI_ratio1, $aCtrl[39][3] * $g_iDPI_ratio1, $aCtrl[39][4] * $g_iDPI_ratio1, $aCtrl[39][5] * $g_iDPI_ratio1, $TVS_CHECKBOXES)
	GUICtrlSetTip(-1, '#Region TREEVIEW TWO')
	GUICtrlSetFont(-1, $aCtrl[39][1] * $g_iDPI_ratio1)
	GUICtrlCreateTreeViewItem("TreeView", $aCtrl[39][0])
	GUICtrlCreateTreeViewItem("With", $aCtrl[39][0])
	GUICtrlCreateTreeViewItem("$TVS_CHECKBOXES", $aCtrl[39][0])
	GUICtrlSetState(-1, $GUI_CHECKED)
	GUICtrlCreateTreeViewItem("Style", $aCtrl[39][0])
	#EndRegion TREEVIEW TWO

	#Region GUI MESSAGE LOOP
	GUISetState(@SW_SHOW)

	If @OSBuild > 9599 Then GUIRegisterMsg($WM_DPICHANGED, "WM_DPICHANGED") ;requires Win 8.1+ / Server 2012 R2+
	GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")
	GUIRegisterMsg($WM_SIZE, "WM_SIZE")

	Local $hGUI_child, $hImage, $hGDIBitmap, $hGfx, $hPath, $hFamily, $hFormat, $tLayout, $hPen, $hBrush, $hB, $aGUIGetMsg
	_GDIPlus_Startup()

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				_GDIPlus_PathDispose($hPath)
				_GDIPlus_PenDispose($hPen)
				_GDIPlus_BrushDispose($hBrush)
				_GDIPlus_FontFamilyDispose($hFamily)
				_GDIPlus_StringFormatDispose($hFormat)
				_GDIPlus_ImageDispose($hImage)
				_GDIPlus_GraphicsDispose($hGfx)
				_GDIPlus_Shutdown()
				GUIRegisterMsg($WM_DPICHANGED, "")
				GUIRegisterMsg(WM_GETMINMAXINFO, "")
				GUIRegisterMsg(WM_SIZE, "")
				GUIDelete()
				Exit
			Case $aCtrl[35][0]
				If $hImage Then $hImage = _GDIPlus_ImageDispose($hImage)
				$hImage = _GDIPlus_BitmapCreateFromScan0($iw * $g_iDPI_ratio1, $ih * $g_iDPI_ratio1)
				If $hGfx Then _GDIPlus_GraphicsDispose($hGfx)
				$hGfx = _GDIPlus_ImageGetGraphicsContext($hImage)
				_GDIPlus_GraphicsSetTextRenderingHint($hGfx, $GDIP_TEXTRENDERINGHINTANTIALIAS)
				_GDIPlus_GraphicsSetSmoothingMode($hGfx, $GDIP_SMOOTHINGMODE_HIGHQUALITY)
				_GDIPlus_GraphicsClear($hGfx, 0xFFF0F0F0)
				If $hPath Then _GDIPlus_PathDispose($hPath)
				$hPath = _GDIPlus_PathCreate()
				If $hFamily Then _GDIPlus_FontFamilyDispose($hFamily)
				$hFamily = _GDIPlus_FontFamilyCreate("Arial")
				If $hFormat Then _GDIPlus_StringFormatDispose($hFormat)
				$hFormat = _GDIPlus_StringFormatCreate()
				_GDIPlus_StringFormatSetAlign($hFormat, 1)
				_GDIPlus_StringFormatSetLineAlign($hFormat, 1)
				$tLayout = _GDIPlus_RectFCreate(0, 0, $iw * $g_iDPI_ratio1, $ih * $g_iDPI_ratio1)
				_GDIPlus_PathAddString($hPath, "Hello World!", $tLayout, $hFamily, 0, 50 * $g_iDPI_ratio1, $hFormat)
				If $hPen Then _GDIPlus_PenDispose($hPen)
				$hPen = _GDIPlus_PenCreate(0xFF000000, 8)
				_GDIPlus_PenSetLineJoin($hPen, 2)
				_GDIPlus_GraphicsDrawPath($hGfx, $hPath, $hPen)
				If $hBrush Then _GDIPlus_BrushDispose($hBrush)
				$hBrush = _GDIPlus_BrushCreateSolid(0xFF00FF00)
				_GDIPlus_GraphicsFillPath($hGfx, $hPath, $hBrush)
				If $hGDIBitmap Then _WinAPI_DeleteObject($hGDIBitmap)
				$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
				Local $aGUI_Pos = WinGetPos($ahWnd[0][0])
				$ahWnd[1][0] = GUICreate("GDI+ Child Window", $iw * $g_iDPI_ratio1, $ih * $g_iDPI_ratio1, $aGUI_Pos[0] - ($aGUI_Pos[2] - $iw * $g_iDPI_ratio1) / 2, $aGUI_Pos[1] + $ih * $g_iDPI_ratio1 / 2, $WS_SIZEBOX, -1, $ahWnd[0][0])
				$aCtrl[40][2] = 0
				$aCtrl[40][3] = 0
				$aCtrl[40][4] = $iw
				$aCtrl[40][5] = $ih
				$aCtrl[40][0] = GUICtrlCreatePic("", $aCtrl[40][2], $aCtrl[40][3], $aCtrl[40][4] * $g_iDPI_ratio1, $aCtrl[40][5] * $g_iDPI_ratio1)
				_WinAPI_DeleteObject(GUICtrlSendMsg($aCtrl[40][0], $STM_SETIMAGE, $IMAGE_BITMAP, $hGDIBitmap))
				GUISetState(@SW_SHOW, $ahWnd[1][0])
				While 1
					$aGUIGetMsg = GUIGetMsg(1)
					Switch $aGUIGetMsg[1]
						Case $ahWnd[1][0]
							Switch $aGUIGetMsg[0]
								Case $GUI_EVENT_CLOSE
									GUIDelete($ahWnd[1][0])
									ExitLoop
							EndSwitch
					EndSwitch
				WEnd
		EndSwitch
	WEnd
	#EndRegion GUI MESSAGE LOOP

EndFunc   ;==>_Example

Func WM_SIZE($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam, $lParam
	Switch $hWnd
		Case $ahWnd[1][0]
			Local $aSize = ControlGetPos($ahWnd[1][0], "", $aCtrl[40][0])
			$aCtrl[40][2] = $aSize[0]
			$aCtrl[40][3] = $aSize[1]
			$aCtrl[40][4] = _WinAPI_LoWord($lParam)
			$aCtrl[40][5] = _WinAPI_HiWord($lParam)
			GUICtrlSetPos($aCtrl[40][0], $aCtrl[40][2], $aCtrl[40][3], $aCtrl[40][4], $aCtrl[40][5])
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE

Func WM_GETMINMAXINFO($hWnd, $Msg, $wParam, $lParam)
	If $hWnd = $ahWnd[1][0] Then
		Local $minmaxinfo = DllStructCreate("long ptReservedX;long ptReservedY;long ptMaxSizeX; long ptMaxSizeY;long ptMaxPositionX;long ptMaxPositionY;long ptMinTrackSizeX;long ptMinTrackSizeY;long ptMaxTrackSizeX;long ptMaxTrackSizeY  ", $lParam)
		$minmaxinfo.ptMinTrackSizeX = $iw / 2
		$minmaxinfo.ptMinTrackSizeY = $ih / 2
		$minmaxinfo.ptMaxTrackSizeX = $iw * 3
		$minmaxinfo.ptMaxTrackSizeY = $ih * 3
	EndIf
	Return "GUI_RUNDEFMSG"
EndFunc   ;==>WM_GETMINMAXINFO

Func WM_DPICHANGED($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg
	Local $iDPI = _WinAPI_LoWord($wParam)
	ConsoleWrite("DPI change triggered! DPI: " & $iDPI & @CRLF)
	$g_iDPI_ratio1 = $iDPI / 96
	$g_iDPI_ratio2 = $g_iDPI_ratio1 ^ - 1
	Local $tRECT = DllStructCreate($tagRECT, $lParam)
	Local $iX = $tRECT.left, $iY = $tRECT.top, $iw = $tRECT.right - $iX, $ih = $tRECT.bottom - $iY, $i
	Switch $hWnd
		Case $ahWnd[0][0]
			_WinAPI_SetWindowPos($ahWnd[0][0], 0, $iX, $iY, $iw, $ih, BitOR($SWP_NOZORDER, $SWP_NOACTIVATE))
			For $i = 0 To 39
				If $aCtrl[$i][1] Then GUICtrlSetFont($aCtrl[$i][0], $aCtrl[$i][1] * $g_iDPI_ratio1)
				If $aCtrl[$i][4] Then GUICtrlSetPos($aCtrl[$i][0], $aCtrl[$i][2] * $g_iDPI_ratio1, $aCtrl[$i][3] * $g_iDPI_ratio1, $aCtrl[$i][4] * $g_iDPI_ratio1, $aCtrl[$i][5] * $g_iDPI_ratio1)
			Next
			_WinAPI_UpdateWindow($ahWnd[0][0])
		Case $ahWnd[1][0]
			$i = 40
			_WinAPI_SetWindowPos($ahWnd[1][0], 0, $iX, $iY, $iw, $ih, BitOR($SWP_NOZORDER, $SWP_NOACTIVATE))
			GUICtrlSetPos($aCtrl[$i][0], $aCtrl[$i][2], $aCtrl[$i][3], $aCtrl[$i][4], $aCtrl[$i][5])
			_WinAPI_UpdateWindow($ahWnd[1][0])
	EndSwitch
	Return 1
EndFunc   ;==>WM_DPICHANGED
