//
//  USNationalityVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 12/02/22.
//

import UIKit
//import Popover

class USNationalityVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var viewbgHeader1: UIView!
    @IBOutlet weak var lblHeader1Title: UILabel!
    @IBOutlet weak var lblHeader1_usaNationality: UILabel!
    @IBOutlet weak var viewbgheader2: UIView!
    @IBOutlet weak var lblHeader2Title: UILabel!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var tblList_height: NSLayoutConstraint!
    @IBOutlet weak var viewbgLine1_height: NSLayoutConstraint!
    @IBOutlet weak var lblUSDocumentDetail: UILabel!
    @IBOutlet weak var txtName: UIFloatingTextField!
    @IBOutlet weak var lblAddressInformation: UILabel!
    @IBOutlet weak var txtAddress: UIFloatingTextField!
    @IBOutlet weak var txtStreetName: UIFloatingTextField!
    @IBOutlet weak var txtFlatVillaNo: UIFloatingTextField!
    @IBOutlet weak var txtCity: UIFloatingTextField!
    @IBOutlet weak var txtState: UIFloatingTextField!
    @IBOutlet weak var txtZipCode: UIFloatingTextField!
    @IBOutlet weak var txtSocialSecurityNumber: UIFloatingTextField!
    @IBOutlet weak var viewbgbtnSubmit: UIView!
    @IBOutlet weak var lblbtnSubmit: UILabel!
    

    //MARK: - Veriable
    var arrListOfDropDown = ManageDropDownOption.getDropDownValue(dropdown_filed: .fatca_classification_c)
    var selectIndex = 0
    var delegate_didSelectCustomDropDown_Protocol: didSelectCustomDropDown_Protocol?
    var isFormSubmitted = false
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        registerCell()
        setupTextField()
        tblList.reloadData()
        AppHelper.disableNextBTN(view_: viewbgbtnSubmit)
        
        apiCall_getApplicationData (showProgress: true, completionOut: { result in
            self.setFormData(result: result)
        })
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblUSDocumentDetail.text = Localize(key: "US Document Details")
        lblAddressInformation.text = Localize(key: "Address Information")
        lblbtnSubmit.text = Localize(key: "SUBMIT")
        lblHeader1Title.text = Localize(key: "Are you a holder of any of the following?")
        lblHeader1_usaNationality.text = selectIndex == -1 ? "" : arrListOfDropDown[selectIndex]
        lblHeader2Title.text = Localize(key: "Are you a holder of any of the following?")
        
        if Managelanguage.getLanguageCode() == "A"
        {
            txtName.txtType.textAlignment = .right
            txtAddress.txtType.textAlignment = .right
            txtStreetName.txtType.textAlignment = .right
            txtFlatVillaNo.txtType.textAlignment = .right
            txtCity.txtType.textAlignment = .right
            txtState.txtType.textAlignment = .right
            txtZipCode.txtType.textAlignment = .right
            txtSocialSecurityNumber.txtType.textAlignment = .right
        }
    }
    func registerCell(){
        tblList.register(UINib(nibName: "CustomDropDownTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "CustomDropDownTblCell")
    }
    func setupTextField(){
        //US Document Details
        txtName.setTitlePlaceholder(text_: Localize(key: "Name (as shown on your income tax return)"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true)
        txtName.delegate_UIFloatingTextField_Protocol = self
        
        //Address Information
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
        
        txtSocialSecurityNumber.setTitlePlaceholder(text_: Localize(key: "Social security number / Employer identification number"), placeholder_: Localize(key: "Enter number"), isUserInteraction: true)
        txtSocialSecurityNumber.txtType.keyboardType = .numberPad
        txtSocialSecurityNumber.delegate_UIFloatingTextField_Protocol = self
    }

    //MARK: - @IBAction
    @IBAction func btnBackHeader1(_ sender: Any) {
        if isFormSubmitted{
            self.dismiss(animated: true, completion: nil)
        }else{
            showAlert()
        }
    }
    @IBAction func btnBackHeader2(_ sender: Any) {
        if isFormSubmitted{
            self.dismiss(animated: true, completion: nil)
        }else{
            showAlert()
        }
    }
    @IBAction func btnHeader1_usaNationality(_ sender: Any) {
        tblList_height.constant = 470 //self.tblList.contentSize.height
        viewbgLine1_height.constant = 10
        viewbgHeader1.isHidden = true
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

extension USNationalityVC: UIFloatingTextField_Protocol{
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool {
        if txtZipCode.txtType != textField ||
            txtSocialSecurityNumber.txtType != textField{
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
        
        if txtName.txtType == textField{
            txtName.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtName.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
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
        if txtSocialSecurityNumber.txtType == textField{
            txtSocialSecurityNumber.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtSocialSecurityNumber.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        validateEnput()
    }
    func validateEnput() {
        var returnValue = true
        
        if AppHelper.isNull(txtName.txtType.text!){
            //txtName.lblError.isHidden = false
            returnValue = false
        }
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
        if AppHelper.isNull(txtSocialSecurityNumber.txtType.text!){
            //txtSocialSecurityNumber.lblError.isHidden = false
            returnValue = false
        }
        //return returnValue
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewbgbtnSubmit)
        }else{
            AppHelper.disableNextBTN(view_: viewbgbtnSubmit)
        }
    }

}
extension USNationalityVC: UITableViewDelegate, UITableViewDataSource
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
            lblHeader1_usaNationality.text = arrListOfDropDown[indexPath.row]
        }
        if fatca_classification_c == "3" ||
            fatca_classification_c == "5" ||
            fatca_classification_c == "6" {
            //"Tax Resident of USA" W8
            //--
            self.dismiss(animated: false, completion: nil)
            delegate_didSelectCustomDropDown_Protocol?.didSelectdidSelectCustomDropDown(title: "", index: indexPath.row, droDownType: "areyouholderofanyoftheusdoc")
            
            /*//--
            let vc = TaxResidentofUSAVC(nibName: "TaxResidentofUSAVC", bundle: nil)
            vc.selectIndex = selectIndex
            vc.modalPresentationStyle = .fullScreen
            AppHelper.returnTopNavigationController().self.present(vc, animated: false, completion: nil)*/
        }
        if  fatca_classification_c == "7"{
            //non
            //--
            self.dismiss(animated: false, completion: nil)
            delegate_didSelectCustomDropDown_Protocol?.didSelectdidSelectCustomDropDown(title: arrListOfDropDown[indexPath.row], index: indexPath.row, droDownType: "areyouholderofanyoftheusdoc_submit")
        }
        
        /*
            //--
            let vc = TaxResidentofUSAVC(nibName: "TaxResidentofUSAVC", bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }else{
            //delegate_didSelectSourceofFunds_protocol?.didSelectSourceofFunds(text: arrListOfDropDown[indexPath.row], index: selectIndex)
            self.dismiss(animated: true, completion: nil)
        }
        */
    }
}

//MARK: - Api Call
extension USNationalityVC{
    func setFormData(result: GetApplicationDataResult){
        //--
        lblHeader1_usaNationality.text = arrListOfDropDown[selectIndex]
        
        if (result.name_fatca_w9_c as? String ?? "").count != 0{
            isFormSubmitted = true
            
            txtName.txtType.text = ""
            txtName.txtType.insertText(result.name_fatca_w9_c as? String ?? "")
            txtName.iconFill.isHidden = AppHelper.isNull(txtName.txtType.text!) == false ? false : true
            
            txtAddress.txtType.text = ""
            txtAddress.txtType.insertText(result.address_number_w9_c as? String ?? "")
            txtAddress.iconFill.isHidden = AppHelper.isNull(txtAddress.txtType.text!) == false ? false : true
            
            txtStreetName.txtType.text = ""
            txtStreetName.txtType.insertText(result.street_number_facta_w9_c as? String ?? "")
            txtStreetName.iconFill.isHidden = AppHelper.isNull(txtStreetName.txtType.text!) == false ? false : true
            
            txtFlatVillaNo.txtType.text = ""
            txtFlatVillaNo.txtType.insertText(result.apt_suite_no_facta_w9_c as? String ?? "")
            txtFlatVillaNo.iconFill.isHidden = AppHelper.isNull(txtFlatVillaNo.txtType.text!) == false ? false : true
            
            txtCity.txtType.text = ""
            txtCity.txtType.insertText(result.city_facta_w9_c as? String ?? "")
            txtCity.iconFill.isHidden = AppHelper.isNull(txtCity.txtType.text!) == false ? false : true
            
            txtState.txtType.text = ""
            txtState.txtType.insertText(result.state_facta_w9_c as? String ?? "")
            txtState.iconFill.isHidden = AppHelper.isNull(txtState.txtType.text!) == false ? false : true
            
            txtZipCode.txtType.text = ""
            txtZipCode.txtType.insertText(result.zip_code_facta_w9_c as? String ?? "")
            txtZipCode.iconFill.isHidden = AppHelper.isNull(txtZipCode.txtType.text!) == false ? false : true
            
            if let ustaxpayer_id_fatca_w9_c = result.ustaxpayer_id_fatca_w9_c as? Int, ustaxpayer_id_fatca_w9_c > 0{
                txtSocialSecurityNumber.txtType.text = ""
                txtSocialSecurityNumber.txtType.insertText("\(ustaxpayer_id_fatca_w9_c)")
                txtSocialSecurityNumber.iconFill.isHidden = AppHelper.isNull(txtSocialSecurityNumber.txtType.text!) == false ? false : true
            }
        }
        
        validateEnput()
    }
    
    func apiCall_updateApplication()  {
        
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.regularityDeclarationScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": ["name_fatca_w9_c":txtName.txtType.text!,
                                                                 "address_number_w9_c":txtAddress.txtType.text!,
                                                                 "street_number_facta_w9_c":txtStreetName.txtType.text!,
                                                                 "apt_suite_no_facta_w9_c":txtFlatVillaNo.txtType.text!,
                                                                 "city_facta_w9_c":txtCity.txtType.text!,
                                                                 "state_facta_w9_c":txtState.txtType.text!,
                                                                 "zip_code_facta_w9_c":txtZipCode.txtType.text!,
                                                                 "ustaxpayer_id_fatca_w9_c":txtSocialSecurityNumber.txtType.text!
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
