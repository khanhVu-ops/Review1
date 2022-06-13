//
//  NewViewSignInViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit


class SignInViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var vEmail: UIView!
    @IBOutlet weak var vPassword: UIView!
    
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    var stEmail = ""
    var stPassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing(_:))))

        if let check = UserDefaults.standard.value(forKey: "active") as? Int{
            print("Current: \(check)")
            if check != 0 {
                setRootViewController()
            }
            
        } else {
            UserDefaults.standard.setValue(0, forKey: "active")
        }
        setUpUI()
        tfPassword.delegate = self
        tfEmail.delegate = self
        
    }
    func setUpUI() {
        let attributeString = NSMutableAttributedString(
            string: "SIGN OUT",
            attributes: yourAttributes
        )
        btnSignUp.setAttributedTitle(attributeString, for: .normal)
        
        btnSignIn.layer.cornerRadius = 20
        btnSignIn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btnSignIn.layer.shadowColor = UIColor.gray.cgColor
        btnSignIn.layer.shadowOpacity = 0.3
        
        setBorderTF(vBorderTf: vEmail)
        setBorderTF(vBorderTf: vPassword)
        
        
    }
    func setBorderTF(vBorderTf: UIView) {
        vBorderTf.layer.cornerRadius = 15
        vBorderTf.layer.shadowOffset = CGSize(width: 0, height: 4)
        vBorderTf.layer.shadowOpacity = 0.3
        vBorderTf.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func getDataUserDefault(id: Int, email: String, password: String) -> Bool {
        if let data = UserDefaults.standard.data(forKey: "user_\(id)") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let model = try decoder.decode(ModelSignUp.self, from: data)
                print("first Name: \(model.firstName)")
                if model.emailAddress == email, model.password == password {
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
    
    func showAlert() {
        let alert = UIAlertController(title: "Notification", message: "Login error", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func setRootViewController() {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = st.instantiateViewController(withIdentifier: "navi2") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
    @IBAction func didTapBtnSignIn(_ sender: Any) {
        view.endEditing(true)
        print("Login")
        print("EMail: \(stEmail)")
        print("Password: \(stPassword)")
        let id = UserDefaults.standard.value(forKey: "id") as? Int ?? 0
        if id == 0 {
            print("Login Error 1")
            showAlert()
        }
        var checkSuccessfull = false
        for i in 0...id {
            if getDataUserDefault(id: i, email: stEmail, password: stPassword) {
                print("Login Succesfully")
                print("I: \(i)")
                checkSuccessfull = true
                UserDefaults.standard.setValue(i, forKey: "active")
                setRootViewController()
                break
            }
        }
        if !checkSuccessfull {
            showAlert()
        }
        
        
    }
    
    @IBAction func didTapBtnSignUp(_ sender: UIButton) {
        
        
    }
    
}
extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfEmail {
            guard let str = textField.text else {
                return
            }
            stEmail = str
        }else if textField == tfPassword {
            guard let str = textField.text else {
                return
            }
            stPassword = str
        }
    }
    
}

