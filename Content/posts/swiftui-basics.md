---
date: 2019-07-02 18:00
title: Learn & Master ⚔️ SwiftUI basic components in 10 minutes
description: How to implement basic UI components in SwiftUI
tags: swiftui, uikit
---
![**SwiftUI** icon](swiftui-basics-header.png) ***SwiftUI** icon (Copyright © 2019 **Apple Inc.**)*

**Updated on 07/06/2019:** *Xcode 11 beta 3*

**Updated on 07/07/2019:** *TextField and SecureField initializer changes*

**Updated on 07/17/2019:** *List, ForEach, ActionSheet, Modal, DatePicker* and *Alert changes (***Xcode 11 beta 4***)*

**Updated on 7/29/2019:** *TabView* (previously named *TabbedView*): *tabItem modifier* supports images, *Alert:* renamed*onTrigger* to *action, Slider:* a range parameter instead of lower and upper bound parameters, *SegmentedControl* is now a picker with a special style (**Xcode 11 beta 5**)

**Updated on 8/31/2019:** No changes required for **Xcode 11 beta 6 + 7**

**Updated on 9/20/2019:** No changes required for **Xcode 11 GM Seed 1 + 2**

**Updated on 9/23/2019:** No changes required for **Xcode 11**

In the following I will take a look at the **SwiftUI** pendants of some *UIKit* components you already know. Many components can be implemented in just **a few lines of code**. The result of each implementation is shown in an (animated) image.

## Navigation

In this section you will meet the basic navigation components of **SwiftUI**.

### UINavigationController pendant

To implement the *UINavigationController* pendant in **SwiftUI** you use the *NavigationView* and add n*avigationBar*modifiers to a subview.

```swift
struct ContentView : View {
    var body: some View {
        NavigationView {
            Text("Hello world!")
                .navigationBarTitle(Text("Navigation bar title"))
        }
    }
}
```

![Screenshot of result on iPhone XR](swiftui-basics-navigationbar.png) *Result on iPhone XR*

### NavigationBarItems

If you want to add navigation bar items use the *navigationBarItems* modifiers on a subview.

```swift
struct ContentView : View {
    private var uuids: [String] = {
        let ids: [String] = Array(0...5).map { _ in
            return UUID().uuidString
        }
        return ids
    }()
    
    var body: some View {
        NavigationView {
            List(uuids, id: \.self) { uuid in
                NavigationLink(destination: Text(uuid).padding(.horizontal)) {
                    Text(uuid)
                }
            }.navigationBarTitle(Text("List of UUIDs"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}
```

![Screenshot of result on iPhone XR](swiftui-basics-navigationbar-items.png) *Result on iPhone XR*

### UITabBarController pendant

To implement a tab bar view use the *TabbedView* with a binding for the tab selection. The type of the binding can be any type conforming to the *Hashable* protocol. That’s amazing because you can use a simple enum (which is *Hashable* by default)!!

**SwiftUI** needs to know which view to load initially. This works via the selection binding. Additionally you have to define the selection value of each subview. Due to the lack of documentation it was hard to find out how to do that ;)

> Thanks to a *StackOverflow post* I found the solution: You need to add a *tag* modifier to each subview and pass the selection value to it.

To define a label or **an image** for each tab use the *tabItem* modifiers on the subviews.

```swift
enum TabIdentifier {
    case list
    case another
}
struct ContentView : View {
    private var uuids: [String] = {
        let ids: [String] = Array(0...5).map { _ in
            return UUID().uuidString
        }
        return ids
    }()
    
    @State private var selectedTab: TabIdentifier = .list
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                List(uuids, id: \.self) { uuid in
                    Text(uuid)
                }.navigationBarTitle(Text("List of UUIDs"))
            }.tabItem {
                Image(systemName: "list.bullet")
                Text("List")
            }
            .tag(TabIdentifier.list)
            
            Text("Hello world!")
                .tabItem {
                    Text("Another view")
                }
                .tag(TabIdentifier.another)
        }
    }
}
```

![Result on iPhone XR](swiftui-basics-tabbar.gif) *Result on iPhone XR*

### Master-Detail

Create a *NavigationView* with a *NavigationLink* as a subview. Finally declare the destination of the *NavigationLink*.

```swift
struct ContentView : View {
    private var uuids: [String] = {
        let ids: [String] = Array(0...5).map { _ in
            return UUID().uuidString
        }
        return ids
    }()
    
    var body: some View {
        NavigationView {
            List(uuids, id: \.self) { uuid in
                NavigationLink(destination: Text(uuid).padding(.horizontal)) {
                    Text(uuid)
                }
            }.navigationBarTitle(Text("List of UUIDs"))
        }
    }
}
```

![Result on iPhone XR](swiftui-basics-master-detail.gif) *Result on iPhone XR*

## Layout

This section will take a look at some of the layout components of **SwiftUI**.

### List of Items

To show a list of items use the *List* view. Pass an array of objects conforming to the I*dentifiable* protocol to the initializer. Finally add a subview in the *content* block.

```swift
struct ContentView : View {
    private var uuids: [String] = {
        let ids: [String] = Array(0...5).map { _ in
            return UUID().uuidString
        }
        return ids
    }()
    
    var body: some View {
        NavigationView {
            List(uuids, id: \.self) { uuid in
                Text(uuid)
            }.navigationBarTitle(Text("List of UUIDs"))
        }
    }
}
```

![Screenshot of result on iPhone XR](swiftui-basics-list-of-items.png) *Result on iPhone XR*

### Form

To render multiple input components as a simple but nice form use the *Form* view. Separate input components with the *Section* view (the form will look like a static table view :-) ).

```swift
struct ContentView : View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var street: String = ""
    @State private var houseNumber: String = ""
    @State private var zip: String = ""
    @State private var city: String = ""
    @State private var termsAccepted: Bool = false
    @State private var privacyAccepted: Bool = false
    
    var body: some View {
        Form {
            Section {
                Text("First name")
                    .font(.headline)
                TextField("First name", text: $firstName)
                Text("Last name")
                    .font(.headline)
                TextField("Last name", text: $lastName)
            }
            
            Section {
                Text("Street")
                    .font(.headline)
                TextField("Street", text: $street)
                Text("House number")
                    .font(.headline)
                TextField("House number", text: $houseNumber)
                Text("Zip")
                    .font(.headline)
                TextField("Zip", text: $zip)
                Text("City")
                    .font(.headline)
                TextField("City", text: $city)
            }
            
            Section {
                Toggle(isOn: $termsAccepted) {
                    Text("Terms")
                        .font(.headline)
                }
                Toggle(isOn: $privacyAccepted) {
                    Text("Privacy")
                        .font(.headline)
                }
            }
        }
    }
}
```

![Screenshot of result on iPhone 8 Plus](swiftui-basics-form.png) *Result on iPhone 8 Plus*

## Presentation

In the following you will learn how to implement UI components which are presented on top of other views.

### Alert

To implement a simple alert you use a *presentation* modifier in combination with the *Alert* container. You need to pass a boolean variable defining the visibility of the alert and a block returning the *Alert* to the *presentation* modifier.

```swift
struct ShowAlertButton : View {
    @State private var isAlertVisible: Bool = false
    
    var body: some View {
        Button(action: {
            self.isAlertVisible.toggle()
        }) {
            Text("Show alert")
        }.alert(isPresented: $isAlertVisible) {
            Alert(title: Text("Hey"),
                  message: Text("I'm a simple alert"),
                  dismissButton: .default(Text("Dismiss"), action: {
                    self.isAlertVisible.toggle()
                  })
            )
        }
    }
}
struct ContentView : View {
    private var uuids: [String] = {
        let ids: [String] = Array(0...5).map { _ in
            return UUID().uuidString
        }
        return ids
    }()
    
    var body: some View {
        NavigationView {
            List(uuids, id: \.self) { uuid in
                NavigationLink(destination: Text(uuid).padding(.horizontal)) {
                    Text(uuid)
                }
            }.navigationBarTitle(Text("List of UUIDs"))
            .navigationBarItems(trailing: ShowAlertButton())
        }
    }
}
```

![Animated image showing SwiftUI alert on iPhone XR](swiftui-basics-alert.gif) *Result on iPhone XR*

### Modal

Implement a modal view using a *PresentationLink*. Dismiss the modal by dragging it down. To manually dismiss the *Modal* in code you can use the *isPresented* environment.

> *Hint:* In my example it’s not possible to open the same modal again after it was dismissed. On Reddit someone wrote: ‘I faced the same issue. Showed it at the labs and the Apple engineers noted that as a bug. So hopefully being fixed soon.’

```swift
struct ExampleModal : View {
    @Binding var isPresented: Bool
    let uuid: String
    
    var body: some View {
        VStack {
            Text(uuid)
            Divider()
            Button(action: {
                self.isPresented = false
            }) {
                Text("Dismiss modal")
            }
        }.padding(.horizontal)
    }
}
struct ListItem : View {
    @State private var isPresented = false
    let uuid: String
    
    var body: some View {
        Button(action: {
            self.isPresented = true
        }) {
            Text(uuid)
        }.sheet(isPresented: $isPresented, onDismiss: {
            self.isPresented = false
        }) {
            ExampleModal(isPresented: self.$isPresented,
                         uuid: self.uuid)
        }
    }
}
struct ContentView : View {
    private var uuids: [String] = {
        let ids: [String] = Array(0...5).map { _ in
            return UUID().uuidString
        }
        return ids
    }()
    
    var body: some View {
        NavigationView {
            List(uuids, id: \.self) { uuid in
                ListItem(uuid: uuid)
            }.navigationBarTitle(Text("List of UUIDs"))
        }
    }
}
```

![Animated image showing SwiftUI modal on iPhone XR](swiftui-basics-modal.gif) *Result on iPhone XR*

### ActionSheet

Implementing an *ActionSheet* is done via a *presentation* modifier added to another view, like a *Button*. Normally you want to hide the *ActionSheet* initially. To achieve this you have to pass *nil* to the *presentation* modifier. A simple solution would be to use a computed property for the *ActionSheet* which returns nil if a related *State variable* is false.

```swift
struct ContentView : View {
    @State private var isActionSheetVisible = false
    private var actionSheet: ActionSheet {
        let button1 = ActionSheet.Button.default(Text("Facebook")) {
            self.isActionSheetVisible = false
        }
        let button2 = ActionSheet.Button.default(Text("Instagram")) {
            self.isActionSheetVisible = false
        }
        let button3 = ActionSheet.Button.default(Text("Twitter")) {
            self.isActionSheetVisible = false
        }
        let dismissButton = ActionSheet.Button.cancel {
            self.isActionSheetVisible = false
        }
        let buttons = [button1, button2, button3, dismissButton]
        return ActionSheet(title: Text("Share"),
                           buttons: buttons)
    }
    
    private var uuids: [String] = {
        let ids: [String] = Array(0...5).map { _ in
            return UUID().uuidString
        }
        return ids
    }()
    
    var body: some View {
        NavigationView {
            List(uuids, id: \.self) { uuid in
                Button(action: {
                    self.isActionSheetVisible = true
                }) {
                    Text(uuid)
                }.actionSheet(isPresented: self.$isActionSheetVisible) {
                    self.actionSheet
                }
            }.navigationBarTitle(Text("List of UUIDs"))
        }
    }
}
```

![Animated image showing SwiftUI action sheet on iPhone XR](swiftui-basics-actionsheet.gif) *Result on iPhone XR*

### Popover

To attach a popover to a view you use the *popover* modifier*.* You have to pass a *boolean* *Binding* to the modifier to control the visibility of the *Popover*. In addition specify a *content* block returning the content view for the *Popover*.

> Keep in mind that a popover will be presented as a modal on smaller screen sizes (like the iPhone). Only on the iPad you get the expected popover style.

```swift
struct PopoverContentView : View {
    let uuid: String
    
    var body: some View {
        Text(uuid)
            .frame(width: 200,
                   height: 50,
                   alignment: .center)
            .padding(.horizontal)
            .background(Color.yellow)
            .cornerRadius(8)
    }
}
struct ListItem : View {
    @State private var isPopoverVisible = false
    
    let uuid: String
    
    var body: some View {
        Button(action: {
            self.isPopoverVisible = true
        }) {
            Text(uuid)
        }.popover(isPresented: $isPopoverVisible) {
            PopoverContentView(uuid: self.uuid)
        }
    }
    
    init(uuid: String) {
        self.uuid = uuid
    }
}
struct ContentView : View {
    private var uuids: [String] = {
        let ids: [String] = Array(0...5).map { _ in
            return UUID().uuidString
        }
        return ids
    }()
    
    var body: some View {
        NavigationView {
            List(uuids, id: \.self) { uuid in
                ListItem(uuid: uuid)
            }.navigationBarTitle(Text("List of UUIDs"))
        }
    }
}
```

![Animated image showing SwiftUI popover on iPhone XR](swiftui-basics-popover-iphone.gif) *Popover on iPhone XR*

On an **iPhone** you can dismiss the modal by dragging down.

![Animated image showing SwiftUI popover on iPad Pro 9.7"](swiftui-basics-popover-ipad.gif) *Popover on iPad Pro 9.7"*

On an **iPad** you tap outside the popover to dismiss it.

> Hint: In my implementation you cannot show the same popover again after dismissing it. It might be the same bug as with the Modal.

## Views

This section covers some basic views you know from **UIKit**.

### Image

To show an image use the *Image* view.

```swift
struct ContentView : View {
    var body: some View {
        Image("swiftui")
    }
}
```

![Screenshot of result on iPhone XR](swiftui-basics-image.png) *Result on iPhone XR*

### ScrollView

Implement it via the *ScrollView* view.

> I did something special here: I made use of the *GeometryReader* to get the size of the root view (in this case the screen size). That way I was able to implement a scroll view containing rectangles having a full screen width.

```swift
struct ContentView : View {
    private var colors: [Color] = {
        let colorArray: [Color] = Array(0...5).map { _ in
            let red = Double.random(in: 0.0 ..< 1.0)
            let green = Double.random(in: 0.0 ..< 1.0)
            let blue = Double.random(in: 0.0 ..< 1.0)
            return Color(red: red,
                         green: green,
                         blue: blue)
        }
        return colorArray
    }()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(self.colors, id: \.self) { color in
                        Rectangle()
                            .frame(width: geometry.size.width,
                                   height: 300)
                            .foregroundColor(color)
                    }
                }.frame(height: geometry.size.height)
            }
        }
    }
}
```

![Animated image showing SwiftUI scroll view on iPhone XR](swiftui-basics-scrollview.gif) *Result on iPhone XR*

## User input controls

This section takes a look at the user input controls of **SwiftUI**.

### Picker

Pickers in **SwiftUI** are really powerful. Besides the data binding feature you can get **a detail view for the selection for free** if you put the picker inside a form which itself lives in a navigation view.

Take a closer look at the *ForEach* in the *content* block:

> To define the selection value of each subview add a tag modifier with the value to it.

```swift
enum Country: String, CaseIterable {
    case albania
    case belgium
    case chile
    case germany
    case hungary
    case iceland
    case mazedonia
    case portugal
    case switzerland
}
struct ContentView : View {
    @State private var selectedCountry: Country = .germany
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $selectedCountry,
                       label: Text("Country"),
                       content: {
                        ForEach(Country.allCases, id: \.self) { country in
                            Text(country.rawValue)
                                .tag(country)
                        }
                }).navigationBarTitle(Text("Where are you from?"))
            }
        }
    }
}
```

![Animated image showing SwiftUI picker on iPhone Xs Max](swiftui-basics-picker.gif) *Result on iPhone Xs Max*

To get the familiar inline picker style add the modifier *.pickerStyle(.wheel)* to the picker.

### DatePicker

With the *DatePicker* its the same. Just put it into a form and **SwiftUI** does the magic.

```swift
struct ContentView : View {
    @State private var date: Date = Date()
    
    var body: some View {
        Form {
            Text("\(date)")
            DatePicker(selection: $date, displayedComponents: [.date]) {
                Text("Birthday")
                    .font(.headline)
            }
        }
    }
}
```

![Animated image showing SwiftUI date picker on iPhone XR](swiftui-basics-datepicker.gif) *Result on iPhone XR*

### Toggle / Switch

To get a simple but beautiful toggle use the *Toggle* view with a data binding.

```swift
struct ContentView : View {
    @State private var toggleValue: Bool = false
    
    var body: some View {
        Form {
            Toggle(isOn: $toggleValue) {
                Text("Terms")
            }
        }
    }
}
```

![Screenshot of result on iPhone XR](swiftui-basics-toggle.png) *Result on iPhone XR*

### Slider

To implement a slider use the *Slider* view and specify a range including a stride (i like that!). **It’s really declarative!!**

```swift
struct ContentView : View {
    private let sliderRange: ClosedRange<Double> = 0...10
    private let distance: Double = 1
    @State private var sliderValue: Double = 5
    
    var body: some View {
        Form {
            HStack {
                Text("\(Int(sliderRange.lowerBound))")
                VStack {
                    Slider(value: $sliderValue,
                           from: sliderRange.lowerBound,
                           through: sliderRange.upperBound,
                           by: distance)
                    Text("\(Int(sliderValue))")
                }
                Text("\(Int(sliderRange.upperBound))")
            }
        }
    }
}
```

![Animated image showing SwiftUI slider on iPhone XR](swiftui-basics-slider.gif) *Result on iPhone XR*

### Stepper

A *Stepper* can be implemented similar to a *Slider.* Instead of specifying *from* and *through* just specify a range. 🚀

```swift
struct ContentView : View {
    private let roomsRange: CountableClosedRange<Int> = 0...10
    @State private var roomsValue: Int = 0
    
    var body: some View {
        Form {
            HStack {
                Stepper(value: $roomsValue, in: roomsRange) {
                    Text("Rooms")
                }
                Text("\(roomsValue)")
            }
        }
    }
}
```

![Animated image showing SwiftUI stepper on iPhone XR](swiftui-basics-stepper.gif) *Result on iPhone XR*

### TextField

To get a simple *TextField* use the *TextField* view. Pass a string specifying the placeholder and a binding for the input to the initializer. You can put the *TextField* into a *HStack* alongside a *Text* and add it to a *Form* to get the following inline style.

```swift
struct ContentView : View {
    @State private var name: String = ""
    
    var body: some View {
        Form {
            HStack {
                Text("Name:")
                TextField("Name", text: $name)
            }
        }
    }
}
```

![Screenshot of result on iPhone 8 Plus](swiftui-basics-textfield.png) *Result on iPhone 8 Plus*

### SecureField

A *SecureField* is a variation of *TextField* which should be used for secure inputs, like passwords or credit card cvc. Pass a *title* and a *binding* to the initializer.

> Hint: I think the SecureField has a bug because the title / placeholder is not visible. I expect the same behaviour as with a TextField view.

```swift
struct ContentView : View {
    @State private var password: String = ""
    
    var body: some View {
        Form {
            HStack {
                Text("Password:")
                    .font(.headline)
                SecureField("Password", text: $password)
            }
        }
    }
}
```

![Animated image showing SwiftUI secure field on iPhone XR](swiftui-basics-securefield.gif) *Result on iPhone XR*

### SegmentedControl

Last but not least implementing a segmented control is easy with the *SegmentedControl* view.

```swift
enum Architecture: String, CaseIterable {
    case mvc
    case mvvm
    case viper
}
struct ContentView : View {
    @State private var selectedArchitecture: Architecture = .viper
    
    var body: some View {
        Form {
            HStack {
                Text("Architecture:")
                    .font(.headline)
                Picker(selection: $selectedArchitecture, label: Text("Architecture")) {
                    ForEach(Architecture.allCases, id: \.self) { architecture in
                        Text(architecture.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}
```

![Animated image showing SwiftUI segmented control on iPhone XR](swiftui-basics-segmentedcontrol.gif) *Result on iPhone XR*

You did it 🏆🎉.

I hope you got an overview of all the basic UI components of **SwiftUI** and learned how to use them. I really enjoyed playing around with all these components and I’m really excited to see what we all do with these in the future.

Stay tuned 📺.
