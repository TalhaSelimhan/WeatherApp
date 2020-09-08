//
//  CurrentWeatherHandler.swift
//  Clima
//
//  Created by Talha Selimhan on 23.08.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherControllerDelegate{
    func updateTheWeatherData(weather: CurrentWeatherHandler)
}

struct CurrentWeatherHandler: Codable {
    let weather: [Weather]?
    let main: Main?
    let name: String?
    func getTemprature() -> String? {
        if let temp = main?.temp {
            return String(format:"%.1f", temp - 273)

        } else {
            return nil
        }
    }
    
    func getConditionName() -> String {
        guard let id = weather?.first?.id else {
            print("Condition id not defined")
            return ""
        }
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            print("No match in condition switch")
            return "cloud"
        }
    }
}
