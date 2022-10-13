//
//  GetNotificationDetailsModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 14/07/22.
//

import Foundation
//import ObjectMapper

class GetNotificationDetailsModel: Mappable {
    
    var Response: GetNotificationDetailsResponse?
    
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

class GetNotificationDetailsResponse: Mappable {
    
    var Body: GetNotificationDetailsBody?
    var Code: String = ""
    

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        Body <- map["Body"]
        Code <- map["Code"]
    }
}

class GetNotificationDetailsBody: Mappable {
    
    var Result: GetNotificationDetailsResult?
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

class GetNotificationDetailsResult: Mappable {
    
    var notifications: [GetNotificationDetailsList] = []
    
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        notifications <- map["notifications"]
        
        
    }
}
class GetNotificationDetailsList: Mappable {
    
    var date: String = ""
    var description: String = ""
    var icon: String = ""
    var link: String = ""
    var name: String = ""
    var notification_crmid: String = ""
    var read_status: Int = 0
    var short_Desc: String = ""
    var status: String = ""
    var type: String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        date <- map["date"]
        description <- map["description"]
        icon <- map["icon"]
        link <- map["link"]
        name <- map["name"]
        notification_crmid <- map["notification_crmid"]
        read_status <- map["read_status"]
        short_Desc <- map["short_Desc"]
        status <- map["status"]
        type <- map["type"]
        
    }
}
