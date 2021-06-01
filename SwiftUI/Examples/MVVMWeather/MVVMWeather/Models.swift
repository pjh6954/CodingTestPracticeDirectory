//
//  Models.swift
//  MVVMWeather
//
//  Created by Dannian Park on 2021/05/20.
//

import Foundation

struct WeatherModel : Codable {
    let timezone : String
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let temp: Float
    let weather: [WeatherInfo]
}

struct WeatherInfo : Codable {
    let main: String
    let description: String
}
