//
//  Login_LocalDB.swift
//  DatingApp
//
//  Created by Maulik Vinodbhai Vora on 24/09/19.
//  Copyright © 2019 Maulik Vora. All rights reserved.
//

import Foundation
struct Login_UserKey {
    static let address: String = "address"
    static let api_token: String = "api_token"
    static let dob: String = "dob"
    static let email: String = "email"
    static let user_id: String = "id"
    static let image: String = "image"
    static let p_mobile_no: String = "p_mobile_no"
    static let p_name: String = "p_name"
    static let fcm_id: String = "fcm_id"
    static let s_mobile_no: String = "s_mobile_no"
    static let s_name: String = "s_name"
    static let fcm_token: String = "fcm_token"
    static let device_type: String = "device_type"
    
    //--tutor key
    static let unique_id: String = "unique_id"
    
}

class Login_LocalDB: NSObject
{
    class func saveLoginInfo(strData: String)
    {
        //--
        UserDefaults.standard.set(strData, forKey: "login_response")
        UserDefaults.standard.synchronize()
    }
    class func getLoginUserModel() -> MobileApiModel
    {
        let login_response = UserDefaults.standard.object(forKey: "login_response") as? String ?? ""
        if login_response.count != 0
        {
            return MobileApiModel(JSONString: login_response)!
        }
        else
        {
            return MobileApiModel()
        }
    }
    class func saveApplicationsInfo(strData: String)
    {
        //--
        UserDefaults.standard.set(strData, forKey: "applicationInfo_response")
        UserDefaults.standard.synchronize()
    }
    class func getApplicationInfo() -> ValidateOTPApplications
    {
        let login_response = UserDefaults.standard.object(forKey: "applicationInfo_response") as? String ?? ""
        if login_response.count != 0
        {
            return ValidateOTPApplications(JSONString: login_response)!
        }
        else
        {
            return ValidateOTPApplications()
        }
    }
    
}


class Managelanguage: NSObject{
    class func setUIAccordingLanguage(){
        let languageCode = getLanguageCode()
        if languageCode == "A"
        {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    class func changeLanguageCode(){
        let languageCode = getLanguageCode()
        if languageCode == "A"
        {
            UserDefaults.standard.set("L", forKey: "LanguageCode")
            UserDefaults.standard.synchronize()
        }
        else
        {
            UserDefaults.standard.set("A", forKey: "LanguageCode")
            UserDefaults.standard.synchronize()
        }
    }
    class func getLanguageCode() -> String{
        let languageCode = UserDefaults.standard.object(forKey: "LanguageCode") as? String ?? "L"
        return languageCode
    }

}
func Localize(key:String) -> String
{
    var path: String?
    var fname: String?
    let selectedLanguage = Managelanguage.getLanguageCode()
    if selectedLanguage == "A" {
        path = bundleIdentifireGlob?.path(forResource: "ar", ofType: "lproj")
        fname = "\(path ?? "")/Arabic.strings"
    } else {
        path = bundleIdentifireGlob?.path(forResource: "en", ofType: "lproj")
        fname = "\(path ?? "")/English.strings"
    }
    let d = NSDictionary(contentsOfFile: fname ?? "") as Dictionary?
    let loc = d?[key as NSObject] as? String
    
    return loc ?? ""
}

