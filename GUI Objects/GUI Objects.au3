#include-once

#include "Form.au3"

#Region ; GUIObjects

Func GUIObjects()	
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Settings_Handler")
	
	_AutoItObject_AddMethod($this, "CreateForm", "GUIObjects_CreateForm", True)
	_AutoItObject_AddMethod($this, "RemoveForm", "GUIObjects_RemoveForm", True)
	_AutoItObject_AddMethod($this, "GetForm", "GUIObjects_GetForm", True)
	_AutoItObject_AddMethod($this, "GetFormCount", "GUIObjects_GetFormCount", True)	
	_AutoItObject_AddMethod($this, "AddForm", "GUIObjects_AddForm", True)
	_AutoItObject_AddMethod($this, "IncrementFormCount", "GUIObjects_IncrementFormCount", True)
	_AutoItObject_AddMethod($this, "DecrementFormCount", "GUIObjects_DecrementFormCount", True)

	Local $formList[]
	
	_AutoItObject_AddProperty($this, "Hwnd", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParentHwnd", $ELSCOPE_PRIVATE, Null)	
	_AutoItObject_AddProperty($this, "ParentWidth", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "ParentHeight", $ELSCOPE_PRIVATE, Null)
	_AutoItObject_AddProperty($this, "FormList", $ELSCOPE_PRIVATE, $formList)
	_AutoItObject_AddProperty($this, "FormCount", $ELSCOPE_PRIVATE, 0)

	Return $this
EndFunc   ;==>GUIObjects

Func GUIObjects_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case "Create Form"
			$this.CreateForm()
			
			$messageQueue.Push($messageQueue.CreateEvent("GUIObjects", "Form Created"))
			
			Return True
			
		Case "Remove Form"
			$this.RemoveForm($event.Form)
			
			$messageQueue.Push($messageQueue.CreateEvent("GUIObjects", "Form Removed"))
			
			Return True			
			
		Case "Hwnd Requested"
			$this.ParentHwnd = $event.Form
			
			Return True
			
		Case "Size Requested"
			$this.ParentWidth = $event.Width
			
			$this.ParentHeight = $event.Height

			Return True
			
		Case "Form Count Request"
			$messageQueue.Push($messageQueue.CreateEvent("GUIObjects", "Form Count Requested", "Count", $this.FormCount))
	EndSwitch

	Return False
EndFunc   ;==>GUIObjects_Handler

Func GUIObjects_CreateForm(ByRef $this)
	$this.IncrementFormCount()

	Local Const $formObject = Form($this.Parent, "Form" & $this.FormCount)

	$this.AddForm($formObject)

	Return $formObject
EndFunc   ;==>GUIObjects_CreateForm

Func GUIObjects_RemoveForm(ByRef $this, Const ByRef $hwnd)
	Local $formList = $this.FormList

	Switch IsObj($formList[$hwnd])
		Case True
			MapRemove($formList, $hwnd)

			$this.FormList = $formList

			Return True
	EndSwitch

	Return False
EndFunc   ;==>GUIObjects_RemoveForm

Func GUIObjects_GetForm(Const ByRef $this, Const ByRef $hwnd)
	Local Const $formList = $this.FormList

	If MapExists($formList, $hwnd) Then
		Return $formList[$hwnd]
	EndIf

	Return False
EndFunc   ;==>GUIObjects_GetForm

Func GUIObjects_AddForm(ByRef $this, Const ByRef $formObject)
	Switch IsObj($formObject)
		Case True
			Local $formList = $this.FormList

			$formList[$formObject.GetHwnd()] = $formObject

			$this.FormList = $formList
	EndSwitch
EndFunc   ;==>GUIObjects_AddForm

Func GUIObjects_IncrementFormCount(ByRef $this)
	$this.FormCount = $this.FormCount + 1
EndFunc   ;==>GUIObjects_IncrementFormCount

Func GUIObjects_DecrementFormCount(ByRef $this)
	$this.FormCount = $this.FormCount - 1
EndFunc   ;==>GUIObjects_DecrementFormCount

#EndRegion ; GUIObjects
