//
//  DebitCardVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 19/02/22.
//

import UIKit

var dicAddonServicesCRMData:[String: AnyObject] = [:]
class DebitCardVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var txtReceiveCard: UIFloatingTextField!
    @IBOutlet weak var lblGenerateVirtualCall_info: UILabel!
    @IBOutlet weak var lblTearmAndCondition: UILabel!
    @IBOutlet weak var viewbgNext: UIView!
    @IBOutlet weak var lblNext: UILabel!
    
    //--
    @IBOutlet weak var viewStepFooter: UIView!
    @IBOutlet weak var progressStepFooter: UIProgressView!
    @IBOutlet weak var lblViewStepFooter: UILabel!
    @IBOutlet weak var lblNextStepFooter: UILabel!
    @IBOutlet weak var viewNextStepFooter: UIView!
    
    
    
    
    //MARK: - Veriable
    var selectReceiveCardIndex = -1
    //var arrListReciveCard = ["Collecting from any branch", "Printing from Kiosk", "Only Digital Card", "Delivery to me"]
    var addonServices = AddonServices.debitcard
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        setupBasic()
        setupTextField()
        validateEnput()
    }
    override func viewWillAppear(_ animated: Bool) {
        progressStepFooter.setProgress(0.5, animated: true)
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblTitle.text = Localize(key: "Debit Card details")
        lblDetail.text = Localize(key: "Debit Card detail")
        lblGenerateVirtualCall_info.text = Localize(key: "We will generate a virtual card for you to use immediately")
        
        lblTearmAndCondition.attributedText = Localize(key: "My clicking Next, you agree to our Terms & Conditions").underlineWords(words: [Localize(key: "Terms & Conditions")], color: .DARKGREENTINT)
        //lblTC_Click.text = Localize(key: "Terms & Conditions")

        lblViewStepFooter.text = Localize(key: "VIEW STEPS")
        lblNext.text = Localize(key: "NEXT")
        lblNextStepFooter.text = Localize(key: "NEXT")
        
        if Managelanguage.getLanguageCode() == "A"
        {
            txtReceiveCard.txtType.textAlignment = .right
            lblTitle.textAlignment = .right
            lblDetail.textAlignment = .right
            lblGenerateVirtualCall_info.textAlignment = .right
            
        }
    }
    func setupHeader(){
         
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    func setupBasic(){
        //AppHelper.disableNextBTN(view_: viewbgNext)
        //AppHelper.disableNextBTN(view_: viewNextStepFooter)
        
        //--
        if addonServices == .both{
            viewStepFooter.isHidden = false
        }else{
            viewStepFooter.isHidden = true
        }
        //--
            //attributedStringWithColor(["Personal"], color: UIColor(named: "DARKGREENTINT")!)
    }
    func setupTextField(){
        
        txtReceiveCard.setTitlePlaceholder(text_: Localize(key: "How will you receive the card?"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtReceiveCard.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .debit_card_collection_c)
            self.openDropDownPicker(headerTitle: Localize(key: "How will you receive the card?"),
                                    dropDownType: "receiveCard",
                                    arrList: list,
                                    selectedIndex: self.selectReceiveCardIndex)
        }
    }

    func validateEnput() {
        var returnValue = true
        
        if AppHelper.isNull(txtReceiveCard.txtType.text!){
            //txtName.lblError.isHidden = false
            returnValue = false
        }
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewbgNext)
            AppHelper.enableNextBTN(view_: viewNextStepFooter)
        }else{
            AppHelper.disableNextBTN(view_: viewbgNext)
            AppHelper.disableNextBTN(view_: viewNextStepFooter)
        }
    }

    //MARK: @IBAction
    @IBAction func btnInfoGenerateVirtualCard(_ sender: Any) {
        
    }
    @IBAction func btnNext(_ sender: Any) {
        apiCall_updateApplication()
    }
    @IBAction func btnTearmCondition(_ sender: Any) {
        AppHelper.openDocuemtnBrowser(docUrl: termAndConditionURL, nav: self.navigationController!)
    }
    @IBAction func btnViewStep(_ sender: Any) {
        //--
        let vc = StepIndicatorVC(nibName: "StepIndicatorVC", bundle: bundleIdentifireGlob)
        vc.selectIndex = 0
        vc.totalStep = 2
        vc.progress = 0.5
        vc.arrListOfDropDown = [Localize(key: "Debit Card details"), Localize(key: "Mobile banking details")]
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnNextStepFooter(_ sender: Any) {
        //--
        let vc = MobileBankingVC(nibName: "MobileBankingVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    /*@objc func textFieldDidChange(textField: UITextField){
        textField.endEditing(true)
        if textField == txtReceiveCard.txtType{
            //--
            let vc = CustomDorpDownVC(nibName: "CustomDorpDownVC", bundle: nil)
            vc.delegate_didSelectCustomDropDown_Protocol = self
            vc.headerTitle = Localize(key: "How will you receive the card?")
            vc.dropDownType = "receiveCard"
            vc.arrListOfDropDown = arrListReciveCard
            vc.selectIndex = selectReceiveCardIndex
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
    }*/
    
    
}

extension DebitCardVC: didSelectCustomDropDown_Protocol{
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String) {
        if droDownType == "receiveCard"{
            selectReceiveCardIndex = index
            
            //--
            let debit_card_collection_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_c, index: selectReceiveCardIndex)
            if debit_card_collection_c == "only_digital_card"{
                //--
                txtReceiveCard.txtType.text = ""
                txtReceiveCard.txtType.insertText(title)
                txtReceiveCard.iconFill.isHidden = AppHelper.isNull(txtReceiveCard.txtType.text!) == false ? false : true
                validateEnput()
            }else{
                //--
                let vc = AnyBranchInfoVC(nibName: "AnyBranchInfoVC", bundle: bundleIdentifireGlob)
                vc.modalPresentationStyle = .fullScreen
                vc.addonServices = addonServices
                //vc.delegate_SubmitAnyBranchInfo_protocol = self
                vc.delegate_didSelectCustomDropDown_Protocol = self
                vc.arrListOfDropDown = ManageDropDownOption.getDropDownValue(dropdown_filed: .debit_card_collection_c)
                vc.header1Detail = title
                vc.selectIndex = selectReceiveCardIndex
                vc.dropDownType = "receiveCard_submit"
                vc.didTappedTC = { (sender) in
                    self.dismiss(animated: true, completion: nil)
                    AppHelper.openDocuemtnBrowser(docUrl: termAndConditionURL, nav: self.navigationController!)
                }
                self.present(vc, animated: true, completion: nil)
            }
        }
        if droDownType == "receiveCard_submit"{
            txtReceiveCard.txtType.text = title
            selectReceiveCardIndex = index
            txtReceiveCard.iconFill.isHidden = AppHelper.isNull(txtReceiveCard.txtType.text!) == false ? false : true
            validateEnput()
        }
    }
}

//MARK: - Api Call
extension DebitCardVC{
   
    func apiCall_updateApplication()  {
        //--
        let debit_card_collection_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_c, index: selectReceiveCardIndex)
        
        dicAddonServicesCRMData["debit_card_collection_c"] = debit_card_collection_c as AnyObject
        dicAddonServicesCRMData["need_debit_card_c"] = "Yes" as AnyObject
        dicAddonServicesCRMData["need_mobile_banking_c"] = "No" as AnyObject
        
        //--
        dicAddonServicesCRMData.removeValue(forKey: "debit_card_datetime_c_backendvalue")
        
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "device_info": deviceInfo,
                                                    "crm_data": dicAddonServicesCRMData
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "200"{
                if oTPGenerationModel.Response?.Body?.status == "Success"{
                    //--
                    let vc = VirtualDebitCardVC(nibName: "VirtualDebitCardVC", bundle: bundleIdentifireGlob)
                    vc.addonServices = addonServices
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.view.makeToast(oTPGenerationModel.Response?.Body?.statusMsg ?? "")
                }
            }else{
                self.view.makeToast(oTPGenerationModel.message)
            }
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_updateApplication()
                }
            }
        }
    }
}


extension DebitCardVC: SubmitAnyBranchInfo_protocol{
    func onSuccess(){
        //--
        let vc = VirtualDebitCardVC(nibName: "VirtualDebitCardVC", bundle: bundleIdentifireGlob)
        vc.addonServices = addonServices
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
