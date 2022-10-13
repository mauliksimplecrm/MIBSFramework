//
//  FinancialInfoVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 01/02/22.
//

import UIKit
//import SKCountryPicker
//import Lightbox
//import AnyFormatKit

class FinancialInfoVC: UIViewController {
    
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
    
    //IncomeDetail
    @IBOutlet weak var viewbgIncomeDetail: UIView!
    @IBOutlet weak var viewbgIncomeDetail_height: NSLayoutConstraint!
    @IBOutlet weak var viewbgLineSection_IncomeDetail_height: NSLayoutConstraint!
    
    //IncomeDetail Employed
    @IBOutlet var viewbg_IncomeDetailEmployed: UIView! //393
    @IBOutlet weak var viewbg_IncomeDetailEmployed_width: NSLayoutConstraint!
    @IBOutlet weak var viewbg_IncomeDetailEmployed_height: NSLayoutConstraint!
    @IBOutlet var viewbgInner_IncomeDetailEmployed: UIView!
    @IBOutlet weak var lblIncomeDetails_IncomeDetailEmployed: UILabel!
    @IBOutlet weak var txtSalaryIncome_IncomeDetailEmployed: FloatingTextFieldWithCode!
    @IBOutlet weak var txtSourceofFunds_IncomeDetailEmployed: UIFloatingTextField!
    @IBOutlet weak var lblPleaseUploadDoc_IncomeDetailEmployed: UILabel!
    @IBOutlet weak var icUploadDocDone_IncomeDetailEmployed: UIImageView!
    @IBOutlet weak var lblUploadDoc_IncomeDetailEmployed: UILabel!
    @IBOutlet weak var lblUploadDocDetail_IncomeDetailEmployed: UILabel!
    @IBOutlet weak var lblUploadDocSize_IncomeDetailEmployed: UILabel!
    @IBOutlet weak var lblProofofEmployment_IncomeDetailEmployed: UILabel!
    
    //IncomeDetail Housewife, Student, Minor, or Un-Employed
    @IBOutlet var viewbg_IncomeDetail2: UIView! //417
    @IBOutlet weak var viewbg_IncomeDetail2_width: NSLayoutConstraint!
    @IBOutlet weak var viewbg_IncomeDetail2_height: NSLayoutConstraint!
    @IBOutlet weak var lblIncomeDetailviewbg_IncomeDetail2: UILabel!
    @IBOutlet weak var txtSourceofFund_IncomeDetail2: UIFloatingTextField!
    @IBOutlet weak var txtRelationshipwithCust_IncomeDetail2: UIFloatingTextField!
    @IBOutlet weak var txtOccuooFundProvider_IncomeDetail2: UIFloatingTextField!
    @IBOutlet weak var txtMonthlyIncomeRangeofFundProvider_IncomeDetail2: FloatingTextFieldWithCode!
    
    @IBOutlet weak var txtOtherIncomeSource: UIFloatingTextField!
    @IBOutlet weak var txtSpecifyOtherIncomeSource: UIFloatingTextField!
    
    //Monthly Transaction
    @IBOutlet weak var lblMonthlyTransactions: UILabel!
    @IBOutlet weak var txtExpectedNoofMonthlyCreditTrans: UIFloatingTextField!
    @IBOutlet weak var txtExpectedCreditAmount: FloatingTextFieldWithCode!
    
    @IBOutlet weak var txtExpectedNoofMonthlyDebitTrans: UIFloatingTextField!
    @IBOutlet weak var txtExpectedDebitAmount: FloatingTextFieldWithCode!
    
    
    //UsualModeofTransaction
    @IBOutlet weak var lblUsualModeofTransaction: UILabel!
    @IBOutlet weak var tblUsualModeOfTransaction: UITableView!
    @IBOutlet weak var tblUsualModeOfTransaction_height: NSLayoutConstraint!
    @IBOutlet weak var txtOtherusualModetransaction: UIFloatingTextField!
    @IBOutlet weak var txtOtherUsualModeofTransaction_height: NSLayoutConstraint!
    
    //Business Detail
    @IBOutlet weak var viewbgSectionLine_Bussinesdetail: UIView!
    @IBOutlet weak var txtNameofBusiness: UIFloatingTextField!
    @IBOutlet weak var txtPercentageofOwnship: UIFloatingTextField!
    @IBOutlet weak var txtMonthlyIncome: UIFloatingTextField!
    
    @IBOutlet weak var imgViewTakePhoto: UIImageView!
    @IBOutlet weak var btnViewTakePhotoHoldingId: UIButton!
    
    
    //MARK: Veriable
    var screenNameEnum: ScreenNameEnum?
    
    var arrUsualModeofTransaction = ManageDropDownOption.getDropDownValue(dropdown_filed: .usual_mode_of_transactions_c)
    var selectUsualModeofTransactionArr:[String] = []
    var selectSourceofFunds_IncomeDetailEmployedIndex = -1
    var selectSourceofFunds_IncomeDetail2 = -1
    var selectRelationshipwithCustomerIndex = -1
    var selectOccupation_of_funds_providerIndex = -1
    var selectOther_Income_SourceIndex = -1
    var selectMonthly_credit_transactionsIndex = -1
    var selectMonthly_debit_transactionsIndex = -1
    var selectPercentage_of_ownershipIndex = -1
    
    var isSelectUploadDoc_IncomeDetailEmployed = false
    var imgUploadDoc_IncomeDetailEmployed = UIImageView()
    
    var otherTextSourceofFund_IncomeDetailEmployed = ""
    var resultGetApplicationDataResult: GetApplicationDataResult?
    
    let moneyInputController = TextFieldStartInputController()
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        setupBasic()
        registerCell()
        setupTextField()
        hideTakePhotoHolding()
        validateEnput()
        
        apiCall_getApplicationData { result in
            self.setFormData(result: result)
            self.manageViewOnSelectedEmpStatus(result: result)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        progressBar.setProgress(0.66, animated: true)
    }
    override func viewDidLayoutSubviews() {
        tblUsualModeOfTransaction_height.constant = tblUsualModeOfTransaction.contentSize.height
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        //--
        lblOnScrollHeader.attributedText = Localize(key: "Financial Information").attributedStringWithColorNew(0, length: 9, color: .DARKGREENTINT)
        lblTitle.attributedText = Localize(key: "Financial Information").attributedStringWithColorNew(0, length: 9, color: .DARKGREENTINT)
        lblDetail.text = Localize(key: "Financial Information detail")
        
        lblIncomeDetails_IncomeDetailEmployed.text = Localize(key: "Income Details")
        lblMonthlyTransactions.text = Localize(key: "Monthly Transactions")
        lblUsualModeofTransaction.text = Localize(key: "Usual Mode of transactions")
        lblPleaseUploadDoc_IncomeDetailEmployed.text = Localize(key: "Please upload a document as Proof Of Employment")
        lblUploadDoc_IncomeDetailEmployed.text = Localize(key: "upload_document")
        lblProofofEmployment_IncomeDetailEmployed.text = Localize(key: "Proof of Employment could be salary certificate or employment letter")
        
        lblIncomeDetailviewbg_IncomeDetail2.text = Localize(key: "Income Details")
        
        lblViewSteps_title.text = Localize(key: "VIEW STEPS")
        lblNext_title.text = Localize(key: "NEXT")
        
        //--
        if Managelanguage.getLanguageCode() == "A"
        {
            lblTitle.semanticContentAttribute = .forceRightToLeft
            lblDetail.semanticContentAttribute = .forceRightToLeft
            
            lblIncomeDetails_IncomeDetailEmployed.semanticContentAttribute = .forceRightToLeft
            lblPleaseUploadDoc_IncomeDetailEmployed.semanticContentAttribute = .forceRightToLeft
            lblUploadDoc_IncomeDetailEmployed.semanticContentAttribute = .forceRightToLeft
            lblProofofEmployment_IncomeDetailEmployed.semanticContentAttribute = .forceRightToLeft
            
            lblMonthlyTransactions.semanticContentAttribute = .forceRightToLeft
            lblUsualModeofTransaction.semanticContentAttribute = .forceRightToLeft
            
            txtSalaryIncome_IncomeDetailEmployed.txtType.textAlignment = .right
            txtSourceofFunds_IncomeDetailEmployed.txtType.textAlignment = .right
            
            txtSourceofFund_IncomeDetail2.txtType.textAlignment = .right
            txtRelationshipwithCust_IncomeDetail2.txtType.textAlignment = .right
            txtOccuooFundProvider_IncomeDetail2.txtType.textAlignment = .right
            txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType.textAlignment = .right
            
            txtOtherIncomeSource.txtType.textAlignment = .right
            txtSpecifyOtherIncomeSource.txtType.textAlignment = .right
            
            txtExpectedNoofMonthlyCreditTrans.txtType.textAlignment = .right
            txtExpectedCreditAmount.txtType.textAlignment = .right
            txtExpectedNoofMonthlyDebitTrans.txtType.textAlignment = .right
            txtExpectedDebitAmount.txtType.textAlignment = .right
            
            txtOtherusualModetransaction.txtType.textAlignment = .right
            
            txtNameofBusiness.txtType.textAlignment = .right
            txtPercentageofOwnship.txtType.textAlignment = .right
            txtMonthlyIncome.txtType.textAlignment = .right
        }
        else
        {
            lblTitle.semanticContentAttribute = .forceLeftToRight
            lblDetail.semanticContentAttribute = .forceLeftToRight
            
            lblIncomeDetails_IncomeDetailEmployed.semanticContentAttribute = .forceLeftToRight
            lblPleaseUploadDoc_IncomeDetailEmployed.semanticContentAttribute = .forceLeftToRight
            lblUploadDoc_IncomeDetailEmployed.semanticContentAttribute = .forceLeftToRight
            lblProofofEmployment_IncomeDetailEmployed.semanticContentAttribute = .forceLeftToRight
            
            lblMonthlyTransactions.semanticContentAttribute = .forceLeftToRight
            lblUsualModeofTransaction.semanticContentAttribute = .forceLeftToRight
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
            let vc = PersonalInfoVC(nibName: "PersonalInfoVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    func registerCell(){
        tblUsualModeOfTransaction.register(UINib(nibName: "UsualModeTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "UsualModeTblCell")
    }
    func setupBasic(){
        moneyFormatter.maximumIntegerCharacters = 10
        moneyInputController.formatter = moneyFormatter
        
        
        
    }
    func manageViewOnSelectedEmpStatus(result: GetApplicationDataResult){
        //
        //hideOtherModeofTransaction(clearText: false)
        
        //Hide Income Detail
        viewbgIncomeDetail_height.constant = 0
        viewbgLineSection_IncomeDetail_height.constant = 0
        
        //Hide Business Detail
        viewbgSectionLine_Bussinesdetail.isHidden = true
        txtNameofBusiness.isHidden = true
        txtPercentageofOwnship.isHidden = true
        txtMonthlyIncome.isHidden = true
        
        //--
        let employment_status_c = result.employment_status_c as? String ?? ""
        if employment_status_c == "1"{
            //Employed
            viewbgIncomeDetail_height.constant = 393
            viewbgLineSection_IncomeDetail_height.constant = 10
            viewbg_IncomeDetailEmployed_width.constant = UIScreen.main.bounds.width
            viewbgIncomeDetail.addSubview(viewbg_IncomeDetailEmployed)
            viewbg_IncomeDetailEmployed.frame = viewbgIncomeDetail.bounds
            
        }else if employment_status_c == "6_6" || employment_status_c == "4" || employment_status_c == "6_7"{
            //Investor, "Self-Employed", Business man
            
            //Show Business Detail
            viewbgSectionLine_Bussinesdetail.isHidden = false
            txtNameofBusiness.isHidden = false
            txtPercentageofOwnship.isHidden = false
            txtMonthlyIncome.isHidden = false
        }else{
            //Housewife, Student, Minor, or Un-Employed
            viewbgIncomeDetail_height.constant = 417
            viewbgLineSection_IncomeDetail_height.constant = 10
            viewbg_IncomeDetail2_width.constant = UIScreen.main.bounds.width
            viewbgIncomeDetail.addSubview(viewbg_IncomeDetail2)
            
        }
        
        validateEnput()
    }
    func setupTextField(){
        //NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification , object: nil)
        
        //Employed
        txtSalaryIncome_IncomeDetailEmployed.setTitlePlaceholder(text_: Localize(key: "Salary Income"), placeholder_: Localize(key: "Enter_Salary_Income"), isUserInteraction: true, allowToChangeActiveColor: false)
        txtSalaryIncome_IncomeDetailEmployed.delegate_FloatingTextFieldWithCode_Protocol = self
        txtSalaryIncome_IncomeDetailEmployed.txtType.keyboardType = .decimalPad
        txtSalaryIncome_IncomeDetailEmployed.lblCode.text = Localize(key: "default_currency_code")
        
        txtSourceofFunds_IncomeDetailEmployed.setTitlePlaceholder(text_: Localize(key: "Source of Funds"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtSourceofFunds_IncomeDetailEmployed.didTappedDropDown = { (sender) in
            //--
            let vc = SourceofFundsVC(nibName: "SourceofFundsVC", bundle: bundleIdentifireGlob)
            vc.selectIndex = 0
            vc.arrListOfDropDown = ManageDropDownOption.getDropDownValue(dropdown_filed: .sources_of_fund_c)
            vc.stepTitle = Localize(key: "Source of Funds")
            vc.pleaseSpecifyText = Localize(key: "Please specify your source of funds")
            vc.pleaseSpecifyTextPlaceHolder = Localize(key: "Enter source")
            vc.delegate_didSelectSourceofFunds_protocol = self
            vc.selectIndex = self.selectSourceofFunds_IncomeDetailEmployedIndex
            vc.otherTextSourceofFund = self.otherTextSourceofFund_IncomeDetailEmployed
            vc.openFromScreen = "financial"
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        
        //2
        txtSourceofFund_IncomeDetail2.setTitlePlaceholder(text_: Localize(key: "Source of fund/ Name of provider"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtSourceofFund_IncomeDetail2.didTappedDropDown = { (sender) in
            //--
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .name_of_fund_provider_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Source of Funds"),
                                    dropDownType: "SourceoffundNameofprovider",
                                    arrList: list,
                                    selectedIndex: self.selectSourceofFunds_IncomeDetail2)
        }
        
        txtRelationshipwithCust_IncomeDetail2.setTitlePlaceholder(text_: Localize(key: "Relationship with Customer"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtRelationshipwithCust_IncomeDetail2.didTappedDropDown = { (sender) in
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .relation_with_funds_provider_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Relationship with Customer"),
                                    dropDownType: "relationshipwithcust",
                                    arrList: list,
                                    selectedIndex: self.selectRelationshipwithCustomerIndex)
        }
        
        txtOccuooFundProvider_IncomeDetail2.setTitlePlaceholder(text_: Localize(key: "Occupation of Fund Provider"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtOccuooFundProvider_IncomeDetail2.didTappedDropDown = { (sender) in
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .occupation_of_fund_provider_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Occupation of Fund Provider"),
                                    dropDownType: "occupation_of_funds_provider",
                                    arrList: list,
                                    selectedIndex: self.selectOccupation_of_funds_providerIndex)
        }
        
        txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.setTitlePlaceholder(text_: Localize(key: "Monthly income range of fund provider"), placeholder_: Localize(key: "monthly_income_range_of_fund_provider_hint"), isUserInteraction: true, allowToChangeActiveColor: false)
        txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.delegate_FloatingTextFieldWithCode_Protocol = self
        txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType.keyboardType = .decimalPad
        txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.lblCode.text = Localize(key: "default_currency_code")
        
        //--
        txtOtherIncomeSource.setTitlePlaceholder(text_: Localize(key: "Do you have other income source?"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtOtherIncomeSource.didTappedDropDown = { (sender) in
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .have_other_source_of_income_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Other_Income_Source"),
                                    dropDownType: "other_income_source",
                                    arrList: list,
                                    selectedIndex: self.selectOther_Income_SourceIndex)
        }
        
        txtSpecifyOtherIncomeSource.setTitlePlaceholder(text_: Localize(key: "Please Specify"), placeholder_: Localize(key: "Enter other income source"), isUserInteraction: true)
        txtSpecifyOtherIncomeSource.isHidden = true
        txtSpecifyOtherIncomeSource.delegate_UIFloatingTextField_Protocol = self
        
        //Monthly Transactions
        txtExpectedNoofMonthlyCreditTrans.setTitlePlaceholder(text_: Localize(key: "Expected_Monthly_credit_transactions"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtExpectedNoofMonthlyCreditTrans.didTappedDropDown = { (sender) in
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .expected_no_of_credit_trans_c)
            self.openDropDownPicker(headerTitle: Localize(key: "select_exp_credit_tran"),
                                    dropDownType: "monthly_transactions",
                                    arrList: list,
                                    selectedIndex: self.selectMonthly_credit_transactionsIndex)
        }
        
        txtExpectedCreditAmount.setTitlePlaceholder(text_: Localize(key: "Expected Credit Amount"), placeholder_: Localize(key: "enter_exp_credit_amt"), isUserInteraction: true, allowToChangeActiveColor: false)
        txtExpectedCreditAmount.delegate_FloatingTextFieldWithCode_Protocol = self
        txtExpectedCreditAmount.txtType.keyboardType = .decimalPad
        txtExpectedCreditAmount.lblCode.text = Localize(key: "default_currency_code")
        
        txtExpectedNoofMonthlyDebitTrans.setTitlePlaceholder(text_: Localize(key: "Expected No of Monthly debit transactions"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtExpectedNoofMonthlyDebitTrans.didTappedDropDown = { (sender) in
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .expected_no_of_debit_trans_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Monthly_Debit_Transactions"),
                                    dropDownType: "monthly_debit_transactions",
                                    arrList: list,
                                    selectedIndex: self.selectMonthly_debit_transactionsIndex)
        }
        
        txtExpectedDebitAmount.setTitlePlaceholder(text_: Localize(key: "Expected Debit Amount"), placeholder_: Localize(key: "enter_exp_debit_amt"), isUserInteraction: true, allowToChangeActiveColor: false)
        txtExpectedDebitAmount.delegate_FloatingTextFieldWithCode_Protocol = self
        txtExpectedDebitAmount.txtType.keyboardType = .decimalPad
        txtExpectedDebitAmount.lblCode.text = Localize(key: "default_currency_code")
        
        txtOtherusualModetransaction.setTitlePlaceholder(text_: Localize(key: "Mention other mode of transaction"), placeholder_: Localize(key: "Mention other mode of transaction"), isUserInteraction: true)
        txtOtherusualModetransaction.delegate_UIFloatingTextField_Protocol = self
        
        txtNameofBusiness.setTitlePlaceholder(text_: Localize(key: "Name of Business"), placeholder_: Localize(key: "Name of Business"), isUserInteraction: true)
        txtNameofBusiness.delegate_UIFloatingTextField_Protocol = self
        
        txtPercentageofOwnship.setTitlePlaceholder(text_: Localize(key: "Percentage of ownership"), placeholder_: Localize(key: "Select"), isUserInteraction: true, type: .dropDown, btnDropDownHide: false)
        txtPercentageofOwnship.didTappedDropDown = { (sender) in
            let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .percentage_of_ownership_c)
            self.openDropDownPicker(headerTitle: Localize(key: "Percentage of ownership"),
                                    dropDownType: "percentage_of_ownership",
                                    arrList: list,
                                    selectedIndex: self.selectPercentage_of_ownershipIndex)
        }
        
        txtMonthlyIncome.setTitlePlaceholder(text_: Localize(key: "Monthly Income"), placeholder_: Localize(key: "monthly_income_hint"), isUserInteraction: true)
        txtMonthlyIncome.delegate_UIFloatingTextField_Protocol = self
        txtMonthlyIncome.txtType.keyboardType = .numberPad
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
        vc.selectIndex = 1
        vc.totalStep = 3
        vc.progress = 0.66
        vc.arrListOfDropDown = [Localize(key: "Personal Information"), Localize(key: "Financial Information"), Localize(key: "Regularity Declaration")]
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnNext(_ sender: Any) {
        self.view.endEditing(true)
        //if validateEnput(){
        isSelectUploadDoc_IncomeDetailEmployed ? apiCall_UploadDoc_IncomeDetailEmployed() : apiCall_updateApplication()
        //}
    }
    @IBAction func btnUploadDoc_IncomeDetailEmployed(_ sender: Any) {
        //--
        let vc = CustomCameraVC(nibName: "CustomCameraVC", bundle: bundleIdentifireGlob)
        vc.headerTitle = Localize(key: "Proof_Employment_letter_msg")
        vc.delegate_didTakeCustomPhoto = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.avCaptureDevicePosition = .back
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnViewTakePhotoHoldingId(_ sender: Any) {
        if let img_ = imgUploadDoc_IncomeDetailEmployed.image{
            setupLightBoxImageArray(imgOpen: img_, msg: "")
        }
    }
    
}
extension FinancialInfoVC: didTakeCustomPhoto_protocol{
    func didTakeCustomPhoto_protocol(image_: UIImage) {
        isSelectUploadDoc_IncomeDetailEmployed = true
        imgUploadDoc_IncomeDetailEmployed.image = image_
        
        selectTakePhotoHolding()
    }
    
    func selectTakePhotoHolding(){
        btnViewTakePhotoHoldingId.isHidden = false
        imgViewTakePhoto.isHidden = false
        icUploadDocDone_IncomeDetailEmployed.image = .IMGDoneGreen
        lblUploadDocDetail_IncomeDetailEmployed.text = "Proof Of Employment.png"
        lblUploadDocDetail_IncomeDetailEmployed.isHidden = false
        lblUploadDocSize_IncomeDetailEmployed.isHidden = false
        let size = Float(imgUploadDoc_IncomeDetailEmployed.image?.getSizeIn(.kilobyte) ?? "0.0") ?? 0.0
        lblUploadDocSize_IncomeDetailEmployed.text = "\(String(format: "%.0f", size))\(Localize(key: "kb"))"
    }
    func hideTakePhotoHolding(){
        btnViewTakePhotoHoldingId.isHidden = true
        imgViewTakePhoto.isHidden = true
        
        lblUploadDocDetail_IncomeDetailEmployed.text = ""
        lblUploadDocDetail_IncomeDetailEmployed.isHidden = true
        lblUploadDocSize_IncomeDetailEmployed.text = ""
        lblUploadDocSize_IncomeDetailEmployed.isHidden = true
    }
    
}
extension FinancialInfoVC: didSelectCustomDropDown_Protocol{
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String) {
        if droDownType == "SourceoffundNameofprovider"{
            txtSourceofFund_IncomeDetail2.txtType.text = ""
            txtSourceofFund_IncomeDetail2.txtType.insertText(title)
            selectSourceofFunds_IncomeDetail2 = index
            txtSourceofFund_IncomeDetail2.lblError.isHidden = true
            txtSourceofFund_IncomeDetail2.iconFill.isHidden = false
        }
        if droDownType == "relationshipwithcust"{
            txtRelationshipwithCust_IncomeDetail2.txtType.text = ""
            txtRelationshipwithCust_IncomeDetail2.txtType.insertText(title)
            selectRelationshipwithCustomerIndex = index
            txtRelationshipwithCust_IncomeDetail2.lblError.isHidden = true
            txtRelationshipwithCust_IncomeDetail2.iconFill.isHidden = false
        }
        if droDownType == "occupation_of_funds_provider"{
            txtOccuooFundProvider_IncomeDetail2.txtType.text = ""
            txtOccuooFundProvider_IncomeDetail2.txtType.insertText(title)
            selectOccupation_of_funds_providerIndex = index
            txtOccuooFundProvider_IncomeDetail2.lblError.isHidden = true
            txtOccuooFundProvider_IncomeDetail2.iconFill.isHidden = false
        }
        if droDownType == "other_income_source"{
            txtOtherIncomeSource.txtType.text = ""
            txtOtherIncomeSource.txtType.insertText(title)
            selectOther_Income_SourceIndex = index
            txtOtherIncomeSource.lblError.isHidden = true
            txtOtherIncomeSource.iconFill.isHidden = false
            
            let have_other_source_of_income_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .have_other_source_of_income_c, index: selectOther_Income_SourceIndex)
            if have_other_source_of_income_c == "Yes"{
                txtSpecifyOtherIncomeSource.isHidden = false
                txtSpecifyOtherIncomeSource.txtType.text = ""
                txtSpecifyOtherIncomeSource.txtType.insertText("")
            }else{
                txtSpecifyOtherIncomeSource.isHidden = true
                txtSpecifyOtherIncomeSource.txtType.text = ""
                txtSpecifyOtherIncomeSource.txtType.insertText("")
            }
        }
        if droDownType == "monthly_transactions"{
            txtExpectedNoofMonthlyCreditTrans.txtType.text = ""
            txtExpectedNoofMonthlyCreditTrans.txtType.insertText(title)
            selectMonthly_credit_transactionsIndex = index
            txtExpectedNoofMonthlyCreditTrans.lblError.isHidden = true
            txtExpectedNoofMonthlyCreditTrans.iconFill.isHidden = false
        }
        if droDownType == "monthly_debit_transactions"{
            txtExpectedNoofMonthlyDebitTrans.txtType.text = ""
            txtExpectedNoofMonthlyDebitTrans.txtType.insertText(title)
            selectMonthly_debit_transactionsIndex = index
            txtExpectedNoofMonthlyDebitTrans.lblError.isHidden = true
            txtExpectedNoofMonthlyDebitTrans.iconFill.isHidden = false
        }
        if droDownType == "percentage_of_ownership"{
            txtPercentageofOwnship.txtType.text = ""
            txtPercentageofOwnship.txtType.insertText(title)
            selectPercentage_of_ownershipIndex = index
            txtPercentageofOwnship.lblError.isHidden = true
            txtPercentageofOwnship.iconFill.isHidden = false
        }
        
        validateEnput()
    }
}

extension FinancialInfoVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUsualModeofTransaction.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsualModeTblCell", for: indexPath) as! UsualModeTblCell
        cell.selectionStyle = .none
        
        cell.lblTitle.text = arrUsualModeofTransaction[indexPath.row]
        
        let selectBackendValue = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .usual_mode_of_transactions_c, index: indexPath.row)

        if selectUsualModeofTransactionArr.contains(selectBackendValue){
            cell.imgCheckBox.image = .IMGCheckGreen
            cell.lblTitle.textColor = .DARKGREY
        }else{
            cell.imgCheckBox.image = .IMGUnCheckGray
            cell.lblTitle.textColor = .MIDGREY
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectBackendValue = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .usual_mode_of_transactions_c, index: indexPath.row)
        
        if selectUsualModeofTransactionArr.contains(selectBackendValue){
            var index = 0
            selectUsualModeofTransactionArr.forEach { obj in
                if  obj == selectBackendValue{
                    selectUsualModeofTransactionArr.remove(at: index)
                }
                index = index + 1
            }
        }else{
            selectUsualModeofTransactionArr.append(selectBackendValue)
        }
        tblUsualModeOfTransaction.reloadData()
        
        if selectUsualModeofTransactionArr.contains("8"){
            showOtherModeofTransaction(clearText: true)
        }else{
            hideOtherModeofTransaction(clearText: true)
        }
    }
    
    func hideOtherModeofTransaction(clearText:Bool){
        txtOtherUsualModeofTransaction_height.constant = 0
        txtOtherusualModetransaction.isHidden = true
        if clearText{
            txtOtherusualModetransaction.txtType.text = ""
        }
        
        validateEnput()
    }
    func showOtherModeofTransaction(clearText:Bool){
        txtOtherUsualModeofTransaction_height.constant = 81
        txtOtherusualModetransaction.isHidden = false
        if clearText{
            txtOtherusualModetransaction.txtType.text = ""
        }
        
        validateEnput()
    }
}

extension FinancialInfoVC: UIScrollViewDelegate{
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

extension FinancialInfoVC: didSelectSourceofFunds_protocol{
    func didSelectSourceofFunds(text: String, otherEnterText: String, index: Int) {
        //Employed
        txtSourceofFunds_IncomeDetailEmployed.txtType.text = ""
        txtSourceofFunds_IncomeDetailEmployed.txtType.insertText(text) //.count == 0 ? otherEnterText : text
        selectSourceofFunds_IncomeDetailEmployedIndex = index
        otherTextSourceofFund_IncomeDetailEmployed = otherEnterText
     
        validateEnput()
    }
    
}

extension FinancialInfoVC: FloatingTextFieldWithCode_Protocol{
    func btnOpenCountryCodePicker(textField: UITextField) {
        
    }
    
    func shouldChangeCharactersIn(textField: UITextField, txt: String) -> Bool {
        if AppHelper.allowSomeDigitOnly(txt: txt) == false{
            return false
        }
        if txtSalaryIncome_IncomeDetailEmployed.txtType == textField{
            txtSalaryIncome_IncomeDetailEmployed.txtType.delegate = moneyInputController
        }
        if txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType == textField{
            txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType.delegate = moneyInputController
        }
        if txtExpectedCreditAmount.txtType == textField{
            txtExpectedCreditAmount.txtType.delegate = moneyInputController
        }
        if txtExpectedDebitAmount.txtType == textField{
            txtExpectedDebitAmount.txtType.delegate = moneyInputController
        }
        
        validateErrorMsgTextField(textField: textField)
        
        return true
    }
    
    func editingChanged(textField: UITextField) {
        validateErrorMsgTextField(textField: textField)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    
}
extension FinancialInfoVC: UIFloatingTextField_Protocol{
//    @objc func textViewDidChange(_ notif: Notification) {
//        if let txtObj = notif.object as? UITextView{
//
//            /*let newString = txtObj.text.replacingOccurrences(of: ",", with: "")
//            if let valueF = Float(newString){
//                let result =  moneyFormatter.format(NSNumber(value: valueF)) ?? ""
//                if txtSalaryIncome_IncomeDetailEmployed.txtType == txtObj{
//                    txtSalaryIncome_IncomeDetailEmployed.txtType.text = "\(result)"
//                }
//                if txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType == txtObj{
//                    txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType.text = "\(result)"
//                }
//                if txtExpectedCreditAmount.txtType == txtObj{
//                    txtExpectedCreditAmount.txtType.text = "\(result)"
//                }
//                if txtExpectedDebitAmount.txtType == txtObj{
//                    txtExpectedDebitAmount.txtType.text = "\(result)"
//                }
//            }*/
//            validateErrorMsg(textField: txtObj)
//        }
//    }
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
        self.view.endEditing(true)
        if textField == txtSalaryIncome_IncomeDetailEmployed.txtType{
            /*CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), countrypicketType: .currency, headerTitle: Localize(key: "Salary Income"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                self.txtSalaryIncome_IncomeDetailEmployed.lblCode.text = countryCode
                let filter = countryListLocal.filter { countryData in countryData.currency == countryCode }
                self.txtSalaryIncome_IncomeDetailEmployed.imgFlag.image = UIImage(named: filter.first?.countryCode ?? "OMN")
            }*/
        }
        if textField == txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType{
            /*CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), countrypicketType: .currency, headerTitle: Localize(key: "Monthly income range of fund provider"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                self.txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.lblCode.text = countryCode
                let filter = countryListLocal.filter { countryData in countryData.currency == countryCode }
                self.txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.imgFlag.image = UIImage(named: filter.first?.countryCode ?? "OMN")
            }*/
        }
        if textField == txtExpectedCreditAmount.txtType{
            /*CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), countrypicketType: .currency, headerTitle: Localize(key: "Expected Credit Amount"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                self.txtExpectedCreditAmount.lblCode.text = countryCode
                let filter = countryListLocal.filter { countryData in countryData.currency == countryCode }
                self.txtExpectedCreditAmount.imgFlag.image = UIImage(named: filter.first?.countryCode ?? "OMN")
            }*/
        }
        if textField == txtExpectedDebitAmount.txtType{
            /*CountryCodePickerVC.presentCountroller(on: self, list: ManageDropDownOption.getDropDownValues(dropdown_filed: .country_of_birth_c), countrypicketType: .currency, headerTitle: Localize(key: "Expected Debit Amount"))
            CountryCodePickerVC.shared.didSelectCountry = { [self] (countryName, countryCode, selectIndex) in
                print(countryName)
                self.txtExpectedDebitAmount.lblCode.text = countryCode
                let filter = countryListLocal.filter { countryData in countryData.currency == countryCode }
                self.txtExpectedDebitAmount.imgFlag.image = UIImage(named: filter.first?.countryCode ?? "OMN")
            }*/
        }
    }
    func editingChanged(textField: UITextView) {
        validateErrorMsg(textField: textField)
    }
    
   
    
    //Validation
    func validateErrorMsgTextField(textField: UITextField){
        //--Employe Detail
        if txtSalaryIncome_IncomeDetailEmployed.txtType == textField{
            txtSalaryIncome_IncomeDetailEmployed.lblError.isHidden = AppHelper.isNull(txtSalaryIncome_IncomeDetailEmployed.txtType.text!) == false ? true : false
        }
        
        //--Employe Income Detail 2
        if txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType == textField{
            txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.lblError.isHidden = AppHelper.isNull(txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType.text!) == false ? true : false
        }
        
        if txtExpectedCreditAmount.txtType == textField{
            txtExpectedCreditAmount.lblError.isHidden = AppHelper.isNull(txtExpectedCreditAmount.txtType.text!) == false ? true : false
        }
        if txtExpectedDebitAmount.txtType == textField{
            txtExpectedDebitAmount.lblError.isHidden = AppHelper.isNull(txtExpectedDebitAmount.txtType.text!) == false ? true : false
        }
        validateEnput()
    }
    func validateErrorMsg(textField: UITextView,txt: String? = ""){
        let txtValue = textField.text == "" ? txt : textField.text!
        
        //--Employe Detail
//        if txtSalaryIncome_IncomeDetailEmployed.txtType == textField{
//            txtSalaryIncome_IncomeDetailEmployed.lblError.isHidden = AppHelper.isNull(txtSalaryIncome_IncomeDetailEmployed.txtType.text!) == false ? true : false
//        }
        if txtSourceofFunds_IncomeDetailEmployed.txtType == textField{
            txtSourceofFunds_IncomeDetailEmployed.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtSourceofFunds_IncomeDetailEmployed.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        //--Employe Income Detail 2
        if txtSourceofFund_IncomeDetail2.txtType == textField{
            txtSourceofFund_IncomeDetail2.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtSourceofFund_IncomeDetail2.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtRelationshipwithCust_IncomeDetail2.txtType == textField{
            txtRelationshipwithCust_IncomeDetail2.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtRelationshipwithCust_IncomeDetail2.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtOccuooFundProvider_IncomeDetail2.txtType == textField{
            txtOccuooFundProvider_IncomeDetail2.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtOccuooFundProvider_IncomeDetail2.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
//        if txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType == textField{
//            txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.lblError.isHidden = AppHelper.isNull(txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType.text!) == false ? true : false
//        }
        
        //--
        if txtOtherIncomeSource.txtType == textField{
            txtOtherIncomeSource.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtOtherIncomeSource.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        let have_other_source_of_income_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .have_other_source_of_income_c, index: selectOther_Income_SourceIndex)
        if have_other_source_of_income_c == "Yes"{
            if txtSpecifyOtherIncomeSource.txtType == textField{
                txtSpecifyOtherIncomeSource.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
                txtSpecifyOtherIncomeSource.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
            }
        }
        
        //--Monthly Transactions
        if txtExpectedNoofMonthlyCreditTrans.txtType == textField{
            txtExpectedNoofMonthlyCreditTrans.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtExpectedNoofMonthlyCreditTrans.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
//        if txtExpectedCreditAmount.txtType == textField{
//            txtExpectedCreditAmount.lblError.isHidden = AppHelper.isNull(txtExpectedCreditAmount.txtType.text!) == false ? true : false
//        }
        if txtExpectedNoofMonthlyDebitTrans.txtType == textField{
            txtExpectedNoofMonthlyDebitTrans.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtExpectedNoofMonthlyDebitTrans.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
//        if txtExpectedDebitAmount.txtType == textField{
//            txtExpectedDebitAmount.lblError.isHidden = AppHelper.isNull(txtExpectedDebitAmount.txtType.text!) == false ? true : false
//        }
        
        //Show Business Detail
        if txtNameofBusiness.txtType == textField{
            txtNameofBusiness.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtNameofBusiness.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtPercentageofOwnship.txtType == textField{
            txtPercentageofOwnship.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPercentageofOwnship.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        if txtMonthlyIncome.txtType == textField{
            txtMonthlyIncome.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtMonthlyIncome.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true
        }
        
        //--
        validateEnput()
    }
    func validateEnput() {
        var returnValue = true
        //--
        let employment_status_c = resultGetApplicationDataResult?.employment_status_c as? String ?? ""
        if employment_status_c == "1"{
            //Employed
            //--Employe Detail
            if AppHelper.isNull(txtSalaryIncome_IncomeDetailEmployed.txtType.text!){
                //txtSalaryIncome_IncomeDetailEmployed.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtSourceofFunds_IncomeDetailEmployed.txtType.text!){
                //txtSourceofFunds_IncomeDetailEmployed.lblError.isHidden = false
                returnValue = false
            }
            
        }else if employment_status_c == "6_6" || employment_status_c == "4" || employment_status_c == "6_7"{
            //Investor, "Self-Employed", Business man
            
            //Show Business Detail
            if AppHelper.isNull(txtNameofBusiness.txtType.text!){
                //txtNameofBusiness.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtPercentageofOwnship.txtType.text!){
                //txtPercentageofOwnship.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtMonthlyIncome.txtType.text!){
                //txtMonthlyIncome.lblError.isHidden = false
                returnValue = false
            }
            
        }else{
            //Housewife, Student, Minor, or Un-Employed
            //--Employe Income Detail 2
            if AppHelper.isNull(txtSourceofFund_IncomeDetail2.txtType.text!){
                //txtSourceofFund_IncomeDetail2.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtRelationshipwithCust_IncomeDetail2.txtType.text!){
                //txtRelationshipwithCust_IncomeDetail2.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtOccuooFundProvider_IncomeDetail2.txtType.text!){
                //txtOccuooFundProvider_IncomeDetail2.lblError.isHidden = false
                returnValue = false
            }
            if AppHelper.isNull(txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType.text!){
                //txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.lblError.isHidden = false
                returnValue = false
            }
        }
        
        //--
        if AppHelper.isNull(txtOtherIncomeSource.txtType.text!){
            //txtOtherIncomeSource.lblError.isHidden = false
            returnValue = false
        }
        let have_other_source_of_income_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .have_other_source_of_income_c, index: selectOther_Income_SourceIndex)
        if have_other_source_of_income_c == "Yes"{
            if AppHelper.isNull(txtSpecifyOtherIncomeSource.txtType.text!){
                //txtSpecifyOtherIncomeSource.lblError.isHidden = false
                returnValue = false
            }
        }
        
        //--Monthly Transactions
        if AppHelper.isNull(txtExpectedNoofMonthlyCreditTrans.txtType.text!){
            //txtExpectedNoofMonthlyCreditTrans.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtExpectedCreditAmount.txtType.text!){
            //txtExpectedCreditAmount.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtExpectedNoofMonthlyDebitTrans.txtType.text!){
            //txtExpectedNoofMonthlyDebitTrans.lblError.isHidden = false
            returnValue = false
        }
        if AppHelper.isNull(txtExpectedDebitAmount.txtType.text!){
            //txtExpectedDebitAmount.lblError.isHidden = false
            returnValue = false
        }
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewbgbtnNext)
        }else{
            AppHelper.disableNextBTN(view_: viewbgbtnNext)
        }
        
        //return returnValue
    }
    
}

//MARK: - Api Call
extension FinancialInfoVC{
    
    func setFormData(result: GetApplicationDataResult){
        resultGetApplicationDataResult = result
        
        let expected_no_of_credit_trans_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .expected_no_of_credit_trans_c, backendvalue: result.expected_no_of_credit_trans_c as? String ?? "")
        if expected_no_of_credit_trans_c.0.count != 0{
            //--Employed
            if let salary_income_c = result.salary_income_c as? Float, salary_income_c > 0{
                //let salary_income_flagcode_c = result.salary_income_flagcode_c as? String ?? ""
                //let filter = countryListLocal.filter { countryData in countryData.currency == salary_income_flagcode_c }
                //txtSalaryIncome_IncomeDetailEmployed.imgFlag.image = UIImage(named: filter.first?.countryCode ?? "OMN")
                //txtSalaryIncome_IncomeDetailEmployed.lblCode.text = result.salary_income_flagcode_c as? String ?? ""
                let result = moneyFormatter.format(NSNumber(value: salary_income_c))
                txtSalaryIncome_IncomeDetailEmployed.txtType.text = result
            }
            
            let sources_of_fund_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .sources_of_fund_c, backendvalue: result.sources_of_fund_c as? String ?? "")
            txtSourceofFunds_IncomeDetailEmployed.txtType.text = ""
            txtSourceofFunds_IncomeDetailEmployed.txtType.insertText(sources_of_fund_c.0)
            selectSourceofFunds_IncomeDetailEmployedIndex = sources_of_fund_c.1
            otherTextSourceofFund_IncomeDetailEmployed = result.other_sources_of_funds_c as? String ?? ""
            txtSourceofFunds_IncomeDetailEmployed.iconFill.isHidden = AppHelper.isNull(txtSourceofFunds_IncomeDetailEmployed.txtType.text!) == false ? false : true

            //--
            let name_of_fund_provider_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .name_of_fund_provider_c, backendvalue: result.name_of_fund_provider_c as? String ?? "")
            txtSourceofFund_IncomeDetail2.txtType.text = ""
            txtSourceofFund_IncomeDetail2.txtType.insertText(name_of_fund_provider_c.0)
            selectSourceofFunds_IncomeDetail2 = name_of_fund_provider_c.1
            txtSourceofFund_IncomeDetail2.iconFill.isHidden = AppHelper.isNull(txtSourceofFund_IncomeDetail2.txtType.text!) == false ? false : true

            let relation_with_funds_provider_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .relation_with_funds_provider_c, backendvalue: result.relation_with_funds_provider_c as? String ?? "")
            txtRelationshipwithCust_IncomeDetail2.txtType.text = ""
            txtRelationshipwithCust_IncomeDetail2.txtType.insertText(relation_with_funds_provider_c.0)
            selectRelationshipwithCustomerIndex = relation_with_funds_provider_c.1
            txtRelationshipwithCust_IncomeDetail2.iconFill.isHidden = AppHelper.isNull(txtRelationshipwithCust_IncomeDetail2.txtType.text!) == false ? false : true

            let occupation_of_fund_provider_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .occupation_of_fund_provider_c, backendvalue: result.occupation_of_fund_provider_c as? String ?? "")
            txtOccuooFundProvider_IncomeDetail2.txtType.text = ""
            txtOccuooFundProvider_IncomeDetail2.txtType.insertText(occupation_of_fund_provider_c.0)
            selectOccupation_of_funds_providerIndex = occupation_of_fund_provider_c.1
            txtOccuooFundProvider_IncomeDetail2.iconFill.isHidden = AppHelper.isNull(txtOccuooFundProvider_IncomeDetail2.txtType.text!) == false ? false : true

            if let monthly_income_range_c = Float("\(result.monthly_income_range_c as? String ?? "")"), monthly_income_range_c > 0{
                //let monthly_incomerange_flagcode_c = result.monthly_incomerange_flagcode_c as? String ?? ""
                //let filter = countryListLocal.filter { countryData in countryData.currency == monthly_incomerange_flagcode_c }
                //txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.imgFlag.image = UIImage(named: filter.first?.countryCode ?? "OMN")
                //txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.lblCode.text = result.monthly_incomerange_flagcode_c as? String ?? ""
                
                let result = moneyFormatter.format(NSNumber(value: monthly_income_range_c))
                txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType.text = result
            }
            
            //--
            let have_other_source_of_income_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .have_other_source_of_income_c, backendvalue: result.have_other_source_of_income_c as? String ?? "")
            txtOtherIncomeSource.txtType.text = ""
            txtOtherIncomeSource.txtType.insertText(have_other_source_of_income_c.0)
            selectOther_Income_SourceIndex = have_other_source_of_income_c.1
            txtOtherIncomeSource.iconFill.isHidden = AppHelper.isNull(txtOtherIncomeSource.txtType.text!) == false ? false : true

            txtSpecifyOtherIncomeSource.txtType.text = ""
            txtSpecifyOtherIncomeSource.txtType.insertText(result.specify_source_of_income_c as? String ?? "")
            txtSpecifyOtherIncomeSource.iconFill.isHidden = AppHelper.isNull(txtSpecifyOtherIncomeSource.txtType.text!) == false ? false : true

            if (result.have_other_source_of_income_c as? String ?? "") == "Yes"{
                txtSpecifyOtherIncomeSource.isHidden = false
            }else{
                txtSpecifyOtherIncomeSource.isHidden = true
            }
            
            //--
            txtExpectedNoofMonthlyCreditTrans.txtType.text = ""
            txtExpectedNoofMonthlyCreditTrans.txtType.insertText(expected_no_of_credit_trans_c.0)
            selectMonthly_credit_transactionsIndex = expected_no_of_credit_trans_c.1
            txtExpectedNoofMonthlyCreditTrans.iconFill.isHidden = AppHelper.isNull(txtExpectedNoofMonthlyCreditTrans.txtType.text!) == false ? false : true

            if let expected_credit_amount_omr_c = Float("\(result.expected_credit_amount_omr_c as? String ?? "")"), expected_credit_amount_omr_c > 0{
                //let expected_creditamt_flagcode_c = result.expected_creditamt_flagcode_c as? String ?? ""
                //let filter = countryListLocal.filter { countryData in countryData.currency == expected_creditamt_flagcode_c }
                //txtExpectedCreditAmount.imgFlag.image = UIImage(named: filter.first?.countryCode ?? "OMN")
                //txtExpectedCreditAmount.lblCode.text = result.expected_creditamt_flagcode_c as? String ?? ""
                let result = moneyFormatter.format(NSNumber(value: expected_credit_amount_omr_c))
                txtExpectedCreditAmount.txtType.text = result
            }
            
            let expected_no_of_debit_trans_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .expected_no_of_debit_trans_c, backendvalue: result.expected_no_of_debit_trans_c as? String ?? "")
            txtExpectedNoofMonthlyDebitTrans.txtType.text = ""
            txtExpectedNoofMonthlyDebitTrans.txtType.insertText(expected_no_of_debit_trans_c.0)
            selectMonthly_debit_transactionsIndex = expected_no_of_debit_trans_c.1
            txtExpectedNoofMonthlyDebitTrans.iconFill.isHidden = AppHelper.isNull(txtExpectedNoofMonthlyDebitTrans.txtType.text!) == false ? false : true

            if let expected_debit_amount_omr_c = Float("\(result.expected_debit_amount_omr_c as? String ?? "")"), expected_debit_amount_omr_c > 0{
                //let expected_debitamt_flagcode_c = result.expected_debitamt_flagcode_c as? String ?? ""
                //let filter = countryListLocal.filter { countryData in countryData.currency == expected_debitamt_flagcode_c }
                //txtExpectedDebitAmount.imgFlag.image = UIImage(named: filter.first?.countryCode ?? "OMN")
                //txtExpectedDebitAmount.lblCode.text = result.expected_debitamt_flagcode_c as? String ?? ""
                let result = moneyFormatter.format(NSNumber(value: expected_debit_amount_omr_c))
                txtExpectedDebitAmount.txtType.text = result
            }
            
            let usual_mode_of_transactions_c = (result.usual_mode_of_transactions_c as? String ?? "").components(separatedBy: ",")
            usual_mode_of_transactions_c.forEach { selectIndex in
                selectUsualModeofTransactionArr.append(selectIndex)
            }
            tblUsualModeOfTransaction.reloadData()
            
            txtOtherusualModetransaction.txtType.text = ""
            txtOtherusualModetransaction.txtType.insertText(result.other_mode_of_transaction_c as? String ?? "")
           
            
            //--
            let percentage_of_ownership_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .percentage_of_ownership_c, backendvalue: result.percentage_of_ownership_c as? String ?? "")
            txtPercentageofOwnship.txtType.text = ""
            txtPercentageofOwnship.txtType.insertText(percentage_of_ownership_c.0)
            selectPercentage_of_ownershipIndex = percentage_of_ownership_c.1
            txtPercentageofOwnship.iconFill.isHidden = AppHelper.isNull(txtPercentageofOwnship.txtType.text!) == false ? false : true

            if let monthly_income_c = Float("\(result.monthly_income_c as? String ?? "")"), monthly_income_c > 0{
                txtMonthlyIncome.txtType.text = ""
                txtMonthlyIncome.txtType.insertText(String(format: "%.0f", monthly_income_c))
                txtMonthlyIncome.iconFill.isHidden = AppHelper.isNull(txtMonthlyIncome.txtType.text!) == false ? false : true

            }
        }
        
        //Set Other Usal Mode of Transaction
        if selectUsualModeofTransactionArr.contains("8"){
            showOtherModeofTransaction(clearText: false)
        }else{
            hideOtherModeofTransaction(clearText: false)
        }
        
        //--
        txtNameofBusiness.txtType.text = ""
        txtNameofBusiness.txtType.insertText(result.name_of_business_c as? String ?? "")
        txtNameofBusiness.iconFill.isHidden = AppHelper.isNull(txtNameofBusiness.txtType.text!) == false ? false : true
        
        //--
        validateEnput()
        
        //--
        getDocumentsList()
    }
    
    func getDocumentsList(){
        //LoadingView.shared.openLodingAlert(view: self.view)
        apiCall_getDocumentsList (showProgress: false){ [self] docResult in
            //LoadingView.shared.dismissLoadingView()
            docResult.documents.forEach { getDocumentsListDocuments in
                if getDocumentsListDocuments.document_type == docTypeBackendValue(value: docType.employment_letter.rawValue) &&
                    getDocumentsListDocuments.card_type == viewType.getValue(.other)(){
                    let document_link = getDocumentsListDocuments.document_link
                    if let url = URL(string: document_link){
                        isSelectUploadDoc_IncomeDetailEmployed = true
                        imgUploadDoc_IncomeDetailEmployed.af.setImage(withURL: url, completion:  { image_ in
                            self.selectTakePhotoHolding()
                        })
                        icUploadDocDone_IncomeDetailEmployed.image = .IMGDoneGreen
                        selectTakePhotoHolding()
                    }
                }
            }
        }
    }
    
    func apiCall_UploadDoc_IncomeDetailEmployed()  {
        //--
        let docBase64 = imgUploadDoc_IncomeDetailEmployed.image?.convertImageToBase64String()
        if docBase64?.count == 0{
            apiCall_updateApplication()
            return
        }
        let dicParam:[String:AnyObject] = ["operation":"documentValidation" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "doc_type":docType.employment_letter.getValue(),
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
                    apiCall_UploadDoc_IncomeDetailEmployed()
                }
            }
        }
    }
    func apiCall_updateApplication()  {
        //--
        let sources_of_fund_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .sources_of_fund_c, index: selectSourceofFunds_IncomeDetailEmployedIndex)
        
        //--
        let name_of_fund_provider_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .name_of_fund_provider_c, index: selectSourceofFunds_IncomeDetail2)
        let relation_with_funds_provider_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .relation_with_funds_provider_c, index: selectRelationshipwithCustomerIndex)
        let occupation_of_fund_provider_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .occupation_of_fund_provider_c, index: selectOccupation_of_funds_providerIndex)
        
        //--
        let have_other_source_of_income_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .have_other_source_of_income_c, index: selectOther_Income_SourceIndex)
        let expected_no_of_credit_trans_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .expected_no_of_credit_trans_c, index: selectMonthly_credit_transactionsIndex)
        let expected_no_of_debit_trans_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .expected_no_of_debit_trans_c, index: selectMonthly_debit_transactionsIndex)
        let percentage_of_ownership_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .percentage_of_ownership_c, index: selectPercentage_of_ownershipIndex)
   
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.financialInfoScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": ["citizenship_c": citizenshipType.rawValue,
                                                                 //--Employe
                                                                 "salary_income_flagcode_c": "OMR",//txtSalaryIncome_IncomeDetailEmployed.lblCode.text!,
                                                                 "salary_income_c": txtSalaryIncome_IncomeDetailEmployed.txtType.text!,
                                                                 "sources_of_fund_c": sources_of_fund_c,
                                                                 "other_sources_of_funds_c": otherTextSourceofFund_IncomeDetailEmployed,
                                                                 //--Investor, Business man
                                                                 "name_of_fund_provider_c":name_of_fund_provider_c,
                                                                 "relation_with_funds_provider_c":relation_with_funds_provider_c,
                                                                 "occupation_of_fund_provider_c":occupation_of_fund_provider_c,
                                                                 "monthly_incomerange_flagcode_c": "OMR",//txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.lblCode.text!,
                                                                 "monthly_income_range_c":txtMonthlyIncomeRangeofFundProvider_IncomeDetail2.txtType.text!,
                                                                 //--
                                                                 "name_of_business_c":txtNameofBusiness.txtType.text!,
                                                                 "percentage_of_ownership_c":percentage_of_ownership_c,
                                                                 "monthly_income_c":txtMonthlyIncome.txtType.text!,
                                                                 //--
                                                                 "have_other_source_of_income_c": have_other_source_of_income_c,
                                                                 "specify_source_of_income_c": txtSpecifyOtherIncomeSource.txtType.text!,
                                                                 "expected_no_of_credit_trans_c": expected_no_of_credit_trans_c,
                                                                 "expected_creditamt_flagcode_c": "OMR",//txtExpectedCreditAmount.lblCode.text!,
                                                                 "expected_credit_amount_omr_c": txtExpectedCreditAmount.txtType.text!,
                                                                 "expected_no_of_debit_trans_c": expected_no_of_debit_trans_c,
                                                                 "expected_debitamt_flagcode_c": "OMR",//txtExpectedDebitAmount.lblCode.text!,
                                                                 "expected_debit_amount_omr_c": txtExpectedDebitAmount.txtType.text!,
                                                                 "usual_mode_of_transactions_c": selectUsualModeofTransactionArr.joined(separator: ","),
                                                                 "other_mode_of_transaction_c": txtOtherusualModetransaction.txtType.text!
                                                                 ]
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "200"{
                if oTPGenerationModel.Response?.Body?.status == "Success"{
                    //--
                    let vc = RegularityDeclVC(nibName: "RegularityDeclVC", bundle: bundleIdentifireGlob)
                    //vc.selectedEmploymentStatus = selectEmployementStatusIndex
                    self.navigationController?.pushViewController(vc, animated: false)
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


extension FinancialInfoVC: LightboxControllerDismissalDelegate, LightboxControllerPageDelegate{
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
