//
//  CurrentModel.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/8/22.
//

import Foundation

class CurrentModel: NSObject, JsonInitObject {
    var last_updated: String?
    var temp_c: Double?
    var temp_f: Double?
    var condition: Condition?
    var wind_mph: Double?
    var wind_kph: Double?
    var wind_degree: Int?
    var wind_dir: String?
    var pressure_mb: Double?
    var pressure_in: Double?
    var precip_mm: Double?
    var precip_in: Double?
    var humidity: Double?
    var cloud: Double?
    var feelslike_c: Double?
    var feelslike_f: Double?
    var vis_km: Double?
    var vis_miles: Double?
    var uv: Double?
    var gust_mph: Double?
    var gust_kph: Double?
    
    convenience init(last_updated: String?,
                     temp_c: Double?,
                     temp_f: Double?,
                     condition: Condition?,
                     wind_mph: Double?,
                     wind_kph: Double?,
                     wind_degree: Int?,
                     wind_dir: String,
                     pressure_mb: Double?,
                     pressure_in: Double?,
                     precip_mm: Double?,
                     precip_in: Double?,
                     humidity: Double?,
                     cloud: Double?,
                     feelslike_c: Double?,
                     feelslike_f: Double?,
                     vis_km: Double?,
                     vis_miles: Double?,
                     uv: Double?,
                     gust_mph: Double?,
                     gust_kph: Double?
                     ) {
        
        self.init()
        
        self.last_updated = last_updated
        self.temp_c = temp_c
        self.temp_f = temp_f
        self.condition = condition
        self.wind_mph = wind_mph
        self.wind_kph = wind_kph
        self.wind_degree = wind_degree
        self.wind_dir = wind_dir
        self.pressure_mb = pressure_mb
        self.pressure_in = pressure_in
        self.precip_mm = precip_mm
        self.precip_in = precip_in
        self.humidity = humidity
        self.cloud = cloud
        self.feelslike_c = feelslike_c
        self.feelslike_f = feelslike_f
        self.vis_km = vis_km
        self.vis_miles = vis_miles
        self.uv = uv
        self.gust_mph = gust_mph
        self.gust_kph = gust_kph
    }
    required convenience init(json: [String : Any]) {
        self.init()
        for (key, value) in json {
            if key == "last_updated", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.last_updated = jsonValue
            }
            if key == "temp_c", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.temp_c = jsonValue
            }
            if key == "temp_f", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.temp_f = jsonValue
            }
            if key == "condition", let wrapValue = value as? [String: Any]{
                let jsonValue = Condition(json: wrapValue)
                self.condition = jsonValue
            }
            if key == "wind_mph", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.wind_mph = jsonValue
            }
            if key == "wind_kph", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.wind_kph = jsonValue
            }
            if key == "wind_degree", let wrapValue = value as? Int {
                let jsonValue = wrapValue
                self.wind_degree = jsonValue
            }
            if key == "wind_dir", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.wind_dir = jsonValue
            }
            if key == "pressure_mb", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.pressure_mb = jsonValue
            }
            if key == "pressure_in", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.pressure_in = jsonValue
            }
            if key == "precip_mm", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.precip_mm = jsonValue
            }
            
            if key == "precip_in", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.precip_in = jsonValue
            }
            if key == "humidity", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.humidity = jsonValue
            }
            if key == "cloud", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.cloud = jsonValue
            }
            if key == "feelslike_c", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.feelslike_c = jsonValue
            }
            if key == "feelslike_f", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.feelslike_f = jsonValue
            }
            if key == "vis_km", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.vis_km = jsonValue
            }
            if key == "vis_miles", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.vis_miles = jsonValue
            }
            if key == "uv", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.uv = jsonValue
            }
            if key == "gust_mph", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.gust_mph = jsonValue
            }
            if key == "gust_kph", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.gust_kph = jsonValue
            }
            
        }
    }
}

class Condition {
    var text: String?
    var icon: String?
    var code: Int?
    
    convenience init(text: String?, icon: String?, code: Int?) {
        self.init()
        self.text = text
        self.icon = icon
        self.code = code
    }
    convenience init(json: [String : Any]) {
        self.init()
        for (key, value) in json {
            if key == "text", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.text = jsonValue
            }
            if key == "icon", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.icon = jsonValue
            }
            if key == "code", let wrapValue = value as? Int {
                let jsonValue = wrapValue
                self.code = jsonValue
            }
        }
    }
}
