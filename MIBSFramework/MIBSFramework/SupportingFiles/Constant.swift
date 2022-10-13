//
//  Constant.swift
//  BeeCrops
//
//  Created by Maulik Vinodbhai Vora on 24/07/19.
//  Copyright © 2019 Maulik Vora. All rights reserved.
//
import UIKit
import Foundation
//import AnyFormatKit
//let appDelegate = UIApplication.shared.delegate as! AppDelegate
var isLoadingViewVisible = false

//Google Api Key
let googleApiKey = ""



//Veiable
var getListOfCountriesData = [GetListOfCountriesData]()
var dropDownOptionsListModel = DropDownOptionsListModel()

let defaultTextLimit = 51
let k_DateFormate = "yyyy-MM-dd HH:mm:ss"
let k_DateFormate_Date = "dd/MM/yyyy"
let k_DateFormate_Time = "hh:mm"
let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first

 


//MARK: - Storyboards Objects
let objMainSB = UIStoryboard(name: "Main", bundle: bundleIdentifireGlob)
let objSideMenuSB = UIStoryboard(name: "SideMenuSB", bundle: bundleIdentifireGlob)








//MARK: - Veriable
let termAndConditionURL = "https://www.maisarah-oman.com/assets/pdf/MIBS_AO_Terms_Conditions.pdf"//"https://www.bankdhofar.com/en-GB/Terms_and_Conditions_Governing_Accounts.aspx"
let kAlertTitle = "Maisarah"
var citizenshipType = CitizenshipType.non
var serviceType = ServiceType.non
let moneyFormatter = SumTextInputFormatter(textPattern: "#,###.###")
var validateOTPStep = ""
var selectMobileCountryCode = "968"
var characterSET = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."
var characterSETdigit = "1234567890.,"
var characterSETEmail = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@"
var popoverBackgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.8)






//MARK: - DeviceInfo
let deviceInfo = ["device_id":kDevice_id,
                  "ip_info":"\(AppHelper.getIP() ?? "")",
                  "braswer_info":"",
                  "os_info":[["name":"ios","version":"\(Bundle.main.releaseVersionNumber ?? "")"]],
                  "other_info":[[:]]
] as [String : Any]




