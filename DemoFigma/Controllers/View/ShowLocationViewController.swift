//
//  ShowLocationViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/13/22.
//

import UIKit

class ShowLocationViewController: UIViewController {

    @IBOutlet weak var tbvLocation: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        tbvLocation.register(UINib(nibName: "ShowLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "ShowLocationTableViewCell")
        tbvLocation.delegate = self
        tbvLocation.dataSource = self
    }
   

}
extension ShowLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvLocation.dequeueReusableCell(withIdentifier: "ShowLocationTableViewCell", for: indexPath) as! ShowLocationTableViewCell
        return cell
    }
    
    
}

extension ShowLocationViewController: UITableViewDelegate {
    
}
