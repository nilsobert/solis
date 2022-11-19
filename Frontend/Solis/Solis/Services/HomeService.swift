//
//  HomeService.swift
//  Solis
//
//  Created by Julian Waluschyk on 19.11.22.
//
//

//{
//    "electricity": [["month1", 10], ["month2", 14], ["month3", 13], ["month4", 20], ["month5", 3], ["month6", 8]],
//    "heating": [["month1", 3], ["month2", 11], ["month3", 63], ["month4", 4], ["month5", 1], ["month6", 12]],
//    "saved": [["month1", 10], ["month2", 1], ["month3", 3], ["month4", 10], ["month5", 3], ["month6", 8]]
//}

import Foundation

public class HomeService {
    
    let networkService: NetworkService!
    
    init() {
        self.networkService = NetworkService()
    }
    
    let HOME_URL: String = "getUserData"
    let USER_UID: String = "11111111111111111111"
    
    func performQuery(completion: @escaping ([String:Any] , Int) -> Void) {
        
        let dataToSend = [
            "uid" : USER_UID
        ] as [String : Any]
        
        networkService.sendPostRequest(url: HOME_URL, parameters: dataToSend, completion: { (data, state) -> Void in
            
            completion(data!, state ?? 0)
            
        })
        
    }
    
}
