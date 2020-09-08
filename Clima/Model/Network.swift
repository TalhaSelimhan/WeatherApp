//
//  Network.swift
//  Clima
//
//  Created by Talha Selimhan on 23.08.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

class Network {
    
    var weatherDelegate: WeatherControllerDelegate?
    
    func getWeatherData(_ cityName: String?) {
        guard let cityName = cityName else {
            return
        }
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=96be0a06cfffd296cba1a2413113a735") else {
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let x = try JSONDecoder().decode(CurrentWeatherHandler.self, from: data)
                    self.weatherDelegate?.updateTheWeatherData(weather: x)
                } catch {
                    print("error")
                }
            } else {
                print(error as Any)
            }
        }
        task.resume()
        
    }
    
    func getWeatherData(_ coordinate: CLLocationCoordinate2D?) {
        guard let lat = coordinate?.latitude else {
            return
        }
        guard let lon = coordinate?.longitude else {
            return
        }
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=96be0a06cfffd296cba1a2413113a735") else {
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let x = try JSONDecoder().decode(CurrentWeatherHandler.self, from: data)
                    self.weatherDelegate?.updateTheWeatherData(weather: x)
                } catch {
                    print("error")
                }
            } else {
                print(error as Any)
            }
        }
        task.resume()
        
    }
    
    func getWeatherURL(_ cityName: String?) -> URLRequest {
        if let cityName = cityName {
            return URLRequest(url: URL(string: "https://samples.openweathermap.org/data/2.5/weather?q=\(cityName),uk&appid=439d4b804bc8187953eb36d2a8c26a02#")! )
        } else {
            return URLRequest(url: URL(string: "www.google.com.tr")!)
        }
    }
}
