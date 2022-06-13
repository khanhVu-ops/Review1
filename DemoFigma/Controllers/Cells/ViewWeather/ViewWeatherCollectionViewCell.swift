//
//  ViewWeatherCollectionViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/10/22.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class ViewWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tbvWeather: UITableView!
    @IBOutlet weak var cltvHour: UICollectionView!
    @IBOutlet weak var vTemp: UIView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbTempMax: UILabel!
    @IBOutlet weak var lbTempMin: UILabel!
    @IBOutlet weak var lbTempAvg: UILabel!
    @IBOutlet weak var vCity: UIView!
    @IBOutlet weak var lbNameCity: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
   
    
    var locationData: LocationModel?
    var currentData: CurrentModel?
    var forecastData: Forecast?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tbvWeather.backgroundColor = .clear
        cltvHour.backgroundColor = .clear
        vTemp.backgroundColor = .clear
        vCity.backgroundColor = .clear
        
        setUpView()
    }
    
    func setUpView() {
        
        
        cltvHour.register(UINib(nibName: "HourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HourCollectionViewCell")
        cltvHour.dataSource = self
        cltvHour.delegate = self
        
        tbvWeather.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        tbvWeather.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        tbvWeather.register(UINib(nibName: "CurrentTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrentTableViewCell")
        
        tbvWeather.delegate = self
        tbvWeather.dataSource = self
    }
    
    /// Resquest data from Api
    /// - Parameter city: Parameters
    func requestDataFromApi(city: String?) {
        
        APIUtilities.requestLocationDataJson(city: city, completionHandler: { [weak self] data, error in
            guard let self = self else {
                return
                
            }
            guard let data = data, error == nil else {
                print("ERRORRR")
                return
            }
            self.locationData = data
            let city = self.locationData?.name ?? ""
            self.lbNameCity.text = city
            print("DATA: \(String(describing: self.locationData?.name)))")
            DispatchQueue.main.async {
                self.tbvWeather.reloadData()
                self.cltvHour.reloadData()
            }
        })
        APIUtilities.requestCurrentDataJson(city: city, completionHandler: { [weak self] data, error in
            guard let self = self else {
                return
                
            }
            guard let data = data, error == nil else {
                print("ERRORRR")
                return
            }
            self.currentData = data
            let description = self.currentData?.condition?.text ?? ""
            self.lbDescription.text = description
            
            print("CURRENT DATA: \(String(describing: self.currentData?.last_updated))")
            DispatchQueue.main.async {
                self.tbvWeather.reloadData()
                self.cltvHour.reloadData()
            }
        })
        APIUtilities.requestForeCastDataJson(city: city, completionHandler: { [weak self] data, error in
            guard let self = self else {
                return

            }
            guard let data = data, error == nil else {
                print("ERRORRR")
                return
            }
            self.forecastData = data
            let day = self.forecastData?.forecastday?[0].date ?? ""
            let temp_max = self.forecastData?.forecastday?[0].day?.maxtemp_c ?? 0
            let temp_min = self.forecastData?.forecastday?[0].day?.mintemp_c ?? 0
            self.lbDay.text = Utilities.changeDate(day, dateFormat: "yyyy-MM-dd", format: "EEEE")
            self.lbTempMax.text = "\(Int(temp_max))"
            self.lbTempMin.text = "\(Int(temp_min))"
            print("CURRENT DATA: \(String(describing: self.forecastData?.forecastday?[0].date))")
            DispatchQueue.main.async {
                self.tbvWeather.reloadData()
                self.cltvHour.reloadData()
            }
        })
        
    }
    
    /// Get index current hour 
    /// - Parameters:
    ///   - forecast: ForecastData
    ///   - location: LocationData
    /// - Returns: index  current hour
    func getIndexNextHour(forecast: Forecast?, location: LocationModel?) -> Int {
        var index_hour = 0
        let local_time = location?.local_time ?? ""
        if forecast?.forecastday?.count ?? 0 > 0 {
            for i in 1..<24 {
                let nextHour = forecast?.forecastday?[0].hour?[i].time ?? ""
                if local_time < nextHour {
                    index_hour = i - 1
                    break
                }
            }
        }
        
        return index_hour
    }
}

extension ViewWeatherCollectionViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return forecastData?.forecastday?.count ?? 0
        }else if section == 1 {
            return 1
        }else if section == 2 {
            return 5
        }else {
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tbvWeather.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
            if let foreCast = forecastData {
                cell.configure(data: foreCast, index: indexPath.row)
            }
            tbvWeather.separatorStyle = .none
            return cell
            
        }else if indexPath.section == 1{
            let cell = tbvWeather.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
            if let current = currentData {
                cell.configure(data: current)
            }
            
            return cell
        }else {
            let cell = tbvWeather.dequeueReusableCell(withIdentifier: "CurrentTableViewCell", for: indexPath) as! CurrentTableViewCell
            if let current = currentData, let forecast = forecastData {
                switch indexPath.row {
                case 0:
                    cell.vLine.isHidden = true
                    cell.configure(firstKey: "Sunrise", firstValue: forecast.forecastday?[0].astro?.sunrise, secondKey: "Sunset", secondValue: forecast.forecastday?[0].astro?.sunset, value1: "", value2: "")
                case 1:
                    cell.configure(firstKey: "Posibility of rain", firstValue: forecast.forecastday?[0].day?.daily_chance_of_rain, secondKey: "Humidity", secondValue: current.humidity, value1: "%", value2: "%")
                case 2:
                    cell.configure(firstKey: "Wind", firstValue: forecast.forecastday?[0].day?.maxwind_mph, secondKey: "Feelslike", secondValue: current.feelslike_c, value1: " km/h", value2: "°")
                case 3:
                    cell.configure(firstKey: "Precip", firstValue: forecast.forecastday?[0].day?.totalprecip_mm, secondKey: "Pressure", secondValue: current.pressure_mb, value1: " cm", value2: " hPa")
                default:
                    cell.configure(firstKey: "Foresight", firstValue: current.vis_km, secondKey: "UV", secondValue: current.uv, value1: " km", value2: "")
                    break
                }
            }
            return cell
        }
        
    }
    
    
}
extension ViewWeatherCollectionViewCell: UITableViewDelegate {

}
extension ViewWeatherCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if forecastData?.forecastday?.count ?? 0 > 0 {
            return forecastData?.forecastday?[0].hour?.count ?? 0
        }else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cltvHour.dequeueReusableCell(withReuseIdentifier: "HourCollectionViewCell", for: indexPath) as! HourCollectionViewCell
        let indexHour = getIndexNextHour(forecast: forecastData, location: locationData)
        let temp = forecastData?.forecastday?[0].hour?[indexHour].temp_c ?? 0
        lbTempAvg.text = "\(Int(temp))°"
        cell.configure(data: forecastData,indexRow: indexPath.row, hour: indexHour)
        return cell
    }
    
    
}
extension ViewWeatherCollectionViewCell: UICollectionViewDelegate {
    
}
extension ViewWeatherCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cltvHour.frame.width/5, height: self.cltvHour.frame.height)
    }
}



