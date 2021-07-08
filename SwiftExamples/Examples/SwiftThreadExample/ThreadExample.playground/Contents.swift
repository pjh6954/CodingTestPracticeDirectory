import Foundation

let displayImojiArr = [
    "263A", // ☺
    "1F600", // 😀
    "1F638", // 😸
    "1F631" // 😱
]
/*
// Test 01
DispatchQueue.main.async {
    testCode(0)
}

DispatchQueue.main.async {
    testCode(1)
}
*/
/*
DispatchQueue.global().async {
    testCode(0)
}
DispatchQueue.global().async {
    testCode(1)
}
*/

DispatchQueue.global().sync {
    testCode(2)
}
DispatchQueue.global().sync {
    testCode(3)
}
DispatchQueue.global().async {
    testCode(0)
}
DispatchQueue.global().async {
    testCode(1)
}
func testCode(_ type : Int) {
    for i in 0 ..< 5 {
        print(String(UnicodeScalar(Int(displayImojiArr[type], radix: 16)!)!) + "\(i + 1)")
    }
}
