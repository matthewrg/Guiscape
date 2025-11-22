
#AutoIt3Wrapper_Add_Constants=n

#include-once

#include "..\AutoItObject\AutoItObject.au3"
#include "Queue.au3"

Func MessageQueue()
	Local Const $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("Subscribe", "MessageQueue_Subscribe")
	$this.AddMethod("Push", "MessageQueue_Push")
	$this.AddMethod("DeQueue", "MessageQueue_DeQueue")
	$this.AddMethod("Peek", "MessageQueue_Peek")
	
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
EndFunc

Func MessageQueue_Push(ByRef $this, Const $topic, Const $event)
	Local Const $message = Create_Message($topic, $event)

	$this.Queue.EnQueue($message)
	
	Return True
EndFunc   ;==>MessageQueue_Push

Func Create_Message(Const $topic, Const $event)
	Local $message[]

	$message.Topic = $topic
	
	$message.Event = $event

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
