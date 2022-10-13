//
//  OTPGenerationModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 23/05/22.
//

import Foundation
//import ObjectMapper

class OTPGenerationModel: Mappable {
    
    var Response: OTPGenerationResponse?
    
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

class OTPGenerationResponse: Mappable {
    
    var Body: OTPGenerationBody?
    var Code: String = ""
    

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Body <- map["Body"]
        Code <- map["Code"]
    }
}

class OTPGenerationBody: Mappable {
    
    var Result: OTPGenerationResult?
    var status: String = ""
    var statusMsg: String = ""

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Result <- map["Result"]
        status <- map["status"]
        statusMsg <- map["statusMsg"]
        
    }
}

class OTPGenerationResult: Mappable {
    
    var email_key: String = ""
    var mobile_key: String = ""

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        email_key <- map["email_key"]
        mobile_key <- map["mobile_key"]
        
    }
}
