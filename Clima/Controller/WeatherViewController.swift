//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    private var network = Network()
    var weatherData: CurrentWeatherHandler? {
        didSet {
            if weatherData?.getTemprature() == nil {
                return
            }
            DispatchQueue.main.async {
                self.temperatureLabel.text = self.weatherData?.getTemprature()
                self.cityLabel.text = self.weatherData?.name
                self.conditionImageView.image = UIImage(systemName: self.weatherData?.getConditionName() ?? "cloud")
            }
        }
    }
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        searchTextField.delegate = self
        network.weatherDelegate = self
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        weatherRequest(searchTextField.text)	
        searchTextField.endEditing(true )
    }
}

// MARK: - Text Field Delegate

extension WeatherViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherRequest(searchTextField.text)
        searchTextField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
}

// MARK: - Network

extension WeatherViewController {
    func weatherRequest(_ key: String?) {
        guard let key = key else {
            return
	        }
        network.getWeatherData(key)
    }
}

// MARK: - Weather Controller Delegate

extension WeatherViewController: WeatherControllerDelegate {
    func updateTheWeatherData(weather: CurrentWeatherHandler) {
        weatherData = weather
    }
}

// MARK: - Location Manager Delegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        let coordinate = locations.last?.coordinate
        network.getWeatherData(coordinate)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
