//
//  DropDownOptionsListModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 22/05/22.
//

import Foundation
//import ObjectMapper

class DropDownOptionsListModel: Mappable {
    
    var response: DropDownResponse?
    
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
        response <- map["Response"]
        
        //Error
        error <- map["error"]
        message <- map["message"]
        hint <- map["hint"]
    }
}
class DropDownResponse: Mappable {
    
    var Code: String = ""
    var Body: DropDownBody?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Code <- map["Code"]
        Body <- map["Body"]
    }
}
class DropDownBody: Mappable {
    
    var status: String = ""
    var statusMsg: String = ""
    var data:[DropDownData] = []
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        data <- map["data"]
        status <- map["status"]
        statusMsg <- map["statusMsg"]
    }
}

class DropDownData: Mappable {
    var dropdown_filed: String = ""
    var dropdown_values: [Dropdown_Values] = []
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        dropdown_filed <- map["dropdown_filed"]
        dropdown_values <- map["dropdown_values"]
        
    }
}

class Dropdown_Values: Mappable {
    var key: Any = ""
    var label: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        key <- map["key"]
        label <- map["label"]
        
    }
}
