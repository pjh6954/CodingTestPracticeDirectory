//
//  TESTCODE.swift
//  SwiftUIMapTestApp
//
//  Created by Dannian Park on 2021/07/23.
//
// Git lab 업로드 용

import SwiftUI
import MapKit

class ContentViewModel : ObservableObject {
    @Published var coordinateRegion : MKCoordinateRegion = MKCoordinateRegion(center: .init(latitude: 37.55873565341439, longitude: 127.01839896779809), span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    public var returnValueLat : CLLocationDegrees {
        self.coordinateRegion.center.latitude
    }
    private var currentIndex : Int = 0
    private var coordinateLattiArr : [CLLocationCoordinate2D] = [.init(latitude: 37.54441902112603, longitude: 127.09999925662044), .init(latitude: 37.52174331346211, longitude: 127.10868982573317), .init(latitude: 37.460024197357185, longitude: 127.12646483782926)]
    
    public func updateData(_ coordinate : CLLocationCoordinate2D) {
        self.coordinateRegion = .init(center: coordinate, span: self.coordinateRegion.span)
    }
    
    public func updateData() {
        if self.coordinateLattiArr.count > self.currentIndex + 1 {
            self.currentIndex = self.currentIndex + 1
        } else {
            self.currentIndex = 0
        }
        self.coordinateRegion = .init(center: self.coordinateLattiArr[self.currentIndex], span: self.coordinateRegion.span)
    }
}

struct ContentView: View {
    @StateObject var viewModel : ContentViewModel = .init()
    var body: some View {
        VStack {
            TestMapView(coordinate: $viewModel.coordinateRegion).ignoresSafeArea(edges: .top).frame(height: 300)
            VStack(alignment: .leading) {
                Button(action: {
                    viewModel.updateData()
                }, label: {
                    Text("Change Location test")
                })
                Text(String(viewModel.coordinateRegion.center.latitude) + ", " + String(viewModel.coordinateRegion.center.longitude))
            }
            .padding()

            Spacer()
        }
    }
}

struct TestMapView: View {
    @Binding var coordinate: MKCoordinateRegion {
        didSet {
            print("NEW VALUE : \(coordinate)")
        }
    }
    
    var body: some View {
        Map(coordinateRegion: $coordinate)
    }
}
