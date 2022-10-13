//
//  MobileApiModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 18/05/22.
//

import Foundation
//import ObjectMapper

class MobileApiModel: Mappable {
    
    var status: Int = 0
    var message: String = ""
    var mobileApiData: MobileApiData?
    
    //Error
    var error: String = ""
    var hint: String = ""
    
    init() {
    }

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        mobileApiData <- map["data"]
        
        //Error
        error <- map["error"]
        hint <- map["hint"]
    }
}

class MobileApiData: Mappable {
    
    var access_token: String = ""
    var expires_in: String = ""
    var token_type: String = ""
    
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
       
        access_token <- map["access_token"]
        expires_in <- map["expires_in"]
        token_type <- map["token_type"]
        
    }
}
