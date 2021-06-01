//
//  ContentView.swift
//  FullScreenModal
//
//  Created by Dannian Park on 2021/05/20.
//

import SwiftUI

struct ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Button(action: {
                        // trigger modal presentation
                        withAnimation {
                            self.isPresented.toggle()
                        }
                    }, label: {
                        Text("Show Standard Modal")
                    })
                }.navigationBarTitle("Standard")
            }
            
            
            ZStack {
                HStack { // 가로 길이를 채워주기 위해
                    Spacer()
                    VStack {
                        // Spacer() // 가운데 정렬 용
                        HStack {
                            Button(action: {
                                withAnimation {
                                    self.isPresented.toggle()
                                }
                            }, label: {
                                Text("Dismiss")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            })
                            Spacer()
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .onTapGesture {
                                    withAnimation {
                                        self.isPresented.toggle()
                                    }
                                }
                        }
                        .padding(.top, UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.top)
                        //windows.filter{$0.isKeyWindow}.first? 는 keyWindow를 대체
                        Spacer()
                    }
                    Spacer()
                }
            }.background(Color.yellow)
            .edgesIgnoringSafeArea(.all)
            .offset(x: 0, y: self.isPresented ? 0 : UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.frame.height ?? 0)
        }
        /*
        NavigationView {
            VStack {
                Button(action: {
                    // trigger modal presentation
                    self.isPresented.toggle()
                }, label: {
                    Text("Show Standard Modal")
                })
            }.navigationBarTitle("Standard")
            .sheet(isPresented: $isPresented, content: {
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    Text("HERE IS MY Modal")
                })
            })
        }
        */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
