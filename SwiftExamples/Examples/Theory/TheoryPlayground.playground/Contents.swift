import UIKit
import Foundation
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

