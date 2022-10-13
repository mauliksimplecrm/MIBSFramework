//
//  OmniResponseModel.swift
//  Maisarah
//
//  Created by Sachin Patoliya on 13/06/22.
//

import Foundation
//import ObjectMapper

class OmniResponseModel: Mappable {
    
    var Response: ValidateOmniResponse?
    
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

class ValidateOmniResponse: Mappable {
    
    var Body: ValidateOmniBody?
    var Code: String = ""
    var status: String = ""

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Body <- map["Body"]
        Code <- map["Code"]
        status <- map["status"]
    }
}

class ValidateOmniBody: Mappable {
    
    var Result: ValidateOmniResult?
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

class ValidateOmniResult: Mappable {
    
    var data: ValidateOmniData?
    var document_id: String = ""
    
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        document_id <- map["document_id"]
        
    }
}
class ValidateOmniData: Mappable {
    
    var error_response: String = ""
    var valid: Int = 0
    var status: String = ""
    
    //--
    var ID: String = ""
    var date_of_birth: String = ""
    var exp_date: String = ""
    var first_name: String = ""
    var last_name: String = ""
    
    //--
    var civil_id: Int = 0
    var civil_id_expiry_date: String = ""
    
    //--
    var issue_date : String = ""
    var nationality : String = ""
    var passport_number : String = ""
    
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        error_response <- map["error_response"]
        valid <- map["valid"]
        status <- map["status"]
        
        //--
        ID <- map["ID"]
        date_of_birth <- map["date_of_birth"]
        exp_date <- map["exp_date"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        
        //--
        civil_id <- map["civil_id"]
        civil_id_expiry_date <- map["civil_id_expiry_date"]
        
        //--
        issue_date <- map["issue_date"]
        nationality <- map["nationality"]
        passport_number <- map["passport_number"]
    }
}
