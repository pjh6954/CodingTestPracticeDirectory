import Foundation

// Are they the "same"?
// https://www.codewars.com/kata/550498447451fbbd7600041c

public class AreTheyTheSame: DefaultExecuteClass {
    public var datas: [([Int], [Int])] = []
    
    public override init() {
        super.init()
        datas = [
            ([121, 144, 19, 161, 19, 144, 19, 11], [121, 14641, 20736, 361, 25921, 361, 20736, 361])
        ]
    }
    
    public override func executeExamples() {
        for element in datas {
            print("My Practice : \nData: \(element) -> Response: \(myComp(element.0, element.1))")
            print("Best Practice : \nData: \(element) -> Response: \(bestComp(element.0, element.1))")
        }
    }
    
    private func myComp(_ a: [Int], _ b: [Int]) -> Bool {
        guard a.count == b.count else {
            return false
        }
        var tempA = a.compactMap { element in
            return element * element
        }
        for element in b {
            if let index = tempA.firstIndex(of: element) {
                tempA.remove(at: index)
            }
        }
        return tempA.isEmpty
    }
    
    private func bestComp(_ a: [Int], _ b: [Int]) -> Bool {
        return a.map{ $0 * $0 }.sorted() == b.sorted()
    }
}
