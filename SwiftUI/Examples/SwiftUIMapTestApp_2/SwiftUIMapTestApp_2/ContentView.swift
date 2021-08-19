//
//  ContentView.swift
//  SwiftUIMapTestApp_2
//
//  Created by Dannian Park on 2021/07/23.
//


// 질문 원본 링크 : https://iphonedev.co.kr/iOSDevQnA/183520
import SwiftUI
import MapKit

class ContentViewModel : ObservableObject { // MVVM패턴의 View Model 부분
    // 각 뷰에서 실질적으로 사용하는 변수
    @Published var coordinateRegion : MKCoordinateRegion = MKCoordinateRegion(center: .init(latitude: 37.55873565341439, longitude: 127.01839896779809), span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    public var returnValueLat : CLLocationDegrees {
        self.coordinateRegion.center.latitude
    }
    private var currentIndex : Int = 0
    private var coordinateLattiArr : [CLLocationCoordinate2D] = [.init(latitude: 37.54441902112603, longitude: 127.09999925662044), .init(latitude: 37.52174331346211, longitude: 127.10868982573317), .init(latitude: 37.460024197357185, longitude: 127.12646483782926)]
    
    // 입력 받은 값으로 직접 넣기 위한 함수
    public func updateData(_ coordinate : CLLocationCoordinate2D) {
        self.coordinateRegion = .init(center: coordinate, span: self.coordinateRegion.span)
    }
    
    // 버튼 누를 때 자동으로 좌표 변하게 해주는 함수
    public func updateData() {
        if self.coordinateLattiArr.count > self.currentIndex + 1 {
            self.currentIndex = self.currentIndex + 1
        } else {
            self.currentIndex = 0
        }
        self.coordinateRegion = .init(center: self.coordinateLattiArr[self.currentIndex], span: self.coordinateRegion.span)
    }
}

// 실제 보이는 뷰
struct ContentView: View {
    // 뷰 모델 init
    @StateObject var viewModel : ContentViewModel = .init()
    var body: some View {
        VStack {
            // Map View에서 받는 값은 viewModel에 있는 coordinateRegion 변수이기 때문에 아래처럼 사용.
            TestMapView(coordinate: $viewModel.coordinateRegion).ignoresSafeArea(edges: .top).frame(height: 300)
            VStack(alignment: .leading) {
                Button(action: {
                    // viewModel.updateData() // viewModel의 좌표값을 변경해주는 함수를 호출.
                    // 아래는 latitude를 10씩 증가시키는 방식
                    viewModel.updateData(CLLocationCoordinate2D(latitude: viewModel.coordinateRegion.center.latitude + 10.0, longitude: viewModel.coordinateRegion.center.longitude))
                }, label: {
                    Text("Change Location")
                })
                Text(String(viewModel.coordinateRegion.center.latitude) + ", " + String(viewModel.coordinateRegion.center.longitude))
            }
            .padding()

            Spacer()
        }
    }
}

// 지도 보여지는 view
struct TestMapView: View {
    @Binding var coordinate: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $coordinate)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
