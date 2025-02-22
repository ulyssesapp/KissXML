# [KissXML](https://github.com/robbiehanson/KissXML)

[![CI Status](http://img.shields.io/travis/robbiehanson/KissXML.svg?style=flat)](https://travis-ci.org/robbiehanson/KissXML)
[![Version](https://img.shields.io/cocoapods/v/KissXML.svg?style=flat)](http://cocoapods.org/pods/KissXML) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Platform](https://img.shields.io/cocoapods/p/KissXML.svg?style=flat)](http://cocoapods.org/pods/KissXML) [![License](https://img.shields.io/cocoapods/l/KissXML.svg?style=flat)](http://cocoapods.org/pods/KissXML)

KissXML provides a drop-in replacement for Apple's NSXML class culster in environments without NSXML (e.g. iOS).

It is implemented atop the defacto libxml2 C library, which comes pre-installed on Mac & iOS.
But it shields you from all the nasty low-level C pointers and malloc's, and provides an easy-to-use Objective-C library.

It is designed for speed and reliability, so it's read-access thread-safe and will "just-work".
That is, KissXML provides an API that follows "what-you-would-expect" rules from an Objective-C library.
So feel free to do things like parallel processing of an xml document using blocks.
It will "just work" so you can get back to designing the rest of your app.

KissXML is a mature library used in thousands of products. It's also used in other libraries, such as [XMPPFramework](https://github.com/robbiehanson/XMPPFramework) (an objective-c library for real-time xml streaming). It's even used in hospital applications.

KissXML was inspired by the TouchXML project, but was created to add full support for generating XML as well as supporting the entire NSXML API.

### Getting Started

The minimum deployment target is iOS 8.0 / macOS 10.9 / tvOS 9.0 / watchOS 2.0.

#### Swift Package Manager
The easiest way to install `KissXML` is using Swift Package Manager, simply add the following to your **`Package.swift`**:

```swift
dependencies: [
    .package(url: "https://github.com/robbiehanson/KissXML.git", .upToNextMajor(from: "x.x.x"))
]
```
> Make sure to replace `x.x.x` with the appropriate version number.

#### CocoaPods

The easiest way to install `KissXML` is using CocoaPods.

```ruby
use_frameworks!
pod 'KissXML'
```

After `pod install` open your `.xcworkspace` and import:

```objc
// Swift
import KissXML     
// Objective-C on iOS 8+ with `use_frameworks!`
@import KissXML;
```

#### Carthage

The `KissXML.xcodeproj` project contains framework targets for iOS, macOS, tvOS, and watchOS.

### Learn More

**[Get started using KissXML](https://github.com/robbiehanson/KissXML/wiki/GettingStarted)**<br/>
**[Learn more about KissXML](https://github.com/robbiehanson/KissXML/wiki)**<br/>

<br/>
Can't find the answer to your question in any of the [wiki](https://github.com/robbiehanson/KissXML/wiki) articles? Try the **[mailing list](http://groups.google.com/group/kissxml)**.
<br/>
<br/>
Love the project? Wanna buy me a ☕️&nbsp;&nbsp;? (or a 🍺&nbsp;&nbsp;😀&nbsp;):

[![donation-bitcoin](https://bitpay.com/img/donate-sm.png)](https://onename.com/robbiehanson)
[![donation-paypal](http://www.paypal.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=69SPF7R4ZF69J)

## Changelog

* 5.2.0 - Feb 2 2017 - Swift 3 and Carthage support. Requires iOS 8 or higher, removes static library support.
* 5.1.2 - Jul 8 2016 - Better Swift generated interface cross-compatibility with NSXML by matching NSXML headers more closely, specifically by changing many set/get methods to properties.
* 5.1.1 - Jul 7 2016 - Fixes issue when integrated as a static library. Min iOS version is back to 6.0. Moved DDXML->NSXML Swift mappings to `SwiftNSXML` subspec. Added test for static library integration.
* 5.1.0 - Jul 6 2016 - Removed need for `libxml_module` subspec by removing references to libxml in public headers. Added Obj-C generics and nullability support to match NSXML API. Added watchOS support. Minimum iOS version is now 8.0.
* 5.0.3 - Feb 1 2016 - Removed `DDXML_NS_DECLARATIONS_ENABLED` to allow for better Swift compatibility. Added `DDXML.swift` with mappings between NSXML classes and constants and DDXML.
* 5.0.2 - Jan 26 2016 - Enable Swift support via `libxml/module.modulemap` and `DDXML_LIBXML_MODULE_ENABLED` macro. You can use the `KissXML/libxml_module` CocoaPods subspec to enable this feature. 
* 5.0.1 - Jan 21 2016 - Run tests on iOS and Mac targets. 
