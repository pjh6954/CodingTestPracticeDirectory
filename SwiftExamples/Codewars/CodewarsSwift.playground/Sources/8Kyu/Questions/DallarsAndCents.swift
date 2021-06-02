import Foundation

// Dollars and Cents
// https://www.codewars.com/kata/55902c5eaa8069a5b4000083/swift
public class DallarsAndCents: DefaultExecuteClass {
    public var datas: [Double] = [] // if you want, edit this data for test
    public override init() {
        super.init()
        print("Start DallarsAndCents")
        // Example datas
        datas = [3.1, 5.7, 10, 55.0, 6.889]
    }
    
    public override func executeExamples() {
        for element in datas {
            print("My practice :\nData: \(element) -> Response: \(myFormatMoney(element))")
            print("Best practice :\nData: \(element) -> Response: \(bestFormatMoney(element))\n")
        }
        print("End DallarsAndCents\n")
    }
    
    private func myFormatMoney(_ val : Double) -> String {
        return String(format: "$%.2f", val)
    }
    
    private func bestFormatMoney(_ val : Double) -> String {
        return String(format: "$%.2f", val)
    }
}
