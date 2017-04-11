## ParserCombinator

[![Build Status](https://travis-ci.org/tigerpixel/ParserCombinator.svg?branch=master)](https://travis-ci.org/tigerpixel/ParserCombinator)
[![Version](https://img.shields.io/cocoapods/v/ParserCombinator.svg?style=flat)](http://cocoapods.org/pods/ParserCombinator)
[![Platform](https://img.shields.io/cocoapods/p/ParserCombinator.svg?style=flat)](http://cocoapods.org/pods/ParserCombinator)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/ParserCombinator.svg?style=flat)](http://cocoapods.org/pods/ParserCombinator)

A simple parser combinator, created in Swift.

ParserCombinator attempts to create a simple and user friendly way to parse strings into objects and structures. Technical terms are largely avoided and convenience parsers are provided.

The parser can be enacted by calling the 'run' function: 

```swift
myParser.run(on: "String to parse")
```

The unit tests provide examples of using the parser and creating your own parsing rules.

Pull requests for improvements are welcome.

## Requirements

There are no external requirements for this project, just Swift.

- iOS 8.0+ / macOS 10.9+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.2+
- Swift 3.0+

## Installation

### Cocoapods

ParserCombinator is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "ParserCombinator"
```

### Carthage

If you use [Carthage](https://github.com/Carthage/Carthage) to manage your dependencies, simply add the following line to your Cartfile:

```ogdl
github "tigerpixel/ParserCombinator"
```

If you use Carthage to build your dependencies, make sure you have added `ParserCombinator.framework` to the "_Linked Frameworks and Libraries_" section of your target, and have included them in your Carthage framework copying build phase.

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager) is the official tool for managing the distribution of Swift code. It is currently available for macOS. It can also be used with Linux but this project does not fully support Linux at this point in time. 

If you use it to manage your dependencies, simply add ParserCombinator to the dependencies value of your Package.swift file.

```swift
dependencies: [
    .Package(url: "https://github.com/Tigerpixel/ParserCombinator.git", majorVersion: 0)
]
```

### Git Submodule

1. Add the ParserCombinator repository as a [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) of your application’s repository.
1. Run `git submodule update --init --recursive` from within the ParserCombinator folder.
1. Drag and drop `ParserCombinator.xcodeproj` into your application’s Xcode project or workspace.
1. On the “General” tab of your application target’s settings, add `ParserCombinator.framework`. to the “Embedded Binaries” section.
1. If your application target does not contain Swift code at all, you should also
set the `EMBEDDED_CONTENT_CONTAINS_SWIFT` build setting to “Yes”.

## MIT License

ParserCombinator is available under the MIT license. Details can be found within the LICENSE file.
