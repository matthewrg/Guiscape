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

	Return $this.Object
EndFunc   ;==>MessageQueue

Func MessageQueue_Subscribe(ByRef $this, Const ByRef $subscriber)
	Local $subscribers = $this.Subscribers

	_ArrayAdd($subscribers, $subscriber)

	$this.Subscribers = $subscribers

	Return True
EndFunc   ;==>MessageQueue_Subscribe

Func MessageQueue_Push(ByRef $this, Const $topic, Const $message)
	Local Const $message = $this.Create_Message($topic, $message)

	$this.Queue.EnQueue($message)
	
	$this.Subscribers.Handler($message)

	Return True
EndFunc   ;==>MessageQueue_Push

Func MessageQueue_Create_Message(ByRef $this, Const $topic, Const $message)
	Local $message[]

	$message.Topic = $topic

	$message.Message = $message

	Return $message

	Return True
EndFunc   ;==>Create_Message

Func MessageQueue_DeQueue(ByRef $this)
	Return $this.Queue.DeQueue()

	Return True
EndFunc   ;==>MessageQueue_DeQueue

Func MessageQueue_Peek(ByRef $this)
	Return $this.Queue.Peek()

	Return True
EndFunc   ;==>MessageQueue_Peek
