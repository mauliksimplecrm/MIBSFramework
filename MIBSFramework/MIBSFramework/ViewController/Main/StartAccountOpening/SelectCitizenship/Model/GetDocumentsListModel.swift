//
//  GetDocumentsListModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 11/07/22.
//

import Foundation
//import ObjectMapper

class GetDocumentsListModel: Mappable {
    
    var status: Int = 0
    var message: String = ""
    var Response: GetDocumentsListResponse?
    
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
class GetDocumentsListResponse: Mappable {
    
    var status: String = ""
    var statusCode: Int = 0
    var statusMsg: String = ""
    var documents: [GetDocumentsListDocuments] = []
    
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
        statusCode <- map["statusCode"]
        statusMsg <- map["statusMsg"]
        documents <- map["documents"]
        
        //Error
        error <- map["error"]
        hint <- map["hint"]
    }
}

class GetDocumentsListDocuments: Mappable {
    
    var card_type: String = ""
    var doc_id: String = ""
    var document_link: String = ""
    var document_type: String = ""
    var edit_staus: Int = 0
    var name: String = ""
    var status: String = ""
    
    init() {
    }

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        card_type <- map["card_type"]
        doc_id <- map["doc_id"]
        document_link <- map["document_link"]
        document_type <- map["document_type"]
        edit_staus <- map["edit_staus"]
        name <- map["name"]
        status <- map["status"]
        
    }
}
