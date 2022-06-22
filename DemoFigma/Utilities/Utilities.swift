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
    static func emailIsValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
   

}
