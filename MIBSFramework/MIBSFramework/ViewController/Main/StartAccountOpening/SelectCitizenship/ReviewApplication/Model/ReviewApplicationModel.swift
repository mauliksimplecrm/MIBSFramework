//
//  ReviewApplicationModel.swift
//  Maisarah
//
//  Created by Maulik Vora on 03/07/22.
//

import Foundation
//import ObjectMapper

class RAData {
    var title: String?
    var detail: String?
    var cellType: RACellType
    var formType: RAFormType
    var subData: [Any]
    var frontImg: String?
    var backImg: String?
    
    internal init(title: String? = nil, detail: String? = nil, cellType: RACellType = .non, formType: RAFormType = .non, subData: [Any] = [], frontImg: String? = nil, backImg: String? = nil) {
        self.title = title
        self.detail = detail
        self.cellType = cellType
        self.formType = formType
        self.subData = subData
        self.frontImg = frontImg
        self.backImg = backImg
    }
}

enum RACellType: String {
    case non = "non"
    case rTitle = "title"
    case rSubTitle = "subtitle"
    case rDocument = "document"
    case rOtherDoc = "otherDoc"
    case rTitleDetail = "titleDetail"
}

enum RAFormType: String {
    case non = "non"
    case citizenship = "citizenship"
    case personalInformation = "personalInformation"
    case financialInformation = "financialInformation"
    case regularityDeclaration = "regularityDeclaration"
}
