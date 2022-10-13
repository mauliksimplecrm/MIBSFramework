//
//  PEPVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 13/02/22.
//

import UIKit
import Foundation
//import Popover
//import SKCountryPicker

protocol didSelectPEP_protocol {
    func didSelectPEP(txt: String, index: Int)
}

class PEPVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var viewMain_top: NSLayoutConstraint!
    @IBOutlet weak var viewStep1: UIView!
    @IBOutlet weak var lblTitleStep1: UILabel!
    @IBOutlet weak var lblDetailStep1: UILabel!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var viewStep1_height: NSLayoutConstraint!
    @IBOutlet weak var viewStep2: UIView!
    @IBOutlet weak var lblTitleStep2: UILabel!
    @IBOutlet weak var lblDetailStep2: UILabel!
    @IBOutlet weak var viewPEPDetailSectionLine: UIView!
    @IBOutlet weak var viewPEPDetail: UIView!
    @IBOutlet weak var viewPEPDetail_height: NSLayoutConstraint! //805
    @IBOutlet weak var lblPEPDetail_title: UILabel!
    @IBOutlet weak var txtTypeofPEP: UIFloatingTextField!
    @IBOutlet weak var txtNameofPEP: UIFloatingTextField!
    @IBOutlet weak var txtPositionofPEP: UIFloatingTextField!
    @IBOutlet weak var txtNationalityofPEP: UIFloatingTextField!
    @IBOutlet weak var txtCountryofResidence: UIFloatingTextField!
    @IBOutlet weak var txtRelationshipwithPEP: UIFloatingTextField!
    @IBOutlet weak var txtSourceofwealth: UIFloatingTextField!
    @IBOutlet weak var viewSubmit: UIView!
    @IBOutlet weak var lblbtnSubmit: UILabel!
    
    //--
    @IBOutlet var viewAlertPopup: UIView!
    @IBOutlet weak var viewInnerAlertPopup: UIView!
    @IBOutlet weak var lblTitleAlertPopup: UILabel!
    @IBOutlet weak var lblDetailAlertPopup: UILabel!
    @IBOutlet weak var btnGotitAlertPopup: UIButton!
    
    
    //MARK: - Veriable
    var popover = Popover()
    var arrListOfDropDown = ManageDropDownOption.getDropDownValue(dropdown_filed: .is_pep_c)
    var selectIndex = -1
    var delegate_didSelectPEP_protocol: didSelectPEP_protocol?
    
    var selectTypeofPEPIndex = -1
    var selectNationalityofPEPIndex = ""
    var selectRelationshipWithThePEP = -1
    var selectSourceOfWealthOfPEP = -1
    var selectCountryofResidence = ""
    var isFormSubmitted = false
    var tableViewHeight: CGFloat {
        tblList.layoutIfNeeded()
        return tblList.contentSize.height
    }
    
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        registerCell()
        setupTextField()
        setUIStep1()
        tblList.reloadData()
        
        AppHelper.disableNextBTN(view_: viewSubmit)
    }
    
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblPEPDetail_title.text = Localize(key: "PEP Details")
        lblbtnSubmit.text = Localize(key: "SUBMIT")
        
        lblTitleStep1.text = Localize(key: "Are you Politically Exposed Person (PEP)?")
        lblDetailStep1.text = Localize(key: "holder_of_us_doc_title_description")
        lblTitleStep2.text = Localize(key: "Are you Politically Exposed Person (PEP)?")
        lblDetailStep2.text = Localize(key: "Yes")
        
        
        if Managelanguage.getLanguageCode() == "A"
        {
            txtTypeofPEP.txtType.textAlignment = .right
            txtNameofPEP.txtType.textAlignment = .right
            txtPositionofPEP.txtType.textAlignment = .right
            txtNationalityofPEP.txtType.textAlignment = .right
            txtCountryofResidence.txtType.textAlignment = .right
            txtRelationshipwithPEP.txtType.textAlignment = .right
            txtSourceofwealth.txtType.textAlignment = .right
            
        }
    }
    func registerCell(){
        tblList.register(UINib(nibName: "CustomDropDownTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "CustomDropDownTblCell")
    }
    func setupTextField(){
        //US Document Details
        txtTypeofPEP.setTitlePlaceholder(text_: Localize(key: "Type of PEP"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtTypeofPEP.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .type_of_pep_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Type of PEP"),
                                    dropDownType: "TypeOfPEP",
                                    arrList: list,
                                    selectedIndex: self.selectTypeofPEPIndex)
        }
        
        txtNameofPEP.setTitlePlaceholder(text_: Localize(key: "Name of the PEP"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtNameofPEP.delegate_UIFloatingTextField_Protocol = self
        
        txtPositionofPEP.setTitlePlaceholder(text_: Localize(key: "Position of the PEP"), placeholder_: Localize(key: "Enter position"), isUserInteraction: true)
        txtPositionofPEP.delegate_UIFloatingTextField_Protocol = self
        
        txtNationalityofPEP.setTitlePlaceholder(text_: Localize(key: "Nationality of PEP"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtNationalityofPEP.didTappedDropDown = { (sender) in
            //--
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Nationality of PEP"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                txtNationalityofPEP.txtType.text = ""
                txtNationalityofPEP.txtType.insertText(countryName)
                selectNationalityofPEPIndex = countryCode
                txtNationalityofPEP.lblError.isHidden = true
                txtNationalityofPEP.iconFill.isHidden = false
                validateEnput()
            }
        }
        
        txtCountryofResidence.setTitlePlaceholder(text_: Localize(key: "Country of Residence of PEP"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtCountryofResidence.didTappedDropDown = { (sender) in
            //--
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Country of Residence of PEP"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                txtCountryofResidence.txtType.text = ""
                txtCountryofResidence.txtType.insertText(countryName)
                selectCountryofResidence = countryCode
                txtCountryofResidence.lblError.isHidden = true
                txtCountryofResidence.iconFill.isHidden = false
                validateEnput()
            }
        }
        
        txtRelationshipwithPEP.setTitlePlaceholder(text_: Localize(key: "Relationship with the PEP"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtRelationshipwithPEP.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .relationship_with_the_pep_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Relationship with the PEP"),
                                    dropDownType: "RelationshipWithThePEP",
                                    arrList: list,
                                    selectedIndex: self.selectRelationshipWithThePEP)
        }
        
        txtSourceofwealth.setTitlePlaceholder(text_: Localize(key: "Source_wealth_PEP"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtSourceofwealth.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .source_of_wealth_of_pep_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Source_wealth_PEP"),
                                    dropDownType: "SourceOfWealthOfPEP",
                                    arrList: list,
                                    selectedIndex: self.selectSourceOfWealthOfPEP)
        }
    }
    func openErrorAlert(title: String, details: String){
        //--
        lblTitleAlertPopup.text = title
        lblDetailAlertPopup.text = details
        
        //--
        popover = Popover()
        viewAlertPopup.frame.size = CGSize(width: UIScreen.main.bounds.width-30, height: viewInnerAlertPopup.frame.height)
        let aView = UIView()
        aView.frame = viewAlertPopup.frame
        aView.addSubview(viewAlertPopup)
        popover.dismissOnBlackOverlayTap = true
        popover.blackOverlayColor = popoverBackgroundColor
        popover.showAsDialog(aView, inView: self.view)
    }
    func setUIStep1(){
        let window = keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0.0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
        let height = UIScreen.main.bounds.height - topPadding - bottomPadding
        
        let fixHeight = 80
        let lbl1Height = lblTitleStep1.systemLayoutSizeFitting(CGSize(width: lblTitleStep1.frame.width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        let lbl2Height = lblDetailStep1.systemLayoutSizeFitting(CGSize(width: lblDetailStep1.frame.width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        let tblheight = tableViewHeight
        let containHeight = (CGFloat(fixHeight) + lbl1Height + lbl2Height + tblheight)
        
        if containHeight < 270{
            viewMain_top.constant = height - 270
            viewStep1_height.constant = 270
        }else{
            viewMain_top.constant = height - containHeight
            viewStep1_height.constant = containHeight
        }
        
        
        viewStep1.isHidden = false
        viewStep2.isHidden = true
        viewPEPDetailSectionLine.isHidden = true
        viewPEPDetail.isHidden = true
        viewPEPDetail_height.constant = 0
    }
    func setUIStep2(){
        viewMain_top.constant = 0
        viewStep1_height.constant = 117
        viewStep1.isHidden = true
        viewStep2.isHidden = false
        viewPEPDetailSectionLine.isHidden = true
        viewPEPDetail.isHidden = false
        viewPEPDetail_height.constant = 815
    }
    func setUIStep3(){
        viewMain_top.constant = 0
        viewStep1_height.constant = 280
        viewStep1.isHidden = false
        viewStep2.isHidden = true
        viewPEPDetailSectionLine.isHidden = false
        viewPEPDetail.isHidden = false
        viewPEPDetail_height.constant = 815
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
    
    //MARK: - @IBAction
    @IBAction func btnGotitAlertPopup(_ sender: Any) {
        popover.dismiss()
    }
    @IBAction func btnBackHeaderStep1(_ sender: Any) {
        popover.dismiss()
        let is_pep_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .is_pep_c, index: selectIndex)
        if is_pep_c == "Y"{
            if isFormSubmitted || selectIndex == -1{
                self.dismiss(animated: true, completion: nil)
            }else{
                showAlert()
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func btnBackStep2(_ sender: Any) {
        popover.dismiss()
        //dismiss(animated: true, completion: nil)
        //openErrorAlert(title: Localize(key: "Sorry!"), details: "Make sure you fill all mandatory details and then submit the form")
        
        let is_pep_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .is_pep_c, index: selectIndex)
        if is_pep_c == "Y"{
            if isFormSubmitted || selectIndex == -1{
                self.dismiss(animated: true, completion: nil)
            }else{
                showAlert()
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func btnOpenListStep2(_ sender: Any) {
        setUIStep3()
    }
    @IBAction func btnSubmit(_ sender: Any) {
        apiCall_updateApplication()
    }



}

extension PEPVC: UIFloatingTextField_Protocol{
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool {
        if AppHelper.allowSomeCharactesOnly(txt: txt) == false{
            return false
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
        
        if txtTypeofPEP.txtType == textField{
            txtTypeofPEP.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtTypeofPEP.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtNameofPEP.txtType == textField{
            txtNameofPEP.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtNameofPEP.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPositionofPEP.txtType == textField{
            txtPositionofPEP.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPositionofPEP.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtNationalityofPEP.txtType == textField{
            txtNationalityofPEP.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtNationalityofPEP.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCountryofResidence.txtType == textField{
            txtCountryofResidence.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtCountryofResidence.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtRelationshipwithPEP.txtType == textField{
            txtRelationshipwithPEP.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtRelationshipwithPEP.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtSourceofwealth.txtType == textField{
            txtSourceofwealth.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtSourceofwealth.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        validateEnput()
    }
    func validateEnput() {
        var returnValue = true
        
        if AppHelper.isNull(txtTypeofPEP.txtType.text!){
            //txtTypeofPEP.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtNameofPEP.txtType.text!){
            //txtNameofPEP.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtPositionofPEP.txtType.text!){
            //txtPositionofPEP.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtNationalityofPEP.txtType.text!){
            //txtNationalityofPEP.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtCountryofResidence.txtType.text!){
            //txtCountryofResidence.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtRelationshipwithPEP.txtType.text!){
            //txtRelationshipwithPEP.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtSourceofwealth.txtType.text!){
            //txtSourceofwealth.lblError.isHidden = false
            returnValue = false
        }
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewSubmit)
        }else{
            AppHelper.disableNextBTN(view_: viewSubmit)
        }
        //return returnValue
    }

}

extension PEPVC: didSelectCustomDropDown_Protocol{
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String) {
        if droDownType == "TypeOfPEP"{
            txtTypeofPEP.txtType.text = ""
            txtTypeofPEP.txtType.insertText(title)
            selectTypeofPEPIndex = index
            txtTypeofPEP.lblError.isHidden = true
            txtTypeofPEP.iconFill.isHidden = false
            validateEnput()
        }
        /*if droDownType == "NationalityofPEP"{
            txtNationalityofPEP.txtType.text = title
            selectNationalityofPEPIndex = index
            txtNationalityofPEP.lblError.isHidden = true
        }
        if droDownType == "CountryofResidence"{
            txtCountryofResidence.txtType.text = title
            selectCountryofResidence = index
            txtCountryofResidence.lblError.isHidden = true
        }*/
        if droDownType == "RelationshipWithThePEP"{
            txtRelationshipwithPEP.txtType.text = ""
            txtRelationshipwithPEP.txtType.insertText(title)
            selectRelationshipWithThePEP = index
            txtRelationshipwithPEP.lblError.isHidden = true
            txtRelationshipwithPEP.iconFill.isHidden = false
            validateEnput()
        }
        if droDownType == "SourceOfWealthOfPEP"{
            txtSourceofwealth.txtType.text = ""
            txtSourceofwealth.txtType.insertText(title)
            selectSourceOfWealthOfPEP = index
            txtSourceofwealth.lblError.isHidden = true
            txtSourceofwealth.iconFill.isHidden = false
            validateEnput()
        }
    }
}

extension PEPVC: UITableViewDelegate, UITableViewDataSource
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
        let is_pep_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .is_pep_c, index: selectIndex)
        if is_pep_c == "Y"{
           setUIStep2()
            //--
            apiCall_getApplicationData (showProgress: true, completionOut: { result in
                self.setFormData(result: result)
            })
        }else{
            
            //--
            delegate_didSelectPEP_protocol?.didSelectPEP(txt: arrListOfDropDown[indexPath.row], index: selectIndex)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

//MARK: - Api Call
extension PEPVC{
    
    
    func setFormData(result: GetApplicationDataResult){
        let type_of_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .type_of_pep_c, backendvalue: result.type_of_pep_c as? String ?? "")
        if type_of_pep_c.0.count != 0{
            isFormSubmitted = true
            
            txtTypeofPEP.txtType.text = ""
            txtTypeofPEP.txtType.insertText(type_of_pep_c.0)
            selectTypeofPEPIndex = type_of_pep_c.1
            txtTypeofPEP.iconFill.isHidden = AppHelper.isNull(txtTypeofPEP.txtType.text!) == false ? false : true
            
            txtNameofPEP.txtType.text = ""
            txtNameofPEP.txtType.insertText(result.name_of_the_pep_c as? String ?? "")
            txtNameofPEP.iconFill.isHidden = AppHelper.isNull(txtNameofPEP.txtType.text!) == false ? false : true
            
            txtPositionofPEP.txtType.text = ""
            txtPositionofPEP.txtType.insertText(result.position_of_pep_c as? String ?? "")
            txtPositionofPEP.iconFill.isHidden = AppHelper.isNull(txtPositionofPEP.txtType.text!) == false ? false : true
            
            let nationality_of_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.nationality_of_pep_c as? String ?? "")
            txtNationalityofPEP.txtType.text = ""
            txtNationalityofPEP.txtType.insertText(nationality_of_pep_c.0)
            selectNationalityofPEPIndex = result.nationality_of_pep_c as? String ?? ""
            txtNationalityofPEP.iconFill.isHidden = AppHelper.isNull(txtNationalityofPEP.txtType.text!) == false ? false : true
            
            let country_of_residence_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.country_of_residence_c as? String ?? "")
            txtCountryofResidence.txtType.text = ""
            txtCountryofResidence.txtType.insertText(country_of_residence_c.0)
            selectCountryofResidence = result.country_of_residence_c as? String ?? ""
            txtCountryofResidence.iconFill.isHidden = AppHelper.isNull(txtCountryofResidence.txtType.text!) == false ? false : true
            
            let relationship_with_the_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .relationship_with_the_pep_c, backendvalue: result.relationship_with_the_pep_c as? String ?? "")
            txtRelationshipwithPEP.txtType.text = ""
            txtRelationshipwithPEP.txtType.insertText(relationship_with_the_pep_c.0)
            selectRelationshipWithThePEP = relationship_with_the_pep_c.1
            txtRelationshipwithPEP.iconFill.isHidden = AppHelper.isNull(txtRelationshipwithPEP.txtType.text!) == false ? false : true
            
            let source_of_wealth_of_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .source_of_wealth_of_pep_c, backendvalue: result.source_of_wealth_of_pep_c as? String ?? "")
            txtSourceofwealth.txtType.text = ""
            txtSourceofwealth.txtType.insertText(source_of_wealth_of_pep_c.0)
            selectSourceOfWealthOfPEP = source_of_wealth_of_pep_c.1
            txtSourceofwealth.iconFill.isHidden = AppHelper.isNull(txtSourceofwealth.txtType.text!) == false ? false : true
            
        }
       
        validateEnput()
    }
    func apiCall_updateApplication()  {
        //--
        let type_of_pep_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .type_of_pep_c, index: selectTypeofPEPIndex)
        let relationship_with_the_pep_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .relationship_with_the_pep_c, index: selectRelationshipWithThePEP)
        let source_of_wealth_of_pep_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .source_of_wealth_of_pep_c, index: selectSourceOfWealthOfPEP)
        
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.regularityDeclarationScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": ["type_of_pep_c":type_of_pep_c,
                                                                 "name_of_the_pep_c":txtNameofPEP.txtType.text!,
                                                                 "position_of_pep_c":txtPositionofPEP.txtType.text!,
                                                                 "nationality_of_pep_c":selectNationalityofPEPIndex,
                                                                 "country_of_residence_c":selectCountryofResidence,
                                                                 "relationship_with_the_pep_c":relationship_with_the_pep_c,
                                                                 "source_of_wealth_of_pep_c":source_of_wealth_of_pep_c
                                                                 ]
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], completion: { [self] (response) in
            print(response as Any)
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "200"{
                if oTPGenerationModel.Response?.Body?.status == "Success"{
                    
                    //--
                    delegate_didSelectPEP_protocol?.didSelectPEP(txt: (arrListOfDropDown.count != 0 ? arrListOfDropDown[selectIndex] : ""), index: selectIndex)
                    self.dismiss(animated: true, completion: nil)
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
