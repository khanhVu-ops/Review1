//
//  HourCollectionViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/11/22.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbHour: UILabel!
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        // Initialization code
    }
    
    func configure(data: Forecast?, indexRow: Int, hour: Int) {
        let id = indexRow + hour
        var hour: String
        var temp: Double
        var imgStr:String
        if id < 24 {
            hour = data?.forecastday?[0].hour?[id].time ?? ""
            temp = data?.forecastday?[0].hour?[id].temp_c ?? 0
            imgStr = data?.forecastday?[0].hour?[id].condition?.icon ?? ""
        }else {
            hour = data?.forecastday?[1].hour?[id-24].time ?? ""
            temp = data?.forecastday?[1].hour?[id-24].temp_c ?? 0
            imgStr = data?.forecastday?[1].hour?[id-24].condition?.icon ?? ""
        }
        
        
        imgWeather.sd_setImage(with: URL(string: "https:" + imgStr), placeholderImage: UIImage(named: "PlaceHolder"))
        if indexRow == 0 {
            lbHour.text = "Now"
        }else {
            lbHour.text = Utilities.changeDate(hour, dateFormat: "yyyy-MM-dd HH:mm", format: "HH")
        }
        
        lbTemp.text = "\(Int(temp))°"
    }
}
