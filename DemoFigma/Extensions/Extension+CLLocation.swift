//
//  extension+CLLocation.swift
//  DemoFigma
//
//  Created by KhanhVu on 6/8/22.
//

import Foundation
import MapKit
//import PlaygroundSupport
//PlaygroundPage.current.needsIndefiniteExecution = true

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
