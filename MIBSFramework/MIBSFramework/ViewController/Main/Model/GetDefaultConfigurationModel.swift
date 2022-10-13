//
//  GetDefaultConfigurationModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 13/07/22.
//

import Foundation
//import ObjectMapper

class GetDefaultConfigurationModel: Mappable {
    
    var status: Int = 0
    var message: String = ""
    var response: GetDefaultConfigurationResponse?
    
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
        response <- map["Response"]
        
        //Error
        error <- map["error"]
        hint <- map["hint"]
    }
}

class GetDefaultConfigurationResponse: Mappable {
    
    var code: String = ""
    var body: GetDefaultConfigurationBody?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        code <- map["Code"]
        body <- map["Body"]
    }
}
class GetDefaultConfigurationBody: Mappable {
    
    var result: GetDefaultConfigurationResult?
    var status: String = ""
    var statusMsg: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        result <- map["Result"]
        status <- map["status"]
        statusMsg <- map["statusMsg"]
        
    }
}
class GetDefaultConfigurationResult: Mappable {
    
    var configuration: GetDefaultConfiguration?
    
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        configuration <- map["configuration"]
        
    }
}
class GetDefaultConfiguration: Mappable {
    var threhold_facematch: GetDefaultConfi_threhold_facematch?
    var threhold_facematch_fail_attempts: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        threhold_facematch <- map["threhold_facematch"]
        threhold_facematch_fail_attempts <- map["threhold_facematch_fail_attempts"]
        
    }
}
class GetDefaultConfi_threhold_facematch: Mappable {
    
    var expatriates: GetDefaultConf_expatriates?
    var gcc: GetDefaultConf_gcc?
    var omani: GetDefaultConf_omani?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        expatriates <- map["expatriates"]
        gcc <- map["gcc"]
        omani <- map["omani"]
        
    }
}
class GetDefaultConf_expatriates: Mappable {
    
    var one: String = ""
    var two: String = ""
    var three: String = ""
    var four: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        one <- map["1"]
        two <- map["2"]
        three <- map["3"]
        four <- map["4"]
        
    }
}
class GetDefaultConf_gcc: Mappable {
    
    var one: String = ""
    var two: String = ""
    var three: String = ""
    var four: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        one <- map["1"]
        two <- map["2"]
        three <- map["3"]
        four <- map["4"]
        
    }
}
class GetDefaultConf_omani: Mappable {
    
    var one: String = ""
    var two: String = ""
    var three: String = ""
    var four: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        one <- map["1"]
        two <- map["2"]
        three <- map["3"]
        four <- map["4"]
        
    }
}
