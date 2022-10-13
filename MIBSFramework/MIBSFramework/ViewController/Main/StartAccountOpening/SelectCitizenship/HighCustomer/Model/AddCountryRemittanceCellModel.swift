//
//  AddCountryRemittanceCellModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 18/02/22.
//

import Foundation
//import ObjectMapper

class AddCountryRemittanceCellModel: Mappable {
    
    var title: String = ""
    
    var txtNameofCountry_title: String = ""
    var txtNameofCountry_placeHolder: String = ""
    var txtNameofCountry_text: String = ""
    
    var txtExpectedPurpose_title: String = ""
    var txtExpectedPurpose_placeHolder: String = ""
    var txtExpectedPurpose_text: String = ""
    
    init() {
    }

    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        title <- map["title"]
        
        txtNameofCountry_title <- map["txtNameofCountry_title"]
        txtNameofCountry_placeHolder <- map["txtNameofCountry_placeHolder"]
        txtNameofCountry_text <- map["txtNameofCountry_text"]
        
        txtExpectedPurpose_title <- map["txtExpectedPurpose_title"]
        txtExpectedPurpose_placeHolder <- map["txtExpectedPurpose_placeHolder"]
        txtExpectedPurpose_text <- map["txtExpectedPurpose_text"]
    }
}
