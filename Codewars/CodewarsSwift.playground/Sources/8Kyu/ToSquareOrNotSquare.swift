import Foundation

// To square(root) or not to square(root)
// https://www.codewars.com/kata/57f6ad55cca6e045d2000627/swift
public class ToSquareOrNotSquare {
    var datas : [[Int]] = []
    public init() {
        print("init to square or not square!")
        datas = [[4,3,9,7,2,1], [5,9,1,77,44,81,32,36]]
        executeExamples()
    }
    
    private func executeExamples() {
        for element in datas {
            print("my practice :\n\(element) -> \(mySquareOrSquareRoot(element))")
            print("best practice :\n\(element) -> \(bestSquareOrSquareRoot(element))\n")
        }
        print("End ToSquareOrNotSquare")
    }
        
    private func mySquareOrSquareRoot(_ input: [Int]) -> [Int] {
        var returnArr : [Int] = [] // 결과 반환 Array
        input.forEach { element in // 입력 값의 각 element
            let sqv = Int(Double(element).squareRoot()) // Int -> Double -> squareRoot() -> Int
            if sqv * sqv == element { // 제곱근을 제곱한 값이 element와 동일한 경우
                returnArr.append(sqv) // 반환 Array에 제곱근을 추가
            }else{ // 그 외
                returnArr.append(element * element) // 원본 입력값을 제곱
            }
        }
        return returnArr
    }
    
    private func bestSquareOrSquareRoot(_ input: [Int]) -> [Int] {
        return input.map { i in
            let r = sqrt(Double(i))
            // truncatingRemainder는 dividingBy의 값으로 나눈 나머지 값을 반환합니다.
            // 단, %연산자와 다른 점은 부동소숫점 타입도 나머지 연산이 가능하다는 점입니다.
            // 여기서는 1로 나머지 연산을 진행하고, 결과값이 0이라면 제곱근, // 아니라면 원본 값을 제곱을 한 값을 반환합니다.
            return r.truncatingRemainder(dividingBy: 1).isZero ? Int(r) : i * i
        }
    }
}
