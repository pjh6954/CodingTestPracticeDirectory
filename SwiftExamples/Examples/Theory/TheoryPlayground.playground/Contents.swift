import UIKit
import Foundation
/*
/*
func optionalFunction() {
    let x : String? = "Hello World"
    let newString : String = "My Name is Dan"
    let z = (x ?? "") + newString
    if let y = x {
        print(y)
    }
    // or
    guard let y = x else { return }
    print(y)
}
// optionalFunction()

func variablesFunction() {
    
}

variablesFunction()
*/

let spellOutFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .spellOut
    nf.locale = Locale(identifier: "en_US") //You may want to try some other locales...
    return nf
}()

extension Numeric {
    var spelledOut: String {
        return spellOutFormatter.string(for: self) ?? String(describing: self)
    }
}
let one = 1.spelledOut
// print(one) //->one
// print(25.spelledOut) //->twenty-five
// print(1.5.spelledOut) //->one point five
var str = ""
for i in 0 ... 1000 {
    let spell = i.spelledOut.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
    print("NUM : \(i) :: \(spell)")
    str += spell
}
print("str count : \(str.count)")

let spellOne : [Int: String] = [
    0 : "zero",
    1 : "one",
    2 : "two",
    3 : "three",
    4 : "four",
    5 : "five",
    6 : "six",
    7 : "seven",
    8 : "eight",
    9 : "nine"
]

let spellTen = [
    10:"ten",
    11:"eleven",
    12:"tweleve",
    13:"thirteen",
    14:"fourteen",
    15:"fifteen",
    16:"sixteen",
    17:"seventeen",
    18:"eighteen",
    19:"nineteen",
    20:"twenty",
    30:"thirty",
    40:"forty",
    50:"fifty",
    60:"sixty",
    70:"seventy",
    80:"eighty",
    90:"ninety"]
let spell100 = "hundred"
let spellAnd = "and"


// remove /*
/*
class HumanKind {
    let name : String = "Dannian"
    var contents: String {
        return "My name is " + self.name
    }
}

class Human {
    static let name : String = "Dannian"
    static var contents: String {
        return "My Name is " + self.name
    }
    class var contentsTwo: String {
        return "My Name was " + self.name
    }
}

class Dannian: Human {
    override class var contentsTwo: String {
        return "This is overridable property : \(self.name)"
    }
}

struct EmptyStruct {
    static let test1 : String = "1"
    static var test2 : String { return "test 1: \(test1)"}
    class var test3 : String { return "test1 - 3 : \(test1)" }
}

let humanContents = Human.contents

let dannianContents = Dannian.contentsTwo

let humanKindContents = HumanKind().contents

let humanClass = Human()

*/
// remove */

*/


