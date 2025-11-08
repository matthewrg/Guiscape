#include-once

#include "..\AutoItObject.au3"

#include <Array.au3>

Func CanvasModel()
	Local $formList[]

	Local $this = _AutoItObject_Class()

	$this.AddMethod("AddForm", "CanvasModel_AddForm")
	$this.AddMethod("RemoveForm", "CanvasModel_RemoveForm")
	$this.AddMethod("GetForm", "CanvasForm_GetForm")
	$this.AddMethod("GetFormCount", "CanvasForm_GetFormCount")

	$this.AddMethod("IncrementFormCount", "CanvasModel_IncrementFormCount", True)
	$this.AddMethod("DecrementFormCount", "CanvasModel_DecrementFormCount", True)

	$this.AddProperty("FormList", $ELSCOPE_PRIVATE, $formList)
	$this.AddProperty("FormCount", $ELSCOPE_PRIVATE, 0)

	Return $this.Object
EndFunc   ;==>CanvasModel

Func CanvasModel_AddForm(ByRef $this, Const ByRef $form)
	Switch IsObj($form)
		Case True
			Local $formList = $this.FormList

			$formList[$form.GetHwnd()] = $form

			$this.FormList = $formList

			$this.IncrementFormCount()
	EndSwitch
EndFunc   ;==>CanvasModel_AddForm

Func CanvasModel_RemoveForm(ByRef $this, Const ByRef $hwnd)
	Local $formList = $this.FormList
	
	Switch IsObj($formList[$hwnd])
		Case True
			$formList[$hwnd].Delete()
			
			MapRemove($formList, $hwnd)
			
			$this.FormList = $formList
		Case False
			Return "Not Found!"
	EndSwitch
EndFunc   ;==>CanvasModel_RemoveForm

Func CanvasForm_GetForm(Const ByRef $this, Const ByRef $hwnd)
	Local Const $formList = $this.FormList
	
	If MapExists($formList, $hwnd) Then
		Return $formList[$hwnd]
	Else
		Return "Not Found!"
	EndIf
EndFunc   ;==>CanvasForm_GetForm

Func CanvasForm_GetFormCount(Const ByRef $this)
	Return $this.FormCount
EndFunc   ;==>CanvasForm_GetFormCount

Func CanvasModel_IncrementFormCount(ByRef $this)
	Local Const $formCount = $this.FormCount

	$this.FormCount = ($formCount + 1)
EndFunc   ;==>CanvasModel_IncrementFormCount

Func CanvasModel_DecrementFormCount(ByRef $this)
	Local Const $formCount = $this.FormCount

	$this.FormCount = $formCount - 1
EndFunc   ;==>CanvasModel_DecrementFormCount
