//
//  TaxResidentofUSAVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 12/02/22.
//

import UIKit
//import SKCountryPicker
//import Popover

class TaxResidentofUSAVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var tblList_height: NSLayoutConstraint!
    //US Document Details
    @IBOutlet weak var lblUSDocumentDetail_title: UILabel!
    @IBOutlet weak var txtNameofIndividual: UIFloatingTextField!
    @IBOutlet weak var txtCountryofCitizenship: UIFloatingTextField!
    //Permanent Address Information
    @IBOutlet weak var lblParmanentAddressInfo_title: UILabel!
    @IBOutlet weak var txtAddress: UIFloatingTextField!
    @IBOutlet weak var txtStreetName: UIFloatingTextField!
    @IBOutlet weak var txtFlatVillaNo: UIFloatingTextField!
    @IBOutlet weak var txtCity: UIFloatingTextField!
    @IBOutlet weak var txtState: UIFloatingTextField!
    @IBOutlet weak var txtZipCode: UIFloatingTextField!
    @IBOutlet weak var txtCountry1: UIFloatingTextField!
    //Is your mailing address the same as any of the following?
    @IBOutlet weak var lblIsYourMailing_title: UILabel!
    @IBOutlet weak var imgPermanentAddressInfo: UIImageView!
    @IBOutlet weak var lblPermanentAddressInfo: UILabel!
    @IBOutlet weak var imgOther: UIImageView!
    @IBOutlet weak var lblOther: UILabel!
    //--
    @IBOutlet weak var txtUSTaxpayer: UIFloatingTextField!
    @IBOutlet weak var txtForeginTax: UIFloatingTextField!
    @IBOutlet weak var txtReferenceNumber: UIFloatingTextField!
    //--
    @IBOutlet weak var viewbgSubmit: UIView!
    @IBOutlet weak var lblBtnSubmit: UILabel!
    
    //-- Other Address
    @IBOutlet weak var txtAddress_Other: UIFloatingTextField!
    @IBOutlet weak var txtStreetName_Other: UIFloatingTextField!
    @IBOutlet weak var txtFlatVillaNo_Other: UIFloatingTextField!
    @IBOutlet weak var txtCity_Other: UIFloatingTextField!
    @IBOutlet weak var txtState_Other: UIFloatingTextField!
    @IBOutlet weak var txtZipCode_Other: UIFloatingTextField!
    @IBOutlet weak var txtCountry_Other: UIFloatingTextField!
    
    
    
    //MARK: - Veriable
    var arrListOfDropDown = ManageDropDownOption.getDropDownValue(dropdown_filed: .fatca_classification_c)
    var selectIndex = 2
    var mailing_address_same_w8_c = ""
    var delegate_didSelectCustomDropDown_Protocol: didSelectCustomDropDown_Protocol?
    var isFormSubmitted = false
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        registerCell()
        setupTextField()
        tblList.reloadData()
        AppHelper.disableNextBTN(view_: viewbgSubmit)
        
        apiCall_getApplicationData (showProgress: true, completionOut: { result in
            self.setFormData(result: result)
        })
    }
    override func viewDidLayoutSubviews() {
        tblList_height.constant = tblList.contentSize.height
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblHeaderTitle.text = Localize(key: "Are you a holder of any of the following?")
        lblUSDocumentDetail_title.text = Localize(key: "US Document Details")
        lblParmanentAddressInfo_title.text = Localize(key: "Permanent Address Information")
        lblIsYourMailing_title.text = Localize(key: "Is your mailing address the same as any of the following?")
        lblPermanentAddressInfo.text = Localize(key: "Permanent Address Information")
        lblOther.text = Localize(key: "Other")
        
        lblBtnSubmit.text = Localize(key: "SUBMIT")
        
        if Managelanguage.getLanguageCode() == "A"
        {
            txtNameofIndividual.txtType.textAlignment = .right
            txtCountryofCitizenship.txtType.textAlignment = .right
            
            txtAddress.txtType.textAlignment = .right
            txtStreetName.txtType.textAlignment = .right
            txtFlatVillaNo.txtType.textAlignment = .right
            txtCity.txtType.textAlignment = .right
            txtState.txtType.textAlignment = .right
            txtZipCode.txtType.textAlignment = .right
            txtCountry1.txtType.textAlignment = .right
            
            txtAddress_Other.txtType.textAlignment = .right
            txtStreetName_Other.txtType.textAlignment = .right
            txtFlatVillaNo_Other.txtType.textAlignment = .right
            txtCity_Other.txtType.textAlignment = .right
            txtState_Other.txtType.textAlignment = .right
            txtZipCode_Other.txtType.textAlignment = .right
            txtCountry_Other.txtType.textAlignment = .right
            
            txtUSTaxpayer.txtType.textAlignment = .right
            txtForeginTax.txtType.textAlignment = .right
            txtReferenceNumber.txtType.textAlignment = .right
        }
    }
    func registerCell(){
        tblList.register(UINib(nibName: "CustomDropDownTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "CustomDropDownTblCell")
    }
    func setupTextField(){
        //US Document Details
        txtNameofIndividual.setTitlePlaceholder(text_: Localize(key: "Name of individual who is the beneficial owner"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtNameofIndividual.delegate_UIFloatingTextField_Protocol = self
        
        txtCountryofCitizenship.setTitlePlaceholder(text_: Localize(key: "Country of Citizenship"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountryofCitizenship.didTappedDropDown = { (sender) in
           
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Country of Citizenship"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                self.txtCountryofCitizenship.txtType.text = ""
                self.txtCountryofCitizenship.txtType.insertText(countryName)
                self.txtCountryofCitizenship.lblError.isHidden = true
                validateEnput()
            }
            /*
            CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: Country) in
                guard let self = self else { return }
                self.txtCountryofCitizenship.txtType.text = country.countryName
                self.txtCountryofCitizenship.lblError.isHidden = true
            }*/
        }
        
        //--Permanent Address
        txtAddress.setTitlePlaceholder(text_: Localize(key: "Address"), placeholder_: Localize(key: "Enter address"), isUserInteraction: true)
        txtAddress.delegate_UIFloatingTextField_Protocol = self
        
        txtStreetName.setTitlePlaceholder(text_: Localize(key: "Street Name"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtStreetName.delegate_UIFloatingTextField_Protocol = self
        
        txtFlatVillaNo.setTitlePlaceholder(text_: Localize(key: "Flat/Villa No."), placeholder_: Localize(key: "Enter no."), isUserInteraction: true)
        txtFlatVillaNo.delegate_UIFloatingTextField_Protocol = self
        
        txtCity.setTitlePlaceholder(text_: Localize(key: "City"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtCity.delegate_UIFloatingTextField_Protocol = self
        
        txtState.setTitlePlaceholder(text_: Localize(key: "State"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtState.delegate_UIFloatingTextField_Protocol = self
        
        txtZipCode.setTitlePlaceholder(text_: Localize(key: "Zip Code"), placeholder_: Localize(key: "enter_zip_code"), isUserInteraction: true)
        txtZipCode.txtType.keyboardType = .numberPad
        txtZipCode.delegate_UIFloatingTextField_Protocol = self
        
        txtCountry1.setTitlePlaceholder(text_: Localize(key: "Country"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountry1.didTappedDropDown = { (sender) in
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Country"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                self.txtCountry1.txtType.text = ""
                self.txtCountry1.txtType.insertText(countryName)
                self.txtCountry1.lblError.isHidden = true
                validateEnput()
            }
        }
        
        //-- Other Address
        txtAddress_Other.setTitlePlaceholder(text_: Localize(key: "Address"), placeholder_: Localize(key: "Enter address"), isUserInteraction: true)
        txtAddress_Other.delegate_UIFloatingTextField_Protocol = self
        
        txtStreetName_Other.setTitlePlaceholder(text_: Localize(key: "Street Name"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtStreetName_Other.delegate_UIFloatingTextField_Protocol = self
        
        txtFlatVillaNo_Other.setTitlePlaceholder(text_: Localize(key: "Flat/Villa No."), placeholder_: Localize(key: "Enter no."), isUserInteraction: true)
        txtFlatVillaNo_Other.delegate_UIFloatingTextField_Protocol = self
        
        txtCity_Other.setTitlePlaceholder(text_: Localize(key: "City"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtCity_Other.delegate_UIFloatingTextField_Protocol = self
        
        txtState_Other.setTitlePlaceholder(text_: Localize(key: "State"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtState_Other.delegate_UIFloatingTextField_Protocol = self
        
        txtZipCode_Other.setTitlePlaceholder(text_: Localize(key: "Zip Code"), placeholder_: Localize(key: "enter_zip_code"), isUserInteraction: true)
        txtZipCode_Other.txtType.keyboardType = .numberPad
        txtZipCode_Other.delegate_UIFloatingTextField_Protocol = self
        
        txtCountry_Other.setTitlePlaceholder(text_: Localize(key: "Country"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountry_Other.didTappedDropDown = { (sender) in
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Country"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                self.txtCountry_Other.txtType.text = ""
                self.txtCountry_Other.txtType.insertText(countryName)
                self.txtCountry_Other.lblError.isHidden = true
                validateEnput()
            }
        }
        
        //--
        txtUSTaxpayer.setTitlePlaceholder(text_: Localize(key: "U.S. taxpayer identification number (SSN or ITIN)"), placeholder_: Localize(key: "Enter number"), isUserInteraction: true)
        txtUSTaxpayer.delegate_UIFloatingTextField_Protocol = self
        
        txtForeginTax.setTitlePlaceholder(text_: Localize(key: "Foreign tax identifying number"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtForeginTax.delegate_UIFloatingTextField_Protocol = self
        
        txtReferenceNumber.setTitlePlaceholder(text_: Localize(key: "Reference number(s)"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtReferenceNumber.delegate_UIFloatingTextField_Protocol = self
    }
    func manageIsYourMailing(clearData:Bool){
        if mailing_address_same_w8_c == "permanent_address_information"{
            imgPermanentAddressInfo.image = UIImage(named: "ic_radio_fill", in: bundleIdentifireGlob, with: nil)
            imgOther.image = UIImage(named: "ic_radio_unfill", in: bundleIdentifireGlob, with: nil)
            lblPermanentAddressInfo.textColor = .DARKGREY
            lblPermanentAddressInfo.font = UIFont.font_(name: "Gotham-Medium", size: 16.0)
            lblOther.textColor = .MIDGREY
            lblOther.font = UIFont.font_(name: "Gotham-Book", size: 16.0)
            
            hideOtherAddress(clearData: clearData)
        }else{
            imgPermanentAddressInfo.image = UIImage(named: "ic_radio_unfill", in: bundleIdentifireGlob, with: nil)
            imgOther.image = UIImage(named: "ic_radio_fill", in: bundleIdentifireGlob, with: nil)
            lblPermanentAddressInfo.textColor = .MIDGREY
            lblPermanentAddressInfo.font = UIFont.font_(name: "Gotham-Book", size: 16.0)
            lblOther.textColor = .DARKGREY
            lblOther.font = UIFont.font_(name: "Gotham-Medium", size: 16.0)
            
            showOtherAddress(clearData: clearData)
        }
    }
    func hideOtherAddress(clearData:Bool){
        txtAddress_Other.isHidden = true
        txtStreetName_Other.isHidden = true
        txtFlatVillaNo_Other.isHidden = true
        txtCity_Other.isHidden = true
        txtState_Other.isHidden = true
        txtZipCode_Other.isHidden = true
        txtCountry_Other.isHidden = true
        if clearData{
        txtAddress_Other.txtType.text = ""
        txtStreetName_Other.txtType.text = ""
        txtFlatVillaNo_Other.txtType.text = ""
        txtCity_Other.txtType.text = ""
        txtState_Other.txtType.text = ""
        txtZipCode_Other.txtType.text = ""
        txtCountry_Other.txtType.text = ""
        }
    }
    func showOtherAddress(clearData:Bool){
        txtAddress_Other.isHidden = false
        txtStreetName_Other.isHidden = false
        txtFlatVillaNo_Other.isHidden = false
        txtCity_Other.isHidden = false
        txtState_Other.isHidden = false
        txtZipCode_Other.isHidden = false
        txtCountry_Other.isHidden = false
        if clearData{
        txtAddress_Other.txtType.text = ""
        txtStreetName_Other.txtType.text = ""
        txtFlatVillaNo_Other.txtType.text = ""
        txtCity_Other.txtType.text = ""
        txtState_Other.txtType.text = ""
        txtZipCode_Other.txtType.text = ""
        txtCountry_Other.txtType.text = ""
        }
    }
    //MARK: - @IBAction
    @IBAction func btnBack(_ sender: Any) {
        if isFormSubmitted{
            self.dismiss(animated: true, completion: nil)
        }else{
            showAlert()
        }
    }
    @IBAction func btnRadioPermanentAddressInfo(_ sender: Any) {
        mailing_address_same_w8_c = "permanent_address_information"
        manageIsYourMailing(clearData: true)
    }
    @IBAction func btnRadioOther(_ sender: Any) {
        mailing_address_same_w8_c = "others"
        manageIsYourMailing(clearData: true)
    }
    @IBAction func btnSubmit(_ sender: Any) {
        apiCall_updateApplication()
    }
    
    func showAlert(){
        //--
        let popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Sorry!")
        alert.lblMessage.text = Localize(key: "Make sure you fill all mandatory details and then submit the form")
        alert.btnGotoApplication.isHidden = true
        alert.btnContinueApplication.isHidden = true
        alert.btnCancel.setTitle(Localize(key: "GOT IT"), for: .normal)
        alert.didTappedCancel = { (sender) in
            popover.dismiss()
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

}

extension TaxResidentofUSAVC: UIFloatingTextField_Protocol{
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool {
        if txtZipCode.txtType != textField ||
            txtZipCode_Other.txtType != textField{
            if AppHelper.allowSomeCharactesOnly(txt: txt) == false{
                return false
            }
        }
        
        
        validateErrorMsg(textField: textField, txt: txt)
        
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
        
        if txtNameofIndividual.txtType == textField{
            txtNameofIndividual.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtNameofIndividual.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCountryofCitizenship.txtType == textField{
            txtCountryofCitizenship.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtCountryofCitizenship.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        //--
        if txtAddress.txtType == textField{
            txtAddress.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtAddress.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtStreetName.txtType == textField{
            txtStreetName.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtStreetName.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtFlatVillaNo.txtType == textField{
            txtFlatVillaNo.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtFlatVillaNo.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCity.txtType == textField{
            txtCity.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtCity.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtState.txtType == textField{
            txtState.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtState.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtZipCode.txtType == textField{
            txtZipCode.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtZipCode.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCountry1.txtType == textField{
            txtCountry1.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtCountry1.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        //-- Other Address
        if txtAddress_Other.txtType == textField{
            txtAddress_Other.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtAddress_Other.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtStreetName_Other.txtType == textField{
            txtStreetName_Other.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtStreetName_Other.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtFlatVillaNo_Other.txtType == textField{
            txtFlatVillaNo_Other.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtFlatVillaNo_Other.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCity_Other.txtType == textField{
            txtCity_Other.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtCity_Other.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtState_Other.txtType == textField{
            txtState_Other.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtState_Other.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtZipCode_Other.txtType == textField{
            txtZipCode_Other.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtZipCode_Other.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCountry_Other.txtType == textField{
            txtCountry_Other.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtCountry_Other.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        //--
        if txtUSTaxpayer.txtType == textField{
            txtUSTaxpayer.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtUSTaxpayer.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtForeginTax.txtType == textField{
            txtForeginTax.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtForeginTax.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtReferenceNumber.txtType == textField{
            txtReferenceNumber.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtReferenceNumber.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        validateEnput()
    }
    func validateEnput(){
        var returnValue = true
        
        if AppHelper.isNull(txtNameofIndividual.txtType.text!){
            //txtNameofIndividual.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtCountryofCitizenship.txtType.text!){
            //txtCountryofCitizenship.lblError.isHidden = false
            returnValue = false
        }
        
        //--
        if AppHelper.isNull(txtAddress.txtType.text!){
            //txtAddress.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtStreetName.txtType.text!){
            //txtStreetName.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtFlatVillaNo.txtType.text!){
            //txtFlatVillaNo.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtCity.txtType.text!){
            //txtCity.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtState.txtType.text!){
            //txtState.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtZipCode.txtType.text!){
            //txtZipCode.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtCountry1.txtType.text!){
            //txtCountry1.lblError.isHidden = false
            returnValue = false
        }
        
        if mailing_address_same_w8_c == "others"{
            //-- Other Address
            if AppHelper.isNull(txtAddress_Other.txtType.text!){
                //txtAddress_Other.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtStreetName_Other.txtType.text!){
                //txtStreetName_Other.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtFlatVillaNo_Other.txtType.text!){
                //txtFlatVillaNo_Other.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtCity_Other.txtType.text!){
                //txtCity_Other.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtState_Other.txtType.text!){
                //txtState_Other.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtZipCode_Other.txtType.text!){
                //txtZipCode_Other.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtCountry_Other.txtType.text!){
                //txtCountry_Other.lblError.isHidden = false
                returnValue = false
            }
        }
        
        //--
        if AppHelper.isNull(txtUSTaxpayer.txtType.text!){
            //txtUSTaxpayer.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtForeginTax.txtType.text!){
            //txtForeginTax.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtReferenceNumber.txtType.text!){
            //txtReferenceNumber.lblError.isHidden = false
            returnValue = false
        }
        //return returnValue
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewbgSubmit)
        }else{
            AppHelper.disableNextBTN(view_: viewbgSubmit)
        }
    }

}


extension TaxResidentofUSAVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListOfDropDown.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDropDownTblCell", for: indexPath) as! CustomDropDownTblCell
        cell.selectionStyle = .none
        
        cell.lblTitle.text = arrListOfDropDown[indexPath.row]
        
        if indexPath.row == selectIndex{
            cell.imgSelectIcon.isHidden = false
        }else{
            cell.imgSelectIcon.isHidden = true
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //--
        selectIndex = indexPath.row
        tblList.reloadData()
        
        
        //--
        let fatca_classification_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .fatca_classification_c, index: selectIndex)
        if fatca_classification_c == "1" ||
            fatca_classification_c == "2" ||
            fatca_classification_c == "4"{
            //"USA Nationality" W9
            
            //--
            self.dismiss(animated: false, completion: nil)
            delegate_didSelectCustomDropDown_Protocol?.didSelectdidSelectCustomDropDown(title: "", index: indexPath.row, droDownType: "areyouholderofanyoftheusdoc")
        }
        if fatca_classification_c == "3" ||
            fatca_classification_c == "5" ||
            fatca_classification_c == "6"{
            //"Tax Resident of USA" W8
            //--
            
        }
        if  fatca_classification_c == "7"{
            //non
            //--
            self.dismiss(animated: false, completion: nil)
            delegate_didSelectCustomDropDown_Protocol?.didSelectdidSelectCustomDropDown(title: arrListOfDropDown[indexPath.row], index: indexPath.row, droDownType: "areyouholderofanyoftheusdoc_submit")
        }
        /*
        //--
        if indexPath.row == 2{
           
            
        }else{
            
            //--
            //delegate_didSelectSourceofFunds_protocol?.didSelectSourceofFunds(text: arrListOfDropDown[indexPath.row], index: selectIndex)
            self.dismiss(animated: true, completion: nil)
        }*/
    }
}

//MARK: - Api Call
extension TaxResidentofUSAVC{
    
   
    func setFormData(result: GetApplicationDataResult){
        //--
        if (result.name_fatca_w8_c as? String ?? "").count != 0{
            isFormSubmitted = true
        }
        txtNameofIndividual.txtType.text = ""
        txtNameofIndividual.txtType.insertText(result.name_fatca_w8_c as? String ?? "")
        txtNameofIndividual.iconFill.isHidden = AppHelper.isNull(txtNameofIndividual.txtType.text!) == false ? false : true
        
        txtCountryofCitizenship.txtType.text = ""
        txtCountryofCitizenship.txtType.insertText(result.country_of_citizenship_w8_c as? String ?? "")
        txtCountryofCitizenship.iconFill.isHidden = AppHelper.isNull(txtCountryofCitizenship.txtType.text!) == false ? false : true
        
        txtAddress.txtType.text = ""
        txtAddress.txtType.insertText(result.address_number_fatca_w8_c as? String ?? "")
        txtAddress.iconFill.isHidden = AppHelper.isNull(txtAddress.txtType.text!) == false ? false : true
        
        txtStreetName.txtType.text = ""
        txtStreetName.txtType.insertText(result.street_fatca_w8_c as? String ?? "")
        txtStreetName.iconFill.isHidden = AppHelper.isNull(txtStreetName.txtType.text!) == false ? false : true
        
        txtFlatVillaNo.txtType.text = ""
        txtFlatVillaNo.txtType.insertText(result.apt_suite_no_facta_w8_c as? String ?? "")
        txtFlatVillaNo.iconFill.isHidden = AppHelper.isNull(txtFlatVillaNo.txtType.text!) == false ? false : true
        
        txtCity.txtType.text = ""
        txtCity.txtType.insertText(result.city_fatca_w8_c as? String ?? "")
        txtCity.iconFill.isHidden = AppHelper.isNull(txtCity.txtType.text!) == false ? false : true
        
        txtState.txtType.text = ""
        txtState.txtType.insertText(result.state_fatca_w8_c as? String ?? "")
        txtState.iconFill.isHidden = AppHelper.isNull(txtState.txtType.text!) == false ? false : true
        
        if let zip_code_w8_c = result.zip_code_w8_c as? Int, zip_code_w8_c > 0{
            txtZipCode.txtType.text = ""
            txtZipCode.txtType.insertText("\(zip_code_w8_c)")
            txtZipCode.iconFill.isHidden = AppHelper.isNull(txtZipCode.txtType.text!) == false ? false : true
        }
        txtCountry1.txtType.text = ""
        txtCountry1.txtType.insertText(result.country_facta_w8_c as? String ?? "")
        txtCountry1.iconFill.isHidden = AppHelper.isNull(txtCountry1.txtType.text!) == false ? false : true
        
        txtAddress_Other.txtType.text = ""
        txtAddress_Other.txtType.insertText(result.mailing_address_number_w8_c as? String ?? "")
        txtAddress_Other.iconFill.isHidden = AppHelper.isNull(txtAddress_Other.txtType.text!) == false ? false : true
        
        txtStreetName_Other.txtType.text = ""
        txtStreetName_Other.txtType.insertText(result.mailing_street_fatca_w8_c as? String ?? "")
        txtStreetName_Other.iconFill.isHidden = AppHelper.isNull(txtStreetName_Other.txtType.text!) == false ? false : true
        
        txtFlatVillaNo_Other.txtType.text = ""
        txtFlatVillaNo_Other.txtType.insertText(result.mailing_apt_suite_no_w8_c as? String ?? "")
        txtFlatVillaNo_Other.iconFill.isHidden = AppHelper.isNull(txtFlatVillaNo_Other.txtType.text!) == false ? false : true
        
        txtCity_Other.txtType.text = ""
        txtCity_Other.txtType.insertText(result.mailing_city_w8_c as? String ?? "")
        txtCity_Other.iconFill.isHidden = AppHelper.isNull(txtCity_Other.txtType.text!) == false ? false : true
        
        txtState_Other.txtType.text = ""
        txtState_Other.txtType.insertText(result.mailing_state_fatca_w8_c as? String ?? "")
        txtState_Other.iconFill.isHidden = AppHelper.isNull(txtState_Other.txtType.text!) == false ? false : true
        
        txtZipCode_Other.txtType.text = ""
        txtZipCode_Other.txtType.insertText(result.mailing_postal_code_fatca_w8_c as? String ?? "")
        txtZipCode_Other.iconFill.isHidden = AppHelper.isNull(txtZipCode_Other.txtType.text!) == false ? false : true
        
        txtCountry_Other.txtType.text = ""
        txtCountry_Other.txtType.insertText(result.mailing_country_fatca_w8_c as? String ?? "")
        txtCountry_Other.iconFill.isHidden = AppHelper.isNull(txtCountry_Other.txtType.text!) == false ? false : true
        
        txtUSTaxpayer.txtType.text = ""
        txtUSTaxpayer.txtType.insertText(result.us_taxpayer_id_fatca_w8_c as? String ?? "")
        txtUSTaxpayer.iconFill.isHidden = AppHelper.isNull(txtUSTaxpayer.txtType.text!) == false ? false : true
        txtForeginTax.txtType.text = ""
        txtForeginTax.txtType.insertText(result.foreign_tax_id_number_w8_c as? String ?? "")
        txtForeginTax.iconFill.isHidden = AppHelper.isNull(txtForeginTax.txtType.text!) == false ? false : true
        txtReferenceNumber.txtType.text = ""
        txtReferenceNumber.txtType.insertText(result.reference_number_w8_c as? String ?? "")
        txtReferenceNumber.iconFill.isHidden = AppHelper.isNull(txtReferenceNumber.txtType.text!) == false ? false : true
        
        mailing_address_same_w8_c = (result.mailing_address_same_w8_c as? String ?? "").count == 0 ? "permanent_address_information" : result.mailing_address_same_w8_c as? String ?? ""
        manageIsYourMailing(clearData: false)
    }
    func apiCall_updateApplication()  {
        
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.regularityDeclarationScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": ["name_fatca_w8_c":txtNameofIndividual.txtType.text!,
                                                                 "country_of_citizenship_w8_c":txtCountryofCitizenship.txtType.text!,
                                                                 "address_number_fatca_w8_c":txtAddress.txtType.text!,
                                                                 "street_fatca_w8_c":txtStreetName.txtType.text!,
                                                                 "apt_suite_no_facta_w8_c":txtFlatVillaNo.txtType.text!,
                                                                 "city_fatca_w8_c":txtCity.txtType.text!,
                                                                 "state_fatca_w8_c":txtState.txtType.text!,
                                                                 "zip_code_w8_c":txtZipCode.txtType.text!,
                                                                 "country_facta_w8_c":txtCountry1.txtType.text!,
                                                                 "mailing_address_same_w8_c":mailing_address_same_w8_c,
                                                                 "mailing_address_number_w8_c":txtAddress_Other.txtType.text!,
                                                                 "mailing_street_fatca_w8_c":txtStreetName_Other.txtType.text!,
                                                                 "mailing_apt_suite_no_w8_c":txtFlatVillaNo_Other.txtType.text!,
                                                                 "mailing_city_w8_c":txtCity_Other.txtType.text!,
                                                                 "mailing_state_fatca_w8_c":txtState_Other.txtType.text!,
                                                                 "mailing_postal_code_fatca_w8_c":txtZipCode_Other.txtType.text!,
                                                                 "mailing_country_fatca_w8_c":txtCountry_Other.txtType.text!,
                                                                 "us_taxpayer_id_fatca_w8_c":txtUSTaxpayer.txtType.text!,
                                                                 "foreign_tax_id_number_w8_c":txtForeginTax.txtType.text!,
                                                                 "reference_number_w8_c":txtReferenceNumber.txtType.text!
                                                                 ]
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], completion: { [self] (response) in
            print(response as Any)
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "200"{
                if oTPGenerationModel.Response?.Body?.status == "Success"{
                    //--
                    self.dismiss(animated: true, completion: nil)
                    delegate_didSelectCustomDropDown_Protocol?.didSelectdidSelectCustomDropDown(title: arrListOfDropDown[selectIndex], index: selectIndex, droDownType: "areyouholderofanyoftheusdoc_submit")
                    //apiCall_UploadImage(isFront: true)
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
