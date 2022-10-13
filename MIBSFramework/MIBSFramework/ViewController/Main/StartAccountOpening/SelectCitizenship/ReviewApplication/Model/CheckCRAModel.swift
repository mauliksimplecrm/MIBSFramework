//
//  CheckCRAModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 05/07/22.
//

import Foundation
//import ObjectMapper

class CheckCRAModel: Mappable {
    
    var Response: CheckCRAResponse?
    
    //Error
    var error: String = ""
    var message: String = ""
    var hint: String = ""
    
    init() {
    }

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Response <- map["Response"]
        
        //Error
        error <- map["error"]
        message <- map["message"]
        hint <- map["hint"]
    
    }
}
class CheckCRAResponse: Mappable {
    
    var Body: CheckCRABody?
    var Code: String = ""
    

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Body <- map["Body"]
        Code <- map["Code"]
    }
}

class CheckCRABody: Mappable {
    
    var risk_level: String?
    var status: String = ""
    var statusMsg: String = ""

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        risk_level <- map["risk_level"]
        status <- map["status"]
        statusMsg <- map["statusMsg"]
        
    }
}
