//
//  WeatherTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/8/22.
//

import UIKit


class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lbTempMax: UILabel!
    @IBOutlet weak var lbTempMin: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: Forecast, index: Int) {
        let tempMax = data.forecastday?[index].day?.maxtemp_c ?? 0
        let tempMin = data.forecastday?[index].day?.mintemp_c ?? 0
        let date = data.forecastday?[index].date ?? ""
        let img = data.forecastday?[index].day?.condition?.icon ?? ""
        let imgStr = "https:"+img
        
        imgWeather.sd_setImage(with: URL(string: imgStr), placeholderImage: UIImage(named: "PlaceHolder"))
        lbName.text = Utilities.changeDate(date,dateFormat: "yyyy-MM-dd", format: "EEEE")
        lbTempMax.text = "\(Int(tempMax))"
        lbTempMin.text = "\(Int(tempMin))"
    }
    
    
}
