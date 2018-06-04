/*:
 ## Learn Swift with Bob
 ### Chapter 1: The Swift Fundamentals
 ### 1002_Optional Chainings
 
 
 **Problem:** Why do I see "?" and "!" when accessing methods and properties?
 
 ---
 */

//: > Example from UIKit
import UIKit
let labelColor = UILabel().highlightedTextColor?.cgColor


//: Design Class
class Human {
  var name: String
  
  init(name: String) {
    self.name = name
  }
  
  func sayHello() {
    print("Hello, I'm \(name)")
  }
  
}

//: Design Another Class
class Apartment {
  var human: Human? = nil
}


//: Initialize

var seoulApartment = Apartment()
seoulApartment.human = Human(name: "Bobby Lee")

seoulApartment.human?.sayHello()


// Force Unwrapping
let name = seoulApartment.human!.name
print(name)


// Implicit/Safe Unwrapping
let NYCAparment = Apartment()
NYCAparment.human = Human(name: "Bob Lee")
NYCAparment.human?.name

if let residentName = NYCAparment.human?.name {
  print(residentName)
} else {
  print("No name available")
}




















