import Foundation

public class FractionalExpression : DefaultExecuteClass{
    let data : [Int] = [1,2,3,4,5,6,7,8,9]
    public override init() {
        
    }
    
    public override func executeExamples() {
        var totalCounter : Int = 0
        print("TEST : \(permuteWirth([1,2,3], 2))")
    }
    
    private func calc(one: Int, two: Int?, three: Int?, four: Int?, five: Int?, six: Int?, seven: Int?, eight: Int?, nine: Int?) {
    }
    
    //https://stackoverflow.com/questions/25162500/apple-swift-generate-combinations-with-repetition
    func combos<T>(elements: ArraySlice<T>, k: Int) -> [[T]] {
        if k == 0 {
            return [[]]
        }

        guard let first = elements.first else {
            return []
        }

        let head = [first]
        let subcombos = combos(elements: elements, k: k - 1)
        var ret = subcombos.map { head + $0 }
        ret += combos(elements: elements.dropFirst(), k: k)

        return ret
    }

    func combos<T>(elements: Array<T>, k: Int) -> [[T]] {
        return combos(elements: ArraySlice(elements), k: k)
    }
    
    //https://velog.io/@hansangjin96/Swift-Factorial-Combination-Permutation
    //가능한 모든 경우의 수
    func permuteWirth<T>(_ a: [T], _ n: Int) -> [T] {
        if n == 0 {
            print("___ \(a)")   // display the current permutation
            return a
        } else {
            var a = a
            let test = permuteWirth(a, n - 1)
            print("TEst : \(test) :: \(a), \(n - 1)")
            for i in 0..<n {
                a.swapAt(i, n)
                let test2 = permuteWirth(a, n - 1)
                print("TEst2 : \(test2) :: \(a), \(n - 1)")
                a.swapAt(i, n)
            }
            return test
        }
    }
}
