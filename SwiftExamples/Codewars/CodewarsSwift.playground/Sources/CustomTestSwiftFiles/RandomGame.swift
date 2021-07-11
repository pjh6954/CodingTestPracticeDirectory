import Foundation

public class RandomGame : DefaultExecuteClass {
    public override init() {
        super.init()
    }
    public override func executeExamples() {
        super.executeExamples()
        self.executeExamples(false)
    }
    public func executeExamples(_ isAllUnique: Bool = false) {
        /*
        print("Random SevenTwenty Game")
        sevenTwenty().forEach { str in
            print("\(str)")
        }
        self.printLine()
        print("Random Lotto Game")
        lotto(isAllUnique) { value in
            value.forEach { str in
                print("\(str)")
            }
        }
        */
        self.printLine()
        print("Power ball game")
        powerBall(isAllUnique).forEach({ str in
            print("\(str)")
        })
    }
    
    private func powerBall(_ isAllUnique: Bool) -> [String] {
        var strArr : [String] = []
        var tempArr: [Int] = []
        for _ in 0 ..< 5 {
            if !isAllUnique {
                tempArr.removeAll()
            }
            var arr : [Int] = []
            for _ in 0 ..< 5 {
                var whileBool = true
                while whileBool {
                    let value = Int.random(in: 1...28)
                    if !tempArr.contains(value) {
                        tempArr.append(value)
                        arr.append(value)
                        whileBool = false
                    }
                }
            }
            arr.sort()
            arr.append(Int.random(in: 0...9))
            strArr.append(arr.compactMap({String($0)}).joined(separator: " "))
        }
        return strArr
    }
    
    // Random number get
    private func sevenTwenty() -> [String] {
        var arr : [String] = []
        for i in 1 ... 5 {
            var str = "\(i)조 "
            for _ in 0 ... 5 {
                str += "\(Int.random(in: 0...9))"
            }
            arr.append(str)
        }
        
        return arr
    }
    
    private func lotto(_ isAllUnique: Bool, completion: @escaping(_ value: [String]) -> Void){
        var arrStr : [String] = []
        DispatchQueue.global().async {
            var uniqueArr: [Int] = []
            for _ in 0 ..< 5 {
                var arr : [Int] = []
                usleep(1000000) // usleep(1000000) //will sleep for 1 second
                if !isAllUnique {
                    uniqueArr.removeAll()
                }
                for _ in 0 ..< 6 {
                    var whileBool = true
                    while whileBool {
                        let value = Int.random(in: 1 ... 45)
                        //print("Check value : \(value), arr : \(arr)")
                        if isAllUnique {
                            if !uniqueArr.contains(value) {
                                uniqueArr.append(value)
                                arr.append(value)
                                whileBool = false
                            }
                        } else{
                            if !arr.contains(value) {
                                arr.append(value)
                                whileBool = false
                            }
                        }
                    }
                }
                arrStr.append(arr.sorted().compactMap({
                    String($0)
                }).joined(separator: " "))
            }
            
            DispatchQueue.main.async {
                print("Complete")
                completion(arrStr)
            }
        }
    }
}
/*
 12 19 27 28 14 8
 23 8 24 21 18 5
 4 7 9 3 26 3
 1 16 25 15 10 4
 5 13 11 17 2 2
 */
/*
 1조 284274
 2조 976079
 3조 432563
 4조 797686
 5조 339945
 
 1조 422574
 2조 394105
 3조 938357
 4조 999138
 5조 720426
 
 1조 713305
 2조 136567
 3조 514937
 4조 638651
 5조 993008
 
 1조 205548
 2조 973990
 3조 613508
 4조 027910
 5조 302423
 */
/*
 2 7 8 10 15 22
 5 6 9 32 36 43
 3 16 17 19 20 25
 4 12 13 29 33 44
 1 14 24 37 39 40
 
 5 8 16 25 40 45
 4 13 27 32 35 39
 9 17 21 29 31 38
 14 19 34 37 41 42
 6 12 20 22 23 30
 
 15 18 28 30 32 43
 3 6 13 17 22 26
 9 12 25 29 31 45
 7 16 20 27 38 41
 1 2 8 21 35 42
 
 12 15 24 31 33 34
 9 19 22 30 35 43
 4 11 20 29 42 44
 8 13 23 26 39 41
 2 7 14 25 27 36
 
 6 18 29 32 33 40
 8 12 22 27 28 45
 2 4 13 31 42 43
 11 14 24 25 35 44
 5 21 26 30 37 41
*/
