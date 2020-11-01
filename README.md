# Queue

A data structure which yelds its stored elements with a predetermined sequential order.

Queues works upon two basilar operations: enqueue and dequeue. 
- Enqueue is the operation for storing elements in the queue. 
- Dequeue is for retrieving elements stored in the queue, sequentially and by the order defined for the queue.

For example a queue using the *FIFO* order (first in, first out), will dequeue  elements starting from the first enqueued element, proceding sequentially to the last enqueued one. On the contrary a queue using the *LIFO* order (last in, first out) —a.k.a stack— will dequeue elements starting from the last enqeueued one, proceding sequentially to the first equeued one.

Conforming to the Queue protocol
========================== 

Despite not being stricktly required, a type conforming to `Queue` protocol might as well benefit from also conforming to `Sequence` or `Collection` protocol in order to retain some common functionalities and properties.
The `count` and the `isEmpty` properties are an example of properties which could be mutated from the `Collection` conformance, or easily implemented from a finite `Sequence`.
To add `Queue` conformance to a type, it must match these requirements:

 - The `count` and `isEmpty` properties
 - The `capacity` and `isFull` properties
 - The `peek()` and `dequeue()` methods
 - The `clear(keepingCapacity:)` method
 - The `enqueue(_:)` and `enqueue(contentsOf:)` methods
 - The `reserveCapacity(_:)` method

Expected Performance
=================

Conforming types are expected to provide the `count`, `isEmpty`, `capacity`, `isFull` and `peek()` properties and method as O(1) operations.
The `dequeue()` and `enqueue(_:)` methods are expected to be at least O(log *n*) operations, where *n* is the count of stored elements, thus `enqueue(contentsOf:)` is expected to be an O(log*n* + *k*) where *k* is the count of elements stored in the sequence specified as `contentsOf` parameter.
Reasonably the `clear(keepingCapacity:)` and `reserveCapacity(_:)` are expected to be at worst O(*n*) operations.
