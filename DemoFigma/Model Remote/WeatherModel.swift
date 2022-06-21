//
//  WeatherModel.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/15/22.
//

import Foundation

class WeatherModel: NSObject, JsonInitObject {
    var location: LocationModel?
    var forecast: Forecast?
    var current: CurrentModel?
    
    convenience init(location: LocationModel?, forecast: Forecast?, current: CurrentModel?) {
        self.init()
        self.location = location
        self.forecast = forecast
        self.current = current
    }
    
    convenience required init(json: [String : Any]) {
        self.init()
        
        for (key, value) in json {
            if key == "location" , let wrapValue = value as? [String : Any] {
                let jsonValue = LocationModel(json: wrapValue)
                self.location = jsonValue
            }
            if key == "forecast" , let wrapValue = value as? [String : Any] {
                let jsonValue = Forecast(json: wrapValue)
                self.forecast = jsonValue
            }
            if key == "current" , let wrapValue = value as? [String : Any] {
                let jsonValue = CurrentModel(json: wrapValue)
                self.current = jsonValue
            }
        }
    }
}
