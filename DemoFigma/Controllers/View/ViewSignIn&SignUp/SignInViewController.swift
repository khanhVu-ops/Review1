//
//  NewViewSignInViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit


class SignInViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnShowPassword: UIButton!
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

        setUpUI()
        tfPassword.delegate = self
        tfEmail.delegate = self
        tfPassword.isSecureTextEntry = true
        
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
        btnShowPassword.isHidden = true
        
        setBorderTF(vBorderTf: vEmail)
        setBorderTF(vBorderTf: vPassword)
        
        
    }
    func setBorderTF(vBorderTf: UIView) {
        vBorderTf.layer.cornerRadius = 15
        vBorderTf.layer.shadowOffset = CGSize(width: 0, height: 4)
        vBorderTf.layer.shadowOpacity = 0.3
        vBorderTf.layer.shadowColor = UIColor.gray.cgColor
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
        let vc = st.instantiateViewController(withIdentifier: "BaseWeatherViewController")
        self.navigationController?.setViewControllers([vc], animated: true)
        let array = self.navigationController?.viewControllers
        print("COUNT: \(String(describing: array?.count))")
    }
    
    func checkUserAccount(id: Int, email: String, password: String) -> Bool {
        var check = false
        ManagerUserDefault.getDataObjectUserDefault(id: id) { (data, error) in
            guard let data = data, error == nil else {
                return
            }
            if data.emailAddress == email, data.password == password {
                check = true
            }
            
        }
        if check {
            return true
        }
        return false
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
            if checkUserAccount(id: i, email: stEmail, password: stPassword) {
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
    
    @IBAction func didTapBtnShowPassword(_ sender: Any) {
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry
    }
    @IBAction func didTapBtnSignUp(_ sender: UIButton) {
        
        
    }
    
}
extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfPassword {
            btnShowPassword.isHidden = false
        }
       
    }
    
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
            btnShowPassword.isHidden = true
        }
    }
    
    
}

