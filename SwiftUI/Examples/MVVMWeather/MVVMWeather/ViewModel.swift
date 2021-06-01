//
//  ViewModel.swift
//  MVVMWeather
//
//  Created by Dannian Park on 2021/05/20.
//

import Foundation

// data needed by view

class WeatherViewModel : ObservableObject {
    @Published var title: String = "-"
    @Published var descriptionText: String = "-"
    @Published var temp: String = "-"
    @Published var timezone: String = "-"
    
    init() {
        fetchWeather()
    }
    
    func fetchWeather() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?exclude=hourly,daily,minutely&lat=37.51237574844059&lon=127.02639947499482&unitsimperial&appid=7beec013582863f91d97c973be8f7cc2") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert data to model
            do {
                let model  = try JSONDecoder().decode(WeatherModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.title = model.current.weather.first?.main ?? "No Title"
                    self.descriptionText = model.current.weather.first?.description ?? "No Description"
                    self.temp = "\(model.current.temp)"
                    self.timezone = model.timezone
                }
            } catch {
                print("Failed")
            }
        }
        task.resume()
    }
}
