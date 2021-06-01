//
//  ContentView.swift
//  MVVMWeather
//
//  Created by Dannian Park on 2021/05/20.
//

//https://youtu.be/ak8x-p-q8tU

//https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,daily,minutely&lat=37.51237574844059&lon=127.02639947499482&unitsimperial&appid=1b3caafecf7848375ad99a84965244df
//https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,daily,minutely&lat=37.51237574844059&lon=127.02639947499482&unitsimperial&appid=7beec013582863f91d97c973be8f7cc2

//https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,daily,minutely&lat=37.51237574844059&lon=127.02639947499482&unitsimperial&appid=a25ffc3abde70c25f3d7f331151a9e3f

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.timezone)
                    .font(.system(size: 32))
                Text(viewModel.temp)
                    .font(.system(size: 44))
                Text(viewModel.title)
                    .font(.system(size: 24))
                Text(viewModel.descriptionText)
                    .font(.system(size: 24))
            }
            .navigationTitle("Weather MVVM")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
