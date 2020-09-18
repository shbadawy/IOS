//
//  WeatherManager.swift
//  Clima
//
//  Created by Shimaa Badawy on 9/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    func fetchWeather (city : String ){
        
        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=761db22dd7c637b151192d302d1afcdb&units=metric"
        let completeURL = String ("\(baseUrl)&q=\(city)")
        
        if let url = URL(string: completeURL){
        
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handle(data:url:error:))
            
            task.resume()
            
        }
        
    }
    
    func handle(data:Data?, url:URLResponse?, error:Error?) {
        
        if error != nil {
            
            print(error!)
            return
            
        }
        if let safeData = data{
            
           
          parseData(weatherData: safeData)
            
        }
        
    }
    
    func parseData (weatherData:Data){
        
           let decoder = JSONDecoder()
           do {
               
               let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
               
           }catch{
               
               print(error)
               
           }
        
    }
    
    
    
}
