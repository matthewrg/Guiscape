
#include-once

Func Control()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddProperty($this, "Name", $ELSCOPE_READONLY, '')
	_AutoItObject_AddProperty($this, "Text", $ELSCOPE_READONLY, '')
	_AutoItObject_AddProperty($this, "Left", $ELSCOPE_READONLY, 0)
	_AutoItObject_AddProperty($this, "Top", $ELSCOPE_READONLY, 0)
	_AutoItObject_AddProperty($this, "Width", $ELSCOPE_READONLY, 0)
	_AutoItObject_AddProperty($this, "Height", $ELSCOPE_READONLY, 0)
	_AutoItObject_AddProperty($this, "Style", $ELSCOPE_READONLY, 0)
	_AutoItObject_AddProperty($this, "ExStyle", $ELSCOPE_READONLY, 0)
	_AutoItObject_AddProperty($this, "BgColor", $ELSCOPE_READONLY, Hex(0))
	_AutoItObject_AddProperty($this, "ForeColor", $ELSCOPE_READONLY, Hex(0))
	_AutoItObject_AddProperty($this, "", $ELSCOPE_READONLY)

	_AutoItObject_AddMethod($this, "", "Control_")
	_AutoItObject_AddMethod($this, "", "Control_")
	
	Return $this
EndFunc   ;==>Control


