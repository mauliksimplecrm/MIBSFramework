//
//  MobileBankingVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 21/02/22.
//

import UIKit

class MobileBankingVC: UIViewController {
    
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var txtLoginPWD: CustomTextField!
    @IBOutlet weak var txtConfirmLoginPWD: CustomTextField!
    @IBOutlet weak var txtTransactionPWD: CustomTextField!
    @IBOutlet weak var txtConfirmTransactionPWD: CustomTextField!
    
    @IBOutlet weak var lblTearmAndCondition: UILabel!
    @IBOutlet weak var viewConfirm: UIView!
    @IBOutlet weak var lblConfirm: UILabel!
    
    //--
    @IBOutlet weak var viewStepFooter: UIView!
    @IBOutlet weak var progressStepFooter: UIProgressView!
    @IBOutlet weak var lblViewStepFooter: UILabel!
    @IBOutlet weak var lblNextStepFooter: UILabel!
    @IBOutlet weak var viewNextStepFooter: UIView!
    
    
    //MARK: - Veriable
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
        progressStepFooter.setProgress(1.0, animated: true)
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblTitle.text = Localize(key: "Mobile banking details")
        lblDetail.text = Localize(key: "Mobile banking details 1")
        
        lblConfirm.text = Localize(key: "CONFIRM")
        lblViewStepFooter.text = Localize(key: "VIEW STEPS")
        lblNextStepFooter.text = Localize(key: "NEXT")
        
        //--
        if Managelanguage.getLanguageCode() == "A"
        {
            lblTitle.semanticContentAttribute = .forceRightToLeft
            lblDetail.semanticContentAttribute = .forceRightToLeft
            lblTearmAndCondition.semanticContentAttribute = .forceRightToLeft
            
            txtLoginPWD.txtType.textAlignment = .right
            txtConfirmLoginPWD.txtType.textAlignment = .right
            txtTransactionPWD.txtType.textAlignment = .right
            txtConfirmTransactionPWD.txtType.textAlignment = .right
        }else{
            lblTitle.semanticContentAttribute = .forceLeftToRight
            lblDetail.semanticContentAttribute = .forceLeftToRight
            lblTearmAndCondition.semanticContentAttribute = .forceLeftToRight
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
        
        //--
        if addonServices == .both{
            viewStepFooter.isHidden = false
        }else{
            viewStepFooter.isHidden = true
        }
        //--
        lblTearmAndCondition.attributedText = Localize(key: "My clicking Next, you agree to our Terms & Conditions").underlineWords(words: [Localize(key: "Terms & Conditions")], color: .DARKGREENTINT)
        
    }
    func setupTextField(){
        //        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: self, queue: nil) { [weak self] notification in
        //            guard let strongSelf = self else { return }
        //            guard let object = notification.object as? UITextField, object == strongSelf else { return }
        //
        //            if self!.txtLoginPWD.txtType == object{
        //                self!.validateErrorMsg(textField: self!.txtLoginPWD.txtType)
        //            }
        //            if self!.txtConfirmLoginPWD.txtType == object{
        //                self!.validateErrorMsg(textField: self!.txtConfirmLoginPWD.txtType)
        //            }
        //            if self!.txtTransactionPWD.txtType == object{
        //                self!.validateErrorMsg(textField: self!.txtTransactionPWD.txtType)
        //            }
        //            if self!.txtConfirmTransactionPWD.txtType == object{
        //                self!.validateErrorMsg(textField: self!.txtConfirmTransactionPWD.txtType)
        //            }
        //        }
        //--
        txtLoginPWD.setTitlePlaceholder(text_: Localize(key: "Login Password"), placeholder_: Localize(key: "Enter password"), isUserInteraction: true, isSecureTextEntry: true)
        //txtLoginPWD.txtType.isSecureTextEntry = true
        txtLoginPWD.delegate_CustomTextFieldDelegate = self
        txtLoginPWD.txtType.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        
        txtConfirmLoginPWD.setTitlePlaceholder(text_: Localize(key: "Confirm Login Password"), placeholder_: Localize(key: "Enter password"), isUserInteraction: true, isSecureTextEntry: true)
        //txtConfirmLoginPWD.txtType.isSecureTextEntry = true
        txtConfirmLoginPWD.delegate_CustomTextFieldDelegate = self
        txtConfirmLoginPWD.txtType.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        txtTransactionPWD.setTitlePlaceholder(text_: Localize(key: "Transaction Password"), placeholder_: Localize(key: "Enter password"), isUserInteraction: true)
        txtTransactionPWD.txtType.isSecureTextEntry = true
        txtTransactionPWD.delegate_CustomTextFieldDelegate = self
        txtTransactionPWD.txtType.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        txtConfirmTransactionPWD.setTitlePlaceholder(text_: Localize(key: "Confirm Transaction Password"), placeholder_: Localize(key: "Enter password"), isUserInteraction: true)
        txtConfirmTransactionPWD.txtType.isSecureTextEntry = true
        txtConfirmTransactionPWD.delegate_CustomTextFieldDelegate = self
        txtConfirmTransactionPWD.txtType.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    @objc func textFieldDidChange(textField: UITextField){
        self.validateErrorMsg(textField: textField)
//        if self.txtLoginPWD.txtType == textField{
//            self.validateErrorMsg(textField: self.txtLoginPWD.txtType)
//        }
//        if self.txtConfirmLoginPWD.txtType == textField{
//            self.validateErrorMsg(textField: self.txtConfirmLoginPWD.txtType)
//        }
//        if self.txtTransactionPWD.txtType == textField{
//            self.validateErrorMsg(textField: self.txtTransactionPWD.txtType)
//        }
//        if self.txtConfirmTransactionPWD.txtType == textField{
//            self.validateErrorMsg(textField: self.txtConfirmTransactionPWD.txtType)
//        }
    }
    
    //MARK: - @IBAction
    @IBAction func btnTearmAndCondition(_ sender: Any) {
        AppHelper.openDocuemtnBrowser(docUrl: termAndConditionURL, nav: self.navigationController!)
    }
    @IBAction func btnConfirm(_ sender: Any) {
        
        //--
        let vc = MobileBankingSubmittedVC(nibName: "MobileBankingSubmittedVC", bundle: bundleIdentifireGlob)
        vc.addonServices = addonServices
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnViewStep(_ sender: Any) {
        //--
        let vc = StepIndicatorVC(nibName: "StepIndicatorVC", bundle: bundleIdentifireGlob)
        vc.selectIndex = 1
        vc.totalStep = 2
        vc.progress = 1.0
        vc.arrListOfDropDown = [Localize(key: "Debit Card details"), Localize(key: "Mobile banking details")]
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnNextStepFooter(_ sender: Any) {
        //--
        let vc = MobileBankingSubmittedVC(nibName: "MobileBankingSubmittedVC", bundle: bundleIdentifireGlob)
        vc.addonServices = addonServices
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension MobileBankingVC: CustomTextFieldDelegate{
    
    func shouldChangeCharactersIn(textField: UITextField, txt: String) -> Bool {
        //validateErrorMsg(textField: textField)
        if AppHelper.allowSomeCharactesOnly(txt: txt) == false{
            return false
        }
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
    }
    func textFieldDidEndEditing(textField: UITextField) {
    }
    func editingChanged(textField: UITextField) {
        
        validateErrorMsg(textField: textField)
    }
    
    //Validation
    func validateErrorMsg(textField: UITextField){
        print(textField.text!)
        //        if txtLoginPWD.txtType == textField{
        //            txtLoginPWD.lblError.text = Localize(key: "Passwords_do_not_match")
        //            txtLoginPWD.lblError.isHidden = AppHelper.isNull(txtLoginPWD.txtType.text!) == false ? true : false
        //            txtLoginPWD.iconFill.isHidden = AppHelper.isNull(txtLoginPWD.txtType.text!) == false ? false : true
        //        }
        //        if txtConfirmLoginPWD.txtType == textField{
        //            txtConfirmLoginPWD.lblError.text = Localize(key: "Passwords_do_not_match")
        //            txtConfirmLoginPWD.lblError.isHidden = AppHelper.isNull(txtConfirmLoginPWD.txtType.text!) == false ? true : false
        //            txtConfirmLoginPWD.iconFill.isHidden = AppHelper.isNull(txtConfirmLoginPWD.txtType.text!) == false ? false : true
        //        }
        if txtLoginPWD.txtType.text?.count != 0 && txtConfirmLoginPWD.txtType.text?.count != 0{
            if txtLoginPWD.txtType.text != txtConfirmLoginPWD.txtType.text{
                txtLoginPWD.lblError.text = Localize(key: "Passwords_do_not_match")
                txtLoginPWD.lblError.isHidden = false
                
                txtConfirmLoginPWD.lblError.text = Localize(key: "Passwords_do_not_match")
                txtConfirmLoginPWD.lblError.isHidden = false
            }else{
                txtLoginPWD.lblError.isHidden = true
                txtConfirmLoginPWD.lblError.isHidden = true
            }
        }
        //        if txtTransactionPWD.txtType == textField{
        //            txtTransactionPWD.lblError.text = Localize(key: "Passwords_do_not_match")
        //            txtTransactionPWD.lblError.isHidden = AppHelper.isNull(txtTransactionPWD.txtType.text!) == false ? true : false
        //            txtTransactionPWD.iconFill.isHidden = AppHelper.isNull(txtTransactionPWD.txtType.text!) == false ? false : true
        //        }
        //        if txtConfirmTransactionPWD.txtType == textField{
        //            txtConfirmTransactionPWD.lblError.text = Localize(key: "Passwords_do_not_match")
        //            txtConfirmTransactionPWD.lblError.isHidden = AppHelper.isNull(txtConfirmTransactionPWD.txtType.text!) == false ? true : false
        //            txtConfirmTransactionPWD.iconFill.isHidden = AppHelper.isNull(txtConfirmTransactionPWD.txtType.text!) == false ? false : true
        //        }
        if txtTransactionPWD.txtType.text?.count != 0 && txtConfirmTransactionPWD.txtType.text?.count != 0{
            if txtTransactionPWD.txtType.text != txtConfirmTransactionPWD.txtType.text{
                txtTransactionPWD.lblError.text = Localize(key: "Passwords_do_not_match")
                txtTransactionPWD.lblError.isHidden = false
                
                txtConfirmTransactionPWD.lblError.text = Localize(key: "Passwords_do_not_match")
                txtConfirmTransactionPWD.lblError.isHidden = false
            }else{
                txtTransactionPWD.lblError.isHidden = true
                txtConfirmTransactionPWD.lblError.isHidden = true
            }
            
        }
        
        
        validateEnput()
    }
    func validateEnput() {
        var returnValue = true
        
        if AppHelper.isNull(txtLoginPWD.txtType.text!){
            //txtBankStatement.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtConfirmLoginPWD.txtType.text!){
            //txtBankStatement.lblError.isHidden = false
            returnValue = false
        }
        if txtLoginPWD.txtType.text?.count != 0 && txtConfirmLoginPWD.txtType.text?.count != 0{
            if txtLoginPWD.txtType.text != txtConfirmLoginPWD.txtType.text{
                returnValue = false
            }
        }
        if AppHelper.isNull(txtTransactionPWD.txtType.text!){
            //txtBankStatement.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtConfirmTransactionPWD.txtType.text!){
            returnValue = false
        }
        if txtTransactionPWD.txtType.text?.count != 0 && txtConfirmTransactionPWD.txtType.text?.count != 0{
            if txtTransactionPWD.txtType.text != txtConfirmTransactionPWD.txtType.text{
                returnValue = false
            }
        }
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewConfirm)
            AppHelper.enableNextBTN(view_: viewNextStepFooter)
        }else{
            AppHelper.disableNextBTN(view_: viewConfirm)
            AppHelper.disableNextBTN(view_: viewNextStepFooter)
        }
    }
    
}
