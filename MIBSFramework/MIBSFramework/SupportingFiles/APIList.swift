//
//  APIList.swift
//  Maisarah
//
//  Created by Maulik Vora on 18/05/22.
//

import Foundation


//MARK: - Api URL
let kClient_id = "34fc68bb-f75e-25db-0ebb-620fd3988d9e"
let kClient_secret = "mibs"
let kDevice_id = "adcdfdcf2d6d1fcb"


let applyValidation = true
let instanceType = InstanceURL.Test

//let kCRM_BASE_URL = "https://mibsv267.simplecrmdev.com" //dev
let kCRM_BASE_URL = "https://mibscrmapptest.dob.maisarah-oman.com:5002" //test v267
//let kCRM_BASE_URL = "https://dcobmea.simplecrmdemo.com" // Demo URL

/*
 this is v267 -----> https://mibscrmapptest.dob.maisarah-oman.com:5002
 this is v3 ------> https://mibscrmappv3test.dob.maisarah-oman.com:5001
 */

//--Api Name
let A_mobileapi = kCRM_BASE_URL + "/custom/mobileapi.php"
let a_mibs = kCRM_BASE_URL + "/Api/V8/mibs"




enum InstanceURL: String {
    case Test = "test"
    case Dev = "dev"
}

