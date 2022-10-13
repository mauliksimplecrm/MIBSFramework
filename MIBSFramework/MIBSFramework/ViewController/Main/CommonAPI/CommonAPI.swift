//
//  CommonAPI.swift
//  Maisarah
//
//  Created by Maulik Vora on 10/07/22.
//

import Foundation
import UIKit

func apiCall_getApplicationData(showProgress:Bool? = nil, completionOut: (@escaping(GetApplicationDataResult) -> ()))  {
    
    //--
    let dicParam:[String:AnyObject] = ["operation": "getApplicationData" as AnyObject,
                                       "data": ["id": Login_LocalDB.getApplicationInfo().crmid
                                               ] as AnyObject]
    HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: showProgress ?? false, completion: { (response) in
        print(response as Any)
        let getApplicationDataModel = GetApplicationDataModel(JSON: response as! [String : Any])!
        if getApplicationDataModel.Response?.Code == "200"{
            if getApplicationDataModel.Response?.Body?.status == "Success"{
                //--
                if let result = getApplicationDataModel.Response?.Body?.Result{
                    completionOut(result)
                }
            }else{
                //self.view.makeToast(getApplicationDataModel.Response?.Body?.statusMsg ?? "")
            }
        }else{
            //self.view.makeToast(getApplicationDataModel.message)
        }
    }) { (error) in
        print(error)
    }
}

func apiCall_getDocumentsList(showProgress:Bool? = nil, completionOut: (@escaping(GetDocumentsListResponse) -> ()))  {
    
    //--
    let dicParam:[String:AnyObject] = ["operation": "getDocumentsList" as AnyObject,
                                       "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid
                                               ] as AnyObject]
    HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: showProgress ?? false, completion: { (response) in
        print(response as Any)
        let getDocumentsListModel = GetDocumentsListModel(JSON: response as! [String : Any])!
        if getDocumentsListModel.Response?.status == "Success"{
            //--
            if let result = getDocumentsListModel.Response{
                completionOut(result)
            }
            
        }else{
            //self.view.makeToast(getApplicationDataModel.message)
        }
    }) { (error) in
        print(error)
    }
}

func getApplicationPreviewLink(completionOut: (@escaping(_ application_preview_link:String,_ errorMSG: String) -> ()))  {
    
    //--
    let dicParam:[String:AnyObject] = ["operation": "getApplicationPreviewLink" as AnyObject,
                                       "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid
                                               ] as AnyObject]
    HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], completion: {  (response) in
        print(response as Any)
        let getApplicationDataModel = GetApplicationDataModel(JSON: response as! [String : Any])!
        if getApplicationDataModel.Response?.Body?.status == "Success"{
            //--
            completionOut(getApplicationDataModel.Response?.Body?.Result?.application_preview_link ?? "","")
        }else{
            completionOut("",getApplicationDataModel.Response?.Body?.statusMsg ?? "")
        }
    }) { (error) in
        print(error)
    }
}

func getListOfCountries(completionOut: (@escaping(_ countryList:[GetListOfCountriesData],_ errorMSG: String) -> ()))  {
    
    //--
    let dicParam:[String:AnyObject] = ["operation": "getListOfCountries" as AnyObject,
                                       "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid
                                               ] as AnyObject]
    HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: {  (response) in
        print(response as Any)
        let getListOfCountriesModel = GetListOfCountriesModel(JSON: response as! [String : Any])!
        if getListOfCountriesModel.Response?.Body?.status == "Success"{
            //--
            if let data_ = getListOfCountriesModel.Response?.Body?.data{
                completionOut(data_,"")
            }else{
                completionOut([GetListOfCountriesData](), getListOfCountriesModel.Response?.Body?.statusMsg ?? "")
            }
        }else{
            completionOut([GetListOfCountriesData](),getListOfCountriesModel.Response?.Body?.statusMsg ?? "")
        }
    }) { (error) in
        print(error)
    }
}

var getDefaultConfiguration: GetDefaultConfiguration?
func apiCall_getDefaultConfiguration()  {
    //--
    let dicParam:[String:AnyObject] = ["operation":"getDefaultConfiguration" as AnyObject,
                                       "data":[
                                               "device_info":deviceInfo
                                              ] as AnyObject]
    HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { (response) in
        print(response as Any)
        let getDefaultConfigurationModel = GetDefaultConfigurationModel(JSON: response as! [String : Any])!
        if getDefaultConfigurationModel.response?.body?.status == "Success"{
            if let configuration = getDefaultConfigurationModel.response?.body?.result?.configuration{
                getDefaultConfiguration = configuration
            }
        }else{
            
        }
    }) { (error) in
        print(error)
    }
}

//--
let popoverRetryApiCall = Popover()

func showAlertForRetryApiCall(view_: UIView, completionOut: (@escaping(_ onClickRetry: Bool) -> ())){
    //--
    
    let alert = InProgressAppAlertView.instanceFromNib()
    //--
    alert.lblTitle.text = Localize(key: "Alert")
    alert.lblMessage.text = Localize(key: "something_went_wrong")
    alert.btnGotoApplication.isHidden = true
    alert.btnContinueApplication.setTitle(Localize(key: "CANCEL"), for: .normal)
    alert.didTappedContinueAPP = {  (sender) in
        popoverRetryApiCall.dismiss()
        completionOut(false)
    }
    alert.btnCancel.setTitle(Localize(key: "RETRY"), for: .normal)
    alert.didTappedCancel = { (sender) in
        popoverRetryApiCall.dismiss()
        completionOut(true)
    }
    
    //--
    alert.frame.size = CGSize(width: UIScreen.main.bounds.width-30, height: alert.viewBG.frame.height)
    let aView = UIView()
    aView.frame = alert.frame
    aView.addSubview(alert)
    popoverRetryApiCall.dismissOnBlackOverlayTap = false
    popoverRetryApiCall.blackOverlayColor = popoverBackgroundColor
    popoverRetryApiCall.showAsDialog(alert, inView: view_)
}
