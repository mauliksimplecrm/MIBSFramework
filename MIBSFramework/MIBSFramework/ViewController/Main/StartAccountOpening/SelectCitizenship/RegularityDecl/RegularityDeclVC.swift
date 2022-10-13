//
//  RegularityDeclVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 05/02/22.
//

import UIKit
//import Lightbox



class RegularityDeclVC: UIViewController {

    //MARK: @IBOutlet
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scrollContainer: UIScrollView!
    @IBOutlet weak var lblOnScrollHeader: UILabel!
    @IBOutlet weak var onscrollHeaderView: UIView!
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblViewSteps_title: UILabel!
    @IBOutlet weak var lblNext_title: UILabel!
    @IBOutlet weak var viewbgbtnNext: UIView!
    
    @IBOutlet weak var lblPurposeOfOpeningAcc: UILabel!
    @IBOutlet weak var lblPurposeOfOpeningAcc_detail: UILabel!
    @IBOutlet weak var imgPurposeOfOpeningAcc: UIImageView!
    @IBOutlet weak var lblAreYouHolderOfAnyUsDoc: UILabel!
    @IBOutlet weak var lbllblAreYouHolderOfAnyUsDoc_detail: UILabel!
    @IBOutlet weak var imgAreYouHolderOfAnyUsDoc: UIImageView!
    @IBOutlet weak var lblPEP: UILabel!
    @IBOutlet weak var lblPEP_detail: UILabel!
    @IBOutlet weak var imgPEP: UIImageView!
    @IBOutlet weak var lblAreYouTaxResident: UILabel!
    @IBOutlet weak var lblAreYouTaxResident_detail: UILabel!
    @IBOutlet weak var imgAreYouTaxResident: UIImageView!
    
    //Proof of Address
    @IBOutlet weak var lblProofofAddress: UILabel!
    @IBOutlet weak var txtBankStatement: UIFloatingTextField!
    @IBOutlet weak var lblUploadBankStatement: UILabel!
    @IBOutlet weak var lblSelectDocumentName: UILabel!
    @IBOutlet weak var lblSelectDocumentSize: UILabel!
    @IBOutlet weak var imgUploadBankStatement: UIImageView!
    @IBOutlet weak var txtNearestBranch: UIFloatingTextField!
    @IBOutlet weak var viewbgUploadBackStatement: UIView!
    @IBOutlet weak var viewbgUploadBackStatement_height: NSLayoutConstraint! //102
    
    @IBOutlet weak var imgViewTakePhoto: UIImageView!
    @IBOutlet weak var btnViewTakePhotoHoldingId: UIButton!
    
    
    //MARK: Veriable
    var screenNameEnum: ScreenNameEnum?
    var selectPurposeofOpeningAccountIndex = -1
    var selectAreyouholderofanyUSDocIndex = -1
    var selectPEPIndex = -1
    var selectCRSIndex = -1
    var selectDocumentIndex = -1
    var selectNearesBranchIndex = -1
    var otherTextSourceofFund = ""
    
    var isSelectProofOfAddressDoc = false
    var takedProofOfAddressDoc = UIImageView()
    
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        setupBasic()
        setupTextField()
        hideTakePhotoHolding()
        validateEnput()
        
        apiCall_getApplicationData { result in
            self.setFormData(result: result)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        progressBar.setProgress(1.0, animated: true)
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        
        //--
        let length_ = Managelanguage.getLanguageCode() == "A" ? 7 : 10
        lblOnScrollHeader.attributedText = Localize(key: "Regularity Declaration").attributedStringWithColorNew(0, length: length_, color: .DARKGREENTINT)
        lblTitle.attributedText = Localize(key: "Regularity Declaration").attributedStringWithColorNew(0, length: length_, color: .DARKGREENTINT)
        lblDetail.text = Localize(key: "Regularity Declaration detail")
        
        lblPurposeOfOpeningAcc.text = Localize(key: "Purpose of opening an account?")
        lblAreYouHolderOfAnyUsDoc.text = Localize(key: "Are you holder of any US Documents?")
        lblPEP.text = Localize(key: "Are you Politically Exposed Person (PEP)?")
        lblAreYouTaxResident.text = Localize(key: "Are you a tax resident of a country other than Sultanate of Oman?")
        lblProofofAddress.text = Localize(key: "Proof of Address")
        lblUploadBankStatement.text = Localize(key: "upload_document")
        lblViewSteps_title.text = Localize(key: "VIEW STEPS")
        lblNext_title.text = Localize(key: "NEXT")
        
        //--
        if Managelanguage.getLanguageCode() == "A"
        {
            lblTitle.semanticContentAttribute = .forceRightToLeft
            lblDetail.semanticContentAttribute = .forceRightToLeft
            
            lblPurposeOfOpeningAcc.semanticContentAttribute = .forceRightToLeft
            lblPurposeOfOpeningAcc_detail.semanticContentAttribute = .forceRightToLeft
            lblAreYouHolderOfAnyUsDoc.semanticContentAttribute = .forceRightToLeft
            lbllblAreYouHolderOfAnyUsDoc_detail.semanticContentAttribute = .forceRightToLeft
            lblPEP.semanticContentAttribute = .forceRightToLeft
            lblPEP_detail.semanticContentAttribute = .forceRightToLeft
            lblAreYouTaxResident.semanticContentAttribute = .forceRightToLeft
            lblAreYouTaxResident_detail.semanticContentAttribute = .forceRightToLeft
            lblProofofAddress.semanticContentAttribute = .forceRightToLeft
            
            lblUploadBankStatement.textAlignment = .right
            txtBankStatement.txtType.textAlignment = .right
            txtNearestBranch.txtType.textAlignment = .right
            
        }
        else
        {
            lblTitle.semanticContentAttribute = .forceLeftToRight
            lblDetail.semanticContentAttribute = .forceLeftToRight
            
            lblPurposeOfOpeningAcc.semanticContentAttribute = .forceLeftToRight
            lblPurposeOfOpeningAcc_detail.semanticContentAttribute = .forceLeftToRight
            lblAreYouHolderOfAnyUsDoc.semanticContentAttribute = .forceLeftToRight
            lbllblAreYouHolderOfAnyUsDoc_detail.semanticContentAttribute = .forceLeftToRight
            lblPEP.semanticContentAttribute = .forceLeftToRight
            lblPEP_detail.semanticContentAttribute = .forceLeftToRight
            lblAreYouTaxResident.semanticContentAttribute = .forceLeftToRight
            lblAreYouTaxResident_detail.semanticContentAttribute = .forceLeftToRight
            lblProofofAddress.semanticContentAttribute = .forceLeftToRight
        }
    }
    func setupHeader(){
         
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { [self] (sender) in
            clickBack()
        }
    }
    func clickBack(){
        if self.screenNameEnum == .reviewApplicationVC{
            //--
            let vc = ReviewApplicationVC(nibName: "ReviewApplicationVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            //--
            let vc = FinancialInfoVC(nibName: "FinancialInfoVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    func setupBasic(){
        //--
        
        
    }
    func setupTextField(){
        //Proof of Address
        txtBankStatement.setTitlePlaceholder(text_: Localize(key: "Select Document"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtBankStatement.didTappedDropDown = { (sender) in
            self.view.endEditing(true)
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .proof_of_address_doctype_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Proof of Address"),
                                    dropDownType: "document",
                                    arrList: list,
                                    selectedIndex: self.selectDocumentIndex)
        }
        //hideDocumentUpload()
        
        txtNearestBranch.setTitlePlaceholder(text_: Localize(key: "Select your nearest branch"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtNearestBranch.didTappedDropDown = { (sender) in
            self.view.endEditing(true)
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .branch_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Select your nearest branch"),
                                    dropDownType: "nearest_branch",
                                    arrList: list,
                                    selectedIndex: self.selectNearesBranchIndex)
        }
   
    }
    func hideDocumentUpload(){
        viewbgUploadBackStatement.isHidden = true
        viewbgUploadBackStatement_height.constant = 0
    }
    func showDocumentUpload(index: Int, title: String){
        lblUploadBankStatement.text = "\(Localize(key: "Upload")) \(title)"
        if index == 0{
            
        }else if index == 1{
            
        }else if index == 2{
            
        }
        viewbgUploadBackStatement.isHidden = false
        viewbgUploadBackStatement_height.constant = 102
    }
    
    //MARK: @IBAction
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
        vc.selectIndex = 2
        vc.totalStep = 3
        vc.progress = 1.0
        vc.arrListOfDropDown = [Localize(key: "Personal Information"), Localize(key: "Financial Information"), Localize(key: "Regularity Declaration")]
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnNext(_ sender: Any) {
        apiCall_UploadImage()
    }
    
    @IBAction func btnPurposeofOpeningAccount(_ sender: Any) {
        self.view.endEditing(true)
        //--
        let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .purpose_of_account_opening_c)
        
        //--
        let vc = SourceofFundsVC(nibName: "SourceofFundsVC", bundle: bundleIdentifireGlob)
        vc.selectIndex = 0
        vc.arrListOfDropDown = list
        vc.stepTitle = Localize(key: "Select_purpose_account")
        vc.pleaseSpecifyText = Localize(key: "please_specify_other_purpose")
        vc.pleaseSpecifyTextPlaceHolder = Localize(key: "Enter purpose")
        vc.delegate_didSelectSourceofFunds_protocol = self
        vc.otherTextSourceofFund = otherTextSourceofFund
        vc.selectIndex = selectPurposeofOpeningAccountIndex
        vc.openFromScreen = "regularity"
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnAreyouHolderUSDoc(_ sender: Any) {
        self.view.endEditing(true)
        //--
        let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .fatca_classification_c)
        
        //--
        let vc = CustomDorpDownVC(nibName: "CustomDorpDownVC", bundle: bundleIdentifireGlob)
        vc.delegate_didSelectCustomDropDown_Protocol = self
        vc.headerTitle = Localize(key: "Are you holder of any of the following?")
        vc.dropDownType = "areyouholderofanyoftheusdoc"
        vc.arrListOfDropDown = list
        vc.selectIndex = selectAreyouholderofanyUSDocIndex
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnPEP(_ sender: Any) {
        self.view.endEditing(true)
    
        //--
        let vc = PEPVC(nibName: "PEPVC", bundle: bundleIdentifireGlob)
        vc.selectIndex = selectPEPIndex
        vc.delegate_didSelectPEP_protocol = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnAreyouTextResident(_ sender: Any) {
        self.view.endEditing(true)
        
        //--
        let vc = CRSVC(nibName: "CRSVC", bundle: bundleIdentifireGlob)
        vc.selectIndex = selectCRSIndex
        vc.delegate_didSelectCRS_protocol = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnUploadbankStatement(_ sender: Any) {
        self.view.endEditing(true)
        //--
        let vc = CustomCameraVC(nibName: "CustomCameraVC", bundle: bundleIdentifireGlob)
        vc.headerTitle = Localize(key: "Proof of Address")
        vc.delegate_didTakeCustomPhoto = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.avCaptureDevicePosition = .back
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnViewTakePhotoHoldingId(_ sender: Any) {
        if let img_ = takedProofOfAddressDoc.image{
            setupLightBoxImageArray(imgOpen: img_, msg: "")
        }
    }

}

extension RegularityDeclVC: didTakeCustomPhoto_protocol{
    func didTakeCustomPhoto_protocol(image_: UIImage) {
        isSelectProofOfAddressDoc = true
        takedProofOfAddressDoc.image = image_
        selectTakePhotoHolding()
        validateEnput()
    }
    func selectTakePhotoHolding(){
        btnViewTakePhotoHoldingId.isHidden = false
        imgViewTakePhoto.isHidden = false
        imgUploadBankStatement.image = .IMGDoneGreen
        lblSelectDocumentName.text = "Filename.png"
        
        lblSelectDocumentSize.isHidden = false
        let size = Float(takedProofOfAddressDoc.image?.getSizeIn(.kilobyte) ?? "0.0") ?? 0.0
        lblSelectDocumentSize.text = "\(String(format: "%.0f", size))\(Localize(key: "kb"))"
    }
    func hideTakePhotoHolding(){
        btnViewTakePhotoHoldingId.isHidden = true
        imgViewTakePhoto.isHidden = true
        lblSelectDocumentName.text = ""
        
        lblSelectDocumentSize.text = ""
        lblSelectDocumentSize.isHidden = true
    }
}

extension RegularityDeclVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scrollContainer{
            if scrollContainer.contentOffset.y > 50{
                onscrollHeaderView.isHidden = false
            }else{
                onscrollHeaderView.isHidden = true
            }
        }
    }
}

extension RegularityDeclVC: didSelectSourceofFunds_protocol{
    func didSelectSourceofFunds(text: String, otherEnterText: String, index: Int) {
        lblPurposeOfOpeningAcc_detail.text = text //== 0 ? otherEnterText : text
        imgPurposeOfOpeningAcc.image = .IMGDoneGreen
        selectPurposeofOpeningAccountIndex = index
        otherTextSourceofFund = otherEnterText
        
        validateEnput()
    }
}

extension RegularityDeclVC: didSelectCustomDropDown_Protocol{
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String) {
        if droDownType == "areyouholderofanyoftheusdoc"{
            let fatca_classification_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .fatca_classification_c, index: index)
            if fatca_classification_c == "1" ||
                fatca_classification_c == "2" ||
                fatca_classification_c == "4"{
                //"USA Nationality" W9
                //--
                let vc = USNationalityVC(nibName: "USNationalityVC", bundle: bundleIdentifireGlob)
                vc.delegate_didSelectCustomDropDown_Protocol = self
                vc.selectIndex = index
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }
            if fatca_classification_c == "3" ||
                fatca_classification_c == "5" ||
                fatca_classification_c == "6"{
                //"Tax Resident of USA" W8
                //--
                let vc = TaxResidentofUSAVC(nibName: "TaxResidentofUSAVC", bundle: bundleIdentifireGlob)
                vc.delegate_didSelectCustomDropDown_Protocol = self
                vc.selectIndex = index
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            if fatca_classification_c == "7"{
                lbllblAreYouHolderOfAnyUsDoc_detail.text = title
                selectAreyouholderofanyUSDocIndex = index
                imgAreYouHolderOfAnyUsDoc.image = .IMGDoneGreen
            }
                
        }
        if droDownType == "areyouholderofanyoftheusdoc_submit"{
            lbllblAreYouHolderOfAnyUsDoc_detail.text = title
            selectAreyouholderofanyUSDocIndex = index
            imgAreYouHolderOfAnyUsDoc.image = .IMGDoneGreen
            
            validateEnput()
        }
        if droDownType == "document"{
            txtBankStatement.txtType.text = ""
            txtBankStatement.txtType.insertText(title)
            selectDocumentIndex = index
            showDocumentUpload(index: index, title: title)
            txtBankStatement.lblError.isHidden = true
            txtBankStatement.iconFill.isHidden = false

            validateEnput()
        }
        if droDownType == "nearest_branch"{
            txtNearestBranch.txtType.text = ""
            txtNearestBranch.txtType.insertText(title)
            selectNearesBranchIndex = index
            txtNearestBranch.lblError.isHidden = true
            txtNearestBranch.iconFill.isHidden = false

            validateEnput()
        }
    }
}

extension RegularityDeclVC: didSelectPEP_protocol{
    func didSelectPEP(txt: String, index: Int) {
        lblPEP_detail.text = txt
        selectPEPIndex = index
        imgPEP.image = .IMGDoneGreen
        validateEnput()
    }
}

extension RegularityDeclVC: didSelectCRS_protocol{
    func didSelectCRS(txt: String, index: Int) {
        lblAreYouTaxResident_detail.text = txt
        selectCRSIndex = index
        imgAreYouTaxResident.image = .IMGDoneGreen
        validateEnput()
    }
}

extension RegularityDeclVC: UIFloatingTextField_Protocol{
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
        
        if txtBankStatement.txtType == textField{
            txtBankStatement.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtBankStatement.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true

        }
        if txtNearestBranch.txtType == textField{
            txtNearestBranch.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtNearestBranch.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true

        }
    }
    func validateEnput() {
        var returnValue = true
        
        if AppHelper.isNull(txtBankStatement.txtType.text!){
            //txtBankStatement.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtNearestBranch.txtType.text!){
            //txtNearestBranch.lblError.isHidden = false
            returnValue = false
        }
        if selectPurposeofOpeningAccountIndex == -1{
            returnValue = false
        }
        if selectAreyouholderofanyUSDocIndex == -1{
            returnValue = false
        }
        if selectPEPIndex == -1{
            returnValue = false
        }
        if selectCRSIndex == -1{
            returnValue = false
        }
        if isSelectProofOfAddressDoc == false{
            returnValue = false
        }
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewbgbtnNext)
        }else{
            AppHelper.disableNextBTN(view_: viewbgbtnNext)
        }
    }

}

//MARK: - Api Call
extension RegularityDeclVC{
    
    func setFormData(result: GetApplicationDataResult){
        
        //txtSalaryIncome_IncomeDetailEmployed.txtType.text = "\(result.salary_income_c as? Float ?? 0.0)"
        
        let purpose_of_account_opening_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .purpose_of_account_opening_c, backendvalue: result.purpose_of_account_opening_c as? String ?? "")
        lblPurposeOfOpeningAcc_detail.text = purpose_of_account_opening_c.0
        selectPurposeofOpeningAccountIndex = purpose_of_account_opening_c.1
        otherTextSourceofFund = result.other_purpose_of_account_c as? String ?? ""
        imgPurposeOfOpeningAcc.image = AppHelper.isNull(purpose_of_account_opening_c.0) == false ? .IMGDoneGreen : nil
        
        let fatca_classification_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .fatca_classification_c, backendvalue: result.fatca_classification_c as? String ?? "")
        lbllblAreYouHolderOfAnyUsDoc_detail.text = fatca_classification_c.0
        selectAreyouholderofanyUSDocIndex = fatca_classification_c.1
        imgAreYouHolderOfAnyUsDoc.image = AppHelper.isNull(fatca_classification_c.0) == false ? .IMGDoneGreen : nil
        
        let is_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .is_pep_c, backendvalue: result.is_pep_c as? String ?? "")
        lblPEP_detail.text = is_pep_c.0
        selectPEPIndex = is_pep_c.1
        imgPEP.image = AppHelper.isNull(is_pep_c.0) == false ? .IMGDoneGreen : nil
        
        let is_crs_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .is_crs_c, backendvalue: result.is_crs_c as? String ?? "")
        lblAreYouTaxResident_detail.text = is_crs_c.0
        selectCRSIndex = is_crs_c.1
        imgAreYouTaxResident.image = AppHelper.isNull(is_crs_c.0) == false ? .IMGDoneGreen : nil
        
        let proof_of_address_doctype_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .proof_of_address_doctype_c, backendvalue: result.proof_of_address_doctype_c as? String ?? "")
        if proof_of_address_doctype_c.0.count != 0{
            txtBankStatement.txtType.text = ""
            txtBankStatement.txtType.insertText(proof_of_address_doctype_c.0)
            selectDocumentIndex = proof_of_address_doctype_c.1
            txtBankStatement.iconFill.isHidden = AppHelper.isNull(txtBankStatement.txtType.text!) == false ? false : true
            
            let branch_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .branch_debit_card_c, backendvalue: result.branch_c as? String ?? "")
            txtNearestBranch.txtType.text = ""
            txtNearestBranch.txtType.insertText(branch_c.0)
            selectNearesBranchIndex = branch_c.1
            txtNearestBranch.iconFill.isHidden = AppHelper.isNull(txtNearestBranch.txtType.text!) == false ? false : true
        }
        
        validateEnput()
        
        //--
        getDocumentsList()
    }
    func getDocumentsList(){
        //LoadingView.shared.openLodingAlert(view: self.view)
        apiCall_getDocumentsList (showProgress: false){ [self] docResult in
            //LoadingView.shared.dismissLoadingView()
            
            //let proof_of_address_doctype_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .proof_of_address_doctype_c, index: selectDocumentIndex)
            docResult.documents.forEach { getDocumentsListDocuments in
                if getDocumentsListDocuments.document_type == docTypeBackendValue(value: docType.address_proof.rawValue) &&
                    getDocumentsListDocuments.card_type == viewType.getValue(.other)(){
                    let document_link = getDocumentsListDocuments.document_link
                    if let url = URL(string: document_link){
                        isSelectProofOfAddressDoc = true
                        takedProofOfAddressDoc.af.setImage(withURL: url, completion:  { image_ in
                            self.selectTakePhotoHolding()
                        })
                        validateEnput()
                    }
                }
            }
        }
    }
    
    func apiCall_UploadImage()  {
        //--
        let docBase64 = takedProofOfAddressDoc.image?.convertImageToBase64String()
        if docBase64?.count == 0{
            apiCall_updateApplication()
            return
        }
        //let proof_of_address_doctype_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .proof_of_address_doctype_c, index: selectDocumentIndex)
        let dicParam:[String:AnyObject] = ["operation":"documentValidation" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "doc_type":docType.getValue(.address_proof)(),
                                                   "view_type":viewType.other.getValue(),
                                                   "step":STEPS_FRONT_END_NAME.getValue(.regularityDeclarationScreen)(),
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
        let purpose_of_account_opening_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .purpose_of_account_opening_c, index: selectPurposeofOpeningAccountIndex)
        let fatca_classification_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .fatca_classification_c, index: selectAreyouholderofanyUSDocIndex)
        let is_pep_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .is_pep_c, index: selectPEPIndex)
        let is_crs_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .is_crs_c, index: selectCRSIndex)
        let proof_of_address_doctype_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .proof_of_address_doctype_c, index: selectDocumentIndex)
        let branch_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .branch_c, index: selectNearesBranchIndex)
        
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.regularityDeclarationScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": ["citizenship_c": citizenshipType.rawValue,
                                                                 "purpose_of_account_opening_c":purpose_of_account_opening_c,
                                                                 "other_purpose_of_account_c":otherTextSourceofFund,
                                                                 "fatca_classification_c":fatca_classification_c,
                                                                 "is_pep_c":is_pep_c,
                                                                 "is_crs_c":is_crs_c,
                                                                 "proof_of_address_doctype_c":proof_of_address_doctype_c,
                                                                 "branch_c":branch_c
                                                                 ]
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], completion: { [self] (response) in
            print(response as Any)
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "200"{
                if oTPGenerationModel.Response?.Body?.status == "Success"{
                    //--
                    let vc = ReviewApplicationVC(nibName: "ReviewApplicationVC", bundle: bundleIdentifireGlob)
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

extension RegularityDeclVC: LightboxControllerDismissalDelegate, LightboxControllerPageDelegate{
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
