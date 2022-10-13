//
//  ValidateOTPModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 24/05/22.
//

import Foundation
//import ObjectMapper

class ValidateOTPModel: Mappable {
    
    var Response: ValidateOTPResponse?
    
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

class ValidateOTPResponse: Mappable {
    
    var Body: ValidateOTPBody?
    var Code: String = ""
    

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Body <- map["Body"]
        Code <- map["Code"]
    }
}

class ValidateOTPBody: Mappable {
    
    var Result: ValidateOTPResult?
    var email_message: ValidateOTPEmail_Message?
    var mobile_message: ValidateOTPMobile_Message?
    var statusMsg: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Result <- map["Result"]
        email_message <- map["email_message"]
        mobile_message <- map["mobile_message"]
        statusMsg <- map["statusMsg"]
        
    }
}

class ValidateOTPResult: Mappable {
    
    var applications: [ValidateOTPApplications] = []
    
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        applications <- map["applications"]
        
        
    }
}
class ValidateOTPApplications: Mappable {
    
    var application_id: String = ""
    var crmid: String = ""//"59f67f42-fabe-3b23-c296-62be9eff9766"
    var date_of_created: String = ""
    var status: String = ""
    var status_display: String = ""
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        application_id <- map["application_id"]
        crmid <- map["crmid"]
        date_of_created <- map["date_of_created"]
        status <- map["status"]
        status_display <- map["status_display"]
        
    }
}

class ValidateOTPEmail_Message: Mappable {
    
    var status: String = ""
    var statusMsg: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        status <- map["status"]
        statusMsg <- map["statusMsg"]
        
    }
}
class ValidateOTPMobile_Message: Mappable {
    
    var status: String = ""
    var statusMsg: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        status <- map["status"]
        statusMsg <- map["statusMsg"]
        
    }
}
