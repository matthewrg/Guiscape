#include-once

#include "Form.au3"

#Region ; GUIObjects

Func GUIObjects(Const $parent)
	Local $formList[]

	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "GUIObjects_Handler")
	$this.AddMethod("Create", "GUIObjects_Create")
	$this.AddMethod("RemoveForm", "GUIObjects_RemoveForm")
	$this.AddMethod("GetForm", "GUIObjects_GetForm")
	$this.AddMethod("GetFormCount", "GUIObjects_GetFormCount")

	$this.AddMethod("AddForm", "GUIObjects_AddForm", True)
	$this.AddMethod("IncrementFormCount", "GUIObjects_IncrementFormCount", True)
	$this.AddMethod("DecrementFormCount", "GUIObjects_DecrementFormCount", True)

	$this.AddProperty("Parent", $ELSCOPE_PRIVATE, $parent)
	$this.AddProperty("FormList", $ELSCOPE_PRIVATE, $formList)
	$this.AddProperty("FormCount", $ELSCOPE_PRIVATE, 0)

	Return $this.Object
EndFunc   ;==>GUIObjects

Func GUIObjects_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case "Create Form"
			Return $this.Create()
	EndSwitch
	
			Local $form = $this.GetForm($event.Form)
			
			If IsObj($form) Then
				Switch $form.Handler($event)
					Case "Form Selected", $NC_CLICKED
						Return "Form Selected"

					Case "Form Closed"
						$this.RemoveForm($event.Form)

						Return "Form Closed"

					Case "Form Resized"
						Return "Form Resized"

					Case "Child Form"
						Return "Child Form"

					Case "Parameters"
						Return "Parameters"

					Case "Styles"
						Return "Styles"

					Case "Extended Styles"
						Return "Extended Styles"

					Case "Context Menu"
						Return "Context Menu"

					Case "Menubar"
						Return "Menubar"
				EndSwitch
			EndIf

	Return False
EndFunc   ;==>GUIObjects_Handler

Func GUIObjects_Create(ByRef $this)
	$this.IncrementFormCount()

	Local Const $formObject = Form($this.Parent, "Form" & $this.FormCount)

	$this.AddForm($formObject)

	Return $formObject
EndFunc   ;==>GUIObjects_Create

Func GUIObjects_RemoveForm(ByRef $this, Const ByRef $hwnd)
	Local $formList = $this.FormList

	Switch IsObj($formList[$hwnd])
		Case True
			$formList[$hwnd].Delete()

			MapRemove($formList, $hwnd)

			$this.FormList = $formList

			Return True

		Case False
			Return False
	EndSwitch
EndFunc   ;==>GUIObjects_RemoveForm

Func GUIObjects_GetForm(Const ByRef $this, Const ByRef $hwnd)
	Local Const $formList = $this.FormList

	If MapExists($formList, $hwnd) Then
		Return $formList[$hwnd]
	EndIf
	
	Return False
EndFunc   ;==>GUIObjects_GetForm

Func GUIObjects_GetFormCount(Const ByRef $this)
	Return $this.FormCount
EndFunc   ;==>GUIObjects_GetFormCount

Func GUIObjects_AddForm(ByRef $this, Const ByRef $formObject)
	Switch IsObj($formObject)
		Case True
			Local $formList = $this.FormList

			$formList[$formObject.GetHwnd()] = $formObject

			$this.FormList = $formList
	EndSwitch
EndFunc   ;==>GUIObjects_AddForm

Func GUIObjects_IncrementFormCount(ByRef $this)
	Local Const $formCount = $this.FormCount

	$this.FormCount = ($formCount + 1)
EndFunc   ;==>GUIObjects_IncrementFormCount

Func GUIObjects_DecrementFormCount(ByRef $this)
	Local Const $formCount = $this.FormCount

	$this.FormCount = $formCount - 1
EndFunc   ;==>GUIObjects_DecrementFormCount

#EndRegion ; GUIObjects
