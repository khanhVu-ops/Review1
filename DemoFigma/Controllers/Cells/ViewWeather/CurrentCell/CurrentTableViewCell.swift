//
//  CurrentTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/10/22.
//

import UIKit

class CurrentTableViewCell: UITableViewCell {
    @IBOutlet weak var lbFirstKey: UILabel!
    @IBOutlet weak var lbFirstValue: UILabel!
    @IBOutlet weak var lbSecondKey: UILabel!
    @IBOutlet weak var lbSecondValue: UILabel!
    @IBOutlet weak var vLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        lbFirstKey.backgroundColor = .clear
        lbSecondKey.backgroundColor = .clear
        lbFirstValue.backgroundColor = .clear
        lbSecondValue.backgroundColor = .clear

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(firstKey: String?, firstValue: Any?, secondKey: String?, secondValue: Any?, value1: String, value2: String) {
        let firstKey = firstKey ?? ""
        let firstValue = firstValue ?? ""
        let secondKey = secondKey ?? ""
        let secondValue = secondValue ?? ""
        
        lbSecondValue.text = "\(secondValue)\(value2)"
        lbFirstKey.text = firstKey
        lbFirstValue.text = "\(firstValue)\(value1)"
        lbSecondKey.text = secondKey
        
    }
    
}
