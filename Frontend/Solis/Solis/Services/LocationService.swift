//
//  LocationService.swift
//  Solis
//
//  Created by Julian Waluschyk on 20.11.22.
//

import Foundation

public class LocationService {
    
    let networkService: NetworkService!
    var lon: String!
    var lat: String!
    
    init(lat: String, lon: String) {
        self.networkService = NetworkService()
        self.lat = lat
        self.lon = lon
    }
    
    let TARGET_URL: String = "getRoof"
    let USER_UID: String = "11111111111111111111"
    
    func performQuery(completion: @escaping ([String: Any] , Int) -> Void) {
    
        let dataToSend = [
            "uid" : USER_UID,
            "lat" : self.lat,
            "lon" : self.lon
        ] as [String : Any]
        
        networkService.sendPostRequest(url: TARGET_URL, parameters: dataToSend, completion: { (data, state) -> Void in
            
            completion(data!, state ?? 0)
            
        })
        
    }
 
}
