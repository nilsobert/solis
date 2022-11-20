//
//  NetworkService.swift
//  Solis
//
//  Created by Julian Waluschyk on 19.11.22.
//

import Foundation
import Alamofire

public class NetworkService {
    
    let TARGET_URL = "http://85.214.129.142:8079/"
    
//getRoof send lon lat
//get area save
    
//getFriendData
//send uid
//get name: [[x, y]]
//
//    {
//    name: [[], []],
//    name:
//    }
    
//getGlobalData
//send uid
//get data: []
    
//getUserData
    
    typealias CompletionHandler = ([String:Any]? , Int?) -> ()
    
    func sendPostRequest(url: String, parameters: [String: Any], completion: @escaping CompletionHandler) {
        
        AF.request(TARGET_URL + url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            completion(nil, 0)
                            return
                        }
                        
                        completion(jsonObject, jsonObject["state"] as? Int)
                        
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }

                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }

                        print(prettyPrintedJson)
                        
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        completion(nil, 0)
                        return
                    }
                case .failure(let error):
                    print(error)
                    print("ldl")
                    if let err = error.underlyingError as? URLError, err.code == .notConnectedToInternet {
                        completion(nil, 10)
                    }else{
                        completion(nil, 0)
                    }
                }
            }
        
    }
    
    func sendPutRequest(url: String, parameters: String) {
        
    }
    
    func sendGetRequest(url: String) {
        
    }
    
}
