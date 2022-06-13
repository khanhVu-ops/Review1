//
//  APIUtilities.swift
//  DemoFigma
//
//  Created by KhanhVu on 5/31/22.
//

import Foundation
import Alamofire

protocol JsonInitObject: NSObject {
    init(json: [String : Any])
}

final class APIUtilities {
    static let domain = "https://api.weatherapi.com/v1/forecast.json?"
    static let responeLocationKey = "location"
    static let responseCurrentKey = "current"
    static let responseForecastKey = "forecast"
    
    static func requestLocationDataJson(city: String?, completionHandler: ((LocationModel?, APIError?) -> Void)?) {
        guard  let city = city else {
            return
        }
        let tailStrURL = "key=ad8b7cbb8f754fbd9be55553220806&q=\(city)&days=9"
        print("CITY: \(String(describing: city))")
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], responeKey: responeLocationKey, completionHandler: completionHandler)
    }
    static func requestCurrentDataJson(city: String?, completionHandler: ((CurrentModel?, APIError?) -> Void)?) {
        guard  let city = city else {
            return
        }
        let tailStrURL = "key=ad8b7cbb8f754fbd9be55553220806&q=\(city)&days=9"
        
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], responeKey: responseCurrentKey, completionHandler: completionHandler)
    }
    static func requestForeCastDataJson(city: String?, completionHandler: ((Forecast?, APIError?) -> Void)?) {
        guard  let city = city else {
            return
        }
        let tailStrURL = "key=ad8b7cbb8f754fbd9be55553220806&q=\(city)&days=9"
        
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], responeKey: responseForecastKey, completionHandler: completionHandler)
    }
    
    //MARK: BASE
    
    static private func jsonResponseObject<T: JsonInitObject>(tailStrURL: String, method: HTTPMethod, headers: HTTPHeaders, responeKey: String, completionHandler: ((T?, APIError?) -> Void)?) {
        
        jsonResponse(tailStrURL: tailStrURL, isPublicAPI: false, method: method, headers: headers) { response in
            
            switch response.result {
            case .success(let value):
                //                guard serverCode == 200 else {
                //                    completionHandler?(nil, .serverError(serverCode, serverMessage))
                //                    return
                //                }
                
                guard let responseDict = value as? [String: Any] else {
                    return
                }
                if let dataLocation = responseDict[responeKey] as? [String: Any] {
                    let obj = T(json: dataLocation)
                    completionHandler?(obj,nil)
                } else {
                    completionHandler?(nil, .resposeFormatError)
                    return
                }
                
                
                
                
//                completionHandler?(obj, nil)
                
            case .failure(let error):
                completionHandler?(nil, .unowned(error))
            }
        }
    }
    
    static private func jsonResponse(tailStrURL: String,
                                     isPublicAPI: Bool,
                                     method: HTTPMethod,
                                     parameters: Parameters? = nil,
                                     encoding: ParameterEncoding = JSONEncoding.default,
                                     headers: HTTPHeaders = [:],
                                     completionHandler: ((AFDataResponse<Any>) -> Void)?) {
        
        guard let url = URL(string: domain + tailStrURL) else { return }
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseJSON { response in
                
                switch response.result {
                case .success( _): break
                    
                case .failure(_):
                    break
                }
                
                completionHandler?(response)
            }
    }
}


extension APIUtilities {
    enum APIError: Error {
        //        case loginFail
        //        case signUpFail
        case resposeFormatError
        case serverError(Int?, String?)
        case unowned(Error)
    }
}
