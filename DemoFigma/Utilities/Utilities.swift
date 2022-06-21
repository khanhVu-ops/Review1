//
//  Utilities.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/10/22.
//

import Foundation
import SDWebImage

class Utilities {
    static func loadImage(_ imv: UIImageView, strURL: String, placeHolder: UIImage?) {
        //        imv.sd_setImage(with: URL(string: strURL), placeholderImage: placeHolder)
        
        let url = URL(string: strURL)
        imv.sd_setImage(with: url, placeholderImage: placeHolder) { image, error, cacheType, url in
            if let downLoadedImage = image {
                if cacheType == .none {
                    imv.alpha = 0
                    UIView.transition(with: imv, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        imv.image = downLoadedImage
                        imv.alpha = 1
                    }, completion: nil)
                    
                }
            } else {
                imv.image = placeHolder
            }
        }
    }
    static func changeDate(_ mydate:String, dateFormat: String, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = dateFormat
        guard let convertedDate = dateFormatter.date(from: mydate) else {
            return ""
        }
        dateFormatter.dateFormat = format
        let date = dateFormatter.string(from: convertedDate)
        return date
    }
    
    static func setRootViewController(controller: UIViewController, to destination: UIViewController) {
        var array = controller.navigationController?.viewControllers
        
        array?.removeAll()
        
        array?.append(destination)
        controller.navigationController?.setViewControllers(array!, animated: true)
        
    }
    

}
