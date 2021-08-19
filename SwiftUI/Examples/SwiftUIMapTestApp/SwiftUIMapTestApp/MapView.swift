//
//  MapView.swift
//  SwiftUIMapTestApp
//
//  Created by Dannian Park on 2021/07/23.
//

import SwiftUI
import MapKit

/*
struct MapView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
*/

struct TestMapView: View {
    @Binding var coordinate: MKCoordinateRegion {
        didSet {
            print("NEW VALUE : \(coordinate)")
        }
    }
    
    var body: some View {
        Map(coordinateRegion: $coordinate)//.ignoresSafeArea(edges: .top)//.frame(height: 250)
    }
}
/*
struct TestMapView_Previews: PreviewProvider {
    static var previews: some View {
        TestMapView(coordinate: MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
                        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        )
    }
}
*/
