//
//  GetAddressDetailsModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 03/08/22.
//

import Foundation
//import ObjectMapper

class GetAddressDetailsModel: Mappable {
    
    var status: Int = 0
    var message: String = ""
    var Response: GetAddressDetailsResponse?
    
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
        Response <- map["Response"]
        
        //Error
        error <- map["error"]
        hint <- map["hint"]
    }
}
class GetAddressDetailsResponse: Mappable {
    
    var Body: GetAddressDetailsBody?
    var Code: String = ""
    

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Body <- map["Body"]
        Code <- map["Code"]
        
    }
}

class GetAddressDetailsBody: Mappable {
    
    var Result: GetAddressDetailsResult?
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

class GetAddressDetailsResult: Mappable {
    
    var cityData: GetAddressDetailsCityData?
    

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        
        cityData <- map["data"]
        
    }
}
class GetAddressDetailsCityData: Mappable {
    
    var city: String = ""
    var key: String = ""

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        city <- map["city"]
        key <- map["key"]
        
    }
}
