#include-once

#include <WinAPISysWin.au3>

#include "AutoItObject.au3"

Func GUIScapeModel()
	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddProperty("Title", $ELSCOPE_READONLY, "Guiscape")
	$this.AddProperty("ResourcesDir", $ELSCOPE_READONLY, @ScriptDir & "\Resources\")

	Return $this.Object
EndFunc   ;==>GUIScapeModel
