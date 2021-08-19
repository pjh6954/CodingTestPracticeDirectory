//
//  ContentView.swift
//  SwiftUIMapTestApp
//
//  Created by Dannian Park on 2021/07/23.
//

import SwiftUI
import UIKit
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
    //@ObservedObject var model : ContentViewModel = controller.viewModel
    
    //@ObservedObject var model : ContentViewModel
    
    /*
    init(_ viewModel : ContentViewModel) {
        self.model = viewModel
    }
    */
    
    @StateObject var viewModel : ContentViewModel = .init()
    
    var body: some View {
        VStack {
            /*
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            */
            
            //CircleImage()
            //    .offset(y: -130)
            //    .padding(.bottom, -130)
            TestMapView(coordinate: $viewModel.coordinateRegion).ignoresSafeArea(edges: .top).frame(height: 300)
            VStack(alignment: .leading) {
                Button(action: {
                    viewModel.updateData()
                }, label: {
                    Text("Change Location")
                })
                
                Text(String(viewModel.coordinateRegion.center.latitude) + ", " + String(viewModel.coordinateRegion.center.longitude))
                /*
                Text("Turtle Rock")
                    .font(.title)

                HStack {
                    Text("Joshua Tree National Park")
                    Spacer()
                    Text("California")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("About Turtle Rock")
                    .font(.title2)
                Text("Descriptive text goes here.")
                */
            }
            .padding()

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

