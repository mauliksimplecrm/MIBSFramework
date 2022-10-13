//
//  AnyBranchInfoVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 21/02/22.
//

import UIKit
////import Popover

protocol SubmitAnyBranchInfo_protocol {
    func onSuccess()
}

class AnyBranchInfoVC: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var viewHeader1: UIView!
    @IBOutlet weak var lblTitleHeader1: UILabel!
    @IBOutlet weak var lblDetailHeader1: UILabel!
    @IBOutlet weak var viewHeader2: UIView!
    @IBOutlet weak var viewHeader2Height: NSLayoutConstraint! //256
    @IBOutlet weak var lblTitleHeader2: UILabel!
    @IBOutlet weak var tblListHeader2: UITableView!
    
    //Branch Details
    @IBOutlet weak var viewBranchDetail: UIView!
    @IBOutlet weak var viewBranchSectionHeight: NSLayoutConstraint! //10
    @IBOutlet weak var lblBranchDetail: UILabel!
    @IBOutlet weak var txtBranch: UIFloatingTextField!
    @IBOutlet weak var txtDate: UIFloatingTextField!
    @IBOutlet weak var txtTime: UIFloatingTextField!
    
    //Kiosk Detail
    @IBOutlet weak var viewKioskDetails: UIView!
    @IBOutlet weak var viewKioskSectionHeight: NSLayoutConstraint!
    @IBOutlet weak var lblKioskDetails: UILabel!
    @IBOutlet weak var txtKioskLocation: UIFloatingTextField!
    
    //Delivery Detail
    @IBOutlet weak var lblDeliveryDetails: UILabel!
    @IBOutlet weak var viewDelivery: UIView!
    @IBOutlet weak var viewDeliveryHeight: NSLayoutConstraint! //644
    @IBOutlet weak var viewDeliverySectionHeight: NSLayoutConstraint!
    @IBOutlet weak var txtAddress: UIFloatingTextField!
    @IBOutlet weak var txtStreetName: UIFloatingTextField!
    @IBOutlet weak var txtFlatVillaNo: UIFloatingTextField!
    @IBOutlet weak var txtCity: UIFloatingTextField!
    @IBOutlet weak var txtState: UIFloatingTextField!
    @IBOutlet weak var txtZipCode: UIFloatingTextField!
    
    @IBOutlet weak var lblTearmCondition: UILabel!
    @IBOutlet weak var viewSubmit: UIView!
    @IBOutlet weak var lblSubmit: UILabel!
    
    
    
    
    //MARK: - Veriable
    var didTappedTC: ((UIButton) -> (Void))? = nil
    var arrListOfDropDown:[Any] = []
    var selectIndex = -1
    var delegate_SubmitAnyBranchInfo_protocol: SubmitAnyBranchInfo_protocol?
    var header1Detail = ""
    var addonServices = AddonServices.debitcard
    
    var delegate_didSelectCustomDropDown_Protocol: didSelectCustomDropDown_Protocol?
    var dropDownType = ""
    
    var selectBranchIndex = -1
    var selectKioskLocationIndex = -1
    var selectDateBackendValue = ""
    
    var isAlreadySubmit = false
    
    var selectTimeSlotIndex = ""

    
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        registerCell()
        setupBasic()
        setupTextField()
        setUIStep1()
        tblListHeader2.reloadData()
        setAlreadySubmitValue()
        validateEnput()
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblTitleHeader1.text = Localize(key: "How will you receive the card?")
        lblTitleHeader2.text = Localize(key: "How will you receive the card?")
        
        lblBranchDetail.text = Localize(key: "Branch Details")
        lblKioskDetails.text = Localize(key: "Kiosk Details")
        lblDeliveryDetails.text = Localize(key: "Delivery Details")
        
        lblSubmit.text = Localize(key: "SUBMIT")
        
        if Managelanguage.getLanguageCode() == "A"
        {
            txtBranch.txtType.textAlignment = .right
            txtDate.txtType.textAlignment = .right
            txtTime.txtType.textAlignment = .right
            
            txtKioskLocation.txtType.textAlignment = .right
            
            txtAddress.txtType.textAlignment = .right
            txtStreetName.txtType.textAlignment = .right
            txtFlatVillaNo.txtType.textAlignment = .right
            txtCity.txtType.textAlignment = .right
            txtState.txtType.textAlignment = .right
            txtZipCode.txtType.textAlignment = .right
        }
    }
    func registerCell(){
        tblListHeader2.register(UINib(nibName: "CustomDropDownTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "CustomDropDownTblCell")
    }
    func setupBasic(){
        //--
        lblTearmCondition.attributedText = Localize(key: "My clicking Next, you agree to our Terms & Conditions").underlineWords(words: [Localize(key: "Terms & Conditions")], color: .DARKGREENTINT)
        
    }
    func setupTextField(){
        
        //Branch
        txtBranch.setTitlePlaceholder(text_: Localize(key: "Select branch you would like to collect"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtBranch.didTappedDropDown = { (sender) in
            self.view.endEditing(true)
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .branch_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Select branch you would like to collect"),
                                    dropDownType: "branch",
                                    arrList: list,
                                    selectedIndex: self.selectBranchIndex)
        }
        
        txtDate.setTitlePlaceholder(text_:Localize(key: "Date"), placeholder_: Localize(key: "Select Date"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtDate.didTappedDropDown = { (sender) in
            self.view.endEditing(true)
            //--
            let vc = SelectDateVC(nibName: "SelectDateVC", bundle: bundleIdentifireGlob)
            vc.delegate_didSelectDate_Protocol = self
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        
        txtTime.setTitlePlaceholder(text_: Localize(key: "Time"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtTime.didTappedDropDown = { (sender) in
            self.view.endEditing(true)
            
            /*//--
            let vc = TimePickerVC(nibName: "TimePickerVC", bundle: nil)
            vc.titleStr = Localize(key: "select_time")
            vc.modalPresentationStyle = .overCurrentContext
            vc.didTappedSubmit = { (sender, selectTime) in
                self.txtTime.txtType.text = selectTime
                self.validateEnput()
            }
            self.present(vc, animated: true, completion: nil)*/
            //--
            let vc = SelectTimeVC(nibName: "SelectTimeVC", bundle: bundleIdentifireGlob)
            vc.delegate_didSelectTimeSlot_Protocol = self
            vc.selectTimeSlotIndex = self.selectTimeSlotIndex
            vc.selectDateBackendValue = self.selectDateBackendValue
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        
        //Kiosk
        txtKioskLocation.setTitlePlaceholder(text_: Localize(key: "Select Kiosk Location"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtKioskLocation.didTappedDropDown = { (sender) in
            self.view.endEditing(true)
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .kiosk_location_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Select Kiosk Location"),
                                    dropDownType: "kiosk_location",
                                    arrList: list,
                                    selectedIndex: self.selectKioskLocationIndex)
        }
        
        //Delivery
        txtAddress.setTitlePlaceholder(text_: Localize(key: "Address"), placeholder_: Localize(key: "Enter address"), isUserInteraction: true, maximumNumberOfLines: 2)
        txtAddress.delegate_UIFloatingTextField_Protocol = self
        txtStreetName.setTitlePlaceholder(text_: Localize(key: "Street Name"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true, maximumNumberOfLines: 2)
        txtStreetName.delegate_UIFloatingTextField_Protocol = self
        txtFlatVillaNo.setTitlePlaceholder(text_: Localize(key: "Flat/Villa name"), placeholder_: Localize(key: "Enter no."), isUserInteraction: true)
        txtFlatVillaNo.delegate_UIFloatingTextField_Protocol = self
        txtCity.setTitlePlaceholder(text_: Localize(key: "City"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true, maximumNumberOfLines: 2)
        txtCity.delegate_UIFloatingTextField_Protocol = self
        txtState.setTitlePlaceholder(text_: Localize(key: "State"), placeholder_: Localize(key: "Enter name"), isUserInteraction: true, maximumNumberOfLines: 2)
        txtState.delegate_UIFloatingTextField_Protocol = self
        txtZipCode.setTitlePlaceholder(text_: Localize(key: "Zip Code"), placeholder_: Localize(key: "enter_zip_code"), isUserInteraction: true, maximumNumberOfLines: 2)
        txtZipCode.delegate_UIFloatingTextField_Protocol = self
        txtZipCode.txtType.keyboardType = .numberPad
        
    }
    func setAlreadySubmitValue(){
        let debit_card_collection_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_c, index: selectIndex)
        if debit_card_collection_c == "collecting_from_branch"{
            let branch_debit_card_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .branch_c, backendvalue: dicAddonServicesCRMData["branch_debit_card_c"] as? String ?? "")
            txtBranch.txtType.text = ""
            txtBranch.txtType.insertText(branch_debit_card_c.0)
            selectBranchIndex = branch_debit_card_c.1
            txtBranch.iconFill.isHidden = AppHelper.isNull(txtBranch.txtType.text!) == false ? false : true
            
            var debit_card_datetime_Arr = (dicAddonServicesCRMData["debit_card_datetime_c"] as? String ?? "").components(separatedBy: " ")
            if debit_card_datetime_Arr.count != 0{
                selectDateBackendValue = debit_card_datetime_Arr[0]
                txtDate.txtType.text = ""
                txtDate.txtType.insertText(AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "EEEE, dd/MM/yyyy", strDate: selectDateBackendValue))
                txtDate.iconFill.isHidden = AppHelper.isNull(txtDate.txtType.text!) == false ? false : true
            }
            if debit_card_datetime_Arr.count > 1{
                debit_card_datetime_Arr.remove(at: 0)
                txtTime.txtType.text = ""
                txtTime.txtType.insertText(debit_card_datetime_Arr.joined(separator: " "))
                txtTime.iconFill.isHidden = AppHelper.isNull(txtTime.txtType.text!) == false ? false : true
                
                selectTimeSlotIndex = dicAddonServicesCRMData["debit_card_datetime_c_backendvalue"] as? String ?? ""
            }
            
            if branch_debit_card_c.0.count != 0{
                isAlreadySubmit = true
            }
        }else if debit_card_collection_c == "printing_from_kiosk"{
            let kiosk_location_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .kiosk_location_c, backendvalue: dicAddonServicesCRMData["kiosk_location_c"] as? String ?? "")
            txtKioskLocation.txtType.text = ""
            txtKioskLocation.txtType.insertText(kiosk_location_c.0)
            selectKioskLocationIndex = kiosk_location_c.1
            txtKioskLocation.iconFill.isHidden = AppHelper.isNull(txtKioskLocation.txtType.text!) == false ? false : true
            
            if kiosk_location_c.0.count != 0{
                isAlreadySubmit = true
            }
        }else if debit_card_collection_c == "delivery_to_me"{
            txtAddress.txtType.text = ""
            txtAddress.txtType.insertText(dicAddonServicesCRMData["debit_card_address_c"] as? String ?? "")
            txtAddress.iconFill.isHidden = AppHelper.isNull(txtAddress.txtType.text!) == false ? false : true
            txtStreetName.txtType.text = ""
            txtStreetName.txtType.insertText(dicAddonServicesCRMData["debit_card_street_name_c"] as? String ?? "")
            txtStreetName.iconFill.isHidden = AppHelper.isNull(txtStreetName.txtType.text!) == false ? false : true
            txtFlatVillaNo.txtType.text = ""
            txtFlatVillaNo.txtType.insertText(dicAddonServicesCRMData["debit_card_flat_villa_no_c"] as? String ?? "")
            txtFlatVillaNo.iconFill.isHidden = AppHelper.isNull(txtFlatVillaNo.txtType.text!) == false ? false : true
            txtCity.txtType.text = ""
            txtCity.txtType.insertText(dicAddonServicesCRMData["debit_card_city_c"] as? String ?? "")
            txtCity.iconFill.isHidden = AppHelper.isNull(txtCity.txtType.text!) == false ? false : true
            txtState.txtType.text = ""
            txtState.txtType.insertText(dicAddonServicesCRMData["debit_card_state_c"] as? String ?? "")
            txtState.iconFill.isHidden = AppHelper.isNull(txtState.txtType.text!) == false ? false : true
            txtZipCode.txtType.text = ""
            txtZipCode.txtType.insertText(dicAddonServicesCRMData["debit_card_zipcode_c"] as? String ?? "")
            txtZipCode.iconFill.isHidden = AppHelper.isNull(txtZipCode.txtType.text!) == false ? false : true
            
            if txtAddress.txtType.text!.count != 0{
                isAlreadySubmit = true
            }
        }
        validateEnput()
        
    }
    func setUIStep1(){
        lblDetailHeader1.text = header1Detail
        
        //--
        viewHeader1.isHidden = false
        viewHeader2.isHidden = true
        viewHeader2Height.constant = 117
        
        //--
        setUIAccordingSelectOption()
    }
    func setUIStep2(){
        lblDetailHeader1.text = header1Detail
        //--
        setUIAccordingSelectOption()
        
        //--
        viewHeader1.isHidden = true
        viewHeader2.isHidden = false
        viewHeader2Height.constant = CGFloat(117 + (arrListOfDropDown.count * 49))
        
        let debit_card_collection_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_c, index: selectIndex)
        if debit_card_collection_c == "collecting_from_branch"{
            viewBranchSectionHeight.constant = 10
        }else if debit_card_collection_c == "printing_from_kiosk"{
            viewKioskSectionHeight.constant = 10
        }else if debit_card_collection_c == "delivery_to_me"{
            viewDeliverySectionHeight.constant = 10
        }
    }
    func setUIAccordingSelectOption(){
        let debit_card_collection_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_c, index: selectIndex)
        if debit_card_collection_c == "collecting_from_branch"{
            viewBranchSectionHeight.constant = 0
            viewBranchDetail.isHidden = false
            viewKioskDetails.isHidden = true
            viewDeliveryHeight.constant = 356
            viewDelivery.isHidden = true
        }else if debit_card_collection_c == "printing_from_kiosk"{
            viewKioskSectionHeight.constant = 0
            viewBranchDetail.isHidden = true
            viewKioskDetails.isHidden = false
            viewDeliveryHeight.constant = 164
            viewDelivery.isHidden = true
        }else if debit_card_collection_c == "delivery_to_me"{
            viewDeliverySectionHeight.constant = 0
            viewBranchDetail.isHidden = true
            viewKioskDetails.isHidden = true
            viewDeliveryHeight.constant = 644
            viewDelivery.isHidden = false
        }
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
    @IBAction func btnCloseHeader1(_ sender: Any) {
        if isAlreadySubmit{
            self.dismiss(animated: true, completion: nil)
        }else{
            showAlert()
        }
    }
    @IBAction func btnDetailHeader1(_ sender: Any) {
        setUIStep2()
    }
    @IBAction func btnTearmCondition(_ sender: UIButton) {
        if self.didTappedTC != nil {
            self.didTappedTC!(sender)
        }
    }
    @IBAction func btnSubmit(_ sender: Any) {
        let title = (arrListOfDropDown[selectIndex] as! String)
        delegate_didSelectCustomDropDown_Protocol?.didSelectdidSelectCustomDropDown(title: title, index: selectIndex, droDownType: dropDownType)
        
        //--
        let debit_card_collection_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_c, index: selectIndex)
        if debit_card_collection_c == "collecting_from_branch"{
            
            let branch_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .branch_c, index: selectBranchIndex)
            let debit_card_datetime_c = "\(selectDateBackendValue) \(txtTime.txtType.text!)"
            
            dicAddonServicesCRMData = ["branch_debit_card_c": branch_c,
                                       "debit_card_datetime_c": debit_card_datetime_c,
                                       "debit_card_datetime_c_backendvalue": selectTimeSlotIndex
            ] as [String: AnyObject]
        }else if debit_card_collection_c == "printing_from_kiosk"{
            
            let kiosk_location_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .kiosk_location_c, index: selectKioskLocationIndex)
            dicAddonServicesCRMData = ["kiosk_location_c": kiosk_location_c
            ] as [String: AnyObject]
        }else if debit_card_collection_c == "delivery_to_me"{
            
            dicAddonServicesCRMData = ["debit_card_address_c": txtAddress.txtType.text!,
                                       "debit_card_street_name_c": txtStreetName.txtType.text!,
                                       "debit_card_flat_villa_no_c": txtFlatVillaNo.txtType.text!,
                                       "debit_card_city_c": txtCity.txtType.text!,
                                       "debit_card_state_c": txtState.txtType.text!,
                                       "debit_card_zipcode_c": txtZipCode.txtType.text!
            ] as [String: AnyObject]
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension AnyBranchInfoVC: didSelectCustomDropDown_Protocol{
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String) {
        if droDownType == "branch"{
            txtBranch.txtType.text = ""
            txtBranch.txtType.insertText(title)
            selectBranchIndex = index
            txtBranch.lblError.isHidden = true
            txtBranch.iconFill.isHidden = false
            
        }
        if droDownType == "kiosk_location"{
            txtKioskLocation.txtType.text = ""
            txtKioskLocation.txtType.insertText(title)
            selectKioskLocationIndex = index
            txtBranch.iconFill.isHidden = false
        }
        
        validateEnput()
    }
}
extension AnyBranchInfoVC: UIFloatingTextField_Protocol{
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool {
        if AppHelper.allowSomeCharactesOnly(txt: txt) == false{
            return false
        }
        
        validateErrorMsg(textField: textField, txt: txt)
        if textField == txtAddress.txtType {
            if txt.count >= 31{
                return false
            }
        }
        if textField == txtStreetName.txtType {
            if txt.count >= 31{
                return false
            }
        }
        if textField == txtFlatVillaNo.txtType {
            if txt.count >= 31{
                return false
            }
        }
        if textField == txtCity.txtType {
            if txt.count >= 31{
                return false
            }
        }
        if textField == txtState.txtType {
            if txt.count >= 31{
                return false
            }
        }
        if textField == txtZipCode.txtType {
            if txt.count >= 31{
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
        if txtBranch.txtType == textField{
            txtBranch.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtBranch.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtKioskLocation.txtType == textField{
            txtKioskLocation.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtKioskLocation.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
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
        
        validateEnput()
    }
    func validateEnput() {
        var returnValue = true
        
        let debit_card_collection_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_c, index: selectIndex)
        if debit_card_collection_c == "collecting_from_branch"{
            if AppHelper.isNull(txtBranch.txtType.text!){
                //txtBankStatement.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtDate.txtType.text!){
                //txtBankStatement.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtTime.txtType.text!){
                //txtBankStatement.lblError.isHidden = false
                returnValue = false
            }
        }else if debit_card_collection_c == "printing_from_kiosk"{
            if AppHelper.isNull(txtKioskLocation.txtType.text!){
                returnValue = false
            }
        }else if debit_card_collection_c == "delivery_to_me"{
            if AppHelper.isNull(txtAddress.txtType.text!){
                returnValue = false
            }
            if AppHelper.isNull(txtStreetName.txtType.text!){
                returnValue = false
            }
            if AppHelper.isNull(txtFlatVillaNo.txtType.text!){
                returnValue = false
            }
            if AppHelper.isNull(txtCity.txtType.text!){
                returnValue = false
            }
            if AppHelper.isNull(txtState.txtType.text!){
                returnValue = false
            }
            if AppHelper.isNull(txtZipCode.txtType.text!){
                returnValue = false
            }
        }
        
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewSubmit)
        }else{
            AppHelper.disableNextBTN(view_: viewSubmit)
        }
    }
    
}
extension AnyBranchInfoVC: didSelectDate_Protocol{
    func didSelectDate(selectDate: String) {
        selectDateBackendValue = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "EEEE, dd/MM/yyyy", dateNewFTR: "yyyy-MM-dd", strDate: selectDate)
        txtDate.txtType.text = selectDate
        txtDate.iconFill.isHidden = AppHelper.isNull(txtDate.txtType.text!) == false ? false : true
        validateEnput()
        
        //--
        clearSelectedTime()
    }
}
extension AnyBranchInfoVC: UITableViewDelegate, UITableViewDataSource
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
        
        cell.lblTitle.text = (arrListOfDropDown[indexPath.row] as! String)
        
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
        tblListHeader2.reloadData()
        
        //--
        let debit_card_collection_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_c, index: selectIndex)
        if debit_card_collection_c == "only_digital_card"{
            //--
            self.dismiss(animated: true, completion: nil)
            delegate_didSelectCustomDropDown_Protocol?.didSelectdidSelectCustomDropDown(title: (arrListOfDropDown[indexPath.row] as? String ?? ""), index: selectIndex, droDownType: dropDownType)
        }else{
            header1Detail = (arrListOfDropDown[indexPath.row] as! String)
            setUIStep2()
        }
        
    }
}



extension AnyBranchInfoVC: didSelectTimeSlot_Protocol{
    func didSelectTimeSlot(timeSlot: String, backendValue: String) {
        txtTime.txtType.text = timeSlot

        validateEnput()
        selectTimeSlotIndex = backendValue
    }
    
    func clearSelectedTime(){
        txtTime.txtType.text = ""
        validateEnput()
        
    }
}
