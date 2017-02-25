# MessageDispatcher

[![CI Status](http://img.shields.io/travis/popwarsweet/MessageDispatcher.svg?style=flat)](https://travis-ci.org/popwarsweet/MessageDispatcher)
[![Version](https://img.shields.io/cocoapods/v/MessageDispatcher.svg?style=flat)](http://cocoapods.org/pods/MessageDispatcher)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/MessageDispatcher.svg?style=flat)](http://cocoapods.org/pods/MessageDispatcher)
[![Platform](https://img.shields.io/cocoapods/p/MessageDispatcher.svg?style=flat)](http://cocoapods.org/pods/MessageDispatcher)

MessageDispatcher is a simple utility for sending messages to multiple listeners. All of the listeners are weakly held so you don't have to worry about manually removing a view controller when it's popped off of the stack. Check out the [tests](Example/Tests/Tests.swift) for examples of how to use MessageDispatcher.

## Simple Example

```ruby
let messageDispatcher = MessageDispatcher<String>()
messageDispatcher.addEventListener(someListener, queue: nil) { message in
    print("Received \(message)")
}
```

## Installation

### CocoaPods

MessageDispatcher is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MessageDispatcher"
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate MessageDispatcher into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "popwarsweet/MessageDispatcher" ~> 0.1.0
```

Run `carthage update` to build the framework and drag the built `Alamofire.framework` into your Xcode project.

## Author

popwarsweet, popwarsweet@gmail.com

## License

MessageDispatcher is available under the MIT license. See the LICENSE file for more info.
