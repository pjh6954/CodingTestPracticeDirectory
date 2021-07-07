import Foundation

public class RandomGame : DefaultExecuteClass {
    public override init() {
        super.init()
    }
    
    public override func executeExamples() {
        print("Random SevenTwenty Game")
        sevenTwenty().forEach { str in
            print("\(str)")
        }
        self.printLine()
        print("Random Lotto Game")
        lotto { value in
            value.forEach { str in
                print("\(str)")
            }
        }
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
    
    private func lotto(completion: @escaping(_ value: [String]) -> Void){
        var arrStr : [String] = []
        DispatchQueue.global().async {
            for _ in 0 ..< 5 {
                var arr : [Int] = []
                usleep(1000000) // usleep(1000000) //will sleep for 1 second
                for _ in 0 ..< 6 {
                    var whileBool = true
                    while whileBool {
                        let value = Int.random(in: 1 ... 45)
                        //print("Check value : \(value), arr : \(arr)")
                        if arr.contains(value) {
                            // do nothing
                            //print("Contain Same value")
                        }else{
                            arr.append(value)
                            whileBool = false
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
