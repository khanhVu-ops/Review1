//
//  ViewTextFieldTableViewCell.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import UIKit



class ViewTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vBorderTf: UIView!
    @IBOutlet weak var tfEnter: UITextField!
    var dict : [ModelSignUp] = []
    var getString = ""
    var str  = ""
    var controller = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setBorderTF()
        tfEnter.delegate = self
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setBorderTF() {
        
        vBorderTf.layer.cornerRadius = 15
        vBorderTf.layer.shadowOffset = CGSize(width: 0, height: 4)
        vBorderTf.layer.shadowOpacity = 0.3
        vBorderTf.layer.shadowColor = UIColor.gray.cgColor
    }
    func addBtnPopover(width: Float?) {
        guard let width = width else {
            return
        }
        print("WIDTH: \(width)")
        let btn = UIButton(frame: CGRect(x: Int(width) - 70, y: 25, width: 30, height: 30))
        self.addSubview(btn)
        btn.setBackgroundImage(UIImage(named: "btn_down"), for: .normal)
        btn.addTarget(self, action: #selector(didTapbtnDown(_:)), for: .touchUpInside)
        tfEnter.isUserInteractionEnabled = false
    }
    
    @IBAction func didTapbtnDown(_ sender: UIButton) {
        presentOptionsPopovered(fromButton: sender)
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
    
    func setPlaceHolder(string: String) {
        tfEnter.placeholder = string
        str = string
    }
    
    
}
extension ViewTextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Get Data textField
        getString = textField.text ?? ""
        UserDefaults.standard.setValue(getString, forKey: str)
        
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

