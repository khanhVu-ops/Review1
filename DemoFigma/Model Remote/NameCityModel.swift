//
//  NameCityModel.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/15/22.
//

import Foundation

class NameCityModel: NSObject, JsonInitObject {
    var id: Int?
    var name: String?
    var region: String?
    var country: String?
    var lat: Double?
    var lon: Double?
    var url: String?
    
    convenience init(id: Int?,
                     name: String?,
                     region: String?,
                     country: String?,
                     lat: Double?,
                     lon: Double?,
                     url: String?) {
        self.init()
        
        self.id = id
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
        self.url = url
    }
    required convenience init(json: [String : Any]) {
        self.init()
        
        for (key, value) in json {
            if key == "id", let wrapValue = value as? Int {
                let jsonValue = wrapValue
                self.id = jsonValue
            }
            if key == "name", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.name = jsonValue
            }
            if key == "region", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.region = jsonValue
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
            if key == "url", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.url = jsonValue
            }
        }
    }

}
