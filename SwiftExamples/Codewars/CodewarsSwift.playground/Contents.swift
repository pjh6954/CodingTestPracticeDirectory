//import UIKit

import Foundation

//var eightKyu = EightKyu()
//eightKyu.toSquareOrNotSquare()
//eightKyu.dallarsAndCents()


//var sevenKyu = SevenKyu()
//sevenKyu.sumOfOddNumbers()
//sevenKyu.toLeetSpeak()

//var sixKyu = SixKyu()
//sixKyu.areTheyTheSame()
//sixKyu.piApproximation()


// print("TEST")
// let test = FractionalExpression()
// test.executeExamples()


// print("Random Game")
// let randomGame = RandomGame()
// randomGame.executeExamples(false)


//let test = LeetCodeEasy()
//test.executeExamples()

//_ = ProgrammersQuestions()


/*
var test : Int = 8 {
    willSet {
        print("Will set : \(newValue)")
    }
    didSet {
        print("Did set : \(oldValue)")
    }
}
print("TEST Value : \(test)")
test = 2
print("TEST VALUE 2 : \(test)")

let names : [String] = ["Junseok", "Songyi", "Kim", "Karl"]
let result1 = names.map{$0.lowercased()}
print("RESULt1 : \(result1)")
let result2 = names.filter({$0.count < 5})
print("Result2 : \(result2)")
defer {
    print("Defer 02")
}
let numbers : [Int] = [1, 2, 3, 4]
let result3 = numbers.reduce(0) { $0 + $1 }
print("Result3 : \(result3)")
let result4 = names.filter({$0.contains("K")}).map({ $0.count })
print("Result4 : \(result4)")
defer {
    print("Defer 01")
}

enum testEnum : Int, Comparable {
    static func < (lhs: testEnum, rhs: testEnum) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case one
    case two
    case three
    case four
}
let enumtestValueOne : testEnum = .one
let enumtestValueTwo : testEnum = .three

print("TEST: \(enumtestValueOne) :: \(enumtestValueTwo) :: \(enumtestValueOne < enumtestValueTwo)")
*/

/*
let today = Date()

let formatter = DateFormatter()
formatter.dateFormat = "yyyy-MM-dd"
if let yesterday = formatter.date(from: "2021-08-20") {
    print("TEST : \(today) :: \(yesterday)")
    
    print("TEW : \(today.timeIntervalSinceNow) - \(yesterday.timeIntervalSinceNow)")
    
    print("BOOL : \(today.timeIntervalSinceNow > yesterday.timeIntervalSinceNow)")
}

*/
func calc(N: Int, M: Int) -> Int {
    // N : 사람 수, M: 터질 폭탄 갯수.
    var arr : [Int] = Array(repeating: 0, count: N)
    var count : Int = 0
    var repeatBool : Bool = true
    while repeatBool {
        var tempArr = arr
        print("ARR : \(tempArr)")
        for (index, value) in arr.enumerated() {
            if index == 0 {
                tempArr[0] += 1
            }
            if value != 0 {
                if value % 2 == 0 {
                    // 짝수 + 1
                    var temp = index + 1
                    if temp > N {
                        temp = 0
                    }
                    tempArr[temp] += 1
                    print("TEMP2 CHECK : \(temp) \(tempArr)")
                } else {
                    // 홀수 - 2
                    var temp = index - 2
                    if temp < 0 {
                        temp = N + temp
                    }
                    tempArr[temp] += 1
                    print("TEMP1 CHECK : \(temp) \(tempArr)")
                }
                // tempArr[index] -= 1
                print("INDEX: \(index) ;; RE : \(tempArr)")
                // if index == 0 {
                    tempArr[index] -= 1
                // }
            }
            // print("INDEX : \(index) :: \(tempArr)")
        }
        print("ARRREsult : \(tempArr)")
        print("BREAK-------------------")
        count += 1
        arr = tempArr
        if arr.contains(where: { element in
            return element >= M
        }) {
            break
        }
    }
    print("N : \(N) ;; \(M) ;; \(count) ;; \(arr)")
    return N + M + arr.reduce(0, +)
}
// print("teest : \(calc(N: 3, M: 3))")
print("test : \(calc(N: 4, M: 4))")
