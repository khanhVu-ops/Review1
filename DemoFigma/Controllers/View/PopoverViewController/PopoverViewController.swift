//
//  PopoverViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/7/22.
//

import UIKit

protocol PopupProtocolDelegate {
    func userDidTapPopover(text: String)
}
class PopoverViewController: UIViewController {
    
    var delegate: PopupProtocolDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func didTapNormal(_ sender: UIButton) {
        if self.delegate != nil {
            self.delegate?.userDidTapPopover(text: sender.title(for: .normal) ?? "")
            dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func didTapPremium(_ sender: UIButton) {
        self.delegate?.userDidTapPopover(text: sender.title(for: .normal) ?? "")
        dismiss(animated: true, completion: nil)
    }
    

}
