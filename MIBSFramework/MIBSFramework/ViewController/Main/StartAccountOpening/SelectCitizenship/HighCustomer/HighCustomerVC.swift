//
//  HighCustomerVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 17/02/22.
//

import UIKit

class HighCustomerVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var scrollContainer: UIScrollView!
    @IBOutlet weak var lblOnScrollHeader: UILabel!
    @IBOutlet weak var onscrollHeaderView: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var txtEstimatedMonthlySalesTurnover: UIFloatingTextField!
    @IBOutlet weak var lblRemittanceInformation: UILabel!
    @IBOutlet weak var lblSendRemittance: UILabel!
    @IBOutlet weak var lblAddCountry_SendRemittance: UILabel!
    @IBOutlet weak var lblReceiveRemittance: UILabel!
    @IBOutlet weak var lblAddCountry_ReceiveRemittance: UILabel!
    @IBOutlet weak var viewbgSubmit: UIView!
    @IBOutlet weak var lblSubmit: UILabel!
    @IBOutlet weak var lblMximumLimitReached_sendRemittance: UILabel!
    @IBOutlet weak var lblMximumLimitReached_receiveRemittance: UILabel!
    
    @IBOutlet weak var viewbgAddCountry_sendRemittance: UIView!
    @IBOutlet weak var viewbgAddCountry_sendRemittance_height: NSLayoutConstraint!
    @IBOutlet weak var viewbgAddCountry_receiveRemittance: UIView!
    @IBOutlet weak var viewbgAddCountry_receiveRemittance_height: NSLayoutConstraint!
    
    @IBOutlet weak var viewbgCountr1_Send: UIView!
    @IBOutlet weak var lblCountry1_send: UILabel!
    @IBOutlet weak var txtCountry1_send: UIFloatingTextField!
    @IBOutlet weak var txtPurpose1_send: UIFloatingTextField!
    @IBOutlet weak var txtPurpose1_send_height: NSLayoutConstraint!
    @IBOutlet weak var viewbgCountr2_Send: UIView!
    @IBOutlet weak var lblCountry2_send: UILabel!
    @IBOutlet weak var txtCountry2_send: UIFloatingTextField!
    @IBOutlet weak var txtPurpose2_send: UIFloatingTextField!
    @IBOutlet weak var txtPurpose2_send_height: NSLayoutConstraint!
    @IBOutlet weak var btnRemove2_send: UIButton!
    @IBOutlet weak var viewbgCountr3_Send: UIView!
    @IBOutlet weak var lblCountry3_send: UILabel!
    @IBOutlet weak var txtCountry3_send: UIFloatingTextField!
    @IBOutlet weak var txtPurpose3_send: UIFloatingTextField!
    @IBOutlet weak var txtPurpose3_send_height: NSLayoutConstraint!
    @IBOutlet weak var btnRemove3_send: UIButton!
    
    @IBOutlet weak var viewbgCountr1_receive: UIView!
    @IBOutlet weak var lblCountry1_receive: UILabel!
    @IBOutlet weak var txtCountry1_receive: UIFloatingTextField!
    @IBOutlet weak var txtPurpose1_receive: UIFloatingTextField!
    @IBOutlet weak var txtPurpose1_receive_height: NSLayoutConstraint!
    @IBOutlet weak var viewbgCountr2_receive: UIView!
    @IBOutlet weak var lblCountry2_receive: UILabel!
    @IBOutlet weak var txtCountry2_receive: UIFloatingTextField!
    @IBOutlet weak var txtPurpose2_receive: UIFloatingTextField!
    @IBOutlet weak var txtPurpose2_receive_height: NSLayoutConstraint!
    @IBOutlet weak var btnRemove2_receive: UIButton!
    @IBOutlet weak var viewbgCountr3_receive: UIView!
    @IBOutlet weak var lblCountry3_receive: UILabel!
    @IBOutlet weak var txtCountry3_receive: UIFloatingTextField!
    @IBOutlet weak var txtPurpose3_receive: UIFloatingTextField!
    @IBOutlet weak var txtPurpose3_receive_height: NSLayoutConstraint!
    @IBOutlet weak var btnRemove3_receive: UIButton!
    
    
    //MARK: - Veriable
    var screenNameEnum: ScreenNameEnum?
    var sendRemittance:[AddCountryRemittanceCellModel] = []
    var receiveRemittance:[AddCountryRemittanceCellModel] = []
    
    var sendRemittanceCount = 1
    var receiveRemittanceCount = 1
    
    var selectMonthlySalesTurnover = -1
    var selectCountr1SendIndex = ""
    var selectCountr2SendIndex = ""
    var selectCountr3SendIndex = ""
    var selectCountr1ReceiveIndex = ""
    var selectCountr2ReceiveIndex = ""
    var selectCountr3ReceiveIndex = ""
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        setupBasic()
        manageAddMoreBTN_sendRemittance()
        manageAddMoreBTN_receiveRemittance()
        validateEnput()
        
        apiCall_getApplicationData { result in
            self.setFormData(result: result)
        }
        
        //registerCell()
        //addSendRemittance()
        //addReceiveRemittance()
    }
    override func viewDidLayoutSubviews() {
        
        /*tblSendRemittance_height.constant = tblSendRemittance.contentSize.height
        tblReceiveRemittance_height.constant = tblReceiveRemittance.contentSize.height
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.tblSendRemittance_height.constant = self.tblSendRemittance.contentSize.height
            self.tblReceiveRemittance_height.constant = self.tblReceiveRemittance.contentSize.height
        })*/
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblOnScrollHeader.text = Localize(key: "Additional Information")
        lblTitle.text = Localize(key: "Additional Information")
        lblDetails.text = Localize(key: "Please fill the missing details")
        lblRemittanceInformation.text = Localize(key: "Remittance Information")
        lblSendRemittance.text = Localize(key: "Send Remittance")
        lblAddCountry_SendRemittance.text = Localize(key: "ADD COUNTRY")
        lblReceiveRemittance.text = Localize(key: "Receive Remittance")
        lblAddCountry_ReceiveRemittance.text = Localize(key: "ADD COUNTRY")
        lblSubmit.text = Localize(key: "SUBMIT")
        
        lblCountry1_send.text = "\(Localize(key: "Country")) #1"
        lblCountry2_send.text = "\(Localize(key: "Country")) #2"
        btnRemove2_send.setTitle(Localize(key: "REMOVE"), for: .normal)
        lblCountry3_send.text = "\(Localize(key: "Country")) #3"
        btnRemove3_send.setTitle(Localize(key: "REMOVE"), for: .normal)
        
        lblCountry1_receive.text = "\(Localize(key: "Country")) #1"
        lblCountry2_receive.text = "\(Localize(key: "Country")) #2"
        btnRemove2_receive.setTitle(Localize(key: "REMOVE"), for: .normal)
        lblCountry3_receive.text = "\(Localize(key: "Country")) #3"
        btnRemove3_receive.setTitle(Localize(key: "REMOVE"), for: .normal)
        
        if Managelanguage.getLanguageCode() == "A"
        {
            txtEstimatedMonthlySalesTurnover.txtType.textAlignment = .right
        
            txtCountry1_send.txtType.textAlignment = .right
            txtPurpose1_send.txtType.textAlignment = .right
            txtCountry2_send.txtType.textAlignment = .right
            txtPurpose2_send.txtType.textAlignment = .right
            txtCountry3_send.txtType.textAlignment = .right
            txtPurpose3_send.txtType.textAlignment = .right
            
            txtCountry1_receive.txtType.textAlignment = .right
            txtPurpose1_receive.txtType.textAlignment = .right
            txtCountry2_receive.txtType.textAlignment = .right
            txtPurpose2_receive.txtType.textAlignment = .right
            txtCountry3_receive.txtType.textAlignment = .right
            txtPurpose3_receive.txtType.textAlignment = .right
            
        }
    }
    /*func registerCell(){
        tblSendRemittance.register(UINib(nibName: "AddCountryRiskCusCell", bundle: nil), forCellReuseIdentifier: "AddCountryRiskCusCell")
        tblReceiveRemittance.register(UINib(nibName: "AddCountryRiskCusCell", bundle: nil), forCellReuseIdentifier: "AddCountryRiskCusCell")
    }*/
    func setupHeader(){
         
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { [self] (sender) in
            self.clickBack()
        }
    }
    func setupBasic(){
        //--
        txtEstimatedMonthlySalesTurnover.setTitlePlaceholder(text_: Localize(key: "Estimated Monthly Sales Turnover"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtEstimatedMonthlySalesTurnover.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .monthly_sales_turnover_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Monthly_Sales_Turnover"),
                                    dropDownType: "monthly_sales_turnover",
                                    arrList: list,
                                    selectedIndex: self.selectMonthlySalesTurnover)
        }
        
        //--Send
        txtCountry1_send.setTitlePlaceholder(text_: Localize(key: "Name_of_recipient_country"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountry1_send.didTappedDropDown = { (sender) in
            //--
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Name_of_recipient_country"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                txtCountry1_send.txtType.text = ""
                txtCountry1_send.txtType.insertText(countryName)
                selectCountr1SendIndex = countryCode
                txtCountry1_send.lblError.isHidden = true
                txtCountry1_send.iconFill.isHidden = false
                
                validateEnput()
            }
        }
        txtPurpose1_send.setTitlePlaceholder(text_: Localize(key: "Expected Purpose of remittance"), placeholder_: Localize(key: "Enter purpose"), isUserInteraction: true, maximumNumberOfLines: 0)
        txtPurpose1_send.delegate_UIFloatingTextField_Protocol = self
        
        txtCountry2_send.setTitlePlaceholder(text_: Localize(key: "Name_of_recipient_country"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountry2_send.didTappedDropDown = { (sender) in
            //--
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Name_of_recipient_country"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                txtCountry2_send.txtType.text = ""
                txtCountry2_send.txtType.insertText(countryName)
                selectCountr2SendIndex = countryCode
                txtCountry2_send.lblError.isHidden = true
                txtCountry2_send.iconFill.isHidden = false
                validateEnput()
            }
            
        }
        txtPurpose2_send.setTitlePlaceholder(text_: Localize(key: "Expected Purpose of remittance"), placeholder_: Localize(key: "Enter purpose"), isUserInteraction: true, maximumNumberOfLines: 0)
        txtPurpose2_send.delegate_UIFloatingTextField_Protocol = self
        
        txtCountry3_send.setTitlePlaceholder(text_: Localize(key: "Name_of_recipient_country"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountry3_send.didTappedDropDown = { (sender) in
            //--
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Name_of_recipient_country"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                txtCountry3_send.txtType.text = ""
                txtCountry3_send.txtType.insertText(countryName)
                selectCountr3SendIndex = countryCode
                txtCountry3_send.lblError.isHidden = true
                txtCountry3_send.iconFill.isHidden = false
                validateEnput()
            }
        }
        txtPurpose3_send.setTitlePlaceholder(text_: Localize(key: "Expected Purpose of remittance"), placeholder_: Localize(key: "Enter purpose"), isUserInteraction: true, maximumNumberOfLines: 0)
        txtPurpose3_send.delegate_UIFloatingTextField_Protocol = self
        
        //--Receive
        txtCountry1_receive.setTitlePlaceholder(text_: Localize(key: "Name_of_recipient_country"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountry1_receive.didTappedDropDown = { (sender) in
            //--
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Name_of_recipient_country"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                txtCountry1_receive.txtType.text = ""
                txtCountry1_receive.txtType.insertText(countryName)
                selectCountr1ReceiveIndex = countryCode
                txtCountry1_receive.lblError.isHidden = true
                txtCountry1_receive.iconFill.isHidden = false
                validateEnput()
            }
            
        }
        txtPurpose1_receive.setTitlePlaceholder(text_: Localize(key: "Expected Purpose of remittance"), placeholder_: Localize(key: "Enter purpose"), isUserInteraction: true, maximumNumberOfLines: 0)
        txtPurpose1_receive.delegate_UIFloatingTextField_Protocol = self
        
        txtCountry2_receive.setTitlePlaceholder(text_: Localize(key: "Name_of_recipient_country"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountry2_receive.didTappedDropDown = { (sender) in
            //--
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Name_of_recipient_country"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                txtCountry2_receive.txtType.text = ""
                txtCountry2_receive.txtType.insertText(countryName)
                selectCountr2ReceiveIndex = countryCode
                txtCountry2_receive.lblError.isHidden = true
                txtCountry2_receive.iconFill.isHidden = false
                validateEnput()
            }
            
        }
        txtPurpose2_receive.setTitlePlaceholder(text_: Localize(key: "Expected Purpose of remittance"), placeholder_: Localize(key: "Enter purpose"), isUserInteraction: true, maximumNumberOfLines: 0)
        txtPurpose2_receive.delegate_UIFloatingTextField_Protocol = self
        
        txtCountry3_receive.setTitlePlaceholder(text_: Localize(key: "Name_of_recipient_country"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountry3_receive.didTappedDropDown = { (sender) in
            //--
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Name_of_recipient_country"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                txtCountry3_receive.txtType.text = ""
                txtCountry3_receive.txtType.insertText(countryName)
                selectCountr3ReceiveIndex = countryCode
                txtCountry3_receive.lblError.isHidden = true
                txtCountry3_receive.iconFill.isHidden = false
                validateEnput()
            }
            
        }
        txtPurpose3_receive.setTitlePlaceholder(text_: Localize(key: "Expected Purpose of remittance"), placeholder_: Localize(key: "Enter purpose"), isUserInteraction: true, maximumNumberOfLines: 0)
        txtPurpose3_receive.delegate_UIFloatingTextField_Protocol = self
        
    }
    /*func addSendRemittance(){
        let add_ = AddCountryRemittanceCellModel()
        add_.title = "\(Localize(key: "Country #"))\(sendRemittance.count+1)"
        add_.txtNameofCountry_title = Localize(key: "Name of the country to receive remaittances")
        add_.txtNameofCountry_placeHolder = Localize(key: "Enter name")
        add_.txtExpectedPurpose_title = Localize(key: "Expected Purpose of remittance")
        add_.txtExpectedPurpose_placeHolder = Localize(key: "Enter Purpose")
        sendRemittance.append(add_)
        /*tblSendRemittance.reloadData()*/
        viewDidLayoutSubviews()
        
        manageAddMoreBTN_sendRemittance()
    }*/
    func manageAddMoreBTN_sendRemittance(){
        viewbgCountr1_Send.isHidden = true
        viewbgCountr2_Send.isHidden = true
        viewbgCountr3_Send.isHidden = true
        if sendRemittanceCount == 1{
            viewbgCountr1_Send.isHidden = false
        }else if sendRemittanceCount == 2{
            viewbgCountr1_Send.isHidden = false
            viewbgCountr2_Send.isHidden = false
            btnRemove2_send.isHidden = false
        }else if sendRemittanceCount == 3{
            viewbgCountr1_Send.isHidden = false
            viewbgCountr2_Send.isHidden = false
            btnRemove2_send.isHidden = true
            viewbgCountr3_Send.isHidden = false
        }
        
        if sendRemittanceCount == 3{
            lblMximumLimitReached_sendRemittance.text = Localize(key: "You have reached a maximum limit of 3 countries")
            viewbgAddCountry_sendRemittance.isHidden = true
            viewbgAddCountry_sendRemittance_height.constant = 0
        }else{
            lblMximumLimitReached_sendRemittance.text = ""
            viewbgAddCountry_sendRemittance.isHidden = false
            viewbgAddCountry_sendRemittance_height.constant = 40
        }
        
        validateEnput()
    }
    /*func addReceiveRemittance(){
        let add_ = AddCountryRemittanceCellModel()
        add_.title = "\(Localize(key: "Country #"))\(receiveRemittance.count+1)"
        add_.txtNameofCountry_title = Localize(key: "Name of the country to receive remaittances")
        add_.txtNameofCountry_placeHolder = Localize(key: "Enter name")
        add_.txtExpectedPurpose_title = Localize(key: "Expected Purpose of remittance")
        add_.txtExpectedPurpose_placeHolder = Localize(key: "Enter Purpose")
        receiveRemittance.append(add_)
        /*tblReceiveRemittance.reloadData()*/
        viewDidLayoutSubviews()
        
        manageAddMoreBTN_receiveRemittance()
    }*/
    func manageAddMoreBTN_receiveRemittance(){
        viewbgCountr1_receive.isHidden = true
        viewbgCountr2_receive.isHidden = true
        viewbgCountr3_receive.isHidden = true
        if receiveRemittanceCount == 1{
            viewbgCountr1_receive.isHidden = false
        }else if receiveRemittanceCount == 2{
            viewbgCountr1_receive.isHidden = false
            viewbgCountr2_receive.isHidden = false
            btnRemove2_receive.isHidden = false
        }else if receiveRemittanceCount == 3{
            viewbgCountr1_receive.isHidden = false
            viewbgCountr2_receive.isHidden = false
            btnRemove2_receive.isHidden = true
            viewbgCountr3_receive.isHidden = false
        }
        
        if receiveRemittanceCount == 3{
            lblMximumLimitReached_receiveRemittance.text = Localize(key: "You have reached a maximum limit of 3 countries")
            viewbgAddCountry_receiveRemittance.isHidden = true
            viewbgAddCountry_receiveRemittance_height.constant = 0
        }else{
            lblMximumLimitReached_receiveRemittance.text = ""
            viewbgAddCountry_receiveRemittance.isHidden = false
            viewbgAddCountry_receiveRemittance_height.constant = 40
        }
        
        validateEnput()
    }
    func clickBack(){
        if screenNameEnum == .reviewApplicationVC{
            //--
            let vc = ReviewApplicationVC(nibName: "ReviewApplicationVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            //--
            let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - @IBAction
    @IBAction func btnBackOnScrollHeader(_ sender: Any) {
        self.clickBack()
    }
    @IBAction func btnMenuOnScrollHeader(_ sender: Any) {
        //--
        let vc = ScheduleCallOptionAlertVC(nibName: "ScheduleCallOptionAlertVC", bundle: bundleIdentifireGlob)
        vc.modalPresentationStyle = .overCurrentContext
        vc.didTappedBtnSchedualCall = { (sender) in
            //--
            let vc = ScheduleVideoCallVC(nibName: "ScheduleVideoCallVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnSubmit(_ sender: Any) {
        apiCall_updateApplication()
    }
    @IBAction func btnAddCountry_SendRemittance(_ sender: Any) {
        //addSendRemittance()
        if sendRemittanceCount < 3{
            sendRemittanceCount = sendRemittanceCount + 1
            manageAddMoreBTN_sendRemittance()
        }
    }
    @IBAction func btnRemoveCountry2_SendRemittance(_ sender: Any) {
        if sendRemittanceCount != 1{
            sendRemittanceCount = sendRemittanceCount - 1
            manageAddMoreBTN_sendRemittance()
        }
    }
    @IBAction func btnRemoveCountry3_SendRemittance(_ sender: Any) {
        if sendRemittanceCount != 1{
            sendRemittanceCount = sendRemittanceCount - 1
            manageAddMoreBTN_sendRemittance()
        }
    }
    
    @IBAction func btnAddCountry_ReceiveRemittance(_ sender: Any) {
        //addReceiveRemittance()
        if receiveRemittanceCount < 3{
            receiveRemittanceCount = receiveRemittanceCount + 1
            manageAddMoreBTN_receiveRemittance()
        }
    }
    @IBAction func btnRemoveCountry2_ReceiveRemittance(_ sender: Any) {
        if receiveRemittanceCount != 1{
            receiveRemittanceCount = receiveRemittanceCount - 1
            manageAddMoreBTN_receiveRemittance()
        }
    }
    @IBAction func btnRemoveCountry3_ReceiveRemittance(_ sender: Any) {
        if receiveRemittanceCount != 1{
            receiveRemittanceCount = receiveRemittanceCount - 1
            manageAddMoreBTN_receiveRemittance()
        }
    }
    
    
    /*
    @objc func btnRemoveCountry_SendRemittance(_ sender: UIButton) {
        let index = sender.tag
        sendRemittance.remove(at: index)
        tblSendRemittance.reloadData()
        manageAddMoreBTN_sendRemittance()
        viewDidLayoutSubviews()
    }
    @objc func btnRemoveCountry_ReceiveRemittance(_ sender: UIButton) {
        let index = sender.tag
        
        receiveRemittance.remove(at: index)
        tblReceiveRemittance.reloadData()
        manageAddMoreBTN_receiveRemittance()
        viewDidLayoutSubviews()
    }*/

}

extension HighCustomerVC: UIFloatingTextField_Protocol{
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool {
        if AppHelper.allowSomeCharactesOnly(txt: txt) == false{
            return false
        }
        
        validateErrorMsg(textField: textField, txt: txt)
        
        
        //Send
        if textField == txtPurpose1_send.txtType
        {
            txtPurpose1_send_height.constant = containSize.height + 43
        }
        if textField == txtPurpose2_send.txtType
        {
            txtPurpose2_send_height.constant = containSize.height + 43
        }
        if textField == txtPurpose3_send.txtType
        {
            txtPurpose3_send_height.constant = containSize.height + 43
        }
        
        //Receive
        if textField == txtPurpose1_receive.txtType
        {
            txtPurpose1_receive_height.constant = containSize.height + 43
        }
        if textField == txtPurpose2_receive.txtType
        {
            txtPurpose2_receive_height.constant = containSize.height + 43
        }
        if textField == txtPurpose3_receive.txtType
        {
            txtPurpose3_receive_height.constant = containSize.height + 43
        }
        
        let expected_purpose_send_c_limit = 151
        if textField == txtPurpose1_send.txtType ||
            textField == txtPurpose2_send.txtType ||
            textField == txtPurpose3_send.txtType ||
            textField == txtPurpose1_receive.txtType ||
            textField == txtPurpose2_receive.txtType ||
            textField == txtPurpose3_receive.txtType{
            if txt.count >= expected_purpose_send_c_limit{
                return false
            }
        }
        
        if txt.count >= defaultTextLimit{
            return false
        }
        return true
    }
    func textFieldDidBeginEditing(textField: UITextView) {
    }
    func btnOpenCountryCodePicker(textField: UITextView) {
    }
    func editingChanged(textField: UITextView) {
        validateErrorMsg(textField: textField)
    }

    
    //Validation
    func validateErrorMsg(textField: UITextView,txt: String? = ""){
        let txtValue = textField.text == "" ? txt : textField.text!
        
        if txtPurpose1_send.txtType == textField{
            txtPurpose1_send.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPurpose1_send.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPurpose2_send.txtType == textField{
            txtPurpose2_send.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPurpose2_send.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPurpose3_send.txtType == textField{
            txtPurpose3_send.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPurpose3_send.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPurpose1_receive.txtType == textField{
            txtPurpose1_receive.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPurpose1_receive.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPurpose2_receive.txtType == textField{
            txtPurpose2_receive.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPurpose2_receive.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPurpose3_receive.txtType == textField{
            txtPurpose3_receive.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPurpose3_receive.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        validateEnput()
    }
    func validateEnput(){
        var returnValue = true
        
        if AppHelper.isNull(txtEstimatedMonthlySalesTurnover.txtType.text!){
            //txtEstimatedMonthlySalesTurnover.lblError.isHidden = false
            returnValue = false
        }
        //--
        if AppHelper.isNull(txtCountry1_send.txtType.text!){
            //txtCountry1_send.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtPurpose1_send.txtType.text!){
            //txtPurpose1_send.lblError.isHidden = false
            returnValue = false
        }
        
        if sendRemittanceCount > 1{
            if AppHelper.isNull(txtCountry2_send.txtType.text!){
                //txtCountry2_send.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtPurpose2_send.txtType.text!){
                //txtPurpose2_send.lblError.isHidden = false
                returnValue = false
            }
        }
        
        if sendRemittanceCount > 2{
            if AppHelper.isNull(txtCountry3_send.txtType.text!){
                //txtCountry3_send.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtPurpose3_send.txtType.text!){
                //txtPurpose3_send.lblError.isHidden = false
                returnValue = false
            }
        }
        
        //--
        if AppHelper.isNull(txtCountry1_receive.txtType.text!){
            //txtCountry1_receive.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtPurpose1_receive.txtType.text!){
            //txtPurpose1_receive.lblError.isHidden = false
            returnValue = false
        }
        
        if receiveRemittanceCount > 1{
            if AppHelper.isNull(txtCountry2_receive.txtType.text!){
                //txtCountry2_receive.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtPurpose2_receive.txtType.text!){
                //txtPurpose2_receive.lblError.isHidden = false
                returnValue = false
            }
        }
        
        if receiveRemittanceCount > 2{
            if AppHelper.isNull(txtCountry3_receive.txtType.text!){
                //txtCountry3_receive.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtPurpose3_receive.txtType.text!){
                //txtPurpose3_receive.lblError.isHidden = false
                returnValue = false
            }
        }
  
        if returnValue{
            AppHelper.enableNextBTN(view_: viewbgSubmit)
        }else{
            AppHelper.disableNextBTN(view_: viewbgSubmit)
        }
    }

}

extension HighCustomerVC: didSelectCustomDropDown_Protocol{
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String) {
        if droDownType == "monthly_sales_turnover"{
            txtEstimatedMonthlySalesTurnover.txtType.text = ""
            txtEstimatedMonthlySalesTurnover.txtType.insertText(title)
            selectMonthlySalesTurnover = index
            txtEstimatedMonthlySalesTurnover.lblError.isHidden = true
            txtEstimatedMonthlySalesTurnover.iconFill.isHidden = false
        }
        validateEnput()
       /* if droDownType == "country1Send"{
            txtCountry1_send.txtType.text = title
            selectCountr1SendIndex = index
            txtCountry1_send.lblError.isHidden = true
            txtCountry1_send.iconFill.isHidden = false
        }
        if droDownType == "country2Send"{
            txtCountry2_send.txtType.text = title
            selectCountr2SendIndex = index
            txtCountry2_send.lblError.isHidden = true
            txtCountry2_send.iconFill.isHidden = false
        }
        if droDownType == "country3Send"{
            txtCountry3_send.txtType.text = title
            selectCountr3SendIndex = index
            txtCountry3_send.lblError.isHidden = true
            txtCountry3_send.iconFill.isHidden = false
        }
        if droDownType == "country1receive"{
            txtCountry1_receive.txtType.text = title
            selectCountr1ReceiveIndex = index
            txtCountry1_receive.lblError.isHidden = true
            txtCountry1_receive.iconFill.isHidden = false
        }
        if droDownType == "country2receive"{
            txtCountry2_receive.txtType.text = title
            selectCountr2ReceiveIndex = index
            txtCountry2_receive.lblError.isHidden = true
            txtCountry2_receive.iconFill.isHidden = false
        }
        if droDownType == "country3receive"{
            txtCountry3_receive.txtType.text = title
            selectCountr3ReceiveIndex = index
            txtCountry3_receive.lblError.isHidden = true
            txtCountry3_receive.iconFill.isHidden = false
        }*/
    }
}
/*
extension HighCustomerVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblSendRemittance{
            return sendRemittance.count
        }else{
            return receiveRemittance.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblSendRemittance{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCountryRiskCusCell", for: indexPath) as! AddCountryRiskCusCell
            cell.selectionStyle = .none
           
            cell.lblTitle.text = sendRemittance[indexPath.row].title
            cell.txtNameOfCountry.setICON(hidden: true)
            cell.txtNameOfCountry.btnOpenDropDown.isHidden = false
            cell.txtNameOfCountry.didTappedDropDown = { (sender) in
                //--
                let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .country_to_send_remittances_c)
                self.openDropDownPicker(headerTitle: "Monthly Sales Turnover",
                                        dropDownType: "monthly_sales_turnover",
                                        arrList: list,
                                        selectedIndex: self.selectMonthlySalesTurnover)
            }
            
            cell.txtNameOfCountry.setTitlePlaceholder(text_: sendRemittance[indexPath.row].txtNameofCountry_title, placeholder_: sendRemittance[indexPath.row].txtNameofCountry_placeHolder, isUserInteraction: true)

            
            cell.txtExpectedPurpose.setICON(hidden: true)
            cell.txtExpectedPurpose.setTitlePlaceholder(text_: sendRemittance[indexPath.row].txtExpectedPurpose_title, placeholder_: sendRemittance[indexPath.row].txtExpectedPurpose_placeHolder, isUserInteraction: true)
            
            if indexPath.row == 0{
                cell.btnRemove.isHidden = true
            }else{
                cell.btnRemove.isHidden = false
            }
            
            //--
            cell.btnRemove.tag = indexPath.row
            cell.btnRemove.addTarget(self, action: #selector(btnRemoveCountry_SendRemittance(_:)), for: .touchUpInside)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCountryRiskCusCell", for: indexPath) as! AddCountryRiskCusCell
            cell.selectionStyle = .none
           
            cell.lblTitle.text = receiveRemittance[indexPath.row].title
            cell.txtNameOfCountry.setICON(hidden: true)
            cell.txtNameOfCountry.setTitlePlaceholder(text_: receiveRemittance[indexPath.row].txtNameofCountry_title, placeholder_: receiveRemittance[indexPath.row].txtNameofCountry_placeHolder, isUserInteraction: true)
            
            cell.txtExpectedPurpose.setICON(hidden: true)
            cell.txtExpectedPurpose.setTitlePlaceholder(text_: receiveRemittance[indexPath.row].txtExpectedPurpose_title, placeholder_: receiveRemittance[indexPath.row].txtExpectedPurpose_placeHolder, isUserInteraction: true)
            
            if indexPath.row == 0{
                cell.btnRemove.isHidden = true
            }else{
                cell.btnRemove.isHidden = false
            }
            
            //--
            cell.btnRemove.tag = indexPath.row
            cell.btnRemove.addTarget(self, action: #selector(btnRemoveCountry_ReceiveRemittance(_:)), for: .touchUpInside)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblSendRemittance{
            
        }else{
            
        }
    }
}*/

//MARK: - Api Call
extension HighCustomerVC{

    
    func setFormData(result: GetApplicationDataResult){
        
        txtEstimatedMonthlySalesTurnover.txtType.text = result.monthly_sales_turnover_c as? String ?? ""
       
        //Send remittance
        let country_to_send_remittances_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.country_to_send_remittances_c as? String ?? "")
        txtCountry1_send.txtType.text = ""
        txtCountry1_send.txtType.insertText(country_to_send_remittances_c.0)
        selectCountr1SendIndex = result.country_to_send_remittances_c as? String ?? ""
        txtCountry1_send.iconFill.isHidden = AppHelper.isNull(txtCountry1_send.txtType.text!) == false ? false : true
        txtPurpose1_send.txtType.text = ""
        txtPurpose1_send.txtType.insertText(result.expected_purpose_send_c as? String ?? "")
        txtPurpose1_send.iconFill.isHidden = AppHelper.isNull(txtPurpose1_send.txtType.text!) == false ? false : true
        
        let send_remittance_country2_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.send_remittance_country2_c as? String ?? "")
        txtCountry2_send.txtType.text = ""
        txtCountry2_send.txtType.insertText(send_remittance_country2_c.0)
        selectCountr2SendIndex = result.send_remittance_country2_c as? String ?? ""
        txtCountry2_send.iconFill.isHidden = AppHelper.isNull(txtCountry2_send.txtType.text!) == false ? false : true
        txtPurpose2_send.txtType.text = ""
        txtPurpose2_send.txtType.insertText(result.expected_purpose_send2_c as? String ?? "")
        txtPurpose2_send.iconFill.isHidden = AppHelper.isNull(txtPurpose2_send.txtType.text!) == false ? false : true
        
        let send_remittance_country3_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.send_remittance_country3_c as? String ?? "")
        txtCountry3_send.txtType.text = ""
        txtCountry3_send.txtType.insertText(send_remittance_country3_c.0)
        selectCountr3SendIndex = result.send_remittance_country3_c as? String ?? ""
        txtCountry3_send.iconFill.isHidden = AppHelper.isNull(txtCountry3_send.txtType.text!) == false ? false : true
        txtPurpose3_send.txtType.text = ""
        txtPurpose3_send.txtType.insertText(result.expected_purpose_send3_c as? String ?? "")
        txtPurpose3_send.iconFill.isHidden = AppHelper.isNull(txtPurpose3_send.txtType.text!) == false ? false : true
        
        //Receive remittance
        let countryto_receive_remittance_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.countryto_receive_remittance_c as? String ?? "")
        txtCountry1_receive.txtType.text = ""
        txtCountry1_receive.txtType.insertText(countryto_receive_remittance_c.0)
        selectCountr1ReceiveIndex = result.countryto_receive_remittance_c as? String ?? ""
        txtCountry1_receive.iconFill.isHidden = AppHelper.isNull(txtCountry1_receive.txtType.text!) == false ? false : true
        txtPurpose1_receive.txtType.text = ""
        txtPurpose1_receive.txtType.insertText(result.expected_purpose_receive_c as? String ?? "")
        txtPurpose1_receive.iconFill.isHidden = AppHelper.isNull(txtPurpose1_receive.txtType.text!) == false ? false : true
        
        let receive_remittance_country2_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.receive_remittance_country2_c as? String ?? "")
        txtCountry2_receive.txtType.text = ""
        txtCountry2_receive.txtType.insertText(receive_remittance_country2_c.0)
        selectCountr2ReceiveIndex = result.receive_remittance_country2_c as? String ?? ""
        txtCountry2_receive.iconFill.isHidden = AppHelper.isNull(txtCountry2_receive.txtType.text!) == false ? false : true
        txtPurpose2_receive.txtType.text = ""
        txtPurpose2_receive.txtType.insertText(result.expected_purpose_receive2_c as? String ?? "")
        txtPurpose2_receive.iconFill.isHidden = AppHelper.isNull(txtPurpose2_receive.txtType.text!) == false ? false : true
        
        let receive_remittance_country3_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.receive_remittance_country3_c as? String ?? "")
        txtCountry3_receive.txtType.text = ""
        txtCountry3_receive.txtType.insertText(receive_remittance_country3_c.0)
        selectCountr3ReceiveIndex = result.receive_remittance_country3_c as? String ?? ""
        txtCountry3_receive.iconFill.isHidden = AppHelper.isNull(txtCountry3_receive.txtType.text!) == false ? false : true
        txtPurpose3_receive.txtType.text = ""
        txtPurpose3_receive.txtType.insertText(result.expected_purpose_receive3_c as? String ?? "")
        txtPurpose3_receive.iconFill.isHidden = AppHelper.isNull(txtPurpose3_receive.txtType.text!) == false ? false : true
        
        validateEnput()
    }

    func apiCall_updateApplication()  {
        //--
        /*/let country_to_send_remittances_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .country_to_send_remittances_c, index: selectCountr1SendIndex)
        let send_remittance_country2_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .country_to_send_remittances_c, index: selectCountr2SendIndex)
        let send_remittance_country3_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .country_to_send_remittances_c, index: selectCountr3SendIndex)
        
        let countryto_receive_remittance_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .countryto_receive_remittance_c, index: selectCountr1ReceiveIndex)
        let receive_remittance_country2_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .countryto_receive_remittance_c, index: selectCountr2ReceiveIndex)
        let receive_remittance_country3_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .countryto_receive_remittance_c, index: selectCountr3ReceiveIndex)
        */
        
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.highRiskCustomerScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": ["monthly_sales_turnover_c":txtEstimatedMonthlySalesTurnover.txtType.text!,
                                                                 //Send remittance
                                                                 "country_to_send_remittances_c":selectCountr1SendIndex,
                                                                 "expected_purpose_send_c":txtPurpose1_send.txtType.text!,
                                                                 "send_remittance_country2_c":selectCountr2SendIndex,
                                                                 "expected_purpose_send2_c":txtPurpose2_send.txtType.text!,
                                                                 "send_remittance_country3_c":selectCountr3SendIndex,
                                                                 "expected_purpose_send3_c":txtPurpose3_send.txtType.text!,
                                                                 
                                                                 //Receive remittance
                                                                 "countryto_receive_remittance_c":selectCountr1ReceiveIndex,
                                                                 "expected_purpose_receive_c":txtPurpose1_receive.txtType.text!,
                                                                 "receive_remittance_country2_c":selectCountr2ReceiveIndex,
                                                                 "expected_purpose_receive2_c":txtPurpose2_receive.txtType.text!,
                                                                 "receive_remittance_country3_c":selectCountr3ReceiveIndex,
                                                                 "expected_purpose_receive3_c":txtPurpose3_receive.txtType.text!
                                                                 ]
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "200"{
                if oTPGenerationModel.Response?.Body?.status == "Success"{
                    
                    //--
                    let vc = LivenessCheckVC(nibName: "LivenessCheckVC", bundle: bundleIdentifireGlob)
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

extension HighCustomerVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollContainer{
            if scrollContainer.contentOffset.y > 100{
                onscrollHeaderView.isHidden = false
            }else{
                onscrollHeaderView.isHidden = true
            }
        }
    }
}
