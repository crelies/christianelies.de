---
date: 2019-07-14 18:00
title: Meet & Greet — Advanced Lists in SwiftUI 
description: Implement a dynamic list with empty, error, and loading state
tags: lists, swiftui
---
![List image (Copyright © 2019 **Christian Elies**)](advanced-lists-header.png) *List image (Copyright © 2019 **Christian Elies**)*

**Update 2019/08/14:** Now available as a [Swift package](https://github.com/crelies/AdvancedList) 🚀

## Motivation

What do I mean by *advanced list*?

The app I’m currently working on has many dynamic lists which can represent different states, such as `empty`, `error`, `items` or `loading`.

I implemented a solution, on top of the data-driven framework [IGListKit](https://github.com/Instagram/IGListKit), to be able to create these type of lists in our [UIKit](https://getuikit.com/) app.

Now, I wanted to implement something similar using [SwiftUI](https://developer.apple.com/xcode/swiftui/). Just a few lines of code, right?

## Implementation

In this section, we will take a look at my implementation and the different components I created.

### ListState

The `AdvancedList` should be able to represent different states. We can easily define the states with an `Enum`.

You will see below why I skipped adding an empty case.

```swift
enum ListState {
    case error(_ error: Error?)
    case items
    case loading
}
extension ListState {
    var error: Error? {
        switch self {
            case .error(let error):
                return error
            default:
                return nil
        }
    }
}
```

### ListService

The `AdvancedList` needs a component which stores and manages the `ListState` and the `items`.

With `Combine` and the data binding feature of SwiftUI, we connect `AdvancedList` and `ListService`.

You can change the list state and modify the items through the `ListService` and the `AdvancedList` gets updated automatically.

```swift
final class ListService: BindableObject {
    private(set) var items: [AnyListItem] = [] {
        didSet {
            didChange.send()
        }
    }
    
    private(set) var didChange = PassthroughSubject<Void, Never>()
    
    var listState: ListState = .items {
        didSet {
            didChange.send()
        }
    }
    
    func appendItems<Item: Identifiable>(_ items: [Item]) where Item: View {
        let anyListItems = items.map { AnyListItem(item: $0) }
        self.items.append(contentsOf: anyListItems)
    }
    
    func updateItems<Item: Identifiable>(_ items: [Item]) where Item: View {
        let anyListItems = items.map { AnyListItem(item: $0) }
        for anyListItem in anyListItems {
            guard let itemIndex = self.items.firstIndex(where: { $0.id == anyListItem.id }) else {
                continue
            }
            
            self.items[itemIndex] = anyListItem
        }
    }
    
    func removeItems<Item: Identifiable>(_ items: [Item]) where Item: View {
        let anyListItemsToRemove = items.map { AnyListItem(item: $0) }
        self.items.removeAll(where: { item in
             return anyListItemsToRemove.contains { item.id == $0.id }
        })
    }
    
    func removeAllItems() {
        items.removeAll()
    }
}
```

There are two special items in the implementation of `ListService`: `Item` and `AnyListItem`.

### Item

We want to be able to show different items in the same list. Each item should be identifiable and should be representable as a SwiftUI view.

To achieve that, I constrained the `Item` to the `Identifiable` and the `View` protocol.

```swift
func appendItems<Item: Identifiable>(_ items: [Item]) where Item: View {}
```

But there is one problem.

We can’t store objects conforming to the `Identifiable` and to the `View` protocol in an array inside of the `ListService`, because the protocols have associated types and generic constraints. That’s why I have to use ‘type erasure’.

I implemented a box type called `AnyListItem` which erases the type information of the `body` property (required by `View`) using `AnyView` and of the `id` property (required by `Identifiable`) using `AnyHashable`.

```swift
struct AnyListItem: Identifiable, View {
    let id: AnyHashable
    let body: AnyView
    
    init<Item: Identifiable>(item: Item) where Item: View {
        id = item.id
        body = AnyView(item)
    }
}
```

`ListService` uses `AnyListItem` internally to erase the type information of each `item` added to the list.

### AdvancedList

Finally, let’s take a look at the implementation of the SwiftUI view `AdvancedList`.

The view renders itself dependent on the current list state and the current items. To do so, the `AdvancedList` view needs an instance of `ListService` which manages the list state and the items.

With the use of the `ObjectBinding` property wrapper on the `listService` variable, we tell the `AdvancedList` view to bind to the changes.

Additionally, a user of the `AdvancedList` view should be able to specify a view for the `empty`, `loading` and `error` state of the list.

I used the `ViewBuilder` property wrapper on the parameters in the initializer to achieve that.

```swift
struct AdvancedList<EmptyStateView: View, ErrorStateView: View, LoadingStateView: View> : View {
    @ObjectBinding private var listService: ListService
    private let emptyStateView: () -> EmptyStateView
    private let errorStateView: (Error?) -> ErrorStateView
    private let loadingStateView: () -> LoadingStateView
    
    var body: some View {
        return Group {
            if listService.listState.error != nil {
                errorStateView(listService.listState.error)
            } else if listService.listState == .items {
                if !listService.items.isEmpty {
                    List(listService.items.identified(by: \.id)) { item in
                        item
                    }
                } else {
                    emptyStateView()
                }
            } else if listService.listState == .loading {
                loadingStateView()
            } else {
                EmptyView()
            }
        }
    }
    
    init(listService: ListService, @ViewBuilder emptyStateView: @escaping () -> EmptyStateView, @ViewBuilder errorStateView: @escaping (Error?) -> ErrorStateView, @ViewBuilder loadingStateView: @escaping () -> LoadingStateView) {
        self.listService = listService
        self.emptyStateView = emptyStateView
        self.errorStateView = errorStateView
        self.loadingStateView = loadingStateView
    }
}
```

As I mentioned above, we don’t need an empty case on the `ListState` enum because we can use `isEmpty` on the `items`instead.

There is one more special thing in my implementation:

The `error` case of the `ListState` has an associated value of type `Error`*.* That way I can pass the error to the error view which can display it if needed.

That’s it! Let’s see how we can use `AdvancedList` in the field.

## Example Usage

In this section, you will see a simple usage example of the `AdvancedList` SwiftUI view.

Hint**:** You will find the complete implementation in the GitHub repository linked below.

First, we have to create the items we want to show on the list.

### Example items

I created a `ContactListItem` representing a contact (name, address, etc.).

To add instances of this item to the list, it has to conform to the protocols `Identifiable` and `View`.

I did something special here; I want to be able to render this item differently, dependent on its type property.

Take a look at the usage of `viewRepresentationType` in the `body` property.

```swift
struct ContactListItem: Identifiable {
    @State private var collapsed: Bool = true
    
    let id: String
    let firstName: String
    let lastName: String
    let streetAddress: String
    let zip: String
    let city: String
    
    var viewRepresentationType: ContactListItemViewRepresentationType = .short
}
extension ContactListItem: View {
    var body: some View {
        Group {
            if viewRepresentationType == .short {
                ContactListItemView(firstName: firstName,
                                    lastName: lastName,
                                    hasMoreInformation: false)
            } else if viewRepresentationType == .detail {
                NavigationLink(destination: ContactDetailView(listItem: self), label: {
                    ContactListItemView(firstName: firstName,
                                        lastName: lastName,
                                        hasMoreInformation: true)
                })
            } else if viewRepresentationType == .collapsable {
                VStack {
                    if collapsed {
                        ContactListItemView(firstName: firstName,
                                            lastName: lastName,
                                            hasMoreInformation: false)
                    } else {
                        ContactDetailView(listItem: self)
                    }
                    
                    Button(action: {
                        self.collapsed.toggle()
                    }) {
                        Text("\(collapsed ? "show" : "hide") details")
                    }.foregroundColor(.blue)
                }
            }
        }
    }
}
```

![Animated image showing an AdvancedList with ContactItems on iPhone XR](advanced-lists-example.gif) *Animated image showing an AdvancedList with ContactItems on iPhone XR*

Additionally, I implemented a second item which represents a simple ad.

I did the same as with `ContactListItem`. The `AdListItem` has a type which controls the view definition.

```swift
struct AdListItem: Identifiable {
    @State private var isImageCollapsed: Bool = true
    
    let id: String
    let text: String
    var viewRepresentationType: AdListItemViewRepresentationType = .short
}
extension AdListItem: View {
    var body: some View {
        Group {
            if viewRepresentationType == .short {
                NavigationLink(destination: AdDetailView(text: text), label: {
                    Text(text)
                        .lineLimit(1)
                    Text("ℹ️")
                })
            } else if viewRepresentationType == .long {
                Text(text)
                    .lineLimit(nil)
            } else if viewRepresentationType == .image {
                VStack {
                    if !isImageCollapsed {
                        Image("restaurant")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    }
                    
                    Button(action: {
                        self.isImageCollapsed.toggle()
                    }) {
                        Text("\(isImageCollapsed ? "show" : "hide") image")
                    }.foregroundColor(.blue)
                }
            }
        }
    }
}
```

![Animated image showing an AdvancedList with AdItems on iPhone XR](advanced-lists-second-example.gif) *Animated image showing an AdvancedList with AdItems on iPhone XR*

### Example content view

Finally, we take a look at how to use the `AdvancedList` inside a simple content view.

You might be wondering what the `CustomListStateSegmentedControlView` is**.** It’s a helper view to easily change the list state and add random items to the list.

```swift
struct ContentView : View {
    @ObjectBinding private var listService: ListService = ListService()
    
    var body: some View {
        NavigationView {
            return GeometryReader { geometry in
                VStack {
                    CustomListStateSegmentedControlView(listService: self.listService)
                    
                    AdvancedList(listService: self.listService, emptyStateView: {
                        Text("No data")
                    }, errorStateView: { error in
                        Text("\(error?.localizedDescription ?? "Error")").lineLimit(nil)
                    }, loadingStateView: {
                        Text("Loading ...")
                    })
                    .frame(width: geometry.size.width)
                }
                .navigationBarTitle(Text("List of Items"))
            }
        }
    }
}
```

![Animated image showing an AdvancedList with different items on iPhone XR](advanced-lists-final.gif) *Animated image showing an AdvancedList with different items on iPhone XR*

You’ve reached the end! Thank you very much for reading this article. I hope you liked my `AdvancedList` `view` and, of course, SwiftUI, as much as I do.

## Resources

Here’s the code for this article:

[**crelies/AdvancedList-SwiftUI**](https://github.com/crelies/AdvancedList-SwiftUI)
