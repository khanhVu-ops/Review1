//
//  LocationModel.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/8/22.
//

import Foundation

class LocationModel: NSObject, JsonInitObject {
    var name: String?
    var country: String?
    var lat: Double?
    var lon: Double?
    var local_time: String?
    
    convenience init(name: String?, country: String?, lat: Double?, lon: Double?, local_time: String?) {
        self.init()
        self.name = name
        self.country = country
        self.lat = lat
        self.lon = lon
        self.local_time = local_time
    }
    
    required convenience init(json: [String : Any]) {
        self.init()
        for (key,value) in json {
            if key == "name", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.name = jsonValue
            }
            if key == "country", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.country = jsonValue
            }
            if key == "lat", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.lat = jsonValue
            }
            if key == "lon", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.lon = jsonValue
            }
            if key == "localtime", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.local_time = jsonValue
            }
        }
    }
    
    
}
