//
//  Queue.swift
//  Queue
//
//  Created by Valeriano Della Longa on 28/10/2020.
//  Copyright © 2020 Valeriano Della Longa
//
//  Permission to use, copy, modify, and/or distribute this software for any
//  purpose with or without fee is hereby granted, provided that the above
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
//  SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
//  IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
//

/// A data structure which yelds its stored elements with a predetermined sequential order.
///
/// Queues works upon two basilar operations: enqueue and dequeue.
/// - Enqueue is the operation for storing elements in the queue.
/// - Dequeue is for retrieving elements stored in the queue, sequentially and by the order defined for the queue.
///
/// For example a queue using the *FIFO* order (first in, first out), will dequeue  elements starting from the first enqueued
/// element, proceding sequentially to the last enqueued one. On the contrary a queue using the *LIFO* order
/// (last in, first out) —a.k.a stack— will dequeue elements starting from the last enqeueued one, proceding sequentially to
/// the first equeued one.
///
/// Conforming to the Queue protocol
/// ================================
///
/// Despite not being stricktly required, a type conforming to `Queue` protocol might as well benefit from also
/// conforming to `Sequence` or `Collection` protocol in order to retain some common functionalities and properties.
/// The `count` and the `isEmpty` properties are an example of properties which could be mutated from the
/// `Collection` conformance, or easily implemented from a finite `Sequence`.
/// To add `Queue` conformance to a type, it must match these requirements:
/// 
/// - The `count` and `isEmpty` properties
/// - The `capacity` and `isFull` properties
/// - The `peek()` and `dequeue()` methods
/// - The `clear(keepingCapacity:)` method
/// - The `enqueue(_:)` and `enqueue(contentsOf:)` methods
/// - The `reserveCapacity(_:)` method
///
/// Expected Performance
/// ====================
/// 
/// Conforming types are expected to provide the `count`, `isEmpty`, `capacity`, `isFull` and `peek()`
/// properties and method as O(1) operations.
/// `dequeue()`, `enqueue(_:)` methods are expected to be at least O(log *n*) operations, where *n* is the count
/// of stored elements, thus `enqueue(contentsOf:)` is expected to be an O(log*n* + *k*) where *k* is the count of
/// elements stored in the sequence specified as `contentsOf` parameter.
/// Reasonably the `clear(keepingCapacity:)` and `reserveCapacity(_:)` are expected to be at worst O(*n*)
/// operations.
public protocol Queue {
    associatedtype Element
    
    /// The number of stored elements.
    var count: Int { get }
    
    /// A Boolean value indicating whether the heap buffer is empty.
    var isEmpty: Bool { get }
    
    /// The total number of elements that the instance can contain without
    /// allocating new storage.
    var capacity: Int { get }
    
    /// A Boolean value indicating whether the heap buffer storage is full.
    var isFull: Bool { get }
    
    /// Returns the first element of the queue, or`nil` when the queue is empty.
    ///
    /// - Returns: the first element of the queue, or `nil` when the queue is empty.
    @discardableResult
    func peek() -> Element?
    
    /// Removes and returns the first element of the queue, or `nil` when the queue is empty.
    ///
    /// - Returns: the first element of the queue, or `nil` when the queue is empty.
    @discardableResult
    mutating func dequeue() -> Element?
    
    /// Removes all stored elements, eventually keeping the storage capacity if so specified.
    ///
    /// - Parameter keepingCapacity:    when set to `true`, the storage doesn't reduce its capacity.
    ///                                 Deafults to `false`.
    mutating func clear(keepingCapacity keepCapacity: Bool)
    
    /// Stores specified element in this queue.
    ///
    /// - Parameter _: the element to store.
    mutating func enqueue(_ newElement: Element)
    
    /// Stores in this queue all elements contained in the given sequence.
    ///
    /// - Parameter contentsOf: the sequence of elements to store.
    mutating func enqueue<S: Sequence>(contentsOf newElements: S) where S.Iterator.Element == Element
    
    /// Reserves enough space to store the specified number of elements.
    ///
    /// If you are adding a known number of elements to a queue, use this method
    /// to avoid multiple reallocations. This method ensures that the queue has
    /// unique, mutable, contiguous storage, with space allocated for at least
    /// the requested number of elements.
    ///
    /// For performance reasons, the size of the newly allocated storage might be
    /// greater than the requested capacity. Use the queue's `capacity` property
    /// to determine the size of the new storage.
    ///
    /// - Parameter _: The requested number of elements to store. **Must not be negative.**
    mutating func reserveCapacity(_ minimumCapacity: Int)
    
}

extension Queue where Self: IteratorProtocol {
    @discardableResult
    public mutating func dequeue() -> Element? { next() }
    
}

extension Queue where Self: RangeReplaceableCollection {
    public mutating func clear(keepingCapacity keepCapacity: Bool = false) {
        self.removeAll(keepingCapacity: keepCapacity)
    }
    
}

extension Queue where Self: RandomAccessCollection {
    public var isFull: Bool { capacity == count }
    
}
