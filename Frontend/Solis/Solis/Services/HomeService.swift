//
//  HomeService.swift
//  Solis
//
//  Created by Julian Waluschyk on 19.11.22.
//
//

import Foundation

public class HomeService {
    
    let networkService: NetworkService!
    
    init() {
        self.networkService = NetworkService()
    }
    
    let HOME_URL: String = "getUserData"
    let HOME_URL_TOP: String = "getTopUserData"
    let USER_UID: String = "11111111111111111111"
    
    func performQuery(completion: @escaping ([String: Any] , Int) -> Void) {
    
        let dataToSend = [
            "uid" : USER_UID
        ] as [String : Any]
        
        networkService.sendPostRequest(url: HOME_URL, parameters: dataToSend, completion: { (data, state) -> Void in
            
            completion(data!, state ?? 0)
            
        })
        
    }
 
    func performTopQuery(completion: @escaping ([String: Any] , Int) -> Void) {
    
        let dataToSend = [
            "uid" : USER_UID
        ] as [String : Any]
        
        networkService.sendPostRequest(url: HOME_URL_TOP, parameters: dataToSend, completion: { (data, state) -> Void in
            
            completion(data!, state ?? 0)
            
        })
        
    }
    
}
