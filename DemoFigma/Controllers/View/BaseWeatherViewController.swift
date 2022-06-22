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
    var deviceLoaction: String?
    let active = UserDefaults.standard.value(forKey: "active") as? Int ?? 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ACTIVE: \(active)")
        setUpView()
    }
    
    func setUpView() {
        cltvWeather.register(UINib(nibName: "ViewWeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewWeatherCollectionViewCell")
        cltvWeather.delegate = self
        cltvWeather.dataSource = self
        cltvWeather.backgroundColor = .clear
        cltvWeather.allowsSelection = false
        if active > 0 {
            if !ManagerUserDefault.checkSelectUserType(id: active) {
                myPageControl.isHidden = true
                btnTabMenu.isHidden = true
            }
            
        }
        myPageControl.currentPage = 0
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                deviceLoaction = userDefaults.value(forKey: "deviceLocation") as? String ?? ""
                print("Access")
            case .notDetermined:
                requireLocation()
                print("NotDEtermine")
            case .restricted:
                print("REstriced")
            case .denied:
                deviceLoaction = ""
                print("Denied 1")
            @unknown default:
                print("Access")
            }
        }else {
            print("Location services are not enabled")
        }
        
        
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
        let vc = st.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        var array = self.navigationController?.viewControllers
        
        array?.removeAll()
        
        array?.append(vc)
        self.navigationController?.setViewControllers(array!, animated: true)
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
            let str = city.replaceSpacingToCorrectURLForm()
            self.userDefaults.set(str, forKey: "deviceLocation")
            self.deviceLoaction = self.userDefaults.value(forKey: "deviceLocation") as? String ?? ""
            
            print("\(city), \( country)")
            DispatchQueue.main.async {
                self.cltvWeather.reloadData()
                
            }
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
        let stringLocation = ManagerUserDefault.getArrayLocation(deviceLocations: self.deviceLoaction ?? "", id: active)
        myPageControl.numberOfPages = stringLocation.count
        return stringLocation.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cltvWeather.dequeueReusableCell(withReuseIdentifier: "ViewWeatherCollectionViewCell", for: indexPath) as! ViewWeatherCollectionViewCell
        let stringLocation = ManagerUserDefault.getArrayLocation(deviceLocations: self.deviceLoaction ?? "", id: active)
        cell.requestDataFromApi(city: stringLocation[indexPath.row])
        
        return cell
    }
    
    
}
extension BaseWeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.cltvWeather.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var currentPage = Int(scrollView.contentOffset.x/UIScreen.main.bounds.width)
        let stringLocation = ManagerUserDefault.getArrayLocation(deviceLocations: self.deviceLoaction ?? "", id: active)
        currentPage = min(currentPage, stringLocation.count - 1)
        currentPage = max(currentPage, 0)
        print("CURRENTPAGE: \(currentPage)")

        
        myPageControl.currentPage = currentPage
    }
}

extension BaseWeatherViewController: TextFieldInputProtocolDelegate {
    func textFieldDidEdit(text: String) {
        if text != "" {
            ManagerUserDefault.addLocationUserDefault(textLocation: text, id: active)
            DispatchQueue.main.async {
                self.cltvWeather.reloadData()
            }
        }
        
    }
}
