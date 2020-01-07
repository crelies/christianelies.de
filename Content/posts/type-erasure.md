---
date: 2019-07-22 18:00
title: Learn & Master ⚔️ Type Erasure in 6 Minutes
description: Type Erasure explained through common use cases
tags: type-erasure, swift
---
![Example constant of type Any](type-erasure-header.png) *Example constant of type Any*

Some of you may already be familiar with **Type Erasure** and know how to use it. But I’m certain there are still people out there which don’t know about it or don’t know how to use it.

**Honestly**, I didn’t take a look at it before writing my article about [*Advanced Lists* in **SwiftUI**](https://medium.com/better-programming/meet-greet-advanced-lists-in-swiftui-80ab6f08ca03). It was a little mystery for me since I listened to a *not so good* talk at a developer conference a while ago.

Before lifting the secret *Type Erasure* let’s take a look at the problem it solved for me.

## The Problem 💣

I wanted to store objects conforming to two different protocols in an array. When dealing with simple protocols the implementation is simple as well.

```swift
protocol ProtocolA {}
protocol ProtocolB {}
let objects: [ProtocolA & ProtocolB] = []
```

In the real world protocols are often more complex (*like in my case*) and have ***associated type\*** *and/or* ***Self requirements\***. Let’s take the **Equatable** protocol for example.

```swift
let objects: [Equatable] = []
```

This code **will not compile** because the *Equatable* protocol has *Self requirements*. Therefore the protocol **can only be used as a** **generic constraint**.

![Compiler error](type-erasure-compiler-error.png)

*One more thing* left before the solution: a **definition** of *Type Erasure*.

## Type Erasure

Here is my definition of *Type Erasure*:

> It’s a technique used to solve the problems which occur when dealing with protocols having associated type and/or Self requirements.

> Type Erasure erases the type information in the first place while still constraining to the specific type. Its achieved with the implementation of a box/wrapper type.

I know it’s weird to erase the type information because we all love the statically typed language **Swift**, right? 🙃

Nevertheless let’s implement a solution to the aforementioned problem.

## The Solution 💡

I implemented a type erased wrapper called **AnyEquatable**. It has a generic initializer which expects an object conforming to the E*quatable* protocol. The object is stored internally in an *Any* property, so the type information is lost.

> The **key thing** here is the ***isEqualTo\* block**. This block gets another *AnyEquatable* object and tries to cast the *equatable* property of it to the type of the *Equatable* object passed to the initializer.

*AnyEquatable* itself conforms to the *Equatable* protocol and uses its *isEqualTo* block to do the equation. That way the conformance to the *Equatable* protocol is preserved regardless of the type erasure.

```swift
struct AnyEquatable {
    private let isEqualTo: (AnyEquatable) -> Bool
    let equatable: Any
    
    init<T: Equatable>(_ equatable: T) {
        self.equatable = equatable
        self.isEqualTo = { anotherEquatable in
            guard let anotherEquatable = anotherEquatable.equatable as? T else {
                return false
            }
            
            return anotherEquatable == equatable
        }
    }
}
extension AnyEquatable: Equatable {
    static func == (lhs: AnyEquatable, rhs: AnyEquatable) -> Bool {
        return lhs.isEqualTo(rhs)
    }
}
```

Now, we are able to store different *Equatable* objects in the same array:

```swift
struct Foo {
    let propertyA: String
}
extension Foo: Equatable {
    static func == (lhs: Foo, rhs: Foo) -> Bool {
        return lhs.propertyA == rhs.propertyA
    }
}
struct Bar {
    let propertyB: String
}
extension Bar: Equatable {
    static func == (lhs: Bar, rhs: Bar) -> Bool {
        return lhs.propertyB == rhs.propertyB
    }
}
var equatableArray: [AnyEquatable] = []
let equatable1 = AnyEquatable(Foo(propertyA: "foo"))
equatableArray.append(equatable1)
let equatable2 = AnyEquatable(Foo(propertyA: "foo"))
equatableArray.append(equatable2)
let equatable3 = AnyEquatable(Bar(propertyB: "bar"))
equatableArray.append(equatable3)
print(equatableArray[0] == equatableArray[1]) // true
print(equatableArray[1] == equatableArray[2]) // false
```

There is another common problem where *Type Erasure* comes to the rescue:

> Think about a delegate protocol where you want to use a type which has *associated type and/or Self requirements*. Again the solution is a type erased wrapper. The only downside is that the delegate has to cast the **Any** value inside the type erased wrapper back to its original type.

Okay, let’s head over to other type erased wrappers.

## More Type erased wrappers 🌟

In this section I’ll give you a short overview of some other type erased wrappers you can use to solve the aforementioned problems.

### AnyHashable

It’s part of the **Swift Standard Library**.

**Usage examples:** Store **Hashable** objects in an array, require *Hashable* conformance in another protocol

### AnyView

The **SwiftUI** framework provides *AnyView* which erases the type information of views.

**Usage examples:** Store objects conforming to the ***View\*** protocol in an array, require conformance to the *View* protocol in another protocol

### AnyIdentifiable

The **Identifiable** protocol is part of **SwiftUI** as well and needs to be implemented by the items used in a *List* view or in a *ForEach*, so they can be uniquely identified by the framework.

A type erased wrapper *AnyIdentifiable* is easily implemented with the use of the existing type erased wrapper *AnyHashable*.

```swift
struct AnyIdentifiable: Identifiable {
    let id: AnyHashable
    
    init<T: Identifiable>(_ identifiable: T) {
        self.id = identifiable.id
    }
}
```

### AnyComparable

Similar to the *AnyEquatable* wrapper is the implementation of the following type erased wrapper for *Comparable* objects.

```swift
struct AnyComparable {
    private let isEqualTo: (AnyComparable) -> Bool
    private let compareTo: (AnyComparable) -> Bool
    let comparable: Any
    
    init<T: Comparable>(_ comparable: T) {
        self.comparable = comparable
        self.isEqualTo = { anotherEquatable in
            guard let anotherEquatable = anotherEquatable.comparable as? T else {
                return false
            }
            
            return anotherEquatable == comparable
        }
        self.compareTo = { anotherComparable in
            guard let anotherComparable = anotherComparable.comparable as? T else {
                return false
            }
            
            return comparable < anotherComparable
        }
    }
}
extension AnyComparable: Comparable {
    static func < (lhs: AnyComparable, rhs: AnyComparable) -> Bool {
        return lhs.compareTo(rhs)
    }
}
extension AnyComparable: Equatable {
    static func == (lhs: AnyComparable, rhs: AnyComparable) -> Bool {
        return lhs.isEqualTo(rhs)
    }
}
```

The following code shows a basic usage example of the type erased wrapper:

```swift
let comparables = [AnyComparable(5), AnyComparable(10)]
print(comparables[0] < comparables[1]) // true
print(comparables[0] > comparables[0]) // false
print(comparables[0] == comparables[0]) // true
```

### AnyNumber

Last but not least I proudly present a type erased wrapper for storing objects conforming to the *Numeric* protocol in the same array (*Int*, *Float* and *Double* numbers).

> Keep in mind that you can only use **add**, **substract** or **multiply on AnyNumber**s with the **same underlying type** (Int, Float or Double).

```swift
struct AnyNumber: Numeric {
    private let add: (AnyNumber) -> AnyNumber
    private let substract: (AnyNumber) -> AnyNumber
    private let multiply: (AnyNumber) -> AnyNumber
    private let isEqualTo: (AnyNumber) -> Bool
    
    var magnitude: Double {
        let stringValue = String(describing: value)
        return Double(stringValue)?.magnitude ?? -1
    }
    
    let value: Any
    
    init?<T>(exactly source: T) where T : BinaryInteger {
        self.init(source)
    }
    
    init<T: Numeric>(_ number: T) {
        self.value = number
        self.add = { anotherNumber in
            guard let anotherNumber = anotherNumber.value as? T else {
                return AnyNumber(number)
            }
            
            let numbers = number + anotherNumber
            return AnyNumber(numbers)
        }
        self.substract = { anotherNumber in
            guard let anotherNumber = anotherNumber.value as? T else {
                return AnyNumber(number)
            }
            
            let numbers = number - anotherNumber
            return AnyNumber(numbers)
        }
        self.multiply = { anotherNumber in
            guard let anotherNumber = anotherNumber.value as? T else {
                return AnyNumber(number)
            }
            
            let numbers = number * anotherNumber
            return AnyNumber(numbers)
        }
        self.isEqualTo = { anotherNumber in
            guard let anotherNumber = anotherNumber.value as? T else {
                return false
            }
            
            return anotherNumber == number
        }
    }
}
extension AnyNumber: Equatable {
    static func == (lhs: AnyNumber, rhs: AnyNumber) -> Bool {
        return lhs.isEqualTo(rhs)
    }
}
extension AnyNumber: AdditiveArithmetic {
    static func -= (lhs: inout AnyNumber, rhs: AnyNumber) {
        lhs = lhs - rhs
    }
    
    static func - (lhs: AnyNumber, rhs: AnyNumber) -> AnyNumber {
        return lhs.substract(rhs)
    }
    
    static func += (lhs: inout AnyNumber, rhs: AnyNumber) {
        lhs = lhs + rhs
    }
    
    static func + (lhs: AnyNumber, rhs: AnyNumber) -> AnyNumber {
        return lhs.add(rhs)
    }
    
    static func * (lhs: AnyNumber, rhs: AnyNumber) -> AnyNumber {
        lhs.multiply(rhs)
    }
    
    static func *= (lhs: inout AnyNumber, rhs: AnyNumber) {
        lhs = lhs * rhs
    }
}
extension AnyNumber: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.init(value)
    }
}
```

The following code shows a simple usage example:

```swift
let floatNumber: Float = 5.5323498539485
let doubleNumber = 6.549123234234234
let intNumber = 3
let numbers = [AnyNumber(floatNumber),
               AnyNumber(doubleNumber),
               AnyNumber(intNumber)]
print(type(of: numbers[0].value)) // Float
print(type(of: numbers[1].value)) // Double
print(type(of: numbers[2].value)) // Int
```

You did it 🎉. Head over to your todo list:

> ✅ Understand and use *Type Erasure*

I hope that I could unlock the secret **Type Erasure** for you. If **yes** then you are ready to use it in the near future 🚀🚀🚀. Otherwise don’t hesitate to **ask questions** ✌️.

**Thanks again for reading** one of my articles. **Check out my other articles** if you like.

Stay tuned 📺.

[**crelies - Overview**](https://github.com/crelies)
