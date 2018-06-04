/*:
 ## Learn Swift with Bob
 ### Chapter 1: The Swift Fundamentals
 ### Extension
 
 **Problem:**
 1. I like to keep it short and modularlized.
 2. Prevent anything massive
 ---
 */

//: Design Class
struct Bob {
  var name = "Bob"
  var skill = "Work"
  
  init() {}
}

Bob().name // "Bob"
let newBob = Bob()



extension Bob {
  var description: String {
    let myName = self.name
    let mySkill = self.skill
    return "I'm \(myName). I know \(skill)"
  }
  
  init(enterSkill: String) {
    self.skill = enterSkill
    print("You've entered a cool skill")
  }
  
  subscript(mySkill: String) -> String {
    return "This is your secret weapon"
  }
  
  
  
}

let bob = Bob()
print(bob.description)

let rob = Bob(enterSkill: "Swift 6")
print(rob.description)

rob["iOS 13"]


//: Extension to Swift Types
let number = 10



extension Int {
  var squared: Int {
    return self * self
  }
}

Int(123).squared
123123.squared

//: Rule in the Swift Extension
//: - You may not have a stored property
/*:
 Extensions in Swift
 
 - Add computed instance properties and computed type properties
 - Define instance methods and type methods (Later)
 - Provide new initializers
 - Define subscripts
 - Define and use new nested types with enum/struct (Later)
 - Make an existing type conform to a protocol (Later)
 */









