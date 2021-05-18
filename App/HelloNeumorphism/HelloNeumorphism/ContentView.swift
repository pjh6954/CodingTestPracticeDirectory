//
//  ContentView.swift
//  HelloNeumorphism
//
//  Created by saltedDev on 2020/03/19.
//  Copyright © 2020 salted_Bucky. All rights reserved.
//

import SwiftUI

struct NeumorphicView: View {
    var bgColor: Color
    @State private var isPressed: Bool = false
    
    var body: some View {
        VStack {
            Button("Hello, Neumorphism!", action: {
                self.isPressed.toggle()
            }).padding(20)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .shadow(color: .white, radius: self.isPressed ? 7: 10, x: self.isPressed ? -5: -10, y: self.isPressed ? -5: -10)
                            .shadow(color: .black, radius: self.isPressed ? 7: 10, x: self.isPressed ? 5: 10, y: self.isPressed ? 5: 10)
                            .blendMode(.overlay)
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(bgColor)
                    }
            )
                .scaleEffect(self.isPressed ? 0.98: 1)
                .foregroundColor(.primary)
                .animation(.spring())
                .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
        }
    }
}
struct NavigationView_L: View {
    var bgColor: Color
    @State private var isPressed: Bool = false
    var body: some View {
        Button("Left", action: {
            self.isPressed.toggle()
        }).padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: .white, radius: self.isPressed ? 7: 10, x: self.isPressed ? -5: -10, y: self.isPressed ? -5: -10)
                        .shadow(color: .black, radius: self.isPressed ? 7: 10, x: self.isPressed ? 5: 10, y: self.isPressed ? 5: 10)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(self.isPressed ? 0.88: 1)
            .foregroundColor(.primary)
            .animation(.spring())
            .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
    }
}

struct NavigationView_M: View {
    var bgColor: Color
    @State private var isPressed: Bool = false
    var body: some View {
        Button("Title", action: {
            self.isPressed.toggle()
        }).padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .shadow(color: .dropLight, radius: self.isPressed ? 7: 10, x: self.isPressed ? -5: -10, y: self.isPressed ? -5: -10)
                    .shadow(color: .dropShadow, radius: self.isPressed ? 7: 10, x: self.isPressed ? 5: 10, y: self.isPressed ? 5: 10)
                    .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .padding(5)
                    .shadow(color: .innerLight, radius: self.isPressed ? 7: 10, x: self.isPressed ? -5: -10, y: self.isPressed ? -5: -10)
                    .shadow(color: .innerShadow, radius: self.isPressed ? 7: 10, x: self.isPressed ? 5: 10, y: self.isPressed ? 5: 10)
                    .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(bgColor)
                    .padding(5)
                    .shadow(color: .dropLight, radius: self.isPressed ? 7: 10, x: self.isPressed ? -5: -10, y: self.isPressed ? -5: -10)
                    .shadow(color: .dropShadow, radius: self.isPressed ? 7: 10, x: self.isPressed ? 5: 10, y: self.isPressed ? 5: 10)
                    .blendMode(.overlay)
                }
        )
            .edgesIgnoringSafeArea(.all)
            .scaleEffect(self.isPressed ? 0.88: 1)
            .foregroundColor(.primary)
            .animation(.spring())
            .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
    }
}

struct NavigationView_R: View {
    var bgColor: Color
    @State private var isPressed: Bool = false
    var body: some View {
        Button("Right", action: {
            self.isPressed.toggle()
        }).padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                        .padding(5)
                        .shadow(color: .dropLight, radius: self.isPressed ? 7: 10, x: self.isPressed ? 5: 10, y: self.isPressed ? 5: 10)
                        .shadow(color: .dropShadow, radius: self.isPressed ? 7: 10, x: self.isPressed ? -5: -10, y: self.isPressed ? -5: -10)
                        .blur(radius: 10, opaque: false)
                }
        )
            .scaleEffect(self.isPressed ? 0.88: 1)
            .foregroundColor(.primary)
            .animation(.spring())
            .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
        .cornerRadius(10)
    }
}
struct NavigationView: View {
    var body: some View {
        HStack{
            NavigationView_L(bgColor: Color.neuBackground)
            Spacer()
            NavigationView_M(bgColor: Color.neuBackground)
            Spacer()
            NavigationView_R(bgColor: Color.neuBackground)
        }
    .padding()
    }
}
struct ContentView: View {
    var body: some View {
        VStack {
            NavigationView()
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .background(Color.neuBackground)
                .edgesIgnoringSafeArea(.all)
            NeumorphicView(bgColor: Color.neuBackground)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                .background(Color.neuBackground)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    static let neuBackground = Color(hex: "f0f0f3")
    
    static let dropLight = Color(hex: "ffffff")
    static let dropShadow = Color(hex: "aeaec0").opacity(0.4)
    
    static let innerShadow = Color(hex: "aeaec0").opacity(0.25)
    static let innerLight = Color(hex: "ffffff")
    
    static let dropLight2 = Color(hex: "ffffff").opacity(0.7)
    static let dropShadow2 = Color(hex: "aeaec0").opacity(0.2)
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
