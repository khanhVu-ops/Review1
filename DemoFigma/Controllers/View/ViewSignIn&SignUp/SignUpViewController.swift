//
//  SignUpViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    let arrayPlaceHolder = ["First Name", "Last Name", "Select User Type", "E-mail Address", "Password"]
    
    var widthDevice: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = AccessToken.current,!token.isExpired {
            setRootViewController()
            print("CUREENT FB: \(token)")
        }
        if GIDSignIn.sharedInstance.currentUser != nil {
            setRootViewController()
            print("CUREENT GG: aa")
        }
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:))))
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // Register Cell
        myTableView.register(UINib(nibName: "ViewTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewTextFieldTableViewCell")
        myTableView.register(UINib(nibName: "ViewBtnSubmitTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewBtnSubmitTableViewCell")
        
    }
    override func viewWillLayoutSubviews() {
        widthDevice = Float(self.view.frame.width)
//        print("WIDTH: \(widthDevice)")
    }
    func setRootViewController() {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = st.instantiateViewController(withIdentifier: "BaseWeatherViewController") as! BaseWeatherViewController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

extension SignUpViewController: UITableViewDelegate {
    
    
}
extension SignUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cell TextField
        let cell = myTableView.dequeueReusableCell(withIdentifier: "ViewTextFieldTableViewCell", for: indexPath) as! ViewTextFieldTableViewCell
        if indexPath.row < 5 {
            let data = arrayPlaceHolder[indexPath.row]
            cell.setPlaceHolder(string: data)
            cell.controller = self
            if indexPath.row == 2 {
                cell.addBtnPopover(width: widthDevice)
            }else if indexPath.row == 4 {
                cell.setSecureTextEntry(isSecure: true)
                cell.addBtnShowPassword(width: widthDevice)
            }
        }
        else if indexPath.row == 5 {
            
            // Cell buttons
            let cell = myTableView.dequeueReusableCell(withIdentifier: "ViewBtnSubmitTableViewCell", for: indexPath) as! ViewBtnSubmitTableViewCell
            cell.controller = self
            cell.placeHolder = arrayPlaceHolder
            
            return cell
        }
        return cell
        
        
    }
}

extension SignUpViewController: UITextFieldDelegate {
    //Estimated
}


