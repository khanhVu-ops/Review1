//
//  ForecastModel.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/8/22.
//

import Foundation

class Forecast: NSObject, JsonInitObject {
    var forecastday: [ForeCastModel]?
    
    convenience init(forecastday: [ForeCastModel]?) {
        self.init()
        self.forecastday = forecastday
    }
    
    required convenience init(json: [String : Any]) {
        self.init()
        for (key, value) in json {
            if key == "forecastday", let wrapValue = value as? [[String : Any]] {
                let jsonValue = wrapValue.map({ ForeCastModel(json: $0)})
                self.forecastday = jsonValue
            }
        }
    }
}
class ForeCastModel {
    var date: String?
    var day: Day?
    var astro: Astro?
    var hour: [Hour]?
    
    
    convenience init(date: String?,
                     day: Day?,
                     astro: Astro?,
                     hour: [Hour]?) {
        
        self.init()
        self.date = date
        self.day = day
        self.astro = astro
        self.hour = hour
    }
    convenience init(json: [String: Any]) {
        self.init()
        for (key, value) in json {
            if key == "date", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.date = jsonValue
            }
            if key == "day", let wrapValue = value as? [String : Any] {
                let jsonValue = Day(json: wrapValue)
                self.day = jsonValue
            }
            if key == "astro", let wrapValue = value as? [String : Any] {
                let jsonValue = Astro(json: wrapValue)
                self.astro = jsonValue
            }
            if key == "hour", let wrapValue = value as? [[String: Any]]{
                let jsonValue = wrapValue.map({ Hour(json: $0)})
                self.hour = jsonValue
            }
        }
    }
}

class Day {
    var maxtemp_c: Double?
    var maxtemp_f: Double?
    var mintemp_c: Double?
    var mintemp_f: Double?
    var avgtemp_c: Double?
    var avgtemp_f: Double?
    var maxwind_mph: Double?
    var avgvis_km: Double?
    var avgvis_miles: Double?
    var avghumidity: Double?
    var daily_chance_of_rain: Int?
    var condition: Condition?
    var uv: Double?
    var totalprecip_mm: Double?
    convenience init(maxtemp_c: Double?,
                     maxtemp_f: Double?,
                     condition: Condition?,
                     mintemp_c: Double?,
                     mintemp_f: Double?,
                     avgtemp_c: Double?,
                     avgtemp_f: Double?,
                     maxwind_mph: Double?,
                     avgvis_km: Double?,
                     avgvis_miles: Double?,
                     avghumidity: Double?,
                     daily_chance_of_rain: Int?,
                     totalprecip_mm: Double?,
                     uv: Double?) {
        
        self.init()
        
        self.maxtemp_c = maxtemp_c
        self.maxtemp_f = maxtemp_f
        self.condition = condition
        self.mintemp_c = mintemp_c
        self.mintemp_f = mintemp_f
        self.avgtemp_c = avgtemp_c
        self.avgtemp_f = avgtemp_f
        self.maxwind_mph = maxwind_mph
        self.avgvis_km = avgvis_km
        self.avgvis_miles = avgvis_miles
        self.avghumidity = avghumidity
        self.daily_chance_of_rain = daily_chance_of_rain
        self.totalprecip_mm = totalprecip_mm
        self.uv = uv
    }
    convenience init(json: [String : Any]) {
        self.init()
        for (key, value) in json {
            if key == "maxtemp_c", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.maxtemp_c = jsonValue
            }
            if key == "maxtemp_f", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.maxtemp_f = jsonValue
            }
            if key == "mintemp_c", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.mintemp_c = jsonValue
            }
            if key == "condition", let wrapValue = value as? [String: Any]{
                let jsonValue = Condition(json: wrapValue)
                self.condition = jsonValue
            }
            if key == "mintemp_f", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.mintemp_f = jsonValue
            }
            if key == "avgtemp_c", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.avgtemp_c = jsonValue
            }
            if key == "avgtemp_f", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.avgtemp_f = jsonValue
            }
            if key == "maxwind_mph", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.maxwind_mph = jsonValue
            }
            if key == "avgvis_km", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.avgvis_km = jsonValue
            }
            if key == "avgvis_miles", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.avgvis_miles = jsonValue
            }
            if key == "avghumidity", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.avghumidity = jsonValue
            }
            if key == "uv", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.uv = jsonValue
            }
            if key == "daily_chance_of_rain", let wrapValue = value as? Int {
                let jsonValue = wrapValue
                self.daily_chance_of_rain = jsonValue
            }
            if key == "totalprecip_mm", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.totalprecip_mm = jsonValue
            }
        }
    }
    
}
class Astro {
    var sunrise: String?
    var sunset: String?
    var moonrise: String?
    var moonset: String?
    var moon_phase: String?
    var moon_illumination: String?

    convenience init(sunrise: String?,
                     sunset: String?,
                     moonrise: String?,
                     moonset: String?,
                     moon_phase: String?,
                     moon_illumination: String?) {
        
        self.init()
        
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moonset = moonset
        self.moon_phase = moon_phase
        self.moon_illumination = moon_illumination
    }
    convenience init(json: [String : Any]) {
        self.init()
        for (key, value) in json {
            if key == "sunrise", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.sunrise = jsonValue
            }
            if key == "sunset", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.sunset = jsonValue
            }
            if key == "moonrise", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.moonrise = jsonValue
            }
            if key == "moonset", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.moonset = jsonValue
            }
            if key == "moon_phase", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.moon_phase = jsonValue
            }
            if key == "moon_illumination", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.moon_illumination = jsonValue
            }
        }
    }
}
class Hour {
    var time: String?
    var temp_c: Double?
    var temp_f: Double?
    var condition: Condition?
    var wind_mph: Double?
    var wind_kph: Double?
    var pressure_mb: Double?
    var humidity: Double?
    var cloud: Int?
    var feelslike_c: Double?
    var feelslike_f: Double?
    var vis_km: Double?
    var uv: Double?
    
    convenience init(time: String?,
                     temp_c: Double?,
                     temp_f: Double?,
                     condition: Condition?,
                     wind_mph: Double?,
                     wind_kph: Double?,
                     pressure_mb: Double?,
                     humidity: Double?,
                     cloud: Int?,
                     feelslike_c: Double?,
                     feelslike_f: Double?,
                     vis_km: Double?,
                     uv: Double?) {
        
        self.init()
        
        self.time = time
        self.temp_c = temp_c
        self.temp_f = temp_f
        self.condition = condition
        self.wind_mph = wind_mph
        self.wind_kph = wind_kph
        self.pressure_mb = pressure_mb
        self.humidity = humidity
        self.cloud = cloud
        self.feelslike_c = feelslike_c
        self.feelslike_f = feelslike_f
        self.vis_km = vis_km
        self.uv = uv
    }
    convenience init(json: [String : Any]) {
        self.init()
        for (key, value) in json {
            if key == "time", let wrapValue = value as? String {
                let jsonValue = wrapValue
                self.time = jsonValue
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
            if key == "pressure_mb", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.pressure_mb = jsonValue
            }
            if key == "humidity", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.humidity = jsonValue
            }
            if key == "cloud", let wrapValue = value as? Int {
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
            if key == "uv", let wrapValue = value as? Double {
                let jsonValue = wrapValue
                self.uv = jsonValue
            }
        }
    }
}
