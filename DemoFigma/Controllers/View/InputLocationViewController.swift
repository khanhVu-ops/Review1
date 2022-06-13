//
//  InputLocationViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/13/22.
//

import UIKit

protocol TextFieldInputProtocolDelegate {
    func textFieldDidEdit(text: String)
}

class InputLocationViewController: UIViewController {

    @IBOutlet weak var tfEnter: UITextField!
    
    var delegate: TextFieldInputProtocolDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfEnter.delegate = self
        tfEnter.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapCancel(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
    }
}

extension InputLocationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        delegate?.textFieldDidEdit(text: text)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        navigationController?.popToRootViewController(animated: true)
        return true
    }
}

