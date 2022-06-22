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
        if let check = UserDefaults.standard.value(forKey: "active") as? Int{
            print("Current: \(check)")
            if check != 0 {
                setRootViewController()
                
            }
            
        } else {
            UserDefaults.standard.setValue(0, forKey: "active")
        }
        
        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), buttonTitle: ["Sign In", "Sign Up"])
        codeSegmented.backgroundColor = .clear
        view.addSubview(codeSegmented)
        codeSegmented.delegate = self
        
        for child in children {
            child.didMove(toParent: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view1.alpha = 1
            self.view2.alpha = 0
        })
    }
    
    func setRootViewController() {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "BaseWeatherViewController")
        
//        var array = self.navigationController?.viewControllers
//        print("COUNT: \(String(describing: array?.count))")
////        array?.removeAll()
//        print("COUNT: \(String(describing: array?.count))")
//        array?.append(vc)
//        print("COUNT: \(String(describing: array?.count))")
//
        self.navigationController?.setViewControllers([vc], animated: true)
        let array = self.navigationController?.viewControllers
        print("COUNT: \(String(describing: array?.count))")
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
