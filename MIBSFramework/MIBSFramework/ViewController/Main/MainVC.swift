//
//  MainVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 21/01/22.
//

import UIKit
//import Toast_Swift
//import Popover

class MainVC: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblChooseOneTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblResumeAccountOpennig_title: UILabel!
    @IBOutlet weak var lblResumeAccountOpennig_detail: UILabel!
    @IBOutlet weak var lblStartAccountOpening_title: UILabel!
    @IBOutlet weak var lblStartAccountOpening_detail: UILabel!
    @IBOutlet weak var lblScheduleVideoCall_title: UILabel!
    @IBOutlet weak var lblScheduleVideoCall_detail: UILabel!
    @IBOutlet weak var lblCheckApplicationStatus_title: UILabel!
    @IBOutlet weak var lblCheckApplicationStatus_detail: UILabel!
    @IBOutlet weak var lblStartVideoCall: UILabel!
    @IBOutlet weak var lblStartScheduledCallDetail: UILabel!
    @IBOutlet weak var lblTitle_addonservices: UILabel!
    @IBOutlet weak var lblDetail_addonservices: UILabel!
    @IBOutlet weak var lblTitle_AdditionalInformation: UILabel!
    @IBOutlet weak var lblDetail_AdditionalInformation: UILabel!
    @IBOutlet weak var lblTitleHighRiskCustomer: UILabel!
    @IBOutlet weak var lblDetailHighRiskCustomer: UILabel!
    @IBOutlet weak var lblTitleVeryHighRiskCustomer: UILabel!
    @IBOutlet weak var lblDetailVeryHighRiskCustomer: UILabel!
    @IBOutlet weak var lblTitleStartVideoCall: UILabel!
    @IBOutlet weak var lblDetailStartVideoCall: UILabel!
    @IBOutlet weak var lblTitle_notification: UILabel!
    @IBOutlet weak var lblDetail_notification: UILabel!
    
    
    
    
    //MARK: - Veriable
    var popover = Popover()
    
    // MARK: LifeCycle Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        setupHeader()
        
        //--
        enterMobileNumber = ""
        enterEmail = ""
        dicAddonServicesCRMData = [:]
        
        //--
        if Login_LocalDB.getApplicationInfo().crmid.count != 0{
            //--
            //citizenshipType = .omani
            //let vc = PersonalInfoVC(nibName: "PersonalInfoVC", bundle: nil)
            //self.navigationController?.pushViewController(vc, animated: true)
            
            //--
            //let vc = VideoCallVC(nibName: "VideoCallVC", bundle: nil)
            //self.navigationController?.pushViewController(vc, animated: true)
            
            //--
            MainVC.apiCall_getDropDownOptions()
        }else{
            MainVC.apiCall_login()
        }

        //--
        configureLightBox()
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        localization()
    }
    
    func configureLightBox(){
        LightboxConfig.CloseButton.text = Localize(key: "CANCEL")
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = Localize(key: "CANCEL")

    }
    func setupHeader(){
       
        headerView.didTappedBack = { (sender) in
            //exit(0)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    func setupBasic(){
        let length_ = Managelanguage.getLanguageCode() == "A" ? 6 : 3
        lblChooseOneTitle.attributedText = Localize(key: "Choose one").attributedStringWithColorNew(7, length: length_, color: .DARKGREENTINT)
        //attributedStringWithColor(["one"], color: UIColor(named: "DARKGREENTINT")!)
        lblDetail.text = Localize(key: "Choose one detail")
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblResumeAccountOpennig_title.text = Localize(key: "ResumeAccountOpennig_title")
        lblResumeAccountOpennig_detail.text = Localize(key: "ResumeAccountOpennig_detail")
        lblStartAccountOpening_title.text = Localize(key: "StartAccountOpening_title")
        lblStartAccountOpening_detail.text = Localize(key: "StartAccountOpening_detail")
        lblScheduleVideoCall_title.text = Localize(key: "ScheduleVideoCall_title")
        lblScheduleVideoCall_detail.text = Localize(key: "ScheduleVideoCall_detail")
        lblCheckApplicationStatus_title.text = Localize(key: "CheckApplicationStatus_title")
        lblCheckApplicationStatus_detail.text = Localize(key: "CheckApplicationStatus_detail")
        lblTitle_notification.text = Localize(key: "notifications")
        lblDetail_notification.text = Localize(key: "notifications_info")
        
        lblTitle_addonservices.text = Localize(key: "Add-on Services")
        lblDetail_addonservices.text = Localize(key: "View the services associated with the account")
        lblTitle_AdditionalInformation.text = Localize(key: "Additional Information")
        lblDetail_AdditionalInformation.text = Localize(key: "Submit document as a proof of address")
        lblTitleHighRiskCustomer.text = Localize(key: "High Risk Customer")
        lblDetailHighRiskCustomer.text = Localize(key: "high_risk_customer_info")
        lblTitleVeryHighRiskCustomer.text = Localize(key: "very_high_risk_customer")
        lblDetailVeryHighRiskCustomer.text = Localize(key: "very_high_risk_customer_info")
        lblStartVideoCall.text = Localize(key: "start_video_call")
        lblDetailStartVideoCall.text = Localize(key: "start_video_call_info")
        
    }
    
    // MARK: @IBAction
    func skipp(){
        let vc = PersonalInfoVC(nibName: "PersonalInfoVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    @IBAction func btnResumeAccOpening(_ sender: Any) {
        serviceType = .ResumeAccountOpening
        validateOTPStep = "resumeFlow"
        
        //--
        //skipp()
        
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
        
        /*
         //--Temp
         citizenshipType = .omani
         let vc = RegularityDeclVC(nibName: "RegularityDeclVC", bundle: nil)
         self.navigationController?.pushViewController(vc, animated: true)
         */
    }
    @IBAction func btnStartAccOpening(_ sender: Any) {
        validateOTPStep = "new"
        //--
        let vc = objMainSB.instantiateViewController(withIdentifier: "SelectAccountTypeVC") as! SelectAccountTypeVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        //        //--
        //        let vc = LivenessCheckVC(nibName: "LivenessCheckVC", bundle: nil)
        //        vc.citizenshipType = .omani
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnScheduleVideoCall(_ sender: Any) {
        serviceType = .ScheduleVideoCall
        validateOTPStep = "resumeFlow"
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
        
        /*
         //Temp
         //--
         let vc = ScheduleVideoCallVC(nibName: "ScheduleVideoCallVC", bundle: nil)
         vc.isComeFromLivenessCheck = true
         self.navigationController?.pushViewController(vc, animated: true)
         //--
         let vc = ScheduleVideoCallVC(nibName: "ScheduleVideoCallVC", bundle: nil)
         self.navigationController?.pushViewController(vc, animated: true)*/
    }
    @IBAction func btnCheckApplication(_ sender: Any) {
        serviceType = .CheckApplicationStatus
        validateOTPStep = "checkStatus"
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnChangeLang(_ sender: Any) {
        var selectIndex = 0
        if Managelanguage.getLanguageCode() == "A"{
            selectIndex = 1
        }
        
        self.openDropDownPicker(headerTitle: Localize(key: "choose_language"),
                                dropDownType: "language",
                                arrList: ["English","عربي"],
                                selectedIndex: selectIndex)
        
    }
    
    //Other Flows
    @IBAction func btnAddOnServices(_ sender: Any) {
        serviceType = .AddOnServices
        validateOTPStep = "resumeFlow"
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
        
        /*
        //--Temp
        let vc = AddonServicesVC(nibName: "AddonServicesVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)*/
    }
    @IBAction func btnProofOfAddress(_ sender: Any) {
        serviceType = .ProofOfAddress
        validateOTPStep = "resumeFlow"
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
        
        /*//--
         let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: nil)
         vc.isComeForAddingProofofAddress = true
         self.navigationController?.pushViewController(vc, animated: true)*/
    }
    @IBAction func btnHighRishCustomer(_ sender: Any) {
        serviceType = .HighRiskCustomer
        validateOTPStep = "resumeFlow"
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
        /*//--
         let vc = HighCustomerVC(nibName: "HighCustomerVC", bundle: nil)
         self.navigationController?.pushViewController(vc, animated: true)
         */
    }
    @IBAction func btnVeryHighRishCustomer(_ sender: Any) {
        serviceType = .VeryHighRiskCustomer
        validateOTPStep = "resumeFlow"
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
        /*
         //--
         let vc = VeryHighCustomerVC(nibName: "VeryHighCustomerVC", bundle: nil)
         self.navigationController?.pushViewController(vc, animated: true)
         */
    }
    @IBAction func btnStartVideoCall(_ sender: Any) {
        serviceType = .StartVideoCall
        validateOTPStep = "resumeFlow"
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnNotification(_ sender: Any) {
        serviceType = .AllNotifications
        validateOTPStep = "resumeFlow"
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
        
        //--70000146
//        let vc = objMainSB.instantiateViewController(withIdentifier: "NotificationSBVC") as! NotificationSBVC
//        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
}


//MARK: - Api Call
extension MainVC{
    class func apiCall_login()  {
        //--
        //let devicetoken = UserDefaults.standard.object(forKey: "fcm_devicetoken") as? String ?? "asdfghjhgfds"
        
        //--
        let dicParam:[String:AnyObject] = ["operation":"login" as AnyObject,
                                           "data":["client_id":kClient_id,
                                                   "client_secret":kClient_secret,
                                                   "grant_type":"client_credentials",
                                                   "language":Managelanguage.getLanguageCode()] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: A_mobileapi, dicsParams: dicParam, headers: [:], showProgress: false, completion: { [self] (response) in
            print(response as Any)
            let mobileApiModel = MobileApiModel(JSON: response as! [String : Any])!
            if mobileApiModel.status == 200{
                //--
                if let mobileApiModel_ = MobileApiModel(JSON: response as! [String : Any])!.toJSONString(){
                    Login_LocalDB.saveLoginInfo(strData: mobileApiModel_)
                }
                //--
                apiCall_getDropDownOptions()
            }else{
                AppHelper.returnTopNavigationController().view.makeToast(response.object(forKey: "message") as? String ?? "")
            }
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { onClickRetry in
                if onClickRetry{
                    apiCall_login()
                }
            }
        }
    }
    
    class func apiCall_getDropDownOptions()  {
        
        //--
        let dicParam:[String:AnyObject] = ["operation":"getDropDownOptions" as AnyObject,
                                           "data":["modulename":"Opportunities",
                                                   "language":Managelanguage.getLanguageCode(),
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { (response) in
            print(response as Any)
            dropDownOptionsListModel = DropDownOptionsListModel(JSON: response as! [String : Any])!
            if dropDownOptionsListModel.response?.Code == "200"{
                
            }else if dropDownOptionsListModel.error == "access_denied"{
                apiCall_login()
            }else{
                AppHelper.returnTopNavigationController().view.makeToast(dropDownOptionsListModel.message)
            }
            
            //--
            getListOfCountries { countryList, errorMSG in
                //--
                var getListOfCountriesData_local = [GetListOfCountriesData]()
                countryList.forEach { objc in
                    if objc.country_code != ""{
                        getListOfCountriesData_local.append(objc)
                    }
                }
                getListOfCountriesData = getListOfCountriesData_local
                
                //--
                apiCall_getDefaultConfiguration()
            }
            
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { onClickRetry in
                if onClickRetry{
                    apiCall_getDropDownOptions()
                }
            }
        }
    }
   
    
}

extension MainVC: didSelectCustomDropDown_Protocol{
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String) {
        if droDownType == "language"{
            if index == 0{
                if Managelanguage.getLanguageCode() == "A"{
                    changeLng()
                }
            }else{
                if Managelanguage.getLanguageCode() != "A"{
                    changeLng()
                }
            }
            
            
        }
    }
    
    func changeLng(){
        Managelanguage.changeLanguageCode()
        MainVC.apiCall_getDropDownOptions()
        //--
        let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
