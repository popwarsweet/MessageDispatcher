import UIKit
import XCTest
@testable import MessageDispatcher

class Tests: XCTestCase {
    
    var messageDispatcher: MessageDispatcher<String>!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        messageDispatcher = MessageDispatcher<String>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMessageIsReceived() {
        let expection = self.expectation(description: "Message is received by listener.")
        let messageString = "Test message"
        messageDispatcher.addEventListener(self, queue: nil) { message in
            XCTAssertEqual(message, messageString)
            expection.fulfill()
        }
        messageDispatcher.alertListeners(messageString)
        self.waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testReleasedListenerIsRemovedAfterMessageDispatch() {
        var listener: NSObject? = NSObject()
        messageDispatcher.addEventListener(listener!, queue: nil) { _ in }
        listener = nil
        messageDispatcher.alertListeners("Message")
        XCTAssertEqual(messageDispatcher.listeners.count, 0)
    }
    
    func testListenerIsWeaklyHeld() {
        var listener: NSObject? = NSObject()
        messageDispatcher.addEventListener(listener!, queue: nil) { _ in }
        listener = nil
        messageDispatcher.resize()
        XCTAssertEqual(messageDispatcher.listeners.count, 0)
    }
    
    func testMessageIsReceivedByMultipleListeners() {
        let expectation = self.expectation(description: "Message is received by multiple listeners.")
        let listenerOne = NSObject()
        let listenerTwo = NSObject()
        var numberOfMessagesReceived = 0
        messageDispatcher.addEventListener(listenerOne, queue: nil) { message in
            numberOfMessagesReceived += 1
            if numberOfMessagesReceived == 2 {
                expectation.fulfill()
            }
        }
        messageDispatcher.addEventListener(listenerTwo, queue: nil) { message in
            numberOfMessagesReceived += 1
            if numberOfMessagesReceived == 2 {
                expectation.fulfill()
            }
        }
        messageDispatcher.alertListeners("Test message")
        self.waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testListenerIsManuallyRemoved() {
        let listener = NSObject()
        messageDispatcher.addEventListener(listener, queue: nil) { message in }
        messageDispatcher.removeEventListener(listener)
        XCTAssertEqual(messageDispatcher.listeners.count, 0)
    }
    
    func testListenerIsCalledOnCorrectQueue() {
        let expectation = self.expectation(description: "Message is received on correct queue.")
        let listener = NSObject()
        let queue = DispatchQueue(label: "TestQueue")
        let key = DispatchSpecificKey<Void>()
        queue.setSpecific(key:key, value: ())
        messageDispatcher.addEventListener(listener, queue: queue) { message in
            guard DispatchQueue.getSpecific(key: key) != nil else { return }
            expectation.fulfill()
        }
        messageDispatcher.alertListeners("Test message")
        self.waitForExpectations(timeout: 0.1, handler: nil)
    }
}
