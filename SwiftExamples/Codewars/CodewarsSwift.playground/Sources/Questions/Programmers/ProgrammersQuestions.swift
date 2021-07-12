import Foundation
/// 스킬체크
/// https://programmers.co.kr/skill_checks

public class ProgrammersQuestions: DefaultExecuteClass {
    public override init() {
        super.init()
        printLine()
        print("Programmers Questions")
        executeExamples()
    }
    
    public override func executeExamples() {
        _ = ProgrammersQuestionOne()
        _ = ProgrammersQuestionTwo()
    }
}

fileprivate class ProgrammersQuestionOne: DefaultExecuteClass {
    var data : [(n: Int, m: Int)] = []
    public override init() {
        super.init()
        data = [
            (n: 3, m: 12),
            (n: 2, m: 5)
        ]
        printLine()
        print("Programmers question one")
        data.forEach { (n, m) in
            print("RESULT: \(self.solution(n, m))")
        }
    }
    
    func solution(_ n:Int, _ m:Int) -> [Int] {
        var max: Int = 0 // 최대 공약수
        var min: Int = 0 // 최소 공배수
        func gcd(num1: Int, num2: Int) -> Int{
            if num2 == 0 {
                return num1
            }
            return gcd(num1: num2, num2: num1 % num2)
        }
        if n > m {
            max = gcd(num1: n, num2: m)
        } else {
            max = gcd(num1: m, num2: n)
        }
        min = (n * m / max)
        return [max, min]
    }
}

fileprivate class ProgrammersQuestionTwo: DefaultExecuteClass {
    var data: [(x:Int, n: Int)] = []
    public override init() {
        super.init()
        data = [ // (x:, n:)
            (x:2, n:5),
            (x:4, n:3),
            (x:-4, n:2)
        ]
        printLine()
        print("Programmers question two")
        data.forEach { (x, n) in
            print("RESULT: \(self.solution(x, n))")
        }
    }
    
    func solution(_ x:Int, _ n:Int) -> [Int64] {
        var returnValue : [Int64] = []
        for i in 1...n {
            returnValue.append(Int64(x * i))
        }
        return returnValue
    }
}
