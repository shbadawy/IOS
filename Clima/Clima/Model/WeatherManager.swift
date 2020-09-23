//
//  WeatherManager.swift
//  Clima
//
//  Created by Shimaa Badawy on 9/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather( _ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError (error: Error)
}

struct WeatherManager {
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=$TOKEN&units=metric"
    var delegate:WeatherManagerDelegate?
    
    func fetchWeather (city : String ){
        
        let completeURL = String ("\(baseUrl)&q=\(city)")
        performRequest(with: completeURL)
        
    }
    
    func fetchWeather (latitude: CLLocationDegrees , longitute: CLLocationDegrees ){
        
        let completeURL = String ("\(baseUrl)&lat=\(latitude)&lon=\(longitute)")
        performRequest(with: completeURL)
        
    }
    
    func parseData (_ weatherData:Data) -> WeatherModel? {
        
           let decoder = JSONDecoder()
           do {
               
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let city = decodedData.name
            
                let weather = WeatherModel(id: id, city: city, temp: temp)
                return weather
            
           }catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    func performRequest(with completeURL:String) {
        
        if let url = URL(string: completeURL){
        
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: {(data, url, error) in
                
                
                if error != nil {
                    
                    self.delegate?.didFailWithError(error: error!)
                    return
                    
                }
                if let safeData = data{
                    if let weather = self.parseData(safeData){
                        self.delegate?.didUpdateWeather(self , weather: weather)
                        
                    }
                    
                }
                
            })
            
            task.resume()
    }
   
    
}
}
