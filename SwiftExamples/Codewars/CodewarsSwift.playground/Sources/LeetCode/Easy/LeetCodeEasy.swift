import Foundation

public class LeetCodeEasy : DefaultExecuteClass {
    public override init() {
        super.init()
        printLine()
        print("Leet Code Easy Questions")
    }
    
    public override func executeExamples() {
        // Reverse Integer
        // let _ = ReverseInteger()
        
        // Palindrome Number
        // let _ = PalindromeNumber()
    }
}



/// Reverse Integer
/// https://leetcode.com/problems/reverse-integer/
fileprivate class ReverseInteger : DefaultExecuteClass{
    fileprivate var datas: [Int] = []
    
    fileprivate override init() {
        super.init()
        datas = [
            123,
            -123,
            1534236469
        ]
        printLine()
        print("Reverse Integer Question")
        self.executeExamples()
    }
    
    fileprivate override func executeExamples() {
        self.datas.forEach { element in
            print("Check : \(element) :: \(reverse(element))")
        }
    }
    
    func reverse(_ x: Int) -> Int {
        let absolute = abs(x)
        print("ABS: \(absolute)")
        let string = String(absolute)
        print("String: \(string)")
        let reversedString = String(string.reversed())
        print("reverse: \(reversedString)")
        let int = Int32(reversedString)
        print("Int: \(int)")
        guard var result = int else { return 0 }
        if x < 0 {
            result = result * -1
        }
        return Int(result)
        /*
        let str = String(x)
        var value = String(str.reversed())
        
        print("value : \(value)")
        if str.hasPrefix("-") { // value.hasPrefix("-")인 경우 removeLast() 및 insert 안됨.
            value.removeLast()
            value.insert("-", at: value.startIndex)
        }
        print("Value2 : \(value), Int? \(Int(value))")
        if let intValue = Int32(value) {
            print("Int 32 value:\(intValue)")
            return Int(intValue)
        }
        return Int(value) ?? 0
         
        // leetcode에서 1534236469의 경우 정상적으로 출력되지 않는 문제가 있습니다.
        */
    }
    
    func solutionReverse(_ x: Int) -> Int {
        let sign = x < 0 ? -1 : 1
        var num = x * sign
        var result = 0
        
        while num > 0 {
            let digit = num % 10
            result = (result * 10 + digit)
            num /= 10
        }
        
        result = result * sign
        if result > (1 << 31) - 1 {
            result = 0
        } else if result < -(1 << 31) {
            result = 0
        }
        
        return result
        
        /*
        let absolute = abs(x)
        let string = String(absolute)
        let reversedString = String(string.reversed())
        let int = Int32(reversedString)
        guard var result = int else { return 0 }
        if x < 0 {
            result = result * -1
        }
        return Int(result)
        */
    }
}

/// Palindrome Number
/// https://leetcode.com/problems/palindrome-number/
fileprivate class PalindromeNumber: DefaultExecuteClass {
    fileprivate var datas: [Int] = []
    
    fileprivate override init() {
        super.init()
        datas = [
            121,
            131,
            123,
            321,
            -123,
            -321
        ]
        printLine()
        print("Palindrome Number Question")
        self.executeExamples()
    }
    
    fileprivate override func executeExamples() {
        datas.forEach { element in
            print("Element: \(element), result : \(self.isPalindrome(element))")
        }
    }
    
    func isPalindrome(_ x: Int) -> Bool {
        guard x >= 0 else { return false }
        let string = String(x)
        let reversedString = String(string.reversed())
        let int = Int32(reversedString)
        guard let result = int else { return false }
        return x == Int(result)
    }
}

/// Roman to Integer
/// https://leetcode.com/problems/roman-to-integer/
fileprivate class RomanToInteger: DefaultExecuteClass {
    fileprivate var datas: [String] = []
    /**
     Symbol       Value
     I                  1
     V                 5
     X                 10
     L                  50
     C                 100
     D                 500
     M                1000
     */
    fileprivate override init() {
        super.init()
        datas = [
            "III", // 3
            "IV", // 4
            "IX", // 9
            "LVIII", // 58
            "MCMXCIV" // 1994
        ]
        printLine()
        print("Palindrome Number Question")
        self.executeExamples()
    }
    
    fileprivate override func executeExamples() {
        //datas.forEach { element in
        //    print("Element: \(element), result :")
        //}
    }
    /*
    func romanToInt(_ s: String) -> Int {
        
    }
    */
}

