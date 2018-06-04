/*:
 ## Learn Swift with Bob
 ### Chapter 1: The Swift Fundamentals
 ### 1001_Optionals
 
 **Problem:**
 
 ---
 */

/*:
 ### Rules:
 1. Every variable type must be defined (Implicit/Explicit)
 2. The type is inferred based on the value
 */
let name: String = "Bob"          // Explicit
let newName = "Bob the Developer" // Implicit
let myAge: Int = 20               // Explicit
let mySisterAge = 14              // Implicit
let myGPA: Double = 3.54          // Explicit


//: Fetching Profile Picture
// If could return "URL" or "nothing"
let myFace = "https://..."


//: Introducing Optionals
// Optional type allows storing nil
let myName: String? = nil
let yourName: String? = "Bob Lee"

print(myName)
print(yourName)

let bobAge: Int? = nil
var robAge: Int? = 123
let danAge: Int? = 3

robAge = 2123


/*:
 ### Optional Rules:
 1. Optionals do not interact with each other
 2. Convert Optionals to normal types, the process known as *unwrapping*
 */
//: ### Optional Unwrapping
//: Forced Unwrapping
let newRobAge = robAge!
print(newRobAge)
let newDanAge = danAge!
print(newRobAge)


// Problem
var image: String? = nil
// image!


//: Implicit Unwrapping
// Conditonal Statement
let imageFromFaceBook: String? = nil


if let normalImage = imageFromFaceBook {
  print(normalImage)
} else {
  print("There is no image")
}




