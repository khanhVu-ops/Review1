//
//  ManagerLoctions.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/20/22.
//

import Foundation
import  UIKit
import CoreLocation
class ManagerUserDefault {
    static func checkSelectUserType(id: Int) -> Bool {
        if let data = UserDefaults.standard.data(forKey: "user_\(id)") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let model = try decoder.decode(ModelSignUp.self, from: data)
                print("User TYPE: \(model.selectUserTpye)")
                if model.selectUserTpye == "Premium" {
                    return true
                }else {
                    return false
                }
                
            } catch {
                print("Unable to Decode Note (\(error))")
                return false
            }
        }
        return false
    }
    
    static func getLocationUserDefaults(id: Int) -> [String] {
        return UserDefaults.standard.object(forKey: "myLocation_\(id)") as? [String] ?? []
        
    }
    
    static func setLocationUserDefault(id: Int, arrayLocation: [String]) {
        UserDefaults.standard.set(arrayLocation,forKey: "myLocation_\(id)")
    }
    
    static func getArrayLocation(deviceLocations: String, id: Int) -> [String]{
        var strings = getLocationUserDefaults(id: id)
        if deviceLocations != "" {
            strings.insert(deviceLocations, at: 0)
        }
        
        let resultLocation = strings
        return resultLocation
    }
    
    static func addLocationUserDefault(textLocation: String, id: Int) {
        var strings = ManagerUserDefault.getLocationUserDefaults(id: id)
        strings.append(textLocation)
        ManagerUserDefault.setLocationUserDefault(id: id, arrayLocation: strings)
    }
    
    static func getDataObjectUserDefault(id: Int, completitionHandler: ((ModelSignUp?, ModelSignUpError?)-> Void)?) {
        if let data = UserDefaults.standard.data(forKey: "user_\(id)") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let model = try decoder.decode(ModelSignUp.self, from: data)
//                print("first Name: \(model.firstName)")
                completitionHandler?(model, .none)
                
                
            } catch {
                print("Unable to Decode Note (\(error))")
                completitionHandler?(nil, .unowned)
            }
        }
        
    }
}
extension ManagerUserDefault {
    enum ModelSignUpError: Error {
        case unowned
    }
}
