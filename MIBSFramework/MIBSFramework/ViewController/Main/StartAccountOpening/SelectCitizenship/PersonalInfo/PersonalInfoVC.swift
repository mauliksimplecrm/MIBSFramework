//
//  PersonalInfoVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 28/01/22.
//

import UIKit
import Foundation
//import MaterialComponents
//import Popover
//import SKCountryPicker
//import Lightbox

class PersonalInfoVC: UIViewController {
    
    //MARK: @IBOutlet
    //--
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblYourDetails_title: UILabel!
    
    @IBOutlet weak var stack_PersonalDetail: UIStackView!
    //--
    @IBOutlet var viewAlertPopup: UIView!
    @IBOutlet weak var viewInnerAlertPopup: UIView!
    @IBOutlet weak var lblTitleAlertPopup: UILabel!
    @IBOutlet weak var lblDetailAlertPopup: UILabel!
    @IBOutlet weak var btnGotitAlertPopup: UIButton!
    
    //--
    @IBOutlet weak var scrollContainer: UIScrollView!
    @IBOutlet weak var lblOnScrollHeader: UILabel!
    @IBOutlet weak var onscrollHeaderView: UIView!
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var txtSalutation: UIFloatingTextField!
    
    @IBOutlet weak var lblViewSteps_title: UILabel!
    @IBOutlet weak var lblNext_title: UILabel!
    @IBOutlet weak var viewbgbtnNext: UIView!
    @IBOutlet weak var txtFullName: UIFloatingTextField!
    @IBOutlet weak var txtFullName_height: NSLayoutConstraint!
    @IBOutlet weak var txtDateofBirth: UIFloatingTextField!
    @IBOutlet weak var txtGender: UIFloatingTextField!
    @IBOutlet weak var txtNationality: UIFloatingTextField!
    @IBOutlet weak var txtIDNo: UIFloatingTextField!
    @IBOutlet weak var txtIDExpiryDate: UIFloatingTextField!
    @IBOutlet weak var txtPassportNo: UIFloatingTextField!
    //@IBOutlet weak var txtPassportNo_top: NSLayoutConstraint! //10
    //@IBOutlet weak var txtPassportNo_height: NSLayoutConstraint! //81
    @IBOutlet weak var txtPassportExpiryDate: UIFloatingTextField!
    //@IBOutlet weak var txtPassportExpiryDate_top: NSLayoutConstraint! //10
    //@IBOutlet weak var txtPassportExpiryDate_height: NSLayoutConstraint! //81
    @IBOutlet weak var txtCountryofBirth: UIFloatingTextField!
    @IBOutlet weak var txtCityofBirth: UIFloatingTextField!
    @IBOutlet weak var lblPleaseuploadyourphotoid_title: UILabel!
    @IBOutlet weak var lblTakePhoto_title: UILabel!
    @IBOutlet weak var lblTakePhoto_detail: UILabel!
    @IBOutlet weak var lblOptional_TakeHolding_title: UILabel!
    
    @IBOutlet weak var lblAddressDetails_title: UILabel!
    @IBOutlet weak var txtCountry: UIFloatingTextField!
    @IBOutlet weak var txtResidentialStatus: UIFloatingTextField!
    @IBOutlet weak var txtPleaseSpecifyCountry: UIFloatingTextField!
    @IBOutlet weak var txtPleaseSpecifyCountry_height: NSLayoutConstraint! //81
    @IBOutlet weak var txtPleaseSpecifyCountry_top: NSLayoutConstraint! //10
    @IBOutlet weak var txtPOBox: UIFloatingTextField!
    @IBOutlet weak var txtPOBox_height: NSLayoutConstraint!
    @IBOutlet weak var txtPOBox_top: NSLayoutConstraint!
    @IBOutlet weak var txtPostalCode: UIFloatingTextField!
    @IBOutlet weak var txtHouseFlatNumber: UIFloatingTextField!
    @IBOutlet weak var txtCity: UIFloatingTextField!
    @IBOutlet weak var txtArea: UIFloatingTextField!
    
    @IBOutlet weak var lblEmploymentDetails_title: UILabel!
    @IBOutlet weak var txtEmploymentStatus: UIFloatingTextField!
    @IBOutlet weak var txtIndustry: UIFloatingTextField!
    @IBOutlet weak var txtEmploymentSector: UIFloatingTextField!
    @IBOutlet weak var txtEmployername: UIFloatingTextField!
    @IBOutlet weak var txtProfession: UIFloatingTextField!
    @IBOutlet weak var txtNameofBusiness: UIFloatingTextField!
    @IBOutlet weak var imgDoneHoldingImage: UIImageView!
    
    @IBOutlet weak var txtEducationLevel: UIFloatingTextField!
    
    @IBOutlet weak var imgViewTakePhoto: UIImageView!
    @IBOutlet weak var btnViewTakePhotoHoldingId: UIButton!
    
    
    
    //MARK: Veriable
    var screenNameEnum: ScreenNameEnum?
    var scanFrontDocData: ValidateOmniData?
    var scanBackDocData: ValidateOmniData?
    var scanPasswordData: ValidateOmniData?
    
    var popover = Popover()
    var delegate_didTakeCustomPhoto: didTakeCustomPhoto_protocol?
    
    var selectSalutationIndex = -1
    var selectGenderIndex = -1
    var selectCountryofNationalityIndex = ""
    var selectCountryofBirthIndex = ""
    var selectCountryIndex = ""
    var selectResidentialStatusIndex = -1
    var selectPostalCodeIndex = -1
    var selectEmployementStatusIndex = -1
    var selectIndustryIndex = -1
    var selectEmployementSectorIndex = -1
    var selectProfessionIndex = -1
    var takedHoldingIDImage = UIImageView()
    var isSelectHoldingImg = false
    var selectEducationLevelIndex = -1
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        managePassportDetailsTextField()
        setupBasic()
        setupHeader()
        hideTakePhotoHolding()
        validateEnput()
        
        apiCall_getApplicationData { result in
            self.setFormData(result: result)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        progressBar.setProgress(0.33, animated: true)
        localization()
    }
    
    override func viewDidLayoutSubviews() {
        //txtFullName_height.constant = txtFullName.manageSubViewHeight()
    }
    //    override func viewDidDisappear(_ animated: Bool) {
    //        self.view.endEditing(true)
    //    }
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        self.view.endEditing(true)
    //    }
    
    
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        
        //--
        lblOnScrollHeader.attributedText = Localize(key: "Personal Information").attributedStringWithColorNew(0, length: 8, color: .DARKGREENTINT)
        lblTitle.attributedText = Localize(key: "Personal Information").attributedStringWithColorNew(0, length: 8, color: .DARKGREENTINT)
        
        lblDetail.text = Localize(key: "Personal Information detail")
        
        lblYourDetails_title.text = Localize(key: "your_details")
        
        lblPleaseuploadyourphotoid_title.text = Localize(key: "Please upload your photo holding the ID")
        lblTakePhoto_title.text = Localize(key: "Take Photo")
        lblOptional_TakeHolding_title.text = Localize(key: "*optional")
        lblAddressDetails_title.text = Localize(key: "Address Details")
        lblEmploymentDetails_title.text = Localize(key: "Employment Details")
        lblViewSteps_title.text = Localize(key: "VIEW STEPS")
        lblNext_title.text = Localize(key: "NEXT")
        
        
        //--
        if Managelanguage.getLanguageCode() == "A"
        {
            lblTitle.semanticContentAttribute = .forceRightToLeft
            lblDetail.semanticContentAttribute = .forceRightToLeft
            lblYourDetails_title.semanticContentAttribute = .forceRightToLeft
            lblPleaseuploadyourphotoid_title.semanticContentAttribute = .forceRightToLeft
            lblTakePhoto_title.semanticContentAttribute = .forceRightToLeft
            lblOptional_TakeHolding_title.semanticContentAttribute = .forceRightToLeft
            lblAddressDetails_title.semanticContentAttribute = .forceRightToLeft
            lblEmploymentDetails_title.semanticContentAttribute = .forceRightToLeft
            
            txtSalutation.txtType.textAlignment = .right
            txtFullName.txtType.textAlignment = .right
            txtDateofBirth.txtType.textAlignment = .right
            txtGender.txtType.textAlignment = .right
            txtNationality.txtType.textAlignment = .right
            txtIDNo.txtType.textAlignment = .right
            txtIDExpiryDate.txtType.textAlignment = .right
            txtPassportNo.txtType.textAlignment = .right
            txtPassportExpiryDate.txtType.textAlignment = .right
            txtCountryofBirth.txtType.textAlignment = .right
            txtCityofBirth.txtType.textAlignment = .right
            txtCountry.txtType.textAlignment = .right
            txtResidentialStatus.txtType.textAlignment = .right
            txtPleaseSpecifyCountry.txtType.textAlignment = .right
            txtPOBox.txtType.textAlignment = .right
            txtPostalCode.txtType.textAlignment = .right
            txtHouseFlatNumber.txtType.textAlignment = .right
            txtCity.txtType.textAlignment = .right
            txtArea.txtType.textAlignment = .right
            txtEmploymentStatus.txtType.textAlignment = .right
            txtIndustry.txtType.textAlignment = .right
            txtEmploymentSector.txtType.textAlignment = .right
            txtEmployername.txtType.textAlignment = .right
            txtProfession.txtType.textAlignment = .right
            txtNameofBusiness.txtType.textAlignment = .right
            txtEducationLevel.txtType.textAlignment = .right
            
        }
        else
        {
            lblTitle.semanticContentAttribute = .forceLeftToRight
            lblDetail.semanticContentAttribute = .forceLeftToRight
            lblYourDetails_title.semanticContentAttribute = .forceLeftToRight
            lblPleaseuploadyourphotoid_title.semanticContentAttribute = .forceLeftToRight
            lblTakePhoto_title.semanticContentAttribute = .forceLeftToRight
            lblOptional_TakeHolding_title.semanticContentAttribute = .forceLeftToRight
            lblAddressDetails_title.semanticContentAttribute = .forceLeftToRight
            lblEmploymentDetails_title.semanticContentAttribute = .forceLeftToRight
            
        }
    }
    func setupBasic(){
        
        //--
        
        
        
    }
    func setupHeader(){
        
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            self.clickBack()
        }
    }
    func clickBack(){
        if screenNameEnum == .reviewApplicationVC{
            //--
            let vc = ReviewApplicationVC(nibName: "ReviewApplicationVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            if citizenshipType == .omani{
                //--
                let vc = OmaniCitizenshipDocVC(nibName: "OmaniCitizenshipDocVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: false)
            }else if citizenshipType == .expatriate{
                //--
                let vc = ExpatrIateCitizenshipDoc(nibName: "ExpatrIateCitizenshipDoc", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: false)
            }else{
                //--
                let vc = GCCNationalsCitizenshipDocVC(nibName: "GCCNationalsCitizenshipDocVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    func managePassportDetailsTextField(){
        
        if citizenshipType == .omani{
            txtPassportNo.isHidden = true
            /*txtPassportNo_top.constant = 0
             txtPassportNo_height.constant = 0*/
            
            txtPassportExpiryDate.isHidden = true
            /*txtPassportExpiryDate_top.constant = 0
             txtPassportExpiryDate_height.constant = 0*/
            
        }else{
            txtPassportExpiryDate.isHidden = false
            /*txtPassportExpiryDate_top.constant = 10
             txtPassportExpiryDate_height.constant = 81*/
        }
        
        //--
        set_OCR_Dtail()
    }
    
    func set_OCR_Dtail(){
        
        if citizenshipType == .gcc{
            txtFullName.txtType.text = ""
            txtFullName.txtType.insertText("\(scanBackDocData?.first_name ?? "") \(scanBackDocData?.last_name ?? "")")
            validateErrorMsg(textField: txtFullName.txtType)
            
            txtDateofBirth.txtType.text = ""
            txtDateofBirth.txtType.insertText(AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "dd/MM/yyyy", strDate: scanBackDocData?.date_of_birth ?? ""))
            validateErrorMsg(textField: txtDateofBirth.txtType)
            
            txtIDNo.txtType.text = ""
            txtIDNo.txtType.insertText("\(scanBackDocData?.ID ?? "")")
            validateErrorMsg(textField: txtIDNo.txtType)
            
            txtIDExpiryDate.txtType.text = ""
            txtIDExpiryDate.txtType.insertText(AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "dd/MM/yyyy", strDate: scanBackDocData?.exp_date ?? ""))
            validateErrorMsg(textField: txtIDExpiryDate.txtType)
        }else{
            txtFullName.txtType.text = ""
            txtFullName.txtType.insertText("\(scanBackDocData?.first_name ?? "") \(scanBackDocData?.last_name ?? "")")
            validateErrorMsg(textField: txtFullName.txtType)
            
            txtDateofBirth.txtType.text = ""
            txtDateofBirth.txtType.insertText(scanFrontDocData?.date_of_birth ?? "")
            validateErrorMsg(textField: txtDateofBirth.txtType)
            
            txtIDNo.txtType.text = ""
            txtIDNo.txtType.insertText("\(scanFrontDocData?.civil_id ?? 0)")
            validateErrorMsg(textField: txtIDNo.txtType)
            
            txtIDExpiryDate.txtType.text = ""
            txtIDExpiryDate.txtType.insertText(scanFrontDocData?.civil_id_expiry_date ?? "")
            validateErrorMsg(textField: txtIDExpiryDate.txtType)
        }
        
        //set passport detail
        if citizenshipType == .expatriate || citizenshipType == .gcc{
            txtPassportNo.txtType.text = ""
            txtPassportNo.txtType.insertText("\(scanPasswordData?.passport_number ?? "")")
            validateErrorMsg(textField: txtPassportNo.txtType)
            
            txtPassportExpiryDate.txtType.text = ""
            txtPassportExpiryDate.txtType.insertText(AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "dd/MM/yyyy", strDate: scanPasswordData?.exp_date ?? ""))
            validateErrorMsg(textField: txtPassportExpiryDate.txtType)
        }
    }
    
    func setupTextField(){
        //Your details
        txtSalutation.setTitlePlaceholder(text_: Localize(key: "salutation"), placeholder_: Localize(key: "Select_Salutation"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtSalutation.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .salutation_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Select_Salutation"),
                                    dropDownType: "salutation",
                                    arrList: list,
                                    selectedIndex: self.selectSalutationIndex)
        }
        
        txtFullName.setTitlePlaceholder(text_: Localize(key: "Full Name"), placeholder_: Localize(key: "Full Name"), isUserInteraction: false, btnDropDownHide: false, maximumNumberOfLines: 0)
        txtFullName.didTappedDropDown = { (sender) in
            self.openErrorAlert(title: Localize(key: "Sorry!"), details: Localize(key: "restricted_edit_field_msg"))
        }
        txtFullName.layoutIfNeeded()
        
        txtDateofBirth.setTitlePlaceholder(text_: Localize(key: "Date of Birth"), placeholder_: Localize(key: "Date of Birth"), isUserInteraction: false, btnDropDownHide: false)
        txtDateofBirth.didTappedDropDown = { (sender) in
            self.openErrorAlert(title: Localize(key: "Sorry!"), details: Localize(key: "restricted_edit_field_msg"))
        }
        
        txtGender.setTitlePlaceholder(text_: Localize(key: "Gender"), placeholder_: "", isUserInteraction: false)
        /*txtGender.didTappedDropDown = { (sender) in
         //--
         let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .gender_c)
         self.openDropDownPicker(headerTitle: Localize(key: "Gender"),
         dropDownType: "gender",
         arrList: list,
         selectedIndex: self.selectGenderIndex)
         }*/
        var uIFloatingTextFieldType:UIFloatingTextFieldType = .dropDown
        
        if citizenshipType == .omani{
            uIFloatingTextFieldType = .normal
        }
        
        txtNationality.setTitlePlaceholder(text_: Localize(key: "Nationality"), placeholder_: Localize(key: "Nationality"), isUserInteraction: true, type: uIFloatingTextFieldType, btnDropDownHide: false)
        txtNationality.didTappedDropDown = { [self] (sender) in
            if citizenshipType == .omani{
                self.openErrorAlert(title: Localize(key: "Sorry!"), details: Localize(key: "restricted_edit_field_msg"))
            }else{
                //--
                CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .nationality_c), headerTitle: Localize(key: "Nationality"), isComeFromNationality: true)
                CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                    print(countryName)
                    txtNationality.setSelectedDropDownUI()
                    txtNationality.txtType.text = ""
                    txtNationality.txtType.insertText(countryName)
                    selectCountryofNationalityIndex = countryCode
                    txtNationality.lblError.isHidden = true
                    validateErrorMsg(textField: txtNationality.txtType)
                }
            }
        }
        if citizenshipType == .omani{
            setDefualtOmanValue()
        }
        
        txtIDNo.setTitlePlaceholder(text_: Localize(key: "ID No."), placeholder_: Localize(key: "ID No."), isUserInteraction: false, btnDropDownHide: false)
        txtIDNo.didTappedDropDown = { (sender) in
            self.openErrorAlert(title: Localize(key: "Sorry!"), details: Localize(key: "restricted_edit_field_msg"))
        }
        
        txtIDExpiryDate.setTitlePlaceholder(text_: Localize(key: "ID Expiry Date"), placeholder_: Localize(key: "ID Expiry Date"), isUserInteraction: false, btnDropDownHide: false)
        txtIDExpiryDate.didTappedDropDown = { (sender) in
            self.openErrorAlert(title: Localize(key: "Sorry!"), details: Localize(key: "restricted_edit_field_msg"))
        }
        
        txtPassportNo.setTitlePlaceholder(text_: Localize(key: "Passport No"), placeholder_: Localize(key: "Passport No"), isUserInteraction: false, btnDropDownHide: false)
        txtPassportNo.didTappedDropDown = { (sender) in
            self.openErrorAlert(title: Localize(key: "Sorry!"), details: Localize(key: "restricted_edit_field_msg"))
        }
        
        txtPassportExpiryDate.setTitlePlaceholder(text_: Localize(key: "Passport Expiry Date"), placeholder_: Localize(key: "Passport Expiry Date"), isUserInteraction: false, btnDropDownHide: false)
        txtPassportExpiryDate.didTappedDropDown = { (sender) in
            self.openErrorAlert(title: Localize(key: "Sorry!"), details: Localize(key: "restricted_edit_field_msg"))
        }
        
        txtCountryofBirth.setTitlePlaceholder(text_: Localize(key: "Country of Birth"), placeholder_: Localize(key: "Select"), isUserInteraction: false, type: .dropDown, btnDropDownHide: false)
        txtCountryofBirth.didTappedDropDown = { (sender) in
            //--
            CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Country of Birth"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                txtCountryofBirth.setSelectedDropDownUI()
                txtCountryofBirth.txtType.text = ""
                txtCountryofBirth.txtType.insertText(countryName)
                selectCountryofBirthIndex = countryCode
                txtCountryofBirth.lblError.isHidden = true
                validateErrorMsg(textField: txtCountryofBirth.txtType)
            }
        }
        
        txtCityofBirth.setTitlePlaceholder(text_: Localize(key: "City of Birth"), placeholder_: Localize(key: "Enter City"), isUserInteraction: true)
        txtCityofBirth.delegate_UIFloatingTextField_Protocol = self
        
        //Address Detail
        txtCountry.setTitlePlaceholder(text_: Localize(key: "Country"), placeholder_: Localize(key: "Select"), isUserInteraction: false, type: .normal, btnDropDownHide: false)
        txtCountry.txtType.text = ""
        txtCountry.txtType.insertText(Localize(key: "oman"))
        selectCountryIndex = "OMN"
        validateErrorMsg(textField: txtCountry.txtType)
        /*txtCountry.didTappedDropDown = { (sender) in
         //--
         CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), headerTitle: Localize(key: "Country"))
         CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
         print(countryName)
         txtCountry.setSelectedDropDownUI()
         txtCountry.txtType.text = countryName
         selectCountryIndex = countryCode
         txtCountry.lblError.isHidden = true
         validateErrorMsg(textField: txtCountry.txtType)
         }
         }*/
        
        txtResidentialStatus.setTitlePlaceholder(text_: Localize(key: "Residential Status"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtResidentialStatus.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .resident_status_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Residential Status"),
                                    dropDownType: "residential_status",
                                    arrList: list,
                                    selectedIndex: self.selectResidentialStatusIndex)
        }
        
        txtPleaseSpecifyCountry.setTitlePlaceholder(text_: Localize(key: "Please Specify"), placeholder_: Localize(key: "enter_other_resident_country"), isUserInteraction: true)
        txtPleaseSpecifyCountry.hiddenTextField(txtView: txtPleaseSpecifyCountry, layoutConTop: txtPleaseSpecifyCountry_top, layoutConHeight: txtPleaseSpecifyCountry_height)
        txtPleaseSpecifyCountry.delegate_UIFloatingTextField_Protocol = self
        
        txtPOBox.setTitlePlaceholder(text_: Localize(key: "P.O Box"), placeholder_: Localize(key: "Enter P.O Box number"), isUserInteraction: true, maximumNumberOfLines: 2)
        txtPOBox.delegate_UIFloatingTextField_Protocol = self
        txtPOBox.txtType.keyboardType = .decimalPad
        
        txtPostalCode.setTitlePlaceholder(text_: Localize(key: "Postal Code"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtPostalCode.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .resident_postal_code_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Postal Code"),
                                    dropDownType: "postal_code",
                                    arrList: list,
                                    selectedIndex: self.selectPostalCodeIndex)
        }
        
        txtHouseFlatNumber.setTitlePlaceholder(text_: Localize(key: "House/Flat Number"), placeholder_: Localize(key: "Enter Number"), isUserInteraction: true, maximumNumberOfLines: 2)
        txtHouseFlatNumber.delegate_UIFloatingTextField_Protocol = self
        txtHouseFlatNumber.isHidden = true
        
        txtCity.setTitlePlaceholder(text_: Localize(key: "City"), placeholder_: Localize(key: "Enter City"), isUserInteraction: false)
        txtCity.delegate_UIFloatingTextField_Protocol = self
        txtCity.isHidden = true
        
        txtArea.setTitlePlaceholder(text_: Localize(key: "Area"), placeholder_: Localize(key: "Enter Area"), isUserInteraction: true, maximumNumberOfLines: 2)
        txtArea.delegate_UIFloatingTextField_Protocol = self
        
        //Employment Details
        txtEmploymentStatus.setTitlePlaceholder(text_: Localize(key: "Employment status"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtEmploymentStatus.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .employment_status_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Employment status"),
                                    dropDownType: "employment_status",
                                    arrList: list,
                                    selectedIndex: self.selectEmployementStatusIndex)
        }
        
        txtIndustry.setTitlePlaceholder(text_: Localize(key: "Industry"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtIndustry.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .industry_type_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Industry"),
                                    dropDownType: "industry",
                                    arrList: list,
                                    selectedIndex: self.selectIndustryIndex)
        }
        
        txtEmploymentSector.setTitlePlaceholder(text_: Localize(key: "Employment sector"), placeholder_: Localize(key: "Select"), isUserInteraction: false, type: .dropDown, btnDropDownHide: false)
        txtEmploymentSector.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .employment_sector_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Employment sector"),
                                    dropDownType: "employment_sector",
                                    arrList: list,
                                    selectedIndex: self.selectEmployementSectorIndex)
        }
        
        txtEmployername.setTitlePlaceholder(text_: Localize(key: "Employer Name"), placeholder_: Localize(key: "Enter Employer Name"), isUserInteraction: true)
        txtEmployername.delegate_UIFloatingTextField_Protocol = self
        
        txtProfession.setTitlePlaceholder(text_: Localize(key: "Profession"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtProfession.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .profession_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Profession"),
                                    dropDownType: "profession",
                                    arrList: list,
                                    selectedIndex: self.selectProfessionIndex)
        }
        
        txtNameofBusiness.setTitlePlaceholder(text_: Localize(key: "Name of Business"), placeholder_: Localize(key: "Enter Name of Business"), isUserInteraction: true)
        txtNameofBusiness.delegate_UIFloatingTextField_Protocol = self
        
        txtEducationLevel.setTitlePlaceholder(text_: Localize(key: "Education_level"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtEducationLevel.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .education_level_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Education_level"),
                                    dropDownType: "education_level",
                                    arrList: list,
                                    selectedIndex: self.selectEducationLevelIndex)
        }
        
        defaultEmploymentDetailsView()
        stack_PersonalDetail.layoutIfNeeded()
    }
    
    func openErrorAlert(title: String, details: String){
        
        //--
        lblTitleAlertPopup.text = title
        lblDetailAlertPopup.text = details
        btnGotitAlertPopup.setTitle(Localize(key: "GOT IT"), for: .normal)
        
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
    func openAMLAlert(title: String, details: String){
        //--
        popover.dismiss()
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = title
        alert.lblMessage.text = details
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
    func setDefualtOmanValue(){
        txtNationality.setSelectedDropDownUI()
        txtNationality.txtType.text = ""
        txtNationality.txtType.insertText(Localize(key: "oman"))
        selectCountryofNationalityIndex = "OMN"
        txtNationality.lblError.isHidden = true
        validateErrorMsg(textField: txtNationality.txtType)
    }
    
    //MARK: @IBAction
    @IBAction func btnGotitAlertPopup(_ sender: Any) {
        popover.dismiss()
    }
    @IBAction func btnBackOnScrollHeader(_ sender: Any) {
        clickBack()
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
    @IBAction func btnViewSteps(_ sender: Any) {
        //--
        let vc = StepIndicatorVC(nibName: "StepIndicatorVC", bundle: bundleIdentifireGlob)
        vc.selectIndex = 0
        vc.totalStep = 3
        vc.progress = 0.33
        vc.arrListOfDropDown = [Localize(key: "Personal Information"), Localize(key: "Financial Information"), Localize(key: "Regularity Declaration")]
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        self.view.endEditing(true)
        //if validateEnput(){
        apiCall_UploadImage()
        //}
        
    }
    @IBAction func btnTakePhotoHoldingID(_ sender: Any) {
        let vc = CustomCameraVC(nibName: "CustomCameraVC", bundle: bundleIdentifireGlob)
        vc.delegate_didTakeCustomPhoto = self
        vc.headerTitle = Localize(key: "picture_similar_passport")
        vc.modalPresentationStyle = .overCurrentContext
        vc.avCaptureDevicePosition = .front
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnViewTakePhotoHoldingId(_ sender: Any) {
        if let img_ = takedHoldingIDImage.image{
            setupLightBoxImageArray(imgOpen: img_, msg: "")
        }
    }
    
    
}

extension PersonalInfoVC: didSelectCustomDropDown_Protocol{
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String) {
        if droDownType == "salutation"{
            txtSalutation.setSelectedDropDownUI()
            txtSalutation.txtType.text = ""
            txtSalutation.txtType.insertText(title)
            selectSalutationIndex = index
            txtSalutation.lblError.isHidden = true
            validateErrorMsg(textField: txtSalutation.txtType)
            
            //--
            let salutation_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .salutation_c, index: selectSalutationIndex)
            if salutation_c == "20"
            {
                let gender_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .gender_c, backendvalue: "M")
                txtGender.txtType.text = ""
                txtGender.txtType.insertText(gender_c.0)
                validateErrorMsg(textField: txtGender.txtType)
                selectGenderIndex = gender_c.1
            }else{
                let gender_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .gender_c, backendvalue: "F")
                txtGender.txtType.text = ""
                txtGender.txtType.insertText(gender_c.0)
                validateErrorMsg(textField: txtGender.txtType)
                selectGenderIndex = gender_c.1
            }
            
        }
        if droDownType == "gender"{
            txtGender.setSelectedDropDownUI()
            txtGender.txtType.text = ""
            txtGender.txtType.insertText(title)
            selectGenderIndex = index
            txtGender.lblError.isHidden = true
            validateErrorMsg(textField: txtGender.txtType)
        }
        /*if droDownType == "country_of_nationality"{
         txtNationality.setSelectedDropDownUI()
         txtNationality.txtType.text = title
         selectCountryofNationalityIndex = index
         txtNationality.lblError.isHidden = true
         }
         if droDownType == "country_of_birth"{
         txtCountryofBirth.setSelectedDropDownUI()
         txtCountryofBirth.txtType.text = title
         selectCountryofBirthIndex = index
         txtCountryofBirth.lblError.isHidden = true
         }*/
        /*if droDownType == "country"{
         txtCountry.setSelectedDropDownUI()
         txtCountry.txtType.text = title
         selectCountryIndex = index
         txtCountry.lblError.isHidden = true
         }*/
        if droDownType == "residential_status"{
            txtResidentialStatus.setSelectedDropDownUI()
            txtResidentialStatus.txtType.text = ""
            txtResidentialStatus.txtType.insertText(title)
            selectResidentialStatusIndex = index
            txtResidentialStatus.lblError.isHidden = true
            validateErrorMsg(textField: txtResidentialStatus.txtType)
            
            let resident_status_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .resident_status_c, index: selectResidentialStatusIndex)
            if resident_status_c == "S"{
                txtPleaseSpecifyCountry.showTextField(txtView: txtPleaseSpecifyCountry, layoutConTop: txtPleaseSpecifyCountry_top, layoutConHeight: txtPleaseSpecifyCountry_height)
            }else{
                txtPleaseSpecifyCountry.hiddenTextField(txtView: txtPleaseSpecifyCountry, layoutConTop: txtPleaseSpecifyCountry_top, layoutConHeight: txtPleaseSpecifyCountry_height)
            }
        }
        if droDownType == "postal_code"{
            txtPostalCode.setSelectedDropDownUI()
            txtPostalCode.txtType.text = ""
            txtPostalCode.txtType.insertText(title)
            selectPostalCodeIndex = index
            txtPostalCode.lblError.isHidden = true
            validateErrorMsg(textField: txtPostalCode.txtType)
            /*//-- Set City
             let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .resident_postal_code_c)
             txtCity.txtType.text = list[selectPostalCodeIndex]
             validateErrorMsg(textField: txtCity.txtType)*/
            //apiCall_getAddressDetails()
        }
        if droDownType == "employment_status"{
            txtEmploymentStatus.setSelectedDropDownUI()
            txtEmploymentStatus.txtType.text = ""
            txtEmploymentStatus.txtType.insertText(title)
            selectEmployementStatusIndex = index
            txtEmploymentStatus.lblError.isHidden = true
            validateErrorMsg(textField: txtEmploymentStatus.txtType)
            
            let employment_status_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .employment_status_c, index: selectEmployementStatusIndex)
            manageEmploymentDetailView(backendValue: employment_status_c)
            
            validateEnput()
        }
        if droDownType == "industry"{
            txtIndustry.setSelectedDropDownUI()
            txtIndustry.txtType.text = ""
            txtIndustry.txtType.insertText(title)
            selectIndustryIndex = index
            txtIndustry.lblError.isHidden = true
            validateErrorMsg(textField: txtIndustry.txtType)
        }
        if droDownType == "employment_sector"{
            txtEmploymentSector.setSelectedDropDownUI()
            txtEmploymentSector.txtType.text = ""
            txtEmploymentSector.txtType.insertText(title)
            selectEmployementSectorIndex = index
            txtEmploymentSector.lblError.isHidden = true
            validateErrorMsg(textField: txtEmploymentSector.txtType)
        }
        if droDownType == "profession"{
            txtProfession.setSelectedDropDownUI()
            txtProfession.txtType.text = ""
            txtProfession.txtType.insertText(title)
            selectProfessionIndex = index
            txtProfession.lblError.isHidden = true
            validateErrorMsg(textField: txtProfession.txtType)
        }
        if droDownType == "education_level"{
            txtEducationLevel.setSelectedDropDownUI()
            txtEducationLevel.txtType.text = ""
            txtEducationLevel.txtType.insertText(title)
            selectEducationLevelIndex = index
            txtEducationLevel.lblError.isHidden = true
            validateErrorMsg(textField: txtEducationLevel.txtType)
        }
        
        
    }
    
    func manageEmploymentDetailView(backendValue: String){
        
        if backendValue == "1"{
            //Employed
            showAllEmploymentDetailsView()
            
            //--
            txtEmploymentSector.setbtnDropDownUserInteraction(isUserInteraction: true)
            validateErrorMsg(textField: txtEmploymentSector.txtType)
            
            //--
            txtNameofBusiness.isHidden = true
            txtNameofBusiness.txtType.text = ""
            txtNameofBusiness.txtType.insertText("")
        }else if backendValue == "6_7" || backendValue == "4" || backendValue == "6_6"{
            //"Business man", "Self-Employed", "Investor",
            showAllEmploymentDetailsView()
            
            //--
            txtEmploymentSector.isHidden = true
            selectEmployementSectorIndex = -1
            txtEmploymentSector.txtType.text = Localize(key: "Other")
            txtEmploymentSector.setbtnDropDownUserInteraction(isUserInteraction: false)
            
            //--
            txtEmployername.isHidden = true
            txtEmployername.txtType.text = ""
            txtEmployername.txtType.insertText("")
        }else{
            //Housewife, Student, Minor, and Un-Employed, Job Seeker, Retired
            hideAllEmploymentDetailsView()
            
            //--
            txtEducationLevel.isHidden = false
            txtEducationLevel.txtType.text = ""
            txtEducationLevel.txtType.insertText("")
            selectEducationLevelIndex = -1
            
            //--
            txtEmploymentSector.isHidden = true
            selectEmployementSectorIndex = -1
            txtEmploymentSector.txtType.text = Localize(key: "Other")
            txtEmploymentSector.setbtnDropDownUserInteraction(isUserInteraction: false)
        }
        
        validateEnput()
    }
    func defaultEmploymentDetailsView(){
        
        hideAllEmploymentDetailsView()
        
        txtIndustry.isHidden = false
        txtIndustry.txtType.text = ""
        txtIndustry.txtType.insertText("")
        selectIndustryIndex = -1
        
        txtEmploymentSector.isHidden = false
        txtEmploymentSector.txtType.text = ""
        txtEmploymentSector.txtType.insertText("")
        selectEmployementSectorIndex = -1
        
        txtProfession.isHidden = false
        txtProfession.txtType.text = ""
        txtProfession.txtType.insertText("")
        selectProfessionIndex = -1
               
        txtEducationLevel.isHidden = false
        txtEducationLevel.txtType.text = ""
        txtEducationLevel.txtType.insertText("")
        selectEducationLevelIndex = -1
    }
    func hideAllEmploymentDetailsView(){
        
        txtIndustry.isHidden = true
        txtIndustry.txtType.text = ""
        txtIndustry.txtType.insertText("")
        selectIndustryIndex = -1
        
        txtEmploymentSector.isHidden = true
        txtEmploymentSector.txtType.text = ""
        txtEmploymentSector.txtType.insertText("")
        selectEmployementSectorIndex = -1
        
        txtProfession.isHidden = true
        txtProfession.txtType.text = ""
        txtProfession.txtType.insertText("")
        selectProfessionIndex = -1
        
        txtEmployername.isHidden = true
        txtEmployername.txtType.text = ""
        txtEmployername.txtType.insertText("")
        
        txtNameofBusiness.isHidden = true
        txtNameofBusiness.txtType.text = ""
        txtNameofBusiness.txtType.insertText("")
        
        txtEducationLevel.isHidden = true
        txtEducationLevel.txtType.text = ""
        txtEducationLevel.txtType.insertText("")
        selectEducationLevelIndex = -1
        
    }
    func showAllEmploymentDetailsView(){
        
        txtIndustry.isHidden = false
        txtIndustry.txtType.text = ""
        txtIndustry.txtType.insertText("")
        selectIndustryIndex = -1
        
        txtEmploymentSector.isHidden = false
        txtEmploymentSector.txtType.text = ""
        txtEmploymentSector.txtType.insertText("")
        selectEmployementSectorIndex = -1
        
        txtProfession.isHidden = false
        txtProfession.txtType.text = ""
        txtProfession.txtType.insertText("")
        selectProfessionIndex = -1
        
        txtEmployername.isHidden = false
        txtEmployername.txtType.text = ""
        txtEmployername.txtType.insertText("")
        
        txtNameofBusiness.isHidden = false
        txtNameofBusiness.txtType.text = ""
        txtNameofBusiness.txtType.insertText("")
        
        txtEducationLevel.isHidden = false
        txtEducationLevel.txtType.text = ""
        txtEducationLevel.txtType.insertText("")
        selectEducationLevelIndex = -1
        
    }
    
}

extension PersonalInfoVC: didTakeCustomPhoto_protocol{
    func didTakeCustomPhoto_protocol(image_: UIImage) {
        isSelectHoldingImg = true
        takedHoldingIDImage.image = image_
        selectTakePhotoHolding()
    }
    
    func selectTakePhotoHolding(){
        btnViewTakePhotoHoldingId.isHidden = false
        imgViewTakePhoto.isHidden = false
        imgDoneHoldingImage.image = .IMGDoneGreen
        lblTakePhoto_detail.text = "Profile Pic.png"
    }
    func hideTakePhotoHolding(){
        btnViewTakePhotoHoldingId.isHidden = true
        imgViewTakePhoto.isHidden = true
        lblTakePhoto_detail.text = ""
    }
}

extension PersonalInfoVC: UIFloatingTextField_Protocol{
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool {
        validateErrorMsg(textField: textField, txt: txt)
        print(containSize)
        if textField == txtPOBox.txtType {
            if txt.count >= 31{
                return false
            }
            
            if AppHelper.allowSomeDigitOnly(txt: txt) == false{
                return false
            }
        }else{
            if textField == txtHouseFlatNumber.txtType {
                if txt.count >= 31{
                    return false
                }
            }
            
            if textField == txtArea.txtType {
                if txt.count >= 31{
                    return false
                }
            }
            if AppHelper.allowSomeCharactesOnly(txt: txt) == false{
                return false
            }
        }
        
        if txt.count >= defaultTextLimit{
            return false
        }
        return true
    }
    func btnOpenCountryCodePicker(textField: UITextView) {
        self.view.endEditing(true)
        
    }
    func editingChanged(textField: UITextView) {
        validateErrorMsg(textField: textField)
    }
    func textFieldDidBeginEditing(textField: UITextView){
        
    }
    
    //Validation
    func validateErrorMsg(textField: UITextView,txt: String? = ""){
        
        
        let txtValue = textField.text == "" ? txt : textField.text!
        if txtSalutation.txtType == textField{
            txtSalutation.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtSalutation.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtFullName.txtType == textField{
            txtFullName.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtDateofBirth.txtType == textField{
            txtDateofBirth.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtGender.txtType == textField{
            txtGender.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtGender.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtNationality.txtType == textField{
            txtNationality.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtNationality.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtIDNo.txtType == textField{
            txtIDNo.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtIDExpiryDate.txtType == textField{
            txtIDExpiryDate.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCountryofBirth.txtType == textField{
            txtCountryofBirth.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtCountryofBirth.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCityofBirth.txtType == textField{
            txtCityofBirth.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtCityofBirth.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCountry.txtType == textField{
            txtCountry.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtCountry.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtResidentialStatus.txtType == textField{
            //txtResidentialStatus.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtResidentialStatus.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPleaseSpecifyCountry.txtType == textField{
            txtResidentialStatus.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPleaseSpecifyCountry.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPOBox.txtType == textField{
            txtPOBox.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPOBox.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPostalCode.txtType == textField{
            txtPostalCode.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPostalCode.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtHouseFlatNumber.txtType == textField{
            //txtHouseFlatNumber.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtHouseFlatNumber.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtCity.txtType == textField{
            //txtCity.lblError.isHidden = AppHelper.isNull(txtCity.txtType.text!) == false ? true : false
            //txtCity.iconFill.isHidden = AppHelper.isNull(txtCity.txtType.text!) == false ? false : true
        }
        if txtArea.txtType == textField{
            txtArea.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtArea.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtEmploymentStatus.txtType == textField{
            txtEmploymentStatus.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtEmploymentStatus.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        
        
        let employment_status_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .employment_status_c, index: selectEmployementStatusIndex)
        if employment_status_c == "1"{
            //Employed
            if txtIndustry.txtType == textField{
                txtIndustry.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtIndustry.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
            if txtEmploymentSector.txtType == textField{
                txtEmploymentSector.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtEmploymentSector.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
            if txtProfession.txtType == textField{
                txtProfession.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtProfession.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
            if txtEmployername.txtType == textField{
                txtEmployername.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtEmployername.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
            if txtEducationLevel.txtType == textField{
                txtEducationLevel.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtEducationLevel.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
        }else if employment_status_c == "6_7" || employment_status_c == "4" || employment_status_c == "6_6"{
            //"Business man", "Self-Employed", "Investor",
            if txtIndustry.txtType == textField{
                txtIndustry.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtIndustry.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
            if txtProfession.txtType == textField{
                txtProfession.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtProfession.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
            if txtNameofBusiness.txtType == textField{
                txtNameofBusiness.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtNameofBusiness.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
            if txtEducationLevel.txtType == textField{
                txtEducationLevel.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtEducationLevel.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
        }else{
            if txtEducationLevel.txtType == textField{
                txtEducationLevel.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtEducationLevel.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
        }
        
        
        
        validateEnput()
    }
    func validateEnput() {
        var returnValue = true
        if AppHelper.isNull(txtSalutation.txtType.text!){
            //txtSalutation.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtGender.txtType.text!){
            //txtGender.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtNationality.txtType.text!){
            //txtNationality.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtCountryofBirth.txtType.text!){
            //txtCountryofBirth.lblError.isHidden = false
            returnValue = false
        }
        /*if AppHelper.isNull(txtCityofBirth.txtType.text!){
         //txtCityofBirth.lblError.isHidden = false
         returnValue = false
         }*/
        if AppHelper.isNull(txtCountry.txtType.text!){
            //txtCountry.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtResidentialStatus.txtType.text!){
            //txtResidentialStatus.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtPOBox.txtType.text!){
            //txtPOBox.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtPostalCode.txtType.text!){
            //txtPostalCode.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtArea.txtType.text!){
            //txtArea.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtEmploymentStatus.txtType.text!){
            //txtEmploymentStatus.lblError.isHidden = false
            returnValue = false
        }
        
        
        
        let employment_status_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .employment_status_c, index: selectEmployementStatusIndex)
        if employment_status_c == "1"{
            //Employed
            if AppHelper.isNull(txtIndustry.txtType.text!){
                //txtIndustry.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtEmploymentSector.txtType.text!){
                //txtIndustry.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtProfession.txtType.text!){
                //txtProfession.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtEmployername.txtType.text!){
                //txtIndustry.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtEducationLevel.txtType.text!){
                //txtEmployername.lblError.isHidden = false
                returnValue = false
            }
        }else if employment_status_c == "6_7" || employment_status_c == "4" || employment_status_c == "6_6"{
            //"Business man", "Self-Employed", "Investor",
            
            if AppHelper.isNull(txtIndustry.txtType.text!){
                //txtIndustry.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtProfession.txtType.text!){
                //txtProfession.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtNameofBusiness.txtType.text!){
                //txtEmployername.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtEducationLevel.txtType.text!){
                //txtEmployername.lblError.isHidden = false
                returnValue = false
            }
        }else{
            if AppHelper.isNull(txtEducationLevel.txtType.text!){
                //txtEmployername.lblError.isHidden = false
                returnValue = false
            }
        }
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewbgbtnNext)
        }else{
            AppHelper.disableNextBTN(view_: viewbgbtnNext)
        }
        //return returnValue
    }
    
}

extension PersonalInfoVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollContainer{
            if scrollContainer.contentOffset.y > 370{
                onscrollHeaderView.isHidden = false
            }else{
                onscrollHeaderView.isHidden = true
            }
        }
    }
}

//MARK: - Api Call
extension PersonalInfoVC{
    
    func setFormData(result: GetApplicationDataResult){
        //if (scanBackDocData?.first_name ?? "").count == 0{
        
        let date_of_birth_c = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "dd/MM/yyyy", strDate: result.date_of_birth_c as? String ?? "")
        if date_of_birth_c.count != 0{
            let civil_id_expiry_date_c = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "dd/MM/yyyy", strDate: result.civil_id_expiry_date_c as? String ?? "")
            let passport_expiry_date_c = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "dd/MM/yyyy", strDate: result.passport_expiry_date_c as? String ?? "")
            
            txtFullName.txtType.text = ""
            txtFullName.txtType.insertText(result.full_name_c as? String ?? "")
            validateErrorMsg(textField: txtFullName.txtType)
            
            txtDateofBirth.txtType.text = ""
            txtDateofBirth.txtType.insertText(date_of_birth_c)
            validateErrorMsg(textField: txtDateofBirth.txtType)
            
            txtIDNo.txtType.text = ""
            txtIDNo.txtType.insertText(result.civil_id_c as? String ?? "")
            validateErrorMsg(textField: txtIDNo.txtType)
            
            txtIDExpiryDate.txtType.text = ""
            txtIDExpiryDate.txtType.insertText(civil_id_expiry_date_c)
            validateErrorMsg(textField: txtIDExpiryDate.txtType)
            
            //set passport detail
            if citizenshipType == .expatriate || citizenshipType == .gcc{
                txtPassportNo.txtType.text = ""
                txtPassportNo.txtType.insertText(result.passport_number_c as? String ?? "")
                validateErrorMsg(textField: txtPassportNo.txtType)
                
                txtPassportExpiryDate.txtType.text = ""
                txtPassportExpiryDate.txtType.insertText(passport_expiry_date_c)
                validateErrorMsg(textField: txtPassportExpiryDate.txtType)
            }
            //}
            
            //--
            let salutation_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .salutation_c, backendvalue: result.salutation_c as? String ?? "")
            txtSalutation.txtType.text = ""
            txtSalutation.txtType.insertText(salutation_c.0)
            validateErrorMsg(textField: txtSalutation.txtType)
            selectSalutationIndex = salutation_c.1
            
            let gender_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .gender_c, backendvalue: result.gender_c as? String ?? "")
            txtGender.txtType.text = ""
            txtGender.txtType.insertText(gender_c.0)
            validateErrorMsg(textField: txtGender.txtType)
            selectGenderIndex = gender_c.1
            
            let nationality_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.nationality_c as? String ?? "")
            if nationality_c.0.count != 0{
                txtNationality.txtType.text = ""
                txtNationality.txtType.insertText(nationality_c.0)
                validateErrorMsg(textField: txtNationality.txtType)
                selectCountryofNationalityIndex = result.nationality_c as? String ?? ""
            }
            
            let country_of_birth_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.country_of_birth_c as? String ?? "")
            txtCountryofBirth.txtType.text = ""
            txtCountryofBirth.txtType.insertText(country_of_birth_c.0)
            validateErrorMsg(textField: txtCountryofBirth.txtType)
            selectCountryofBirthIndex = result.country_of_birth_c as? String ?? ""
            
            txtCityofBirth.txtType.text = ""
            txtCityofBirth.txtType.insertText(result.city_of_birth_c as? String ?? "")
            validateErrorMsg(textField: txtCityofBirth.txtType)
            
            let resident_status_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .resident_status_c, backendvalue: result.resident_status_c as? String ?? "")
            txtResidentialStatus.txtType.text = ""
            txtResidentialStatus.txtType.insertText(resident_status_c.0)
            validateErrorMsg(textField: txtResidentialStatus.txtType)
            selectResidentialStatusIndex = resident_status_c.1
            
            if (result.resident_status_c as? String ?? "") == "S"{
                txtPleaseSpecifyCountry.showTextField(txtView: txtPleaseSpecifyCountry, layoutConTop: txtPleaseSpecifyCountry_top, layoutConHeight: txtPleaseSpecifyCountry_height)
            }else{
                txtPleaseSpecifyCountry.hiddenTextField(txtView: txtPleaseSpecifyCountry, layoutConTop: txtPleaseSpecifyCountry_top, layoutConHeight: txtPleaseSpecifyCountry_height)
            }
            validateErrorMsg(textField: txtPleaseSpecifyCountry.txtType)
            
            txtPOBox.txtType.text = ""
            txtPOBox.txtType.insertText(result.resident_po_box_c as? String ?? "")
            validateErrorMsg(textField: txtPOBox.txtType)
            
            let resident_postal_code_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .resident_postal_code_c, backendvalue: result.resident_postal_code_c as? String ?? "")
            txtPostalCode.txtType.text = ""
            txtPostalCode.txtType.insertText(resident_postal_code_c.0) //result.resident_postal_code_c as? String ?? ""
            validateErrorMsg(textField: txtPostalCode.txtType)
            selectPostalCodeIndex = resident_postal_code_c.1
            
            //txtHouseFlatNumber.txtType.text = result.resident_house_no_c as? String ?? ""
            //validateErrorMsg(textField: txtHouseFlatNumber.txtType)
            
            //txtCity.txtType.text = result.city_c as? String ?? ""
            //validateErrorMsg(textField: txtCity.txtType)
            
            txtArea.txtType.text = ""
            txtArea.txtType.insertText(result.area_c as? String ?? "")
            validateErrorMsg(textField: txtArea.txtType)
            
            /*
             let resident_country_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.resident_country_c as? String ?? "")
             txtCountry.txtType.text = resident_country_c.0
             validateErrorMsg(textField: txtCountry.txtType)
             selectCountryIndex = result.resident_country_c as? String ?? ""
             */
            
            let employment_status_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .employment_status_c, backendvalue: result.employment_status_c as? String ?? "")
            txtEmploymentStatus.txtType.text = ""
            txtEmploymentStatus.txtType.insertText(employment_status_c.0)
            validateErrorMsg(textField: txtEmploymentStatus.txtType)
            selectEmployementStatusIndex = employment_status_c.1
            manageEmploymentDetailView(backendValue: result.employment_status_c as? String ?? "")
            
            let industry_type_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .industry_type_c, backendvalue: result.industry_type_c as? String ?? "")
            txtIndustry.txtType.text = ""
            txtIndustry.txtType.insertText(industry_type_c.0)
            validateErrorMsg(textField: txtIndustry.txtType)
            selectIndustryIndex = industry_type_c.1
            
            let employment_sector_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .employment_sector_c, backendvalue: result.employment_sector_c as? String ?? "")
            txtEmploymentSector.txtType.text = ""
            txtEmploymentSector.txtType.insertText(employment_sector_c.0.count == 0 ? Localize(key: "Other") : employment_sector_c.0)
            validateErrorMsg(textField: txtEmploymentSector.txtType)
            selectEmployementSectorIndex = employment_sector_c.1
            
            txtEmployername.txtType.text = ""
            txtEmployername.txtType.insertText(result.employer_name_c as? String ?? "")
            validateErrorMsg(textField: txtEmployername.txtType)
            
            let profession_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .profession_c, backendvalue: result.profession_c as? String ?? "")
            txtProfession.txtType.text = ""
            txtProfession.txtType.insertText(profession_c.0)
            validateErrorMsg(textField: txtProfession.txtType)
            selectProfessionIndex = profession_c.1
            
            txtNameofBusiness.txtType.text = ""
            txtNameofBusiness.txtType.insertText(result.name_of_business_c as? String ?? "")
            validateErrorMsg(textField: txtNameofBusiness.txtType)
            
            txtPleaseSpecifyCountry.txtType.text = ""
            txtPleaseSpecifyCountry.txtType.insertText(result.other_resident_country_c as? String ?? "")
            validateErrorMsg(textField: txtPleaseSpecifyCountry.txtType)
            
            let education_level_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .education_level_c, backendvalue: result.education_level_c as? String ?? "")
            txtEducationLevel.txtType.text = ""
            txtEducationLevel.txtType.insertText(education_level_c.0)
            validateErrorMsg(textField: txtEducationLevel.txtType)
            selectEducationLevelIndex = education_level_c.1
            
        }
        //--
        validateEnput()
        
        //--
        getDocumentsList()
        
        //--
        viewDidLayoutSubviews()
    }
    
    func getDocumentsList(){
        //LoadingView.shared.openLodingAlert(view: self.view)
        apiCall_getDocumentsList (showProgress: false){ [self] docResult in
            //LoadingView.shared.dismissLoadingView()
            docResult.documents.forEach { getDocumentsListDocuments in
                if getDocumentsListDocuments.document_type == docTypeBackendValue(value: docType.customer_photo.rawValue) &&
                    getDocumentsListDocuments.card_type == viewType.getValue(.other)(){
                    let document_link = getDocumentsListDocuments.document_link
                    if let url = URL(string: document_link){
                        isSelectHoldingImg = true
                        takedHoldingIDImage.af.setImage(withURL: url)
                        imgDoneHoldingImage.image = .IMGDoneGreen
                        selectTakePhotoHolding()
                    }
                }
            }
        }
    }
    
    func apiCall_UploadImage()  {
        //--
        let docBase64 = takedHoldingIDImage.image?.convertImageToBase64String()
        if docBase64?.count == 0{
            apiCall_updateApplication()
            return
        }
        let dicParam:[String:AnyObject] = ["operation":"documentValidation" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "doc_type":docType.customer_photo.getValue(),
                                                   "view_type":viewType.other.getValue(),
                                                   "document_base64":docBase64 ?? "",
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
            let validateOTPModel = OmniResponseModel(JSON: response as! [String : Any])!
            if validateOTPModel.Response?.Body?.status == "Success"{
                apiCall_updateApplication()
            }else{
                self.view.makeToast(validateOTPModel.Response?.Body?.Result?.data?.error_response ?? "")
            }
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_UploadImage()
                }
            }
        }
    }
    func apiCall_updateApplication()  {
        
        //--
        let salutation_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .salutation_c, index: selectSalutationIndex)
        var fName = ""
        var lName = ""
        if let fullName = txtFullName.txtType.text{
            var nameArr = fullName.description.components(separatedBy: " ")
            fName = nameArr.count != 0 ? nameArr[0] : ""
            if nameArr.count > 1{
                nameArr.remove(at: 0)
                lName = nameArr.joined(separator: " ")
            }
        }
        let gender_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .gender_c, index: selectGenderIndex)
        
        //let resident_country_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .resident_country_c, index: selectCountryIndex)
        let resident_status_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .resident_status_c, index: selectResidentialStatusIndex)
        let resident_postal_code_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .resident_postal_code_c, index: selectPostalCodeIndex)
        let employment_status_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .employment_status_c, index: selectEmployementStatusIndex)
        let industry_type_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .industry_type_c, index: selectIndustryIndex)
        let employment_sector_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .employment_sector_c, index: selectEmployementSectorIndex)
        let profession_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .profession_c, index: selectProfessionIndex)
        let education_level_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .education_level_c, index: selectEducationLevelIndex)
        
        
        let date_of_birth_c = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "dd/MM/yyyy", dateNewFTR: "yyyy-MM-dd", strDate: txtDateofBirth.txtType.text!)
        let civil_id_expiry_date_c = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "dd/MM/yyyy", dateNewFTR: "yyyy-MM-dd", strDate: txtIDExpiryDate.txtType.text!)
        let passport_expiry_date_c = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "dd/MM/yyyy", dateNewFTR: "yyyy-MM-dd", strDate: txtPassportExpiryDate.txtType.text!)
        
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.personalInfoScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": ["citizenship_c": citizenshipType.rawValue,
                                                                 "salutation_c":  salutation_c,
                                                                 "full_name_c": txtFullName.txtType.text!,
                                                                 "first_name_c": fName,
                                                                 "last_name_c": lName,
                                                                 "date_of_birth_c": date_of_birth_c,
                                                                 "gender_c": gender_c,
                                                                 "nationality_c": selectCountryofNationalityIndex,
                                                                 "civil_id_c": txtIDNo.txtType.text!,
                                                                 "civil_id_expiry_date_c": civil_id_expiry_date_c,
                                                                 "passport_number_c": txtPassportNo.txtType.text!,
                                                                 "passport_expiry_date_c": passport_expiry_date_c,
                                                                 "country_of_birth_c": selectCountryofBirthIndex,
                                                                 "city_of_birth_c": txtCityofBirth.txtType.text!,
                                                                 "resident_country_c": selectCountryIndex,
                                                                 "resident_status_c": resident_status_c,
                                                                 "resident_po_box_c": txtPOBox.txtType.text!,
                                                                 "resident_postal_code_c": resident_postal_code_c,
                                                                 //"resident_house_no_c": txtHouseFlatNumber.txtType.text!,
                                                                 //"city_c": txtCity.txtType.text!,
                                                                 "area_c": txtArea.txtType.text!,
                                                                 "employment_status_c": employment_status_c,
                                                                 "industry_type_c": selectIndustryIndex == -1 ? "75" : industry_type_c,
                                                                 "employment_sector_c": selectEmployementSectorIndex == -1 ? "7" : employment_sector_c,
                                                                 "employer_name_c": txtEmployername.txtType.text!,
                                                                 "profession_c": selectProfessionIndex == -1 ? "16" : profession_c,
                                                                 "name_of_business_c": txtNameofBusiness.txtType.text!,
                                                                 "other_resident_country_c": txtPleaseSpecifyCountry.txtType.text!,
                                                                 "education_level_c":education_level_c]
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "200"{
                if oTPGenerationModel.Response?.Body?.status == "Success"{
                    apiCall_checkAmlDedubCBO()
                    /*if citizenshipType == CitizenshipType.omani{
                     apiCall_checkAmlDedubCBO()
                     }else{
                     //--
                     let vc = FinancialInfoVC(nibName: "FinancialInfoVC", bundle: nil)
                     vc.selectedEmploymentStatus = employment_status_c
                     vc.citizenshipType = citizenshipType
                     vc.scanPasswordData = scanPasswordData
                     vc.scanFrontDocData = scanFrontDocData
                     vc.scanBackDocData = scanBackDocData
                     self.navigationController?.pushViewController(vc, animated: false)
                     }*/
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
    func apiCall_checkAmlDedubCBO()  {
        //--
        let dicParam:[String:AnyObject] = ["operation":"checkAmlDedubCBO" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
            self.popover.dismiss()
            let validateOTPModel = OmniResponseModel(JSON: response as! [String : Any])!
            if validateOTPModel.Response?.Code == "200"{
                //--
                let vc = FinancialInfoVC(nibName: "FinancialInfoVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: false)
                
            }else{
                self.popover.dismiss()
                openAMLAlert(title: "Error", details: validateOTPModel.Response?.Body?.statusMsg ?? "")
                //openErrorAlert(title: "Error", details: validateOTPModel.Response?.Body?.statusMsg ?? "")
            }
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_checkAmlDedubCBO()
                }
            }
        }
    }
    
    func apiCall_getAddressDetails()  {
        let resident_postal_code_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .resident_postal_code_c, index: selectPostalCodeIndex)
        //--
        let dicParam:[String:AnyObject] = ["operation":"getAddressDetails" as AnyObject,
                                           "data":["zipcode":resident_postal_code_c,
                                                   "language":Managelanguage.getLanguageCode(),
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { [self] (response) in
            print(response as Any)
            let getAddressDetailsModel = GetAddressDetailsModel(JSON: response as! [String : Any])!
            if getAddressDetailsModel.Response?.Code == "200"{
                if getAddressDetailsModel.Response?.Body?.status == "Success"{
                    txtCity.txtType.text = getAddressDetailsModel.Response?.Body?.Result?.cityData?.city
                    validateErrorMsg(textField: txtCity.txtType)
                }
            }else{
            }
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_getAddressDetails()
                }
            }
        }
    }
}


extension PersonalInfoVC: LightboxControllerDismissalDelegate, LightboxControllerPageDelegate{
    func setupLightBoxImageArray(imgOpen:UIImage, msg: String){
        //--
        var images_LightBox:[LightboxImage] = []
        images_LightBox.append(LightboxImage(image: imgOpen, text: msg))
        
        //--
        let controller = LightboxController(images: images_LightBox)
        controller.pageDelegate = self
        controller.dismissalDelegate = self
        controller.dynamicBackground = true
        self.present(controller, animated: true, completion: nil)
    }
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        print(page)
    }
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        
    }
}
