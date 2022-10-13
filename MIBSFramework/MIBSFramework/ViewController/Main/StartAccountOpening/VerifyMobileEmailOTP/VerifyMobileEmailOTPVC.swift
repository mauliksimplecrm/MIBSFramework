//
//  VerifyMobileEmailOTPVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 22/01/22.
//

import UIKit
////import Popover
import AVFoundation

//import DPOTPView


class VerifyMobileEmailOTPVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    
    //Veriy Mobile
    @IBOutlet weak var lblVerifyMobile: UILabel!
    @IBOutlet weak var lblVerifyMobileDetail: UILabel!
    @IBOutlet weak var txtOtpPhone1: UITextField!
    @IBOutlet weak var txtOtpPhone2: UITextField!
    @IBOutlet weak var txtOtpPhone3: UITextField!
    @IBOutlet weak var txtOtpPhone4: UITextField!
    @IBOutlet weak var lblResendMobileOTP: UILabel!
    @IBOutlet weak var lblResendOTP_Only_Mobile: UILabel!
    @IBOutlet weak var btnResendMobileOTP: UIButton!
    @IBOutlet weak var lblPhoneValidation: UILabel!
    @IBOutlet weak var viewUndoSkip_Mobile: UIView!
    @IBOutlet weak var lblDidyouReceiveOtpNow_Mobile: UILabel!
    @IBOutlet weak var btnUndoSkip_Mobile: UIButton!
    @IBOutlet weak var lblHavingIssueOTP_Mobile: UILabel!
    @IBOutlet weak var btnYes_Mobile: UIButton!
    @IBOutlet weak var btnNo_Mobile: UIButton!
    @IBOutlet weak var btnSkipMobile_Mobile: UIButton!
    @IBOutlet weak var viewOTPMobile: UIView!
    @IBOutlet weak var viewMainVerifyMobile: UIView!
    @IBOutlet weak var viewHavingIssuesMobile: UIView!
    @IBOutlet weak var viewHavingIssuesHeight: NSLayoutConstraint! //91
    @IBOutlet weak var stack_mobile_otp: UIStackView!
    @IBOutlet weak var txtMobileOTP: DPOTPView!
    
    //Verify Email
    @IBOutlet weak var lblVerifyEmail: UILabel!
    @IBOutlet weak var lblVerifyEmailDetail: UILabel!
    @IBOutlet weak var txtOtpEmail1: UITextField!
    @IBOutlet weak var txtOtpEmail2: UITextField!
    @IBOutlet weak var txtOtpEmail3: UITextField!
    @IBOutlet weak var txtOtpEmail4: UITextField!
    @IBOutlet weak var lblResendEmailOTP: UILabel!
    @IBOutlet weak var lblResendOTP_Only_Email: UILabel!
    @IBOutlet weak var btnResendEmailOTP: UIButton!
    @IBOutlet weak var lblEmailValidation: UILabel!
    @IBOutlet weak var viewUndoSkip_Email: UIView!
    @IBOutlet weak var lblDidyouReceiveOtpNow_Email: UILabel!
    @IBOutlet weak var btnUndoSkip_Email: UIButton!
    @IBOutlet weak var lblHavingIssueOTP_Email: UILabel!
    @IBOutlet weak var btnYes_Email: UIButton!
    @IBOutlet weak var btnNo_Email: UIButton!
    @IBOutlet weak var btnSkipMobile_Email: UIButton!
    @IBOutlet weak var viewOTPEmail: UIView!
    @IBOutlet weak var viewMainVerifyEmail: UIView!
    @IBOutlet weak var viewHavingIssuesEmail: UIView!
    @IBOutlet weak var viewHavingIssuesHeightEmail: NSLayoutConstraint! //91
    @IBOutlet weak var stack_email_otp: UIStackView!
    @IBOutlet weak var txtEmailOTP: DPOTPView!
    
    @IBOutlet weak var lblVerifyDetail: UILabel!
    @IBOutlet weak var viewbgbtnVerifyDetails: UIView!
    
    @IBOutlet var viewbg_AttemptAlert: UIView!
    @IBOutlet weak var lblTitle_AttemptAlert: UILabel!
    @IBOutlet weak var lblDetail_AttemptAlert: UILabel!
    @IBOutlet weak var btnBack_AttemptAlert: UIButton!
    @IBOutlet weak var btnContactbank_AttemptAlert: UIButton!
    @IBOutlet weak var viewbgContainer: UIView!
    
    
    
    
    //MARK: - Veriable
    var popover = Popover()
    var timerResendPhoneOTP: Timer?
    var phoneResendOTPTime = 30
    var totalPhoneResendOTPAttempt = 2
    var timerResendEmailOTP: Timer?
    var emailResendOTPTime = 30
    var totalEmailResendOTPAttempt = 2
    
    var oTPGenerationResult:OTPGenerationResult?
    
    var skipMobileOTP = false
    var skipEmailOTP = false
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupBasic()
        setOtpTextField()
        defaultUI_Mobile()
        defaultUI_Email()
        
        //txtMobileOTP.semanticContentAttribute = .forceLeftToRight
        //txtEmailOTP.semanticContentAttribute = .forceRightToLeft
    }
    override func viewWillAppear(_ animated: Bool) {
        localization()
    }
    override func viewWillDisappear(_ animated: Bool) {
        timerResendPhoneOTP?.invalidate()
        timerResendEmailOTP?.invalidate()
        
    }
    override func viewDidLayoutSubviews() {
    }
    func setupHeader(){

        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    func setupBasic(){
        if applyValidation{
            AppHelper.disableNextBTN(view_: viewbgbtnVerifyDetails)
        }
        
        //--
        let a_mobile_msg = "\(Localize(key: "Please enter the 4 digit code we've sent to your phone no")) \(selectMobileCountryCode)\(enterMobileNumber)+".attributedStringWithColor(["\(selectMobileCountryCode)\(enterMobileNumber)+"], color: .DARKGREY)
        let e_mobile_msg = "\(Localize(key: "Please enter the 4 digit code we've sent to your phone no")) +\(selectMobileCountryCode)\(enterMobileNumber)".attributedStringWithColor(["+\(selectMobileCountryCode)\(enterMobileNumber)"], color: .DARKGREY)
        lblVerifyMobileDetail.attributedText = Managelanguage.getLanguageCode() == "A" ? a_mobile_msg : e_mobile_msg
        lblResendMobileOTP.text = Localize(key: "did_not_receive_the_otp")
        lblResendOTP_Only_Mobile.text = Localize(key: "resend_otp")
        //attributedText = Localize(key: "Didn't receive the OTP? RESEND OTP").attributedStringWithColor(["RESEND OTP"], color: .DARKGREENTINT)
        
        
        lblVerifyEmailDetail.attributedText = "\(Localize(key: "Please enter the 4 digit code we've sent to your email id")) \(enterEmail)".attributedStringWithColor(["\(enterEmail)"], color: .DARKGREY)
        lblResendEmailOTP.text = Localize(key: "did_not_receive_the_otp")
        lblResendOTP_Only_Email.text = Localize(key: "resend_otp")
        //attributedText = Localize(key: "Didn't receive the OTP? RESEND OTP").attributedStringWithColor(["RESEND OTP"], color: .DARKGREENTINT)
        
        //--
        lblPhoneValidation.text = ""
        lblEmailValidation.text = ""
        
        //if isComeForAddingProofofAddress{
        //     viewMainVerifyEmail.isHidden = true
        //}
        
        
    }
    func setOtpTextField()  {
        txtOtpEmail1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtOtpEmail2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtOtpEmail3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtOtpEmail4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        txtOtpPhone1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtOtpPhone2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtOtpPhone3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtOtpPhone4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    func openAttemptAlert(){
        /*//--
         popover = Popover()
         viewbg_AttemptAlert.frame.size = CGSize(width: self.view.frame.width-20, height: viewbg_AttemptAlert.frame.height)
         let aView = UIView()
         aView.frame = viewbg_AttemptAlert.frame
         aView.addSubview(viewbg_AttemptAlert)
         popover.dismissOnBlackOverlayTap = true
         popover.showAsDialog(aView, inView: self.view)*/
        //--
        popover.dismiss()
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Sorry!")
        alert.lblMessage.text = Localize(key: "You've entered an incorrect OTP 3 times in a row")
        alert.btnGotoApplication.setTitle(Localize(key: "SCHEDUAL_A_CALL"), for: .normal)
        alert.didTappedGoToDashboard = { (sender) in
            self.popover.dismiss()
            //--
            let vc = ScheduleVideoCallVC(nibName: "ScheduleVideoCallVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alert.btnContinueApplication.setTitle(Localize(key: "CONTACT_BANK"), for: .normal)
        alert.didTappedContinueAPP = { (sender) in
            self.popover.dismiss()
            //--
            let vc = ContactUsVC(nibName: "ContactUsVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alert.btnCancel.setTitle(Localize(key: "CANCEL"), for: .normal)
        alert.didTappedCancel = { (sender) in
            self.popover.dismiss()
        }
        
        //--
        alert.frame.size = CGSize(width: UIScreen.main.bounds.width-30, height: alert.viewBG.frame.height)
        let aView = UIView()
        aView.frame = alert.frame
        aView.addSubview(alert)
        popover.dismissOnBlackOverlayTap = false
        popover.blackOverlayColor = popoverBackgroundColor
        popover.showAsDialog(alert, inView: self.view)
    }
    func openSkipLimitAlert(msg_: String){
        
        //--
        popover.dismiss()
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = msg_
        alert.btnGotoApplication.isHidden = true
        
        alert.btnContinueApplication.isHidden = true
        
        alert.btnCancel.setTitle(Localize(key: "BACK"), for: .normal)
        alert.didTappedCancel = { (sender) in
            self.popover.dismiss()
        }
        
        //--
        alert.frame.size = CGSize(width: UIScreen.main.bounds.width-30, height: alert.viewBG.frame.height)
        let aView = UIView()
        aView.frame = alert.frame
        aView.addSubview(alert)
        popover.dismissOnBlackOverlayTap = false
        popover.blackOverlayColor = popoverBackgroundColor
        popover.showAsDialog(alert, inView: self.view)
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        
        lblVerifyMobile.text = Localize(key: "Verify Mobile")
        lblDidyouReceiveOtpNow_Mobile.text = Localize(key: "Did you receive the OTP now?")
        btnUndoSkip_Mobile.setTitle(Localize(key: "UNDO SKIP"), for: .normal)
        lblHavingIssueOTP_Mobile.text = Localize(key: "Having issues receiving the OTP?")
        btnYes_Mobile.setTitle(Localize(key: "Yes"), for: .normal)
        btnNo_Mobile.setTitle(Localize(key: "No"), for: .normal)
        btnSkipMobile_Mobile.setTitle(Localize(key: "SKIP MOBILE OTP"), for: .normal)
        
        lblVerifyEmail.text = Localize(key: "Verify Email")
        lblDidyouReceiveOtpNow_Email.text = Localize(key: "Did you receive the OTP now?")
        btnUndoSkip_Email.setTitle(Localize(key: "UNDO SKIP"), for: .normal)
        lblHavingIssueOTP_Email.text = Localize(key: "Having issues receiving the OTP?")
        btnYes_Email.setTitle(Localize(key: "Yes"), for: .normal)
        btnNo_Email.setTitle(Localize(key: "No"), for: .normal)
        btnSkipMobile_Email.setTitle(Localize(key: "SKIP EMAIL OTP"), for: .normal)
        
        lblTitle_AttemptAlert.text = Localize(key: "Sorry!")
        lblDetail_AttemptAlert.text = Localize(key: "You've entered an incorrect OTP 3 times in a row")
        btnBack_AttemptAlert.setTitle(Localize(key: "BACK"), for: .normal)
        btnContactbank_AttemptAlert.setTitle(Localize(key: "CONTACT BANK"), for: .normal)
        
        lblVerifyDetail.text = Localize(key: "VERIFY DETAILS")
        btnSkipMobile_Email.isHidden = true
        btnSkipMobile_Mobile.isHidden = true
        
        //Setup OTP TextFiled
        txtMobileOTP.dpOTPViewDelegate = self
        txtMobileOTP.fontTextField = UIFont(name: "Gotham-Medium", size: CGFloat(18.0))!
        
        txtEmailOTP.dpOTPViewDelegate = self
        txtEmailOTP.fontTextField = UIFont(name: "Gotham-Medium", size: CGFloat(18.0))!
        
        //setupBasicOTPFiled(txtFiled: txtMobileOTP)
    }
    
    func setupBasicOTPFiled(txtFiled: DPOTPView){
        //txtFiled.semanticContentAttribute = .forceLeftToRight
        
        
    }
    
    //MARK: - Func Mobile Verification
    func startTimerResendPhoneOTP() {
        phoneResendOTPTime = 30
        timerResendPhoneOTP = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerEventResendPhoneOTP(timer:)), userInfo: nil, repeats: true)
    }
    @objc func timerEventResendPhoneOTP(timer: Timer!) {
        if phoneResendOTPTime == 0{
            lblResendMobileOTP.text = Localize(key: "did_not_receive_the_otp")
            lblResendOTP_Only_Mobile.text = Localize(key: "resend_otp")
            //lblResendMobileOTP.attributedText = Localize(key: "Didn't receive the OTP? RESEND OTP").attributedStringWithColor(["RESEND OTP"], color: .DARKGREENTINT)
            timerResendPhoneOTP?.invalidate()
            timerResendPhoneOTP = nil
            btnResendMobileOTP.isUserInteractionEnabled = true
        }else{
            lblResendMobileOTP.attributedText = "\(Localize(key: "OTP has been resent.\nYou will be able to resend the OTP again in")) \(phoneResendOTPTime) \(Localize(key: "seconds"))".attributedStringWithColor([""], color: .DARKGREENTINT)
            lblResendOTP_Only_Mobile.text = ""
            btnResendMobileOTP.isUserInteractionEnabled = false
            phoneResendOTPTime = phoneResendOTPTime - 1
        }
    }
    //188 - Undo skip, 317 - Having issue, 211 - Default View
    func defaultUI_Mobile(){
        viewHavingIssuesMobile.isHidden = true
        viewHavingIssuesHeight.constant = 0
        viewUndoSkip_Mobile.isHidden = true
        viewOTPMobile.isHidden = false
    }
    func havingIssuesReceivingOtp_Mobile(){
        viewHavingIssuesMobile.isHidden = false
        viewHavingIssuesHeight.constant = 91
        viewUndoSkip_Mobile.isHidden = true
        viewOTPMobile.isHidden = false
    }
    func undoSkip_Mobile(){
        viewHavingIssuesMobile.isHidden = true
        viewHavingIssuesHeight.constant = 0
        viewUndoSkip_Mobile.isHidden = false
        viewOTPMobile.isHidden = true
    }
    
    func defaultUI_Email(){
        viewHavingIssuesEmail.isHidden = true
        viewHavingIssuesHeightEmail.constant = 0
        viewUndoSkip_Email.isHidden = true
        viewOTPEmail.isHidden = false
    }
    func havingIssuesReceivingOtp_Email(){
        viewHavingIssuesEmail.isHidden = false
        viewHavingIssuesHeightEmail.constant = 91
        viewUndoSkip_Email.isHidden = true
        viewOTPEmail.isHidden = false
    }
    func undoSkip_Email(){
        viewHavingIssuesEmail.isHidden = true
        viewHavingIssuesHeightEmail.constant = 0
        viewUndoSkip_Email.isHidden = false
        viewOTPEmail.isHidden = true
    }
    
    //MARK: - Func Email Verification
    func startTimerResendEmailOTP() {
        emailResendOTPTime = 30
        timerResendEmailOTP = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerEventResendEmailOTP(timer:)), userInfo: nil, repeats: true)
    }
    @objc func timerEventResendEmailOTP(timer: Timer!) {
        if emailResendOTPTime == 0{
            lblResendEmailOTP.text = Localize(key: "did_not_receive_the_otp")
            lblResendOTP_Only_Email.text = Localize(key: "resend_otp")
            //lblResendEmailOTP.attributedText = Localize(key: "Didn't receive the OTP? RESEND OTP").attributedStringWithColor(["RESEND OTP"], color: .DARKGREENTINT)
            timerResendEmailOTP?.invalidate()
            timerResendEmailOTP = nil
            btnResendEmailOTP.isUserInteractionEnabled = true
        }else{
            lblResendEmailOTP.attributedText = "\(Localize(key: "OTP has been resent.\nYou will be able to resend the OTP again in")) \(emailResendOTPTime) \(Localize(key: "seconds"))".attributedStringWithColor([""], color: .DARKGREENTINT)
            lblResendOTP_Only_Email.text = ""
            btnResendEmailOTP.isUserInteractionEnabled = false
            emailResendOTPTime = emailResendOTPTime - 1
        }
    }
    
    
    //MARK: @IBAction
    @IBAction func btnSkipMobile_Mobile(_ sender: Any) {
        if skipEmailOTP{
            openSkipLimitAlert(msg_: Localize(key: "email_already_skip_msg"))
        }else{
            undoSkip_Mobile()
            skipMobileOTP = true
        }
    }
    @IBAction func btnNo_Mobile(_ sender: Any) {
        defaultUI_Mobile()
        btnSkipMobile_Email.isHidden = true
        setButtonColor(isSelected: true, btn: btnNo_Mobile)
        setButtonColor(isSelected: false, btn: btnYes_Mobile)
    }
    @IBAction func btnYes_Mobile(_ sender: Any) {
        btnSkipMobile_Mobile.isHidden = false
        setButtonColor(isSelected: true, btn: btnYes_Mobile)
        setButtonColor(isSelected: false, btn: btnNo_Mobile)
    }
    
    @IBAction func btnUndoSkip_Mobile(_ sender: Any) {
        defaultUI_Mobile()
        skipMobileOTP = false
    }
    @IBAction func btnResendPhoneOTP(_ sender: Any) {
        if totalPhoneResendOTPAttempt < 1{
            openAttemptAlert()
        }else{
            startTimerResendPhoneOTP()
            /*totalPhoneResendOTPAttempt = totalPhoneResendOTPAttempt - 1
             if totalPhoneResendOTPAttempt == 2{
             lblPhoneValidation.text = "You only have 1 attempt remaining"
             }else{
             lblPhoneValidation.text = ""
             }*/
            apiCall_resend_otpGeneration(isResendEmail: false)
        }
        havingIssuesReceivingOtp_Mobile()
    }
    @IBAction func btnSkipMobile_Email(_ sender: Any) {
        if skipMobileOTP{
            openSkipLimitAlert(msg_: Localize(key: "mobile_already_skip_msg"))
        }else{
            undoSkip_Email()
            skipEmailOTP = true
        }
    }
    @IBAction func btnNo_Email(_ sender: Any) {
        defaultUI_Email()
        btnSkipMobile_Email.isHidden = true
        setButtonColor(isSelected: true, btn: btnNo_Email)
        setButtonColor(isSelected: false, btn: btnYes_Email)
    }
    @IBAction func btnYes_Email(_ sender: Any) {
        btnSkipMobile_Email.isHidden = false
        setButtonColor(isSelected: true, btn: btnYes_Email)
        setButtonColor(isSelected: false, btn: btnNo_Email)
    }
    @IBAction func btnUndoSkip_Email(_ sender: Any) {
        defaultUI_Email()
        skipEmailOTP = false
    }
    @IBAction func btnResendEmailOTP(_ sender: Any) {
        /*if totalEmailResendOTPAttempt == 3{
         openAttemptAlert()
         }else{
         startTimerResendEmailOTP()
         totalEmailResendOTPAttempt = totalEmailResendOTPAttempt + 1
         if totalEmailResendOTPAttempt == 2{
         lblEmailValidation.text = "You only have 1 attempt remaining"
         }else{
         lblEmailValidation.text = ""
         }
         apiCall_resend_otpGeneration(isResendEmail: true)
         }*/
        startTimerResendEmailOTP()
        apiCall_resend_otpGeneration(isResendEmail: true)
        havingIssuesReceivingOtp_Email()
    }
    @IBAction func btnVerifyDetails(_ sender: Any) {
        self.view.endEditing(true)
        //        if isComeForAddingProofofAddress{
        //            apiCall_ValidateOTP()
        //        }else{
        apiCall_ValidateOTP()
        //}
        
    }
    
    @IBAction func txtEditingChange(_ sender: Any) {
        //validateEnput()
    }
    
    @IBAction func btnBack_AttemptAlert(_ sender: Any) {
        popover.dismiss()
    }
    @IBAction func btnContactbank_AttemptAlert(_ sender: Any) {
        popover.dismiss()
        
        //--
        let vc = ContactUsVC(nibName: "ContactUsVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setButtonColor(isSelected: Bool, btn: UIButton){
        btn.setTitleColor(isSelected ? UIColor.white : UIColor.GREEN, for: .normal)
        btn.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.GREEN.cgColor
        btn.backgroundColor = isSelected ? UIColor.GREEN : UIColor.white
    }
}


extension VerifyMobileEmailOTPVC:UITextFieldDelegate{
    func validateEnput(){
        let phone_otp = txtMobileOTP.text! //"\(txtOtpPhone1.text ?? "")\(txtOtpPhone2.text ?? "")\(txtOtpPhone3.text ?? "")\(txtOtpPhone4.text ?? "")"
        let email_otp = txtEmailOTP.text! //"\(txtOtpEmail1.text ?? "")\(txtOtpEmail2.text ?? "")\(txtOtpEmail3.text ?? "")\(txtOtpEmail4.text ?? "")"
        
        var validateCorrect = false
        if skipMobileOTP == false{
            if (phone_otp.count) == 4{
                validateCorrect = true
            }else{
                validateCorrect = false
            }
        }
        
        if skipEmailOTP == false{
            if (email_otp.count) == 4{
                validateCorrect = true
            }else{
                validateCorrect = false
            }
        }
        
        
        if validateCorrect{
            AppHelper.enableNextBTN(view_: viewbgbtnVerifyDetails)
        }else{
            AppHelper.disableNextBTN(view_: viewbgbtnVerifyDetails)
        }
        
        /*if isComeForAddingProofofAddress{
         if (phone_otp.count) == 4{
         AppHelper.enableNextBTN(view_: viewbgbtnVerifyDetails)
         }else{
         AppHelper.disableNextBTN(view_: viewbgbtnVerifyDetails)
         }
         }else{
         
         if (phone_otp.count) == 4 && (email_otp.count) == 4{
         AppHelper.enableNextBTN(view_: viewbgbtnVerifyDetails)
         }else{
         AppHelper.disableNextBTN(view_: viewbgbtnVerifyDetails)
         }
         //}*/
        
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        validateEnput()
        //--
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case txtOtpEmail1:
                txtOtpEmail2.becomeFirstResponder()
            case txtOtpEmail2:
                txtOtpEmail3.becomeFirstResponder()
            case txtOtpEmail3:
                txtOtpEmail4.becomeFirstResponder()
            case txtOtpEmail4:
                txtOtpEmail4.resignFirstResponder()
                
            case txtOtpPhone1:
                txtOtpPhone2.becomeFirstResponder()
            case txtOtpPhone2:
                txtOtpPhone3.becomeFirstResponder()
            case txtOtpPhone3:
                txtOtpPhone4.becomeFirstResponder()
            case txtOtpPhone4:
                txtOtpPhone4.resignFirstResponder()
            default:
                break
            }
        }
        
        if  text?.count == 0 {
            switch textField{
            case txtOtpEmail1:
                txtOtpEmail1.becomeFirstResponder()
            case txtOtpEmail2:
                txtOtpEmail1.becomeFirstResponder()
            case txtOtpEmail3:
                txtOtpEmail2.becomeFirstResponder()
            case txtOtpEmail4:
                txtOtpEmail3.becomeFirstResponder()
            default:
                break
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //if ((textField.text?.count ?? 0) >= 1) && (string.count > 0) {
        /*if (string.count == 0) {
            switch textField{
            case txtOtpEmail1:
                txtOtpEmail1.becomeFirstResponder()
            case txtOtpEmail2:
                txtOtpEmail3.becomeFirstResponder()
            case txtOtpEmail3:
                txtOtpEmail4.becomeFirstResponder()
            case txtOtpEmail4:
                txtOtpEmail4.resignFirstResponder()
                
            case txtOtpPhone1:
                txtOtpPhone2.becomeFirstResponder()
            case txtOtpPhone2:
                txtOtpPhone3.becomeFirstResponder()
            case txtOtpPhone3:
                txtOtpPhone4.becomeFirstResponder()
            case txtOtpPhone4:
                txtOtpPhone4.resignFirstResponder()
            default:
                break
            }
            return false
        }*/
        
        return true
    }
    
}

//MARK: - Api Call
extension VerifyMobileEmailOTPVC{
    
    func apiCall_ValidateOTP()  {
        let mobile_otp = txtMobileOTP.text! //"\(txtOtpPhone1.text!)\(txtOtpPhone2.text!)\(txtOtpPhone3.text!)\(txtOtpPhone4.text!)"
        let email_otp = txtEmailOTP.text! //"\(txtOtpEmail1.text!)\(txtOtpEmail2.text!)\(txtOtpEmail3.text!)\(txtOtpEmail4.text!)"
        var verification_type = "both"
        /*if isComeForAddingProofofAddress{
         verification_type = "mobile"
         }else{
         verification_type = "both"
         }*/
        
        if skipMobileOTP {
            verification_type = "email"
        }
        if skipEmailOTP{
            verification_type = "mobile"
        }
        
        
        //--
        let dicParam:[String:AnyObject] = ["operation":"validateOTP" as AnyObject,
                                           "data":["mobile_key":"Q66P4XNHE4LPK4MO",
                                                   "email_key":"RUFHV4RY265PXFQU",
                                                   "mobile_otp":mobile_otp,
                                                   "email_otp":email_otp,
                                                   "step":validateOTPStep,
                                                   "mobile_number":"\(enterMobileNumber)",
                                                   "email":"\(enterEmail)",
                                                   "verification_type":verification_type,
                                                   "device_info":deviceInfo,
                                                   "language":Managelanguage.getLanguageCode()
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
            let validateOTPModel = ValidateOTPModel(JSON: response as! [String : Any])!
            
            //var validateOTPFail = false
            var validateOTPFail_Email = false
            var validateOTPFail_Mobile = false
            if validateOTPModel.Response?.Body?.mobile_message?.status != "Success" && skipMobileOTP == false{
                lblPhoneValidation.text = "Invalid OTP. You have \(totalPhoneResendOTPAttempt) attempts left"
                if totalPhoneResendOTPAttempt < 1{
                    //openAttemptAlert()
                    //havingIssuesReceivingOtp_Mobile()
                }else{
                    //totalPhoneResendOTPAttempt = totalPhoneResendOTPAttempt - 1
                }
                
                //validateOTPFail = true
                validateOTPFail_Mobile = true
            }
            if validateOTPModel.Response?.Body?.email_message?.status != "Success" && skipEmailOTP == false{
                lblEmailValidation.text = "Invalid OTP. You have \(totalEmailResendOTPAttempt) attempts left"
                if totalEmailResendOTPAttempt < 1{
                    //openAttemptAlert()
                    //havingIssuesReceivingOtp_Email()
                }else{
                    //totalEmailResendOTPAttempt = totalEmailResendOTPAttempt - 1
                }
                //validateOTPFail = true
                validateOTPFail_Email = true
            }
            if validateOTPFail_Mobile == true && validateOTPFail_Email == true{
                if totalPhoneResendOTPAttempt < 1 && totalEmailResendOTPAttempt < 1{
                    openAttemptAlert()
                }else{
                    totalPhoneResendOTPAttempt = totalPhoneResendOTPAttempt - 1
                    totalEmailResendOTPAttempt = totalEmailResendOTPAttempt - 1
                }
                return
            }else if validateOTPFail_Mobile == true{
                if totalPhoneResendOTPAttempt < 1{
                    //openAttemptAlert()
                    havingIssuesReceivingOtp_Mobile()
                }else{
                    totalPhoneResendOTPAttempt = totalPhoneResendOTPAttempt - 1
                }
                return
            }else if validateOTPFail_Email == true{
                if totalEmailResendOTPAttempt < 1{
                    //openAttemptAlert()
                    havingIssuesReceivingOtp_Email()
                }else{
                    totalEmailResendOTPAttempt = totalEmailResendOTPAttempt - 1
                }
                return
            }
            
            //--
            if serviceType == .ResumeAccountOpening{
                //if validateOTPModel.Response?.Body?.email_message?.status == "Success" && validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showResumeAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!, detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .ResumeAccountOpening)
                }else{
                    showResumeAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .ResumeAccountOpening)
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
            }else if serviceType == .StartAccountOpening{
                //if validateOTPModel.Response?.Body?.email_message?.status == "Success" && validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showNewAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!, detail: validateOTPModel.Response?.Body?.statusMsg ?? "")
                }else{
                    showNewAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "")
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
            }else if serviceType == .ScheduleVideoCall{
                //if validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showResumeAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!, detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .ScheduleVideoCall)
                }else{
                    showResumeAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .ScheduleVideoCall)
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
            }else if serviceType == .CheckApplicationStatus{
                //if validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showCheckStatusAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!, detail: validateOTPModel.Response?.Body?.statusMsg ?? "")
                }else{
                    showCheckStatusAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "")
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
            }else if serviceType == .AddOnServices{
                //if validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showResumeAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!, detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .AddOnServices)
                    
                }else{
                    showResumeAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .AddOnServices)
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
            }else if serviceType == .ProofOfAddress{
                //if validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showResumeAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!, detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .ProofOfAddress)
                }else{
                    showResumeAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .ProofOfAddress)
                    
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
            }else if serviceType == .HighRiskCustomer{
                //if validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showResumeAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!, detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .HighRiskCustomer)
                    
                }else{
                    showResumeAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .HighRiskCustomer)
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
            }else if serviceType == .VeryHighRiskCustomer{
                //if validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showResumeAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!,detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .VeryHighRiskCustomer)
                }else{
                    showResumeAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType:  .VeryHighRiskCustomer)
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
            }else if serviceType == .StartVideoCall{
                //if validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showResumeAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!,detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .StartVideoCall)
                }else{
                    showResumeAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType:  .StartVideoCall)
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
            }else if serviceType == .AllNotifications{
                //if validateOTPModel.Response?.Body?.mobile_message?.status == "Success"{
                //--
                let applicationsArrObj = validateOTPModel.Response?.Body?.Result?.applications
                if applicationsArrObj?.count != 0{
                    if let mobileApiModel_ = applicationsArrObj?.first?.toJSONString(){
                        Login_LocalDB.saveApplicationsInfo(strData: mobileApiModel_)
                    }
                    
                    showResumeAppAlert(validateOTPApplications: (applicationsArrObj?.first!)!,detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType: .AllNotifications)
                }else{
                    showResumeAppAlert(detail: validateOTPModel.Response?.Body?.statusMsg ?? "", serviceType:  .AllNotifications)
                }
                //                }else{
                //                    self.view.makeToast(validateOTPModel.Response?.Body?.email_message?.statusMsg)
                //                }
                
            }else{
                //--
                showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                    if onClickRetry{
                        apiCall_ValidateOTP()
                    }
                }
            }
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_ValidateOTP()
                }
            }
        }
    }
    
    func showCheckStatusAppAlert(validateOTPApplications: ValidateOTPApplications? = nil, detail: String){
        let status = validateOTPApplications?.status ?? ""
        //--
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = detail
        
        if status == ApplicationStatus.New.rawValue{
            
            //--navigate to check application status screen
            let vc = ApplicationStatusVC(nibName: "ApplicationStatusVC", bundle: bundleIdentifireGlob)
            validateOTPApplicationsGlob = validateOTPApplications
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }else if status == ApplicationStatus.InProgress.rawValue ||
                    status == ApplicationStatus.submitted_to_compliance.rawValue ||
                    status == ApplicationStatus.submitted_to_headofbranches.rawValue ||
                    status == ApplicationStatus.submitted_to_headofretail.rawValue{
            
            //--navigate to check application status screen
            let vc = ApplicationStatusVC(nibName: "ApplicationStatusVC", bundle: bundleIdentifireGlob)
            validateOTPApplicationsGlob = validateOTPApplications
            self.navigationController?.pushViewController(vc, animated: true)
            return
            
        }else if status == ApplicationStatus.application_submitted.rawValue ||
                    status == ApplicationStatus.middleware_api_pending.rawValue ||
                    status == ApplicationStatus.Account_Created.rawValue {
            //--navigate to check application status screen
            let vc = ApplicationStatusVC(nibName: "ApplicationStatusVC", bundle: bundleIdentifireGlob)
            validateOTPApplicationsGlob = validateOTPApplications
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }else if status == ApplicationStatus.Rejected.rawValue{
            alert.btnContinueApplication.setTitle(Localize(key: "CONTACT BANK"), for: .normal)
            alert.didTappedContinueAPP = { (sender) in
                //--
                self.popover.dismiss()
                self.openAttemptAlert()
            }
            
            alert.btnCancel.setTitle(Localize(key: "CHECK_STATUS"), for: .normal)
            alert.didTappedCancel = { (sender) in
                //--
                self.popover.dismiss()
                
                //--navigate to check application status screen
                let vc = ApplicationStatusVC(nibName: "ApplicationStatusVC", bundle: bundleIdentifireGlob)
                validateOTPApplicationsGlob = validateOTPApplications
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            alert.lblMessage.text = status == "" ? Localize(key: "no_application_found") : detail
            alert.btnGotoApplication.isHidden = true
            alert.btnContinueApplication.isHidden = true
            alert.btnContinueApplication.setTitle(Localize(key: "GOT IT"), for: .normal)
        }
        
        showAlert(alert: alert, status: status)
    }
    func showResumeAppAlert(validateOTPApplications: ValidateOTPApplications? = nil, detail: String, serviceType: ServiceType){
        let status = validateOTPApplications?.status ?? ""
        //--
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = detail
        //var isShowAlert = true
        
        if status == ApplicationStatus.New.rawValue{
            if serviceType == .ResumeAccountOpening{
                //--
                let vc = SelectCitizenshipVC(nibName: "SelectCitizenshipVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .ScheduleVideoCall{
                //--
                let vc = ScheduleVideoCallVC(nibName: "ScheduleVideoCallVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .AddOnServices{
                //--
                let vc = AddonServicesVC(nibName: "AddonServicesVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .ProofOfAddress{
                //--
                let vc = ProofofAddressVC(nibName: "ProofofAddressVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .HighRiskCustomer{
                //--
                let vc = HighCustomerVC(nibName: "HighCustomerVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .VeryHighRiskCustomer{
                //--
                let vc = VeryHighCustomerVC(nibName: "VeryHighCustomerVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .StartVideoCall{
                /*//--
                let vc = VideoCallVC(nibName: "VideoCallVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)*/
                let vc = objMainSB.instantiateViewController(withIdentifier: "NotificationSBVC") as! NotificationSBVC
                vc.serviceType = .StartVideoCall
                self.navigationController?.pushViewController(vc, animated: false)
                return
            }else if serviceType == .AllNotifications{
                alert.lblMessage.text = status == "" ? Localize(key: "no_application_found") : detail
                alert.btnGotoApplication.isHidden = true
                alert.btnContinueApplication.isHidden = true
                alert.btnContinueApplication.setTitle(Localize(key: "GOT IT"), for: .normal)
            }else{
                return
            }
        }else if status == ApplicationStatus.InProgress.rawValue{
            
            if serviceType == .ResumeAccountOpening{
                self.findLastApplicationStep()
                return
                /*alert.btnContinueApplication.setTitle(Localize(key: "CONTINUE"), for: .normal)
                alert.didTappedContinueAPP = { (sender) in
                    
                    self.findLastApplicationStep()
                }*/
            }else if serviceType == .ScheduleVideoCall{
                //--
                let vc = ScheduleVideoCallVC(nibName: "ScheduleVideoCallVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .AddOnServices{
                //--
                let vc = AddonServicesVC(nibName: "AddonServicesVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .ProofOfAddress{
                //--
                let vc = ProofofAddressVC(nibName: "ProofofAddressVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .HighRiskCustomer{
                //--
                let vc = HighCustomerVC(nibName: "HighCustomerVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .VeryHighRiskCustomer{
                //--
                let vc = VeryHighCustomerVC(nibName: "VeryHighCustomerVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .StartVideoCall{
                /*//--
                let vc = VideoCallVC(nibName: "VideoCallVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)*/
                let vc = objMainSB.instantiateViewController(withIdentifier: "NotificationSBVC") as! NotificationSBVC
                vc.serviceType = .StartVideoCall
                self.navigationController?.pushViewController(vc, animated: false)
                return
            }else if serviceType == .AllNotifications{
                //--70000146
                let vc = objMainSB.instantiateViewController(withIdentifier: "NotificationSBVC") as! NotificationSBVC
                vc.serviceType = .AllNotifications
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }else if status == ApplicationStatus.application_submitted.rawValue ||
                    status == ApplicationStatus.Account_Created.rawValue ||
                    status == ApplicationStatus.submitted_to_compliance.rawValue ||
                    status == ApplicationStatus.submitted_to_headofbranches.rawValue ||
                    status == ApplicationStatus.submitted_to_headofretail.rawValue{
            if serviceType == .ResumeAccountOpening{
                alert.btnContinueApplication.setTitle(Localize(key: "CHECK_STATUS"), for: .normal)
                alert.didTappedContinueAPP = { (sender) in
                    //--
                    self.popover.dismiss()
                    
                    //--navigate to check application status screen
                    let vc = ApplicationStatusVC(nibName: "ApplicationStatusVC", bundle: bundleIdentifireGlob)
                    validateOTPApplicationsGlob = validateOTPApplications
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else if serviceType == .ScheduleVideoCall{
                //--
                let vc = ScheduleVideoCallVC(nibName: "ScheduleVideoCallVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .AddOnServices{
                //--
                let vc = AddonServicesVC(nibName: "AddonServicesVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .ProofOfAddress{
                //--
                let vc = ProofofAddressVC(nibName: "ProofofAddressVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .HighRiskCustomer{
                //--
                let vc = HighCustomerVC(nibName: "HighCustomerVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .VeryHighRiskCustomer{
                //--
                let vc = VeryHighCustomerVC(nibName: "VeryHighCustomerVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }else if serviceType == .StartVideoCall{
                /*//--
                let vc = VideoCallVC(nibName: "VideoCallVC", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)*/
                let vc = objMainSB.instantiateViewController(withIdentifier: "NotificationSBVC") as! NotificationSBVC
                vc.serviceType = .StartVideoCall
                self.navigationController?.pushViewController(vc, animated: false)
                return
            }else if serviceType == .AllNotifications{
                //--70000146
                let vc = objMainSB.instantiateViewController(withIdentifier: "NotificationSBVC") as! NotificationSBVC
                vc.serviceType = .AllNotifications
                self.navigationController?.pushViewController(vc, animated: false)
            }
            
        }else if status == ApplicationStatus.Rejected.rawValue ||
                    status == ApplicationStatus.middleware_api_pending.rawValue{
            
            if serviceType == .AllNotifications{
                //--70000146
                let vc = objMainSB.instantiateViewController(withIdentifier: "NotificationSBVC") as! NotificationSBVC
                vc.serviceType = .AllNotifications
                self.navigationController?.pushViewController(vc, animated: false)
            }else{
                alert.btnContinueApplication.setTitle(Localize(key: "CONTACT BANK"), for: .normal)
                alert.didTappedContinueAPP = { (sender) in
                    //--
                    self.popover.dismiss()
                    self.openAttemptAlert()
                }
                
                alert.btnCancel.setTitle(Localize(key: "CHECK_STATUS"), for: .normal)
                alert.didTappedCancel = { (sender) in
                    //--
                    self.popover.dismiss()
                    
                    //--navigate to check application status screen
                    let vc = ApplicationStatusVC(nibName: "ApplicationStatusVC", bundle: bundleIdentifireGlob)
                    validateOTPApplicationsGlob = validateOTPApplications
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }else{
            alert.lblMessage.text = status == "" ? Localize(key: "no_application_found") : detail
            alert.btnGotoApplication.isHidden = true
            alert.btnContinueApplication.isHidden = true
            alert.btnContinueApplication.setTitle(Localize(key: "GOT IT"), for: .normal)
        }
        
        showAlert(alert: alert, status: status)
    }
    func showNewAppAlert(validateOTPApplications: ValidateOTPApplications? = nil, detail: String){
        let status = validateOTPApplications?.status ?? ""
        //--
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = detail
        
        if status == ApplicationStatus.New.rawValue{
            //--
            let vc = SelectCitizenshipVC(nibName: "SelectCitizenshipVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }else if status == ApplicationStatus.InProgress.rawValue{
            alert.btnContinueApplication.setTitle(Localize(key: "CONTINUE"), for: .normal)
            alert.didTappedContinueAPP = { (sender) in
                self.findLastApplicationStep()
            }
        }else if status == ApplicationStatus.application_submitted.rawValue ||
                    status == ApplicationStatus.Account_Created.rawValue ||
                    status == ApplicationStatus.submitted_to_compliance.rawValue ||
                    status == ApplicationStatus.submitted_to_headofbranches.rawValue ||
                    status == ApplicationStatus.submitted_to_headofretail.rawValue{
            alert.btnContinueApplication.setTitle(Localize(key: "CHECK_STATUS"), for: .normal)
            alert.didTappedContinueAPP = { (sender) in
                //--
                self.popover.dismiss()
                
                //--navigate to check application status screen
                let vc = ApplicationStatusVC(nibName: "ApplicationStatusVC", bundle: bundleIdentifireGlob)
                validateOTPApplicationsGlob = validateOTPApplications
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if status == ApplicationStatus.Rejected.rawValue ||
                    status == ApplicationStatus.middleware_api_pending.rawValue{
            alert.btnContinueApplication.setTitle(Localize(key: "CONTACT BANK"), for: .normal)
            alert.didTappedContinueAPP = { (sender) in
                //--
                self.popover.dismiss()
                self.openAttemptAlert()
            }
            
            alert.btnCancel.setTitle(Localize(key: "CHECK_STATUS"), for: .normal)
            alert.didTappedCancel = { (sender) in
                //--
                self.popover.dismiss()
                
                //--navigate to check application status screen
                let vc = ApplicationStatusVC(nibName: "ApplicationStatusVC", bundle: bundleIdentifireGlob)
                validateOTPApplicationsGlob = validateOTPApplications
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            alert.lblMessage.text = status == "" ? Localize(key: "no_application_found") : detail
            alert.btnGotoApplication.isHidden = true
            alert.btnContinueApplication.isHidden = true
            alert.btnContinueApplication.setTitle(Localize(key: "GOT IT"), for: .normal)
        }
        
        showAlert(alert: alert, status: status)
    }
    func showAlert(alert: InProgressAppAlertView, status:String){
        //--
        alert.frame.size = CGSize(width: UIScreen.main.bounds.width-30, height: alert.viewBG.frame.height)
        let aView = UIView()
        aView.frame = alert.frame
        aView.addSubview(alert)
        popover.dismissOnBlackOverlayTap = false
        popover.blackOverlayColor = popoverBackgroundColor
        popover.showAsDialog(alert, inView: self.view)
        
        alert.btnCancel.setTitle(Localize(key: "CANCEL"), for: .normal)
        alert.btnGotoApplication.setTitle(Localize(key: "GO TO DASHBOARD"), for: .normal)
        alert.didTappedGoToDashboard = { (sender) in
            //--
            let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if status != ApplicationStatus.Rejected.rawValue{
            alert.didTappedCancel = { (sender) in
                self.popover.dismiss()
            }
        }
    }
    
    func apiCall_resend_otpGeneration(isResendEmail: Bool)  {
        //--
        let verification_type = "both"
        
        
        //--
        var key = ""
        var value = ""
        if isResendEmail{
            key = "email"
            value = enterEmail
        }else{
            key = "mobile_number"
            value = enterMobileNumber
        }
        let dicParam:[String:AnyObject] = ["operation":"otpGeneration" as AnyObject,
                                           "data":[key: value,
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
                
            }else{
                self.view.makeToast(oTPGenerationModel.message)
            }
        }) { (error) in
            print(error)
        }
    }
}

extension UIViewController{
    func findLastApplicationStep(){
        LoadingView.shared.openLodingAlert(view: self.view)
        apiCall_getApplicationData { result in
            LoadingView.shared.dismissLoadingView()
            
            //--
            citizenshipType = self.returnCitizenship(citizenship: result.citizenship_c as? String ?? "")
            //--
            if "\(result.app_current_step_c as? String ?? "")" == STEPS_FRONT_END_NAME.personalInfoScreen.rawValue{
                //--
                let vc = PersonalInfoVC(nibName: "PersonalInfoVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.app_current_step_c as? String ?? "")" == STEPS_FRONT_END_NAME.financialInfoScreen.rawValue{
                //--
                let vc = FinancialInfoVC(nibName: "FinancialInfoVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.app_current_step_c as? String ?? "")" == STEPS_FRONT_END_NAME.regularityDeclarationScreen.rawValue{
                //--
                let vc = RegularityDeclVC(nibName: "RegularityDeclVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.app_current_step_c as? String ?? "")" == STEPS_FRONT_END_NAME.reviewApplicationScreen.rawValue{
                //--
                let vc = ReviewApplicationVC(nibName: "ReviewApplicationVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.app_current_step_c as? String ?? "")" == STEPS_FRONT_END_NAME.livenessCheckScreen.rawValue{
                //--
                let vc = LivenessCheckVC(nibName: "LivenessCheckVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.app_current_step_c as? String ?? "")" == STEPS_FRONT_END_NAME.highRiskCustomerScreen.rawValue{
                //--
                let vc = HighCustomerVC(nibName: "HighCustomerVC", bundle: bundleIdentifireGlob)
                vc.screenNameEnum = .reviewApplicationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.app_current_step_c as? String ?? "")" == STEPS_FRONT_END_NAME.veryHighRiskCustomerScreen.rawValue{
                //--
                let vc = VeryHighCustomerVC(nibName: "VeryHighCustomerVC", bundle: bundleIdentifireGlob)
                vc.screenNameEnum = .reviewApplicationVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.app_current_step_c as? String ?? "")" == STEPS_FRONT_END_NAME.termsAndConditionsScreen.rawValue{
                //--
                let vc = TermsConditionsVC(nibName: "TermsConditionsVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.citizenship_c as? String ?? "")" == CitizenshipType.omani.rawValue{
                //--
                let vc = OmaniCitizenshipDocVC(nibName: "OmaniCitizenshipDocVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.citizenship_c as? String ?? "")" == CitizenshipType.expatriate.rawValue{
                //--
                let vc = ExpatrIateCitizenshipDoc(nibName: "ExpatrIateCitizenshipDoc", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if "\(result.citizenship_c as? String ?? "")" == CitizenshipType.gcc.rawValue{
                //--
                let vc = GCCNationalsCitizenshipDocVC(nibName: "GCCNationalsCitizenshipDocVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                //--
                let vc = SelectCitizenshipVC(nibName: "SelectCitizenshipVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func returnCitizenship(citizenship: String) -> CitizenshipType{
        if citizenship == CitizenshipType.omani.rawValue{
            return .omani
        }else if citizenship == CitizenshipType.expatriate.rawValue{
            return .expatriate
        }else{
            return .gcc
        }
    }
}

extension VerifyMobileEmailOTPVC : DPOTPViewDelegate {
   func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
       validateEnput()
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
        validateEnput()
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
    }
    func dpOTPViewBecomeFirstResponder() {
        
    }
    func dpOTPViewResignFirstResponder() {
        
    }
    
}
