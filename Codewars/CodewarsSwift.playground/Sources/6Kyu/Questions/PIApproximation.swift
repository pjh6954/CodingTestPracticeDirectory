import Foundation

// PI Approximation
// https://www.codewars.com/kata/550527b108b86f700000073f
// https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%80
// 라이프니츠 정리 파이
// How to : https://github.com/RDCLder/Codewars/blob/master/6_Kyu/Pi_Approximation.md

public class PIApproximation: DefaultExecuteClass {
    public var datas : [Double] = []
    
    public override init() {
        super.init()
        datas = [0.1, 0.01, 0.001, 0.0001, 0.00001, 0.000001, 0.05]
    }
    
    public override func executeExamples() {
        for element in datas {
            print("My Practice : \nData: \(element) -> Response: \(myIterPi(element))")
            print("Best Practice : \nData: \(element) -> Response: \(bestIterPi(element))")
        }
    }
    
    private func myIterPi(_ epsilon: Double) -> (Int, String) {
        var precision: Double = 0
        var odd = 1
        var sign = 1
        var i = 0
        while abs(precision * 4 - Double.pi) > epsilon {
            precision += 1.0 / Double((odd * sign))
            odd += 2
            sign *= -1
            i += 1
        }
        return (i, String(format: "%.10f", precision * 4))
    }
    
    private func bestIterPi(_ epsilon: Double) -> (Int, String) {
        var pi = 1.0, i = 0
        while abs(Double.pi - 4 * pi) > epsilon {
            i += 1
            pi += ( pow(Double(-1), Double(i)) / Double(2*i + 1) )
        }
        return ( i + 1, String(format: "%.10f", pi * 4) )
    }
}
