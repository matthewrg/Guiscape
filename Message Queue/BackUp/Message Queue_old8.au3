#include-once

#include <Array.au3>

#include "Queue.au3"

Global $messageQueue = MessageQueue()

Func MessageQueue()
	Local Const $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Subscribe", "MessageQueue_Subscribe")
	$this.AddMethod("Push", "MessageQueue_Push")
	$this.AddMethod("DeQueue", "MessageQueue_DeQueue")
	$this.AddMethod("Peek", "MessageQueue_Peek")
	$this.AddMethod("Print", "MessageQueue_Print")

	$this.AddMethod("CreateEvent", "MessageQueue_CreateEvent", True)

	Local $subscribers[] = []

	$this.AddProperty("Queue", $ELSCOPE_PRIVATE, Queue())
	$this.AddProperty("Subscribers", $ELSCOPE_PRIVATE, $subscribers)
	$this.AddProperty("Count", $ELSCOPE_PRIVATE, 0)

	Return $this.Object
EndFunc   ;==>MessageQueue

Func MessageQueue_Subscribe(ByRef $this, Const ByRef $subscriber)
	Local $subscribers = $this.Subscribers

	_ArrayAdd($subscribers, $subscriber)

	$this.Subscribers = $subscribers

	$this.Count = $this.Count + 1

	Return True
EndFunc   ;==>MessageQueue_Subscribe

Func MessageQueue_Push(ByRef $this, Const ByRef $event)
	If $event.Message = 0 Then Return True

	$this.Queue.EnQueue($event)

	Local Const $subscribers = $this.Subscribers

	Local Const $count = $this.Count

	Local $subscriber, $peek

	For $i = 1 To $count
		$peek = $this.Peek()

		If IsMap($peek) Then
			$subscriber = $subscribers[$i]

			$subscriber.Handler($event)
		EndIf
	Next

	Return True
EndFunc   ;==>MessageQueue_Push

Func MessageQueue_EnQueue(ByRef $this, Const ByRef $item)
	Local $queue = $this.Queue

	$queue[$this.Tail] = $item

	$this.Tail = $this.Tail + 1

	$this.Size = $this.Size + 1

	;ConsoleWrite("EnQueue" & @CRLF)

	$this.Queue = $queue
EndFunc

Func MessageQueue_CreateEvent(Const ByRef $this, Const ByRef $sender, Const ByRef $message, Const $key1 = Null, Const $data1 = Null, Const $key2 = Null, Const $data2 = Null, Const $key3 = Null, Const $data3 = Null, Const $key4 = Null, Const $data4 = Null, Const $key5 = Null, Const $data5 = Null)
	#forceref $this

	Local $messageMap[]

	$messageMap.Sender = $sender

	$messageMap.Message = $message

	Select
		Case $key1
			$messageMap[$key1] = $data1

		Case $key2
			$messageMap[$key2] = $data2

		Case $key3
			$messageMap[$key3] = $data3

		Case $key4
			$messageMap[$key4] = $data4

		Case $key5
			$messageMap[$key5] = $data5
	EndSelect

	Return $messageMap
EndFunc   ;==>MessageQueue_CreateEvent

Func MessageQueue_Print(ByRef $this)
	Local Const $event = $this.Peek()

	ConsoleWrite($event.Sender & @TAB & $event.Message & @CRLF)
EndFunc   ;==>MessageQueue_Print

Func MessageQueue_DeQueue(ByRef $this)
	Return $this.Queue.DeQueue()
EndFunc   ;==>MessageQueue_DeQueue

Func MessageQueue_Peek(ByRef $this)
	Return $this.Queue.Peek()
EndFunc   ;==>MessageQueue_Peek
