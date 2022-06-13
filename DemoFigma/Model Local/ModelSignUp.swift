//
//  ModelDict.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import Foundation

struct ModelSignUp: Codable {
    var firstName = ""
    var lastName = ""
    var selectUserTpye = ""
    var emailAddress = ""
    var password = ""
    
    init(firstName: String = "", lastName: String = "", selectUserTpye: String = "", emailAddress: String = "", password: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.selectUserTpye = selectUserTpye
        self.emailAddress = emailAddress
        self.password = password
    }
    init() {
        let userDefault = UserDefaults.standard
        
        self.firstName = userDefault.value(forKey: "First Name") as? String ?? ""
        self.lastName = userDefault.value(forKey: "Last Name") as? String ?? ""
        self.selectUserTpye = userDefault.value(forKey: "Select User Type") as? String ?? ""
        self.emailAddress = userDefault.value(forKey: "E-mail Address") as? String ?? ""
        self.password = userDefault.value(forKey: "Password") as? String ?? ""
        
        
    }
}
