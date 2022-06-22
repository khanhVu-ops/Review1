//
//  SuggestionTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/20/22.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell {

    @IBOutlet weak var lbSuggestion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: NameCityModel?) {
        guard let name = data?.name, let country = data?.country else {
            return
        }
        lbSuggestion.text = "\(name), \(country)."
    }
    
}
