//
//  ViewTextFieldTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit



class ViewTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var vBorderTf: UIView!
    @IBOutlet weak var tfEnter: UITextField!
    var dict : [ModelSignUp] = []
    var getString = ""
    var str  = ""
    var controller = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorderTF()
        showLabelError(bool: false)
        tfEnter.delegate = self
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setPlaceHolder(string: String) {
        tfEnter.placeholder = string
        str = string
    }
    
    func showLabelError(bool: Bool) {
        lbError.isHidden = !bool
    }
    
    func setSecureTextEntry(isSecure: Bool) {
        tfEnter.isSecureTextEntry = isSecure
    }
    
    func setBorderTF() {
        
        vBorderTf.layer.cornerRadius = 15
        vBorderTf.layer.shadowOffset = CGSize(width: 0, height: 4)
        vBorderTf.layer.shadowOpacity = 0.3
        vBorderTf.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func addBtnShowPassword(width: Float?) {
        guard let width = width else {
            return
        }
        let btn = UIButton(frame: CGRect(x: Int(width) - 70, y: Int(tfEnter.frame.height)/2-15, width: 30, height: 30))
        self.addSubview(btn)
//        btn.isHidden = false
        btn.setBackgroundImage(UIImage(named: "btn_eye"), for: .normal)
        btn.addTarget(self, action: #selector(didTapbtnShowPassword(_:)), for: .touchUpInside)
       
    }
    @IBAction func didTapbtnShowPassword(_ sender: UIButton) {
        tfEnter.isSecureTextEntry = !tfEnter.isSecureTextEntry
    }
    
    func addBtnPopover(width: Float?) {
        guard let width = width else {
            return
        }
        print("WIDTH: \(width)")
        let btn = UIButton(frame: CGRect(x: Int(width) - 70, y: Int(tfEnter.frame.height)/2-15, width: 30, height: 30))
        self.addSubview(btn)
        btn.setBackgroundImage(UIImage(named: "btn_down"), for: .normal)
        btn.addTarget(self, action: #selector(didTapbtnDown(_:)), for: .touchUpInside)
        tfEnter.isUserInteractionEnabled = false
    }
    func presentOptionsPopovered( fromButton btn: UIButton) {
        
        
        let popoverContent = PopoverViewController(nibName: "PopoverViewController", bundle: nil)
        popoverContent.delegate = self
        popoverContent.modalPresentationStyle = .popover
        if let popover = popoverContent.popoverPresentationController {
            popover.delegate = self
            let viewForSource = btn as UIView
            popover.sourceView = viewForSource
            
            popover.sourceRect = viewForSource.bounds
            popoverContent.preferredContentSize = CGSize(width: 200, height: 100)
            
        }
        controller.present(popoverContent, animated: true, completion: nil)
    }
    func checkEmailWasRegisted(email: String) -> Bool {
        let id = UserDefaults.standard.value(forKey: "id") as? Int ?? 0
        var check = false
        for i in 0...id {
            
            ManagerUserDefault.getDataObjectUserDefault(id: i) { (data, error) in
                guard let data = data, error == nil else {
                    return
                }
                if data.emailAddress == email {
                    check = true
                }
                
            }
            if check {
                return true
            }
        }
        return false
    }
    
    
    @IBAction func didTapbtnDown(_ sender: UIButton) {
        presentOptionsPopovered(fromButton: sender)
    }
    
    
    
    
}
extension ViewTextFieldTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if str = "Password" {
//            
//        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Get Data textField
        getString = textField.text ?? ""
        if str == "E-mail Address" {
            if !Utilities.emailIsValid(getString) {
                lbError.text = "Error: Invalid email address!"
                showLabelError(bool: true)
                UserDefaults.standard.setValue("", forKey: str)
            }else if checkEmailWasRegisted(email: getString) {
                lbError.text = "Error: Email address was registered!"
                showLabelError(bool: true)
                UserDefaults.standard.setValue("", forKey: str)
            }else {
                showLabelError(bool: false)
                UserDefaults.standard.setValue(getString, forKey: str)
            }
        }else {
            UserDefaults.standard.setValue(getString, forKey: str)
        }
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
extension ViewTextFieldTableViewCell: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
extension ViewTextFieldTableViewCell: PopupProtocolDelegate {
    func userDidTapPopover(text: String) {
        tfEnter.text = text
        UserDefaults.standard.setValue(text, forKey: str)
        contentView.endEditing(true)
    }
}

