//
//  DescriptionTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/10/22.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var lbDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = . clear
        lbDescription.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: CurrentModel) {
        let text = data.condition?.text ?? ""
        lbDescription.text = "Today: \(text) \(text) \(text) \(text) \(text) \(text) \(text) \(text) \(text) \(text) \(text) \(text) \(text) \(text) \(text) \(text)"
    }
    
}
