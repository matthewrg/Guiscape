#include-once

#include "Form.au3"

Func GUIObjects()
	Local $formList[]

	Local $this = _AutoItObject_Class()

	$this.AddMethod("Handler", "GUIObjects_Handler")
	$this.AddMethod("Create", "GUIObjects_Create")
	$this.AddMethod("RemoveForm", "GUIObjects_RemoveForm")
	$this.AddMethod("GetForm", "CanvasForm_GetForm")
	$this.AddMethod("GetFormCount", "CanvasForm_GetFormCount")

	$this.AddProperty("ActiveForm", $ELSCOPE_READONLY)

	$this.AddMethod("Test1", "Test1")
	$this.AddMethod("AddForm", "GUIObjects_AddForm", True)
	$this.AddMethod("IncrementFormCount", "GUIObjects_IncrementFormCount", True)
	$this.AddMethod("DecrementFormCount", "GUIObjects_DecrementFormCount", True)

	$this.AddProperty("FormList", $ELSCOPE_PRIVATE, $formList)
	$this.AddProperty("FormCount", $ELSCOPE_PRIVATE, 0)

	Return $this.Object
EndFunc   ;==>GUIObjects

Func GUIObjects_Handler(ByRef $this, Const ByRef $event)
;~ 	Local Const $form = $this.GetForm($event.Form)
;~
;~ 	If Not $form Then Return False

	Switch $event.Form
		Case $this.GetForm($event.Form).GetHwnd()
			Switch $event.ID
				Case $GUI_EVENT_PRIMARYUP, $WM_NCLBUTTONDOWN
					$this.ActiveForm = $this.GetForm($event.Form)

					Print("Active Form: " & $this.ActiveForm.GetTitle())

					Return True
					
				Case $WM_SIZE
					;Print("Form Resize: " & WinGetTitle($event.Form))
			EndSwitch
	EndSwitch
EndFunc   ;==>GUIObjects_Handler

Func GUIObjects_Create(ByRef $this, Const ByRef $parent)
	$this.IncrementFormCount()

	Local Const $form = Form($parent, "Form" & $this.FormCount)

	$this.AddForm($form)

	$this.ActiveForm = $form

	Return True
EndFunc   ;==>GUIObjects_Create

Func GUIObjects_RemoveForm(ByRef $this, Const ByRef $hwnd)
	Local $formList = $this.FormList

	Switch IsObj($formList[$hwnd])
		Case True
			$formList[$hwnd].Delete()

			MapRemove($formList, $hwnd)

			$this.FormList = $formList

			$this.ActiveForm = Null

			Return True

		Case False
			Return "Not Found!"
	EndSwitch
EndFunc   ;==>GUIObjects_RemoveForm

Func CanvasForm_GetForm(Const ByRef $this, Const ByRef $hwnd)
	Local Const $formList = $this.FormList

	If MapExists($formList, $hwnd) Then
		Return $formList[$hwnd]
	Else
		Return False
	EndIf
EndFunc   ;==>CanvasForm_GetForm

Func CanvasForm_GetFormCount(Const ByRef $this)
	Return $this.FormCount
EndFunc   ;==>CanvasForm_GetFormCount

Func GUIObjects_AddForm(ByRef $this, Const ByRef $form)
	Switch IsObj($form)
		Case True
			Local $formList = $this.FormList

			$formList[$form.GetHwnd()] = $form

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
