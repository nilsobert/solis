//
//  AutarchicService.swift
//  Solis
//
//  Created by Julian Waluschyk on 20.11.22.
//

import Foundation

public class AutarchicService {
    
    let networkService: NetworkService!
    
    init() {
        self.networkService = NetworkService()
    }
    
    let FRIEND_URL: String = "getFriendData"
    let GLOBAL_URL: String = "getGlobalData"
    let USER_UID: String = "11111111111111111111"
    
    func performFriendQuery(completion: @escaping ([String: Any] , Int) -> Void) {
    
        let dataToSend = [
            "uid" : USER_UID
        ] as [String : Any]
        
        networkService.sendPostRequest(url: FRIEND_URL, parameters: dataToSend, completion: { (data, state) -> Void in
            
            completion(data!, state ?? 0)
            
        })
        
    }
 
    func performGlobalQuery(completion: @escaping ([String: Any] , Int) -> Void) {
    
        let dataToSend = [
            "uid" : USER_UID
        ] as [String : Any]
        
        networkService.sendPostRequest(url: GLOBAL_URL, parameters: dataToSend, completion: { (data, state) -> Void in
            
            completion(data!, state ?? 0)
            
        })
        
    }
    
}
