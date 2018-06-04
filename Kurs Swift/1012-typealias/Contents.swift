/*:
 ## Learn Swift with Bob
 ### Chapter 1: The Swift Fundamentals
 ### Typealias
 
 **Problem:** The parameters are unreadable and boring
 
 ---
 */

//: Typealias for 'String'
typealias Name = String

func insertName(name: Name) {
  print(name)
}

//: Typealias for Custom Class
class Employee {}



typealias MyEmployees = [Employee]
func listEmployees(enterEmployees: MyEmployees) {
  
}

listEmployees(enterEmployees: [Employee(), Employee()])



typealias GridPoint = (Int, Int)

func enterPoint(grid: GridPoint) {
  print(grid.0)
  print(grid.1)
}

enterPoint(grid: (1, 2))

//: ### Type Definition
//: Array Type
let arrayOne: Array<String> = Array(["Bob", "Bobby"]) //2
let arrayTwo: [String] = ["Bob", "Bobby"] //1


//: Dictionary Type
let dictOne: [String: Int] = ["Alex": 31, "Paul": 39]
let dictTwo: Dictionary<String, Int> = ["Alex": 31, "Paul": 39]


//: Optional Type
var optionalOne: String?
var optionalTwo: Optional<String>












































