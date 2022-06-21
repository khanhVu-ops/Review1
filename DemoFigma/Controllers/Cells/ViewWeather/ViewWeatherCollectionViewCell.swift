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
    
    var weatherModel: WeatherModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
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
        tbvWeather.backgroundColor = .clear
        cltvHour.backgroundColor = .clear
        vTemp.backgroundColor = .clear
        vCity.backgroundColor = .clear
        
    }
    
    /// Resquest data from Api
    /// - Parameter city: Parameters
    func requestDataFromApi(city: String?) {
        
        APIUtilities.requestWeatherDataJson(city: city, completionHandler: { [weak self] data, error in
            guard let self = self else {
                return
                
            }
            guard let data = data, error == nil else {
                print("ERRORRR")
                return
            }
            self.weatherModel = data
            let city = self.weatherModel?.location?.name ?? ""
            self.lbNameCity.text = city
            let description = self.weatherModel?.current?.condition?.text ?? ""
            self.lbDescription.text = description
            let day = self.weatherModel?.forecast?.forecastday?[0].date ?? ""
            let temp_max = self.weatherModel?.forecast?.forecastday?[0].day?.maxtemp_c ?? 0
            let temp_min = self.weatherModel?.forecast?.forecastday?[0].day?.mintemp_c ?? 0
            self.lbDay.text = Utilities.changeDate(day, dateFormat: "yyyy-MM-dd", format: "EEEE")
            self.lbTempMax.text = "\(Int(temp_max))"
            self.lbTempMin.text = "\(Int(temp_min))"
            print("DATA: \(String(describing: self.weatherModel?.location?.country)))")
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
            return weatherModel?.forecast?.forecastday?.count ?? 0
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
            if let foreCast = weatherModel?.forecast {
                cell.configure(data: foreCast, index: indexPath.row)
            }
            tbvWeather.separatorStyle = .none
            return cell
            
        }else if indexPath.section == 1{
            let cell = tbvWeather.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as! DescriptionTableViewCell
            if let current = weatherModel?.current {
                cell.configure(data: current)
            }
            
            return cell
        }else {
            let cell = tbvWeather.dequeueReusableCell(withIdentifier: "CurrentTableViewCell", for: indexPath) as! CurrentTableViewCell
            if let current = weatherModel?.current, let forecast = weatherModel?.forecast {
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
        if weatherModel?.forecast?.forecastday?.count ?? 0 > 0 {
            return weatherModel?.forecast?.forecastday?[0].hour?.count ?? 0
        }else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cltvHour.dequeueReusableCell(withReuseIdentifier: "HourCollectionViewCell", for: indexPath) as! HourCollectionViewCell
        let indexHour = getIndexNextHour(forecast: weatherModel?.forecast, location: weatherModel?.location)
        let temp = weatherModel?.forecast?.forecastday?[0].hour?[indexHour].temp_c ?? 0
        lbTempAvg.text = "\(Int(temp))°"
        cell.configure(data: weatherModel?.forecast, indexRow: indexPath.row, hour: indexHour)
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



