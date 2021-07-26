//
//  SwiftUICurrencyView.swift
//  CurrencyConverter
//
//  Created by Dannian Park on 2021/07/26.
//

import SwiftUI
// 참고 : https://medium.com/digital-curry/how-i-created-a-beautiful-calculator-in-less-than-200-loc-with-swiftui-f1640504a50d
struct SwiftUICurrencyView: View {
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 36) {
                HStack {
                    Button(action: {
                        print("Korea Button Action")
                    }, label: {
                        //Image(🇰🇷)
                        Text("🇰🇷")
                    })
                    Button("Image") {
                        
                    }
                    Spacer()
                }.padding([.leading, .trailing], 12)
                
                CalcView()
            }
        }
        .padding([.leading, .trailing], 8)
        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.clear)
        //.edgesIgnoringSafeArea(.all)
        
    }
}

struct SwiftUICurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUICurrencyView()
    }
}


struct CalcView: View {
    
    @State private var celsius: Double = 0
    
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Spacer()
                Text("$0")
                    .font(.system(size: 48, weight: .regular, design: .default))
                Text("USD")
                    .font(.system(size: 18, weight: .regular, design: .default))
            }.padding([.leading, .trailing], 8)
            Slider(value: $celsius, in: 0...1)
            CalcButtonView()
        }
    }
}

struct CalcButtonView : View {
    
    let rowInNum: [[String]] = [
        ["1", "4", "7"], ["2", "5", "8"], ["3", "6", "9"], ["000", "00", "0"], ["Del", "AC"]
    ]
    
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            
            ForEach(rowInNum, id: \.self) { element in
                VStack(alignment: .center, spacing: 2){
                    ForEach(element, id: \.self) { value in
                        Button(action: {}, label: {
                            Text("\(value)")
                                .font(.system(size: getFontSize(btnTxt: value)))
                                //.frame(idealWidth: 100, maxWidth: .infinity, idealHeight: 20, maxHeight: .infinity, alignment: .center)
                                .frame(minWidth: 0, idealWidth: 40, maxWidth: .infinity, alignment: .center)
                                                                
                        })
                            .foregroundColor(Color.black)
                            .background(Color(red: 0.9, green: 0.9, blue: 0.9))//(getBackground(str: value))
                            //.mask(CustomShape(radius: 40, value: value))
                    }
                }
                    .background(Color.clear)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 414, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

let primaryColor = Color.init(red: 0, green: 116/255, blue: 178/255, opacity: 1.0)

// Return differnt font sizes for operators and numbers.
func getBackground(str:String) -> Color {
    
    if checkIfOperator(str: str) {
        return primaryColor
    }
    return Color.black
}

// Return differnt font sizes for operators and numbers.
func getFontSize(btnTxt: String) -> CGFloat {
    
    if checkIfOperator(str: btnTxt) {
        return 42
    }
    return 24
    
}

// This function returns if the passed argument is a operator or not.
func checkIfOperator(str:String) -> Bool {
    
    if str == "÷" || str == "×" || str == "−" || str == "+" || str == "=" {
        return true
    }
    
    return false
    
}


class SwiftUICurrencyViewController: UIHostingController<SwiftUICurrencyView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: SwiftUICurrencyView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
