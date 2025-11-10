#include-once

#include "Form.au3"

#Region ; GUIObjects

Func GUIObjects()
	Local $formList[]

	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Handler", "GUIObjects_Handler")
	$this.AddMethod("Create", "GUIObjects_Create")
	$this.AddMethod("RemoveForm", "GUIObjects_RemoveForm")
	$this.AddMethod("GetForm", "GUIObjects_GetForm")
	$this.AddMethod("GetFormCount", "GUIObjects_GetFormCount")
	$this.AddMethod("GetActiveObject", "GUIObjects_GetActiveObject")
	$this.AddMethod("UnSetActiveObject", "GUIObjects_UnSetActiveObject")

	$this.AddMethod("AddForm", "GUIObjects_AddForm", True)
	$this.AddMethod("IncrementFormCount", "GUIObjects_IncrementFormCount", True)
	$this.AddMethod("DecrementFormCount", "GUIObjects_DecrementFormCount", True)

	$this.AddProperty("ActiveObject", $ELSCOPE_PRIVATE, ActiveObject())
	$this.AddProperty("FormList", $ELSCOPE_PRIVATE, $formList)
	$this.AddProperty("FormCount", $ELSCOPE_PRIVATE, 0)

	Return $this.Object
EndFunc   ;==>GUIObjects

Func GUIObjects_Handler(ByRef $this, Const ByRef $event)
	Switch $event.Form
		Case $this.GetForm($event.Form).GetHwnd()
			Switch $event.ID
				Case $GUI_EVENT_PRIMARYUP, $WM_NCLBUTTONDOWN
					$this.ActiveObject.Set($this.GetForm($event.Form))

					Return "Form Selected"

				Case $WM_SIZE
					;Print("Form Resize: " & WinGetTitle($event.Form))

					Return True
			EndSwitch
	EndSwitch

	Return False
EndFunc   ;==>GUIObjects_Handler

Func GUIObjects_Create(ByRef $this, Const ByRef $parent)
	$this.IncrementFormCount()

	Local Const $form = Form($parent, "Form" & $this.FormCount)

	$this.AddForm($form)

	$this.ActiveObject.Set($form)

	Return True
EndFunc   ;==>GUIObjects_Create

Func GUIObjects_RemoveForm(ByRef $this, Const ByRef $hwnd)
	Local $formList = $this.FormList

	Switch IsObj($formList[$hwnd])
		Case True
			$formList[$hwnd].Delete()

			MapRemove($formList, $hwnd)

			$this.FormList = $formList

			$this.ActiveObject.UnSet()

			Return True

		Case False
			Return False
	EndSwitch
EndFunc   ;==>GUIObjects_RemoveForm

Func GUIObjects_GetForm(Const ByRef $this, Const ByRef $hwnd)
	Local Const $formList = $this.FormList

	If MapExists($formList, $hwnd) Then
		Return $formList[$hwnd]
	Else
		Return False
	EndIf
EndFunc   ;==>GUIObjects_GetForm

Func GUIObjects_GetFormCount(Const ByRef $this)
	Return $this.FormCount
EndFunc   ;==>GUIObjects_GetFormCount

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

Func GUIObjects_GetActiveObject(Const ByRef $this)
	Return $this.ActiveObject.Get()
EndFunc   ;==>GUIObjects_GetActiveObject

Func GUIObjects_UnSetActiveObject(Const ByRef $this)
	$this.ActiveObject.UnSet()
EndFunc   ;==>GUIObjects_UnSetActiveObject

#EndRegion ; GUIObjects

#Region ; ActiveObject

Func ActiveObject()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Get", "ActiveObject_Get")
	$this.AddMethod("Set", "ActiveObject_Set")
	$this.AddMethod("UnSet", "ActiveObject_UnSet")

	$this.AddProperty("Type", $ELSCOPE_READONLY, Null)

	$this.AddProperty("ActiveObject", $ELSCOPE_PRIVATE, Null)

	Return $this.Object
EndFunc   ;==>ActiveObject

Func ActiveObject_Get(Const ByRef $this)
	Return $this.ActiveObject
EndFunc   ;==>ActiveObject_Get

Func ActiveObject_Set(ByRef $this, Const ByRef $form)
	Switch IsObj($form)
		Case True
			Switch $this.ActiveObject.GetHwnd() <> $form.GetHwnd()
				Case True
					$this.ActiveObject = $form

					Print("Active Form: " & $form.GetTitle())
			EndSwitch
	EndSwitch
EndFunc   ;==>ActiveObject_Set

Func ActiveObject_UnSet(ByRef $this)
	Switch $this.ActiveObject <> Null
		Case True
			$this.ActiveObject = Null

			Print("Active Form: Null")
	EndSwitch
EndFunc   ;==>ActiveObject_UnSet
