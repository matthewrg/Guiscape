#include-once

#include "Queue.au3"

Func MessageQueue()
	Local Const $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Push"   , "MessageQueue_Push"   )
	$this.AddMethod("DeQueue", "MessageQueue_DeQueue")
	$this.AddMethod("Peek"   , "MessageQueue_Peek"   )

	$this.AddProperty("Queue", $ELSCOPE_PRIVATE, Queue())

	Return $this.Object
EndFunc

Func MessageQueue_Push(ByRef $this, Const $param1, Const $param2, Const $param3 = '', Const $param4 = '', Const $param5 = '', Const $param6 = '', Const $param7 = '', Const $param8 = '')
	Local Const $message = Create_Message($param1, $param2, $param3, $param4, $param5, $param6)
	
	$this.Queue.EnQueue($message)
EndFunc

Func Create_Message(Const $param1, Const $param2, Const $param3 = '', Const $param4 = '', Const $param5 = '', Const $param6 = '', Const $param7 = '', Const $param8 = '')
	Local Const $message = _AutoItObject_Class()
	
	$message.Create()

	For $i = 1 to @NumParams - 1 Step 2
		;Consolewrite(Eval("param" & $i) & @TAB & Eval("param" & $i + 1) & @CRLF)
		
		$message.AddProperty(Eval("param" & $i), $ELSCOPE_READONLY, Eval("param" & ($i + 1)))
	Next

	Return $message.Object
EndFunc

Func MessageQueue_DeQueue(ByRef $this)
	Return $this.Queue.DeQueue()
EndFunc

Func MessageQueue_Peek(ByRef $this)
	Return $this.Queue.Peek()
EndFunc