//
//  ConsumerService.swift
//  Solis
//
//  Created by Julian Waluschyk on 20.11.22.
//

import Foundation

public class ConsumerService {
    
    let networkService: NetworkService!
    var accessCode: String!
    var deviceType: String!
    var role: String!
    var serialNumber: String!
    
    init(accessCode: String, deviceType: String, role: String, serialNumber: String) {
        self.networkService = NetworkService()
        self.accessCode = accessCode
        self.deviceType = deviceType
        self.role = deviceType
        self.serialNumber = deviceType
    }
    
    let TARGET_URL: String = "addDevice"
    let USER_UID: String = "11111111111111111111"
    
    func performQuery(completion: @escaping ([String: Any] , Int) -> Void) {
    
        let dataToSend = [
            "uid" : USER_UID,
            "accessCode" : self.accessCode,
            "deviceType" : self.deviceType,
            "role" : self.role,
            "serialNumber" : self.serialNumber
        ] as [String : Any]
        
        networkService.sendPostRequest(url: TARGET_URL, parameters: dataToSend, completion: { (data, state) -> Void in
            
            completion(data!, state ?? 0)
            
        })
        
    }
 
}
