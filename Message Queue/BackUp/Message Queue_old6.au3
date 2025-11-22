#include-once

#include <Array.au3>

#include "..\AutoItObject\AutoItObject.au3"
#include "Queue.au3"

Func MessageQueue()
	Local Const $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Subscribe", "MessageQueue_Subscribe")
	$this.AddMethod("Push", "MessageQueue_Push")
	$this.AddMethod("DeQueue", "MessageQueue_DeQueue")
	$this.AddMethod("Peek", "MessageQueue_Peek")

	$this.AddMethod("CreateMessage", "MessageQueue_CreateMessage", True)

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

	Local $count = $this.Count + 1

	$this.Count = $count

	$subscriber.SetQueue($this)

	Return True
EndFunc   ;==>MessageQueue_Subscribe

Func MessageQueue_Push(ByRef $this, Const $topic, Const $message, Const $Hwnd = '')
	$this.Queue.EnQueue($this.CreateMessage($topic, $message, $hwnd))

	Local $subscribers = $this.Subscribers

	Local Const $count = $this.Count

	Local $subscriber, $peek

	For $i = 1 To $count
		$peek = $this.Peek()

		If IsMap($peek) Then
			$subscriber = $subscribers[$i]

			$subscriber.Handler()
		EndIf
	Next

	Return True
EndFunc   ;==>MessageQueue_Push

Func MessageQueue_CreateMessage(ByRef $this, Const $topic, Const $message, Const $Hwnd = '')
	Local $messageMap[]

	$messageMap.Topic = $topic

	$messageMap.Message = $message
	
	$messageMap.Hwnd = $Hwnd

	Return $messageMap
EndFunc   ;==>MessageQueue_CreateMessage

Func MessageQueue_DeQueue(ByRef $this)
	Return $this.Queue.DeQueue()
EndFunc   ;==>MessageQueue_DeQueue

Func MessageQueue_Peek(ByRef $this)
	Return $this.Queue.Peek()
EndFunc   ;==>MessageQueue_Peek
