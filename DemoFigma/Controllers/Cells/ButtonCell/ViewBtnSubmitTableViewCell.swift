//
//  ViewBtnSubmitTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn


class ViewBtnSubmitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbFacebook: UILabel!
    @IBOutlet weak var vLoginFB: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    var placeHolder: [String] = []
    var controller = UIViewController()
    let signInConfig = GIDConfiguration(clientID: "9756767917-h2voeeek9pobvegib7sua592fennnvbq.apps.googleusercontent.com")
    
    var modelSignUp = ModelSignUp()
    let userDefault = UserDefaults.standard
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnSubmit.layer.cornerRadius = 20
        btnSubmit.layer.shadowOffset = CGSize(width: 0, height: 4)
        btnSubmit.layer.shadowColor = UIColor.gray.cgColor
        btnSubmit.layer.shadowOpacity = 0.3
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: "Notification", message: title, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        controller.present(alert, animated: true, completion: nil)
    }
    
    func checkTfFilled() -> Bool {
        for i in 0..<placeHolder.count {
            guard let text = UserDefaults.standard.value(forKey: placeHolder[i]) as? String else {
                return false
            }
            if text == "" {
                return false
            }
        }
        return true
    }
    
    func resetTextField() {
        for i in 0..<placeHolder.count {
            UserDefaults.standard.setValue("", forKey: placeHolder[i])
            
        }
    }
    
    func setDataUserDefault(object: ModelSignUp, id: Int) {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(object)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "user_\(id)")
            
        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    func setRootViewController() {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "BaseWeatherViewController")
        var array = controller.navigationController?.viewControllers
        
        array?.removeAll()
        
        array?.append(vc)
        controller.navigationController?.setViewControllers(array!, animated: true)
    }
    
    @IBAction func didTapBtnSubmit(_ sender: Any) {
        print("submit")
        controller.view.endEditing(true)
        if checkTfFilled() {
            print("Filled")
            modelSignUp = ModelSignUp()
            var id = 1
            if let idDefault = userDefault.value(forKey: "id") as? Int {
                id = idDefault + 1
                userDefault.setValue(id, forKey: "id")
                setDataUserDefault(object: modelSignUp, id: id)
            } else{
                userDefault.setValue(1, forKey: "id")
                setDataUserDefault(object: modelSignUp, id: id)
            }
            showAlert(title: "Register succesfully")
            resetTextField()
            print("ID: \(id)")
            
        }else {
            showAlert(title: "Please fill out all registration information.")
        }
        
        
    }
    
    @IBAction func didTapBtnLoginWithFB(_ sender: Any) {
        let loginManager = LoginManager()
        
        if let _ = AccessToken.current {
            //Log out fb
            
//            loginManager.logOut()
            print("Log out FB")
        } else {
            // Login Fb
            loginManager.logIn(permissions: [], from: controller) { [weak self] (result, error) in
                // Check for error
                guard error == nil else {
                    // Error occurred
                    print(error!.localizedDescription)
                    return
                }
                // Check for cancel
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                let id = AccessToken.current?.userID ?? ""
                UserDefaults.standard.setValue(-2, forKey: "active")
                // Login successfully
                self?.setRootViewController()
                
            }
            
        }
    }
    
    @IBAction func didTapBtnGoogle(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: controller) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            _ = user.profile?.email
            
            let fullName = user.profile?.name
            let id = user.userID
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            
            _ = user.profile?.imageURL(withDimension: 320)
            print("User id : \(String(describing: id))")
            print("Full name: \(String(describing: fullName))")
            print("Given Name: \(String(describing: givenName))")
            print("Family Name: \(String(describing: familyName))")
            
            UserDefaults.standard.setValue(-1, forKey: "active")
            self.setRootViewController()
        }
    }
}
