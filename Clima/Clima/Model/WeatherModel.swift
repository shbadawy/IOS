//
//  WeatherModel.swift
//  Clima
//
//  Created by Shimaa Badawy on 9/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    var id:Int
    var city:String
    var temp:Double
    var tempString:String{return String(format: "%.1f", temp)}
    
    var iconName:String {
        
        switch id {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
        
    }
    
}
