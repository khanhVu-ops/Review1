//
//  BaseWeatherViewController.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/10/22.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import CoreLocation
class BaseWeatherViewController: UIViewController {
    
    @IBOutlet weak var cltvWeather: UICollectionView!
    @IBOutlet weak var vTabbar: UIView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var btnTabMenu: UIButton!
    
    let userDefaults = UserDefaults.standard

    var currentLocation = CLLocation()
    let locationManager = CLLocationManager()
    var arrayLoaction = [""]
    let active = UserDefaults.standard.value(forKey: "active") as? Int ?? 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let strings = userDefaults.object(forKey: "myLocation_\(active)") as? [String] ?? []
        if strings.count == 0 {
            userDefaults.set(arrayLoaction, forKey: "myLocation_\(active)")
        }
       
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        cltvWeather.register(UINib(nibName: "ViewWeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewWeatherCollectionViewCell")
        cltvWeather.delegate = self
        cltvWeather.dataSource = self
        cltvWeather.backgroundColor = .clear
        cltvWeather.allowsSelection = false
        if active > 0 {
            if !checkSelectUserType(id: active) {
                myPageControl.isHidden = true
                btnTabMenu.isHidden = true
            }
            
        }
        let strings = userDefaults.object(forKey: "myLocation_\(active)") as? [String] ?? []
        myPageControl.currentPage = 0
        myPageControl.numberOfPages = strings.count
        
        requireLocation()
    }
    func checkSelectUserType(id: Int) -> Bool {
        if let data = UserDefaults.standard.data(forKey: "user_\(active)") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let model = try decoder.decode(ModelSignUp.self, from: data)
                print("User TYPE: \(model.selectUserTpye)")
                if model.selectUserTpye == "Normal" {
                    return false
                }else {
                    return true
                }
                
            } catch {
                print("Unable to Decode Note (\(error))")
                return false
            }
        }
        return false
    }
    
    
    func requireLocation() {
        self.locationManager.requestAlwaysAuthorization()
//        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func setRootViewController() {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = st.instantiateViewController(withIdentifier: "navi") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func didTapLogOut(_ sender: Any) {
        UserDefaults.standard.setValue(0, forKey: "active")
        let loginManager = LoginManager()
        if let _ = AccessToken.current {
            //Log out fb
            loginManager.logOut()
            print("Log out FB")
        }
        if GIDSignIn.sharedInstance.currentUser != nil {
            GIDSignIn.sharedInstance.signOut()
        }
        setRootViewController()
    }
    @IBAction func didTapBtnMenu(_ sender: Any) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "InputLocationViewController") as! InputLocationViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension BaseWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations.first!
        locationManager.stopUpdatingLocation()
        currentLocation.fetchCityAndCountry { (city, country, error) in
            guard let city = city, let country = country, error == nil else {
                return
            }
            let str = city.removeSperator()
            var strings = self.userDefaults.object(forKey: "myLocation_\(self.active)") as? [String] ?? []
            strings.removeFirst()
            strings.insert(str, at: 0)
            self.userDefaults.set(strings, forKey: "myLocation_\(self.active)")
            print("\(city), \( country)")
            DispatchQueue.main.async {
                self.cltvWeather.reloadData()
                
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clErr = error as? CLError {
            switch clErr {
            case CLError.locationUnknown:
                print("location unknown")
            case CLError.denied:
                print("denied")
                var strings = userDefaults.object(forKey: "myLocation_\(active)") as? [String] ?? []
                if strings[0] == "" {
                    strings.removeFirst()
                    userDefaults.set(strings, forKey: "myLocation_\(active)")
                    DispatchQueue.main.async {
                        self.cltvWeather.reloadData()
                        self.myPageControl.numberOfPages = strings.count
                    }
                }
                
            default:
                print("other Core Location error")
            }
        } else {
            print("other error:", error.localizedDescription)
        }
    }
}
extension BaseWeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        myPageControl.currentPage = indexPath.row
    }
}
extension BaseWeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let stringLocation = userDefaults.object(forKey: "myLocation_\(active)") as? [String] ?? []
        return stringLocation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cltvWeather.dequeueReusableCell(withReuseIdentifier: "ViewWeatherCollectionViewCell", for: indexPath) as! ViewWeatherCollectionViewCell
        let stringLocation = userDefaults.object(forKey: "myLocation_\(active)") as? [String] ?? []
        cell.requestDataFromApi(city: stringLocation[indexPath.row])
        
        return cell
    }
    
    
}
extension BaseWeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.cltvWeather.frame.height)
    }
}

extension BaseWeatherViewController: TextFieldInputProtocolDelegate {
    func textFieldDidEdit(text: String) {
        var strings = userDefaults.object(forKey: "myLocation_\(active)") as? [String] ?? []
        strings.append(text)
        userDefaults.set(strings,forKey: "myLocation_\(active)")
        DispatchQueue.main.async {
            self.myPageControl.numberOfPages = strings.count
            self.cltvWeather.reloadData()
        }
    }
}
