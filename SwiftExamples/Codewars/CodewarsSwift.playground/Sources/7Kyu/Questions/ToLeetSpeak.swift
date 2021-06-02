import Foundation

// To Leet Speak
// https://www.codewars.com/kata/57c1ab3949324c321600013f
public class ToLeetSpeak: DefaultExecuteClass {
    public var datas: [String] = []
    
    public override init() {
        super.init()
        print("Start To Leet Speak")
        
        datas = ["LEET"]
    }
    
    public override func executeExamples() {
        for element in datas {
            print("My practice :\n\(element) -> \(myToLeetSpeak(element))")
            print("Best practice :\n\(element) -> \(bestToLeetSpeak(element))\n")
        }
        print("End To Leet Speak")
    }
    
    private func myToLeetSpeak(_ s: String) -> String {
        let leetSpeakArr : [Character : Character] = [ "A" : "@", "B" : "8", "C" : "(", "D" : "D", "E" : "3", "F" : "F", "G" : "6", "H" : "#", "I" : "!", "J" : "J", "K" : "K", "L" : "1", "M" : "M", "N" : "N", "O" : "0", "P" : "P", "Q" : "Q", "R" : "R", "S" : "$", "T" : "7", "U" : "U", "V" : "V", "W" : "W", "X" : "X", "Y" : "Y", "Z" : "2", " " : " " ]
        return String(s.compactMap {leetSpeakArr[$0]})
    }
    
    private func bestToLeetSpeak(_ s: String) -> String {
        let dict : [Character : Character] = [ "A" : "@", "B" : "8", "C" : "(", "E" : "3", "G" : "6", "H" : "#", "I" : "!", "L" : "1", "O" : "0", "S" : "$", "T" : "7", "Z" : "2", ]
        return String(s.map { dict[$0] ?? $0 })
    }
}
