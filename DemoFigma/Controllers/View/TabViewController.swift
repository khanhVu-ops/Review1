//
//  TabViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/3/22.
//

import UIKit

class TabViewController: UIViewController {
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), buttonTitle: ["Sign In", "Sign Out"])
        codeSegmented.backgroundColor = .clear
        view.addSubview(codeSegmented)
        codeSegmented.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view1.alpha = 1
            self.view2.alpha = 0
        })
    }
    
    
    
    @IBAction func didTapSegmentControl(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.view1.alpha = 1
                self.view2.alpha = 0
            })
        }else {
            
            
        }
    }
}

extension TabViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        if index == 1 {
            UIView.animate(withDuration: 0.3, animations: {
                self.view1.alpha = 0
                self.view2.alpha = 1
            })
        }else {
            UIView.animate(withDuration: 0.3, animations: {
                self.view1.alpha = 1
                self.view2.alpha = 0
            })
        }
    }
}
