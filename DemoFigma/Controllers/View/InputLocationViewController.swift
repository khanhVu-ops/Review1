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
    @IBOutlet weak var tbvSuggestion: UITableView!
    
    var delegate: TextFieldInputProtocolDelegate?
    var dataCity: [NameCityModel]?
//    var weatherModel: WeatherModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfEnter.delegate = self
        tbvSuggestion.dataSource = self
        tbvSuggestion.delegate = self
        
        tbvSuggestion.register(UINib(nibName: "SuggestionTableViewCell", bundle: nil), forCellReuseIdentifier: "SuggestionTableViewCell")
        tbvSuggestion.isHidden = true
        tfEnter.becomeFirstResponder()
//        requestApi(text: "thanh hoa")
        
        // Do any additional setup after loading the view.
    }
    
    func requestApi(text: String?) {
        APIUtilities.requestSuggestLocation(text: text) { [weak self] (data, error) in
            guard let self = self else {
                return
            }
            guard let data = data, error == nil else {
                print("ERROR")
                return
            }
            self.dataCity = data
//            print("AAAAA: \(String(describing: self.dataCity?[0].name))")
        }
       
    }
    

    @IBAction func didTapCancel(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
}

extension InputLocationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        var textInput = text + string
        textInput = textInput.replaceSpacingToCorrectURLForm()
        print("TEXT: \(textInput)")
        if textInput.count > 1 {
            requestApi(text: textInput)
            tbvSuggestion.isHidden = false
            DispatchQueue.main.async {
                self.tbvSuggestion.reloadData()
            }
        }
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        navigationController?.popToRootViewController(animated: true)
        return true
    }
}
extension InputLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCity?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvSuggestion.dequeueReusableCell(withIdentifier: "SuggestionTableViewCell", for: indexPath) as! SuggestionTableViewCell
        cell.configure(data: dataCity?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let name = dataCity?[indexPath.row].name,
               let country = dataCity?[indexPath.row].country else {
            return
        }
        let text = name + ", " + country + "."
        tfEnter.text = text
        tbvSuggestion.deselectRow(at: indexPath, animated: true)
        tbvSuggestion.isHidden = true
        view.endEditing(true)
        let textInput = name.replaceSpacingToCorrectURLForm()
        delegate?.textFieldDidEdit(text: textInput)
        navigationController?.popToRootViewController(animated: true)
    }
    
}
extension InputLocationViewController: UITableViewDelegate {
    
}

