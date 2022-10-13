//
//  GetListOfCountriesModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 26/08/22.
//

import Foundation
//import ObjectMapper

class GetListOfCountriesModel: Mappable {
    
    var Response:GetListOfCountriesResponse?
    
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
class GetListOfCountriesResponse: Mappable {
    
    var Code: String = ""
    var Body: GetListOfCountriesBody?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Code <- map["Code"]
        Body <- map["Body"]
    }
}
class GetListOfCountriesBody: Mappable {
    
    var status: String = ""
    var statusMsg: String = ""
    var data:[GetListOfCountriesData] = []
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        status <- map["status"]
        statusMsg <- map["statusMsg"]
    }
}

class GetListOfCountriesData: Mappable {
    var country_code: String = ""
    var en_label: String = ""
    var ar_label: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        country_code <- map["country_code"]
        en_label <- map["en_label"]
        ar_label <- map["ar_label"]
        
    }
}
