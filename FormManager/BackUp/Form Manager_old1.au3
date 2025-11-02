
#include-once

#include <Array.au3>

#include "Form.au3"

Func FormManager()
	Local $formList = []

	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddProperty("State", $ELSCOPE_PUBLIC, "Default")

	$this.AddProperty("ActiveForm", $ELSCOPE_PUBLIC, Null)
	$this.AddProperty("FormList", $ELSCOPE_READONLY, $formList)
	$this.AddProperty("FormCount", $ELSCOPE_READONLY, 0)

	$this.AddMethod("Handler", "FormManager_Handler")
	$this.AddMethod("CreateHandler", "FormManager_CreateHandler")
	$this.AddMethod("SetActiveForm", "FormManager_SetActiveForm")
	$this.AddMethod("GetForm", "FormManager_GetForm")
	$this.AddMethod("Add", "FormManager_Add")
	$this.AddMethod("Remove", "FormManager_Remove")

	Return $this.Object
EndFunc   ;==>FormManager

Func FormManager_Handler(ByRef $this, Const ByRef $event)  
  Local Const $title = WinGetTitle(HWnd($event.Form))
  
  If $title = "Guiscape" Or $title = "Canvas" Then Return False
  
  Switch $this.State
	Case "Default"
	  Switch $event.ID
		Case $GUI_EVENT_PRIMARYUP		
			Return True
	  EndSwitch
	  
	Case "Button"
	Switch $event.ID
		Case $GUI_EVENT_PRIMARYDOWN
			Local $form = $this.GetForm($event.Form)
			
			$form.CreateButton($event.X, $event.Y)

			Return "Button"
	EndSwitch
  EndSwitch
  
  Return False
EndFunc

Func FormManager_CreateHandler(ByRef $this, Const ByRef $event)

	Return False
EndFunc   ;==>Form_CreateButtonHandler

Func FormManager_SetActiveForm(ByRef $this, Const ByRef $form)
	$this.ActiveForm = $form
EndFunc   ;==>FormManager_SetActiveForm

Func FormManager_GetForm(ByRef $this, Const $form)  
	Local Const $formList = $this.FormList
	
	Local Const $formCount = $this.FormCount
	
	For $i = 1 To $formCount
		If HWnd($form) = HWnd($formList[$i].Hwnd) Then
		  Return $formList[$i]
		EndIf
	Next
	
	Return -1
EndFunc

Func FormManager_Add(ByRef $this, Const ByRef $form)
	Local $formList = $this.FormList

	_ArrayAdd($formList, $form)

	$this.FormList = $formList

	Local $formCount = $this.FormCount

	$formCount += 1

	$this.FormCount = $formCount

	$this.SetActiveForm($form)
EndFunc   ;==>FormManager_Add

Func FormManager_Remove(ByRef $this, Const ByRef $form)
	Local $formCount = $this.FormCount
	
	$formCount -= 1

	$this.FormCount = $formCount
	
	Local $formList = $this.FormList
	
	_ArrayDelete($formList, $form)

	$this.FormList = $formList
	
	$this.SetActiveForm($form)
EndFunc   ;==>FormManager_Remove
