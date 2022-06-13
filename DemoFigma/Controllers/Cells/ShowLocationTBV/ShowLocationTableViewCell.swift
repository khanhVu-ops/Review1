//
//  ShowLocationTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/13/22.
//

import UIKit

class ShowLocationTableViewCell: UITableViewCell {
    @IBOutlet weak var lbCurrentTime: UILabel!
    @IBOutlet weak var lbNameCity: UILabel!
    @IBOutlet weak var lbTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        
    }
    
}
