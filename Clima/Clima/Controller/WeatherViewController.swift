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
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
            
            locationManager.requestLocation()
        
    }
    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
        
    }
    
}

//MARK: - UIText Field Delegate

extension WeatherViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.endEditing(true)
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            
            return true
            
        }else{
            
            textField.placeholder="Type something"
            return false
            
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let city = searchTextField.text
        weatherManager.fetchWeather(city: city!)
        searchTextField.text = ""
        
        
    }
    
    
}

//MARK: - Weather Manager Delegate
extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.conditionImageView.image = UIImage(systemName: weather.iconName)
            self.temperatureLabel.text = weather.tempString
            self.cityLabel.text = weather.city
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - Location Delegate
extension WeatherViewController: CLLocationManagerDelegate{
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitute: lon)
            
        }
    }
    
}
