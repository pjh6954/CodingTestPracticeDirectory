import Foundation

// Sum Of Odd Numbers
// https://www.codewars.com/kata/55fd2d567d94ac3bc9000064
public class SumOfOddNumbers: DefaultExecuteClass {
    public var datas : [Int] = []
    
    public override init() {
        super.init()
        print("Start Sum Of Odd Numbers")
        
        datas = [1, 2, 5, 8, 10]
    }
    
    public override func executeExamples() {
        for element in datas {
            print("My Practice : \nData: \(element) -> Response: \(mySumOfOddNumbers(element))")
            print("Best Practice : \nData: \(element) -> Response: \(bestSumOfOddNumbers(element))")
        }
    }
    
    private func mySumOfOddNumbers(_ row: Int) -> Int {
        return row * row * row
    }
    
    private func bestSumOfOddNumbers(_ row: Int) -> Int {
        return Int(pow(Double(row),3))
    }
}
