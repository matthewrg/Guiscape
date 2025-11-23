
#include-once

Global Const $init = "Initialize"

Global Const $GUI_NC_CLICKED = "GUI_NC_CLICKED"

Global Const $mainFormBroadcast = "Main Form Broadcast"

Global Const $mainFormRequest = "Main Form Request"

Global Const $mainFormHwndRequest = "Main Form Hwnd Request"

Global Const $mainFormSizeRequest = "Main Form Size Request"

Global Const $mainFormPositionRequest = "Main Form Position Request"

Global Const $mainFormShowRequest = "Main Form Show Request"

Global Const $mainFormResized = "Main Form Resized"

Global Const $mainFormMoved = "Main Form Moved"

Global Const $mainTabRequest = "Main Tab Request"

Global Const $mainTabHwndRequest = "Main Tab Hwnd Request"

Global Const $menuItemSelected = "Menu Item Selected"

Global Const $tabItemHwndRequest = "Tab Item Hwnd Request"

Global Const $settingsRequest = "Settings Request"

Global Const $showCanvasRequest = "Show Canvas Request"

Global Const $showParametersRequest = "Show Parameters Request"

Global Const $showScriptRequest = "Show Script Request"

Global Const $showObjectExplorerRequest = "Show Object Explorer Request"

Global Const $showSettingsRequest = "Show Settings Request"

Func Request(Const $sender, Const $request)
	Return $sender & ' ' & $request
EndFunc

Func Response(Const $sender, Const $request)
	Return Request($sender, $request) & "ed"
EndFunc
