//
//  MessageDispatcher.swift
//
//
//  Created by Kyle Zaragoza on 2/17/17.
//  Copyright © 2017 Kyle Zaragoza. All rights reserved.
//

import Foundation

/// Contains the closure and queue that the message should be dispatched on.
final public class HandlerWrapper<T> {
    let handler: ((_ object: T) -> Void)
    var queue: DispatchQueue?
    init(handler: @escaping ((_ object: T) -> Void), queue: DispatchQueue? = nil) {
        self.handler = handler
        self.queue = queue
    }
}

/// Used for weakly wrapping listeners.
final public class WeakWrapper<T: AnyObject>: Hashable {
    weak var value: T?
    init (value: T) {
        self.value = value
    }
    
    public var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
  
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    public static func ==(lhs: WeakWrapper<T>, rhs: WeakWrapper<T>) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

/// The class for managing event listeners as well as dispatching messages.
final class MessageDispatcher<MessageType> {
    typealias ListenerType = WeakWrapper<AnyObject>
    typealias MessageHandler<T> = ((_ object: T) -> Void)
    
    /// Dictionary of listeners as keys, and wrapped handlers as their values.
    /// - NOTE: Once a listener (key) is released, the table will not immediately be resized. Do not rely on the count of `listeners` to accurately reflect the number of listeners.
    private(set) var listeners = [ListenerType: HandlerWrapper<MessageType>]()
    
    
    /// Removes all keys that have nil values.
    func resize() {
        let nilListeners = Array(listeners.keys.filter { $0.value == nil })
        nilListeners.forEach { self.listeners.removeValue(forKey: $0) }
    }
    
    /// Alerts all listeners of the given message.
    ///
    /// - Parameter message: The message to send to the listeners.
    func alertListeners(_ message: MessageType) {
        var needsResizing = false
        // Alert all non-nil listeners.
        for (k, v) in listeners {
            guard k.value != nil else {
                // Flag that listeners needs resizing.
                needsResizing = true
                continue
            }
            if let queue = v.queue {
                queue.async { v.handler(message) }
            } else {
                v.handler(message)
            }
        }
        // Resize if need be.
        if needsResizing { resize() }
    }
    
    /// Adds a closure to be called when messages are dispatched.
    ///
    /// - Parameters:
    ///   - listener: The object which is listening to messagse, this object is weakly held.
    ///   - queue: The queue to have the handler called on, specify nil to be called on the calling queue.
    ///   - handler: The closure to be called when the dispatcher alerts all listeners.
    func addEventListener(_ listener: AnyObject, queue: DispatchQueue?, handler: @escaping MessageHandler<MessageType>) {
        // wrap in a class so we can store it in a MapTable
        let handlerWrapper = HandlerWrapper<MessageType>(handler: handler, queue: queue)
        let weakListener = WeakWrapper(value: listener)
        listeners[weakListener] = handlerWrapper
    }
    
    /// Removes a listener from the dispatcher
    ///
    /// - Parameter listener: This object to be removed.
    func removeEventListener(_ listener: AnyObject) {
        listeners.keys.filter {
            $0.value === listener
        }.forEach {
            listeners[$0] = nil
        }
    }
}
