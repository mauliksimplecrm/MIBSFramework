//
//  EnterMobileEmailVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 21/01/22.
//

import UIKit
//import SKCountryPicker


var enterMobileNumber = ""
var enterEmail = ""



class EnterMobileEmailVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var txtMobileNumber: FloatingTextFieldWithCode!
    @IBOutlet weak var txtEmail: UIFloatingTextField!
    @IBOutlet weak var viewbgbtnNext: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblNext: UILabel!
    
    
    //MARK: - Veriable
    var comeForSelectAccountTypeVC = false
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupBasic()
        
        if enterMobileNumber.count != 0{
            txtMobileNumber.txtType.text = enterMobileNumber
            validateEnput()
        }
        if enterEmail.count != 0{
            txtEmail.txtType.text = enterEmail
            validateEnput()
        }
        
        
        //temp
        txtMobileNumber.txtType.text = "10000088"
        txtEmail.txtType.text = ""
        txtEmail.txtType.insertText("test@gmail.com")
        validateEnput()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        localization()
        
        //clear common variable
        openPreSelectCitizenshipScreen = ""
    }
    func setupHeader(){
         
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            if self.comeForSelectAccountTypeVC{
                //--
                let vc = objMainSB.instantiateViewController(withIdentifier: "SelectAccountTypeVC") as! SelectAccountTypeVC
                self.navigationController?.pushViewController(vc, animated: false)
            }else{
                //--
                let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    func setupBasic(){
        if applyValidation{
            AppHelper.disableNextBTN(view_: viewbgbtnNext)
        }
        
        //--
        let length_ = Managelanguage.getLanguageCode() == "A" ? 17 : 7
        let location_ = Managelanguage.getLanguageCode() == "A" ? 5 : 6
        lblTitle.attributedText = Localize(key: "Enter details").attributedStringWithColorNew(location_, length: length_, color: .DARKGREENTINT)
        lblDetail.text = Localize(key: "Enter details detail")
        
        //--
        txtMobileNumber.setTitlePlaceholder(text_: Localize(key: "Mobile Number"), placeholder_: Localize(key: "enter_mobile_number"), isUserInteraction: true)
        txtMobileNumber.lblCode.text = "+968"
        txtMobileNumber.delegate_FloatingTextFieldWithCode_Protocol = self
        txtMobileNumber.txtType.keyboardType = .numberPad
        //txtMobileNumber.txtType.font = .boldSystemFont(ofSize: <#T##CGFloat#>)
        
        txtEmail.setTitlePlaceholder(text_: Localize(key: "Email ID"), placeholder_: Localize(key: "enter_email_hint"), isUserInteraction: true, maximumNumberOfLines: 2)
        txtEmail.delegate_UIFloatingTextField_Protocol = self
        txtEmail.txtType.keyboardType = .emailAddress
        
        //--
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblNext.text = Localize(key: "NEXT")
        
        //--
        if Managelanguage.getLanguageCode() == "A"{
            txtMobileNumber.txtType.textAlignment = .right
            txtEmail.txtType.textAlignment = .right
        }else{
            txtMobileNumber.txtType.textAlignment = .left
            txtEmail.txtType.textAlignment = .left
        }
        
    }
    
    //MARK: @IBAction
    @IBAction func btnNext(_ sender: Any) {
        self.view.endEditing(true)
        
        apiCall_otpGeneration()
    }
    
  
}

extension EnterMobileEmailVC: FloatingTextFieldWithCode_Protocol{
    func btnOpenCountryCodePicker(textField: UITextField) {
    }
    
    func shouldChangeCharactersIn(textField: UITextField, txt: String) -> Bool {
        if AppHelper.allowSomeDigitOnly(txt: txt) == false{
            return false
        }
        
        if textField == txtMobileNumber.txtType{
            var maxLength = 0
            if instanceType == .Dev{
                maxLength = 10
            }else{
                maxLength = 9
            }
            
            
            if txt.count == maxLength{
                //print(maxLength)
                //let latestString = txtMobileNumber.txtType.text!
                //print(String(txt.prefix(maxLength)))
                
                //txtMobileNumber.txtType.text = String(txt.prefix(maxLength))
                return false
            }else{
                
            }
        }
  
        validateEnput()
        
        return true
    }
    
    func editingChanged(textField: UITextField) {
        validateEnput()
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func validateEnput(){
        var maxLength = 0
        if instanceType == .Dev{
            maxLength = 10
        }else{
            maxLength = 8
        }
        /*if isComeForAddingProofofAddress{
            if (txtMobileNumber.txtType.text?.count ?? 0) >= 5{
                AppHelper.enableNextBTN(view_: viewbgbtnNext)
            }else{
                AppHelper.disableNextBTN(view_: viewbgbtnNext)
            }
        }else{*/
        
            if (txtMobileNumber.txtType.text?.count ?? 0) == maxLength && AppHelper.isValidEmail(txtEmail.txtType.text!) == true{
                AppHelper.enableNextBTN(view_: viewbgbtnNext)
            }else{
                AppHelper.disableNextBTN(view_: viewbgbtnNext)
            }
        //}
    }
}

extension EnterMobileEmailVC: UIFloatingTextField_Protocol{
    
    func textFieldDidBeginEditing(textField: UITextView) {
        print(textField.text!)
    }
    
    func btnOpenCountryCodePicker(textField: UITextView) {
        self.view.endEditing(true)
        if textField == txtMobileNumber.txtType{
           /*
            CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
                guard let self = self else { return }
                self.txtMobileNumber.lblCode.text = country.dialingCode ?? ""
                self.txtMobileNumber.imgFlag.image = country.flag
            }
            */
        }

    }
    func editingChanged(textField: UITextView)  {
        validateEnput()

    }
    
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool{
        if AppHelper.allowEmailCharactesOnly(txt: txt) == false{
            return false
        }
        validateEnput()
        if textField == txtEmail.txtType{
            if txt.count >= 51{
                //print(maxLength)
                //let latestString = txtMobileNumber.txtType.text!
                //print(String(txt.prefix(maxLength)))
                
                //txtMobileNumber.txtType.text = String(txt.prefix(maxLength))
                return false
            }
        }
        
        if txt.count >= defaultTextLimit{
            return false
        }
        return true
    }
    
    
    
}


//MARK: - Api Call
extension EnterMobileEmailVC{
    
    func apiCall_otpGeneration()  {
        //--
        let verification_type = "both"
        /*if isComeForAddingProofofAddress{
            verification_type = "mobile"
        }else{
            verification_type = "both"
        }*/
        
        //--
        let dicParam:[String:AnyObject] = ["operation":"otpGeneration" as AnyObject,
                                           "data":["mobile_number": "\(txtMobileNumber.txtType.text!)",//"\(txtMobileNumber.lblCode.text!)\(txtMobileNumber.txtType.text!)",
                                                   "email":txtEmail.txtType.text!,
                                                   "verification_type":verification_type,
                                                   "mobile_key":"Q66P4XNHE4LPK4MO",
                                                   "email_key":"RUFHV4RY265PXFQU",
                                                   "step":validateOTPStep,
                                                   "device_info":deviceInfo,
                                                   "language":Managelanguage.getLanguageCode()
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], completion: { [self] (response) in
            print(response as Any)
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "001"{
                
                //--
                enterEmail = txtEmail.txtType.text!
                enterMobileNumber = "\(txtMobileNumber.txtType.text!)"
                //selectMobileCountryCode = "\(txtMobileNumber.lblCode.text!)"
                
                //--
                let vc = VerifyMobileEmailOTPVC(nibName: "VerifyMobileEmailOTPVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.view.makeToast(oTPGenerationModel.message)
            }
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_otpGeneration()
                }
            }
        }
    }

}
