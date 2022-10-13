//
//  GetFacePredictionModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 23/06/22.
//

import Foundation
//import ObjectMapper

class GetFacePredictionModel: Mappable {
    
    var Response: ValidateFacePredictionResponse?
    
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

class ValidateFacePredictionResponse: Mappable {
    
    var Body: FacePredictionBody?
    var Code: String = ""
    

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Body <- map["Body"]
        Code <- map["Code"]
    }
}

class FacePredictionBody: Mappable {
    
    var Result: FacePredictionResult?
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

class FacePredictionResult: Mappable {
    
    var confidence: Int = 0
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        confidence <- map["confidence"]
        
    }
}
