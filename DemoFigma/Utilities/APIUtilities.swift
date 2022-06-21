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
    static let domain = "https://api.weatherapi.com/v1/"
    static let APIKEY = "ad8b7cbb8f754fbd9be55553220806"
    static let responeLocationKey = "location"
    static let responseCurrentKey = "current"
    static let responseForecastKey = "forecast"
    
    static func requestWeatherDataJson(city: String?, completionHandler: ((WeatherModel?, APIError?) -> Void)?) {
        guard  let city = city else {
            return
        }
        let tailStrURL = "forecast.json?key=\(APIKEY)&q=\(city)&days=9"
        print("CITY: \(String(describing: city))")
        print("URL: \(domain + tailStrURL)")
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    static func requestSuggestLocation(text: String?, completionHandler: (([NameCityModel]?, APIError?) -> Void)?) {
        guard  let text = text else {
            return
        }
        print("TEXTTTT: \(String(describing: text))")
        let tailUrl = "search.json?key=\(APIKEY)&q=\(text)"
        print("URL: \(domain + tailUrl)")
        jsonResponseObjectLoction(tailStrURL: tailUrl, method: .get, headers: [:], completionHandler: completionHandler)
    }

    //MARK: BASE
    
    static private func jsonResponseObject<T: JsonInitObject>(tailStrURL: String, method: HTTPMethod, headers: HTTPHeaders, completionHandler: ((T?, APIError?) -> Void)?) {
        
        jsonResponse(tailStrURL: tailStrURL, isPublicAPI: false, method: method, headers: headers) { response in
            
            switch response.result {
            case .success(let value):
              
                if let dataLocation = value as? [String : Any] {
                    let obj = T(json: dataLocation )
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
    
    static private func jsonResponseObjectLoction<T: JsonInitObject>(tailStrURL: String, method: HTTPMethod, headers: HTTPHeaders, completionHandler: (([T]?, APIError?) -> Void)?) {
        
        jsonResponse(tailStrURL: tailStrURL, isPublicAPI: false, method: method, headers: headers) { response in
            
            switch response.result {
            case .success(let value):
              
                guard let dataLocation = value as? [[String : Any]] else {
                    completionHandler?(nil, .resposeFormatError)
                    return
                }
                
                var listObj: [T] = []
                
                for item in dataLocation {
                    let obj = T(json: item)
                    listObj.append(obj)
                }
                
                completionHandler?(listObj, nil)
                
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
        
        guard let url = URL(string: domain + tailStrURL) else {
            return
            
        }
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
