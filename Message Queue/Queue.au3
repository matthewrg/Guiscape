#include-once

Func Queue()
	Local $queue[]

	Local Const $this = _AutoitObject_Class()

	$this.Create()

	$this.AddMethod("EnQueue", "Queue_EnQueue")
	$this.AddMethod("DeQueue", "Queue_DeQueue")
	$this.AddMethod("Peek"   , "Queue_Peek"   )

	$this.AddProperty("Queue", $ELSCOPE_PRIVATE, $queue)
	$this.AddProperty("Head" , $ELSCOPE_PRIVATE, 1)
	$this.AddProperty("Tail" , $ELSCOPE_PRIVATE, 1)
	$this.AddProperty("Size" , $ELSCOPE_PRIVATE, 0)

	Return $this.Object
EndFunc

Func Queue_EnQueue(ByRef $this, Const ByRef $item)
	Local $queue = $this.Queue

	$queue[$this.Tail] = $item

	$this.Tail = $this.Tail + 1

	$this.Size = $this.Size + 1

	$this.Queue = $queue
EndFunc

Func Queue_DeQueue(ByRef $this)
	If $this.Size > 0 Then
		Local Const $queue = $this.Queue

		Local Const $item = $queue[$this.Head]

		$this.Head = $this.Head + 1

		$this.Size = $this.Size - 1

		Return $item
	EndIf
EndFunc

Func Queue_Peek(Const ByRef $this)
	If $this.Size > 0 Then
		Local Const $queue = $this.Queue

		Return $queue[$this.Head]
	EndIf
EndFunc