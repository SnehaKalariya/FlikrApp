//
//  WebServiceHandler.swift
//  FlickerApp
//
//  Created by Greek1 on 1/27/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

class WebServiceHandler {
    
    static func getApiCall_CodableRES(url:String,completion:@escaping (_ result : Data?)-> Void,failure:@escaping ((_ getError: Error) -> Void)) {
        
        guard let serviceUrl = URL(string: url) else { return }
        
        print("base 64 \(serviceUrl)")
        URLSession.shared.dataTask(with: serviceUrl) { (data, response, err) in
            
            guard let data = data else {
                return
            }
            
            let strResponse = String(data: data, encoding: .utf8)
            let jsonData: Data? = strResponse?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue ))
            var strDecodedData: String?
            if let aData = jsonData {
                strDecodedData = String(data: aData, encoding: .utf8)
                print("string data \(String(describing: strDecodedData))")
            }
            
            completion(jsonData)
            
            }.resume()
    }
    
    static func getApiCallWithoutEncode(url:String,completion:@escaping (_ result : [AnyHashable : Any]?)-> Void,failure:@escaping ((_ getError: Error) -> Void)) {
        
        
        guard let serviceUrl = URL(string: url) else { return }
        
        print("base 64 \(serviceUrl)")
        URLSession.shared.dataTask(with: serviceUrl) { (data, response, err) in
           
            guard let data = data else {
                return
            }
            
            let strResponse = String(data: data, encoding: .utf8)
            
            let jsonData: Data? = strResponse?.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue ))
            var dicResponse : [AnyHashable : Any]?
            if let aData = jsonData {
                dicResponse = try! JSONSerialization.jsonObject(with: aData, options: []) as? [AnyHashable : Any ]
            }
            
            print (dicResponse as Any)
            
            print("response decode dict \(String(describing: dicResponse))")
            
            completion(dicResponse)
            
            }.resume()
    }
}
