/*:
 ## Learn Swift with Bob
 ### Chapter 1: The Swift Fundamentals
 ### Guard and Defer Statement
 
 
 **Problem:** 
 1. Is there any alternative to write an `else-if` statement?
 2. How do you safely unwrap multiple `optionals`?
 
 ---
 */

//: > **Zenness:** A trait where peace, calmness, and inner awesomeness are all intertwined - [Urban Dictionary](http://www.urbandictionary.com/define.php?term=Zenness)l


func checkDrinkingAge() {
  let canDrink = true
  
  if canDrink {
    print("You may enter")
    // More
    // More Code
    // More Code

  } else {
    // More Code
    // More Code
    // More Code
    print("Let me take you to the jail")
  }
  
}

/*: 
### Issues with Else-If
1. Nested Brakets
2. Have to read all
 */


//: Introducing Guard
let iCanDrink = true

func checkDrinkingAges() {
  
  guard iCanDrink else {
    // iCanDrink == false
    // iCanDrink == true // simply ignore the guard block
    print("You can't drink, let me take you to the jail")
    return
  }
  
  
  print("Enjoy your night")
  // You may move on
  // Come on.
  // You may leave
  // You don't need to read this.
  // Only one bracket on the bottom: feeling zen.
  
}

checkDrinkingAges()

//: ### Unwrapping Optionals
var publicName: String? = "Bob Lee"
var publicPhoto: String? = "Bob's Face"
var publicAge: Int? = 20

//: The Worst Nightware
func unwrapOneByOne() {
  if let name = publicName {
    if let photo = publicPhoto {
      if let age = publicAge {
        print("Bob: \(name), \(photo), \(age)")
      } else {
        print("age is mising")
      }
    } else {
      print("photo is missing")
    }
  } else {
    print("name is missing")
  }
}

unwrapOneByOne()

//: Slightly Better
func unwrapBetter() {
  if let name = publicName {
    print("Yes name")
  } else {
    print("No name")
    return
  }
  
  if let photo = publicPhoto {
    print("Yes photo")
  } else {
    print("No photo")
    return
  }
  
  if let age = publicAge {
    print("Yes age")
  } else {
    print("No age")
    return
  }
  
}

//: Introducing Guard Statement
func unwrapOneByOneWithGuard() {
  
  guard let name = publicName else {
    // if publicName is non-nil, ignore the block
    // if publicName i nil, run the guard block
    print("Name missing")
    return
  }
  
  guard let photo = publicPhoto else {
    print("Photo missing")
    return
  }
  
  guard let age = publicAge else {
    print("Age missing")
    return
  }
  
  print(name)
  print(photo)
  print(age)
  
}

//: Unwrap multiple optionals with `else-if`
func unwrap() {
  if let name = publicName, let photo = publicPhoto, let age = publicAge {
    print("Your name is \(name). I see your face right here, \(photo), you are \(age)")
  } else {
    print("Something is missing")
  }
}

unwrap()

//: Unwrap multiple optionals with `guard`
func unwrapWithGuard() {
  
  guard let name = publicName, let photo = publicPhoto, let age = publicAge else {
    // one or two of the variables contain "nil"
    print("Something is missing")
    return
  }
  
  
  
  print("Your name is \(name). I see your, \(photo). You are \(age).")
  // Animation Logic
  // Networking
  // More Code, but still zen
}

//: ### Introducing Defer Statement
//: > **Defer Statement:** Put off (an action or event) to a later time; postpone. In Swift, it will execute a block of code until the current scope (loop, method, etc) exits.

func simpleDefer() {
  
  defer {
    print("Chill, later")
  }
  
  print("Print First")
}

simpleDefer()

for i in 1...3 {
  defer { print ("Deferred \(i)") }
  print ("First \(i)")
}


























