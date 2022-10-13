//
//  GCCNationalsCitizenshipDocVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 26/01/22.
//

import UIKit
//import Lightbox
//import MBDocCapture
//import Popover

class GCCNationalsCitizenshipDocVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblNationalId_title: UILabel!
    @IBOutlet weak var lblScanNationalD_done: UIImageView!
    @IBOutlet weak var lblScanNationalID: UILabel!
    @IBOutlet weak var lblPassport: UILabel!
    @IBOutlet weak var imgScanPassport_done: UIImageView!
    @IBOutlet weak var lblScanPassport: UILabel!
    @IBOutlet weak var viewbgbtnNext: UIView!
    @IBOutlet weak var lblbtnNext: UILabel!
    
    @IBOutlet var viewbgMain_ErrorAlert: UIView!
    @IBOutlet weak var viewbgInner_ErrorAlert: UIView!
    @IBOutlet weak var lblTitle_ErrorAlert: UILabel!
    @IBOutlet weak var lblDetail_ErrorAlert: UILabel!
    @IBOutlet weak var btnCancel_ErrorAlert: UIButton!
    @IBOutlet weak var btnContactBank_ErrorAlert: UIButton!
    
    @IBOutlet weak var viewbg_Scaned_nationlid: UIView!
    @IBOutlet weak var viewbg_Scaned_nationalid_height: NSLayoutConstraint!
    @IBOutlet weak var btnViewScannedImages_nationalid: UIButton!
    @IBOutlet weak var viewbg_front_nationalid: UIView!
    @IBOutlet weak var imgFront_NationalScaned: UIImageView!
    @IBOutlet weak var lblFront_nationId: UILabel!
    @IBOutlet weak var viewbg_back_nationalid: UIView!
    @IBOutlet weak var imgBack_NationalScaned: UIImageView!
    @IBOutlet weak var lblBack_nationIdScaned: UILabel!
    
    @IBOutlet weak var viewbg_Scaned_password: UIView!
    @IBOutlet weak var viewbg_firstpage_password: UIView!
    @IBOutlet weak var viewbg_Scaned_password_height: NSLayoutConstraint!
    @IBOutlet weak var btnViewScannedImages_password: UIButton!
    @IBOutlet weak var imgFirstPage_passwordScaned: UIImageView!
    @IBOutlet weak var lblFirstPage_passwordScaned: UILabel!
    
    
    //MARK: Veriable
    var screenNameEnum: ScreenNameEnum?
    var selectFrontNationalIdImg = false
    var selectBackNationalIdImg = false
    
    var selectPassportImg = false
    var scanedIDCount = 0
    
    var delegate_didTakeCustomPhoto: didTakeCustomPhoto_protocol?
    var popover = Popover()
    var scanPasswordData: ValidateOmniData?
    var scanBackDocData: ValidateOmniData?
    var uploadDocumentCancel = false
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        localization()
        setupBasic()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func setupHeader(){
         
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { [self] (sender) in
            if screenNameEnum == .reviewApplicationVC{
                //--
                let vc = ReviewApplicationVC(nibName: "ReviewApplicationVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: false)
            }else{
                //--
                let vc = SelectCitizenshipVC(nibName: "SelectCitizenshipVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblTitle.text = Localize(key: "GCC Nationals")
        lblDetail.text = Localize(key: "Please scan and upload the following documents")
        
        lblNationalId_title.text = Localize(key: "National ID")
        lblScanNationalID.text = Localize(key: "Scan National ID")
        lblPassport.text = Localize(key: "Passport")
        lblScanPassport.text = Localize(key: "Scan Passport")
        
        lblbtnNext.text = Localize(key: "NEXT")
        btnCancel_ErrorAlert.setTitle(Localize(key: "CANCEL"), for: .normal)
        btnContactBank_ErrorAlert.setTitle(Localize(key: "CONTACT BANK"), for: .normal)
        
        if Managelanguage.getLanguageCode() == "A"
        {
            btnViewScannedImages_nationalid.contentHorizontalAlignment = .right
            btnViewScannedImages_password.contentHorizontalAlignment = .right
         
        }
    }
    func setupBasic(){
        if applyValidation{
            AppHelper.disableNextBTN(view_: viewbgbtnNext)
        }
        hiddenScanedNationalID()
        hiddenScanedPassword()
        
        getDocumentsList()
    }
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
    func validateEnput(){
        if selectFrontNationalIdImg && selectBackNationalIdImg && selectPassportImg{
            AppHelper.enableNextBTN(view_: viewbgbtnNext)
        }else{
            AppHelper.disableNextBTN(view_: viewbgbtnNext)
        }
    }
    
    func hiddenScanedNationalID(){
        viewbg_Scaned_nationalid_height.constant = 0
        viewbg_Scaned_nationlid.isHidden = true
        btnViewScannedImages_nationalid.isHidden = true
    }
    func showScanedNationalID(){
        viewbg_Scaned_nationalid_height.constant = 30
        viewbg_Scaned_nationlid.isHidden = false
        btnViewScannedImages_nationalid.isHidden = false
        btnViewScannedImages_nationalid.setTitle(Localize(key: "VIEW_SCANNED_IMAGES"), for: .normal)
        viewbg_front_nationalid.isHidden = true
        viewbg_back_nationalid.isHidden = true
    }
    func hiddenFrontBackImg_ResidentID(){
        viewbg_front_nationalid.isHidden = true
        viewbg_back_nationalid.isHidden = true
        viewbg_Scaned_nationalid_height.constant = 30
        btnViewScannedImages_nationalid.setTitle(Localize(key: "VIEW_SCANNED_IMAGES"), for: .normal)
    }
    func showFrontBackImg_ResidentID(){
        viewbg_front_nationalid.isHidden = false
        viewbg_back_nationalid.isHidden = false
        viewbg_Scaned_nationalid_height.constant = 195
        btnViewScannedImages_nationalid.setTitle(Localize(key: "HIDE SCANNED IMAGES"), for: .normal)
    }
    
    func hiddenScanedPassword(){
        viewbg_Scaned_password_height.constant = 0
        viewbg_Scaned_password.isHidden = true
        btnViewScannedImages_password.isHidden = true
    }
    func showScanedPassword(){
        viewbg_Scaned_password_height.constant = 30
        viewbg_Scaned_password.isHidden = false
        btnViewScannedImages_password.isHidden = false
        btnViewScannedImages_password.setTitle(Localize(key: "VIEW_SCANNED_IMAGES"), for: .normal)
        viewbg_firstpage_password.isHidden = true
    }
    func hiddenFrontBackImg_Password(){
        viewbg_firstpage_password.isHidden = true
        viewbg_Scaned_password_height.constant = 30
        btnViewScannedImages_password.setTitle(Localize(key: "VIEW_SCANNED_IMAGES"), for: .normal)
    }
    func showFrontBackImg_Password(){
        viewbg_firstpage_password.isHidden = false
        viewbg_Scaned_password_height.constant = 195
        btnViewScannedImages_password.setTitle(Localize(key: "HIDE SCANNED IMAGES"), for: .normal)
    }
    
    //MARK: @IBAction
    @IBAction func btnSacnned_Front_national_ZOOM(_ sender: Any) {
        if let img_ = imgFront_NationalScaned.image{
            setupLightBoxImageArray(imgOpen: img_, msg: Localize(key: "National ID - Front"))
        }
    }
    @IBAction func btnSacnned_Back_national_ZOOM(_ sender: Any) {
        if let img_ = imgBack_NationalScaned.image{
            setupLightBoxImageArray(imgOpen: img_, msg: Localize(key: "National ID - Back"))
        }
    }
    @IBAction func btnSacnned_Passport_ZOOM(_ sender: Any) {
        if let img_ = imgFirstPage_passwordScaned.image{
            setupLightBoxImageArray(imgOpen: img_, msg: Localize(key: "Passport - First Page"))
        }
    }
    @IBAction func btnViewScannedImage_nationalid(_ sender: Any) {
        if viewbg_front_nationalid.isHidden{
            showFrontBackImg_ResidentID()
        }else{
            hiddenFrontBackImg_ResidentID()
        }
    }
    @IBAction func btnViewScannedImage_password(_ sender: Any) {
        if viewbg_firstpage_password.isHidden{
            showFrontBackImg_Password()
        }else{
            hiddenFrontBackImg_Password()
        }
    }
    
    @IBAction func btnCancel_ErrorAlert(_ sender: Any) {
        popover.dismiss()
        //openErrorAlert(title: "Sorry!", details: "We're not able to process your request right now. please contact our customer support.")
    }
    @IBAction func btnContactBank_ErrorAlert(_ sender: Any) {
        popover.dismiss()
        //--
        let vc = ContactUsVC(nibName: "ContactUsVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnScanNationalID(_ sender: Any) {
        scanedIDCount = 1
        scanIDCard(title: Localize(key: "Scan the front side of your National ID"))
    }
    @IBAction func btnScanPassport(_ sender: Any) {
        scanedIDCount = 3
        scanIDCard(title: Localize(key: "Scan the first page of your passport"))
    }
    @IBAction func btnNext(_ sender: Any) {
        //--
        apiCall_updateApplication()
    }
    
    func scanIDCard(title: String) {
        let controller = CardDetectionViewController()
        controller.delegate = self
        let lbl = UILabel(frame: CGRect(x: 0, y: 50, width: 320, height: 0))
        lbl.text = ""
        controller.view.addSubview(lbl)
        controller.lbltrmp.text = title
        self.present(controller, animated: true, completion: nil)
    }
    
    
}

extension GCCNationalsCitizenshipDocVC: CardDetectionViewControllerDelegate{
    func cardDetectionViewController(_ viewController: CardDetectionViewController, didDetectCard image: CGImage, withSettings settings: CardDetectionSettings) {
        // The card has been scanned
        // Display the image in the image view
        
        if scanedIDCount == 1{
            selectFrontNationalIdImg = true
            imgFront_NationalScaned.image = UIImage(cgImage: image)
            
            scanedIDCount = 2
            scanIDCard(title: Localize(key: "Scan the back side of your Resident ID"))
            
            validateEnput()
        }else if scanedIDCount == 2{
            scanedIDCount = 0
            
            selectBackNationalIdImg = true
            imgBack_NationalScaned.image = UIImage(cgImage: image)
            lblScanNationalD_done.image = UIImage(named: "ic_fill_correct_green", in: bundleIdentifireGlob, with: nil)
            
            validateEnput()
            showScanedNationalID()
        }else if scanedIDCount == 3{
            scanedIDCount = 0
            
            selectPassportImg = true
            imgFirstPage_passwordScaned.image = UIImage(cgImage: image)
            imgScanPassport_done.image = UIImage(named: "ic_fill_correct_green", in: bundleIdentifireGlob, with: nil)
            
            validateEnput()
            showScanedPassword()
        }
    }
}

//MARK:- Show Alerts
extension GCCNationalsCitizenshipDocVC{
    func openErrorAlert(title: String, details: String){
        //--
        lblTitle_ErrorAlert.text = title
        lblDetail_ErrorAlert.text = details
        
        //--
        popover = Popover()
        viewbgMain_ErrorAlert.frame.size = CGSize(width: UIScreen.main.bounds.width-30, height: viewbgInner_ErrorAlert.frame.height)
        let aView = UIView()
        aView.frame = viewbgMain_ErrorAlert.frame
        aView.addSubview(viewbgMain_ErrorAlert)
        popover.dismissOnBlackOverlayTap = true
        popover.blackOverlayColor = popoverBackgroundColor
        popover.showAsDialog(aView, inView: self.view)
    }
    func showAlertForInvalidDoc(details: String){
        //--
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = details
        alert.btnGotoApplication.isHidden = true
        alert.btnContinueApplication.setTitle(Localize(key: "CANCEL"), for: .normal)
        alert.didTappedContinueAPP = { [self] (sender) in
            self.popover.dismiss()
//            let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
//            self.navigationController?.pushViewController(vc, animated: false)
        }
        alert.btnCancel.setTitle(Localize(key: "RETRY"), for: .normal)
        alert.didTappedCancel = { (sender) in
            self.popover.dismiss()
            //--
            self.apiCall_updateApplication()
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
/*
 extension GCCNationalsCitizenshipDocVC: LoadingView_Protocol{
 func btnCancelLoding(){
 popover.dismiss()
 openErrorAlert(title: Localize(key: "Unfortunately your country is not supported"), details: "")
 }
 }
 */

//MARK: - Api Call
extension GCCNationalsCitizenshipDocVC{
    func getDocumentsList(){
        //LoadingView.shared.openLodingAlert(view: self.view)
        apiCall_getDocumentsList (showProgress: true){ [self] docResult in
            //LoadingView.shared.dismissLoadingView()
            
            docResult.documents.forEach { getDocumentsListDocuments in
                if getDocumentsListDocuments.document_type == docTypeBackendValue(value: docType.gcc.rawValue) &&
                    getDocumentsListDocuments.card_type == viewType.getValue(.front)(){
                    let document_link = getDocumentsListDocuments.document_link
                    if let url = URL(string: document_link){
                        selectFrontNationalIdImg = true
                        imgFront_NationalScaned.af.setImage(withURL: url)
                        
                        validateEnput()
                    }
                }
                if getDocumentsListDocuments.document_type == docTypeBackendValue(value: docType.gcc.rawValue) &&
                    getDocumentsListDocuments.card_type == viewType.getValue(.rear)(){
                    let document_link = getDocumentsListDocuments.document_link
                    if let url = URL(string: document_link){
                        selectBackNationalIdImg = true
                        imgBack_NationalScaned.af.setImage(withURL: url)
                        lblScanNationalD_done.image = UIImage(named: "ic_fill_correct_green", in: bundleIdentifireGlob, with: nil)
                        
                        validateEnput()
                        showScanedNationalID()
                    }
                }
                if getDocumentsListDocuments.document_type == docTypeBackendValue(value: docType.passport.rawValue) &&
                    getDocumentsListDocuments.card_type == viewType.getValue(.front)(){
                    let document_link = getDocumentsListDocuments.document_link
                    if let url = URL(string: document_link){
                        selectPassportImg = true
                        imgFirstPage_passwordScaned.af.setImage(withURL: url)
                        imgScanPassport_done.image = UIImage(named: "ic_fill_correct_green", in: bundleIdentifireGlob, with: nil)
                        
                        validateEnput()
                        showScanedPassword()
                    }
                }
        
            }
        }
    }
    
    func apiCall_updateApplication()  {
        LoadingView.shared.openLodingAlert(btnCancelHide: false, view: self.view)
        LoadingView.shared.didTappedCancelBtn = { (sender) in
            self.uploadDocumentCancel = true
            LoadingView.shared.dismissLoadingView()
        }
        
        
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.selectDocumentTypeScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": ["citizenship_c": CitizenshipType.gcc.rawValue,
                                                                 "application_status_c": ApplicationStatus.InProgress.rawValue,
                                                                 "id_type_c":"1",
                                                                 "account_type_c": AccountType.getBackendValue(accountType)(),
                                                                 "langpreference_c": Managelanguage.getLanguageCode()
                                                                ]
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { [self] (response) in
            print(response as Any)
            if uploadDocumentCancel == false{
                let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
                if oTPGenerationModel.Response?.Code == "200"{
                    if oTPGenerationModel.Response?.Body?.status == "Success"{
                        //--
                        apiCall_UploadNationalId(isFront: true)
                    }else{
                        LoadingView.shared.dismissLoadingView()
                        self.view.makeToast(oTPGenerationModel.Response?.Body?.statusMsg ?? "")
                    }
                }else{
                    LoadingView.shared.dismissLoadingView()
                    self.view.makeToast(oTPGenerationModel.message)
                }
            }
        }) { (error) in
            print(error)
            LoadingView.shared.dismissLoadingView()
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_updateApplication()
                }
            }
        }
    }
    func apiCall_UploadNationalId(isFront: Bool)  {
        //--
        //openLodingAlert()
        let docBase64 = isFront ? imgFront_NationalScaned.image?.convertImageToBase64String() : imgBack_NationalScaned.image?.convertImageToBase64String()
        let dicParam:[String:AnyObject] = ["operation":"documentValidation" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "doc_type":docType.gcc.getValue(),
                                                   "view_type": isFront ? viewType.front.getValue() : viewType.rear.getValue(),
                                                   "step":STEPS_FRONT_END_NAME.getValue(.selectDocumentTypeScreen)(),
                                                   "document_base64":docBase64 ?? "",
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { [self] (response) in
            print(response as Any)
            if uploadDocumentCancel == false{
                let validateOTPModel = OmniResponseModel(JSON: response as! [String : Any])!
                if validateOTPModel.Response?.Body?.status == "Success"{
                    if isFront{
                        //--
                        apiCall_UploadNationalId(isFront: false)
                    }else{
                        if validateOTPModel.Response?.Body?.Result?.data?.valid == 1{
                            //--
                            self.scanBackDocData = validateOTPModel.Response?.Body?.Result?.data
                            
                            //-- Check Exp Date
                            let exp_date = AppHelper.stringToDate(strDate: self.scanBackDocData?.exp_date ?? "", strFormate: "yyyy-MM-dd", localise: "en")
                            if Date().ticks < exp_date.ticks{
                                //-- Check DOB valid
                                let yearAgo = AppHelper.stringToDate(strDate: self.scanBackDocData?.date_of_birth ?? "", strFormate: "yyyy-MM-dd", localise: "en").getYearAgo()
                                if yearAgo >= 18{
                                    //--
                                    self.apiCall_UploadPassport()
                                }else{
                                    //--
                                    LoadingView.shared.dismissLoadingView()
                                    openErrorAlert(title: Localize(key: "Error"), details: "\(Localize(key: "national_id_title"))\n\n\(Localize(key: "minimum_age_msg"))")
                                }
                            }else{
                                //--
                                LoadingView.shared.dismissLoadingView()
                                openErrorAlert(title: Localize(key: "Error"), details: Localize(key: "national_id_expire_msg"))
                            }
                        }else{
                            //self.view.makeToast(validateOTPModel.Response?.Body?.Result?.data?.error_response ?? "")
                            LoadingView.shared.dismissLoadingView()
                            let msg = validateOTPModel.Response?.Body?.Result?.data?.error_response ?? ""
                            showAlertForInvalidDoc(details: "\(Localize(key: "national_id_title"))\n\n\(msg)")
                        }
                    }
                }else{
                    //self.view.makeToast(validateOTPModel.Response?.Body?.Result?.data?.error_response ?? "")
                    LoadingView.shared.dismissLoadingView()
                    let msg = validateOTPModel.Response?.Body?.Result?.data?.error_response == "" ? validateOTPModel.message : validateOTPModel.Response?.Body?.Result?.data?.error_response ?? ""
                    showAlertForInvalidDoc(details: "\(Localize(key: "national_id_title"))\n\n\(msg)")
                }
            }
        }) { (error) in
            print(error)
            self.showAlertForInvalidDoc(details: "\(Localize(key: "national_id_title"))\n\n\(Localize(key: "something_went_wrong"))")
        }
    }
    
    func apiCall_UploadPassport()  {
        //--
        let docBase64 = imgFirstPage_passwordScaned.image?.convertImageToBase64String()
        let dicParam:[String:AnyObject] = ["operation":"documentValidation" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "doc_type":docType.passport.getValue(),
                                                   "view_type":viewType.front.getValue(),
                                                   "step":STEPS_FRONT_END_NAME.getValue(.selectDocumentTypeScreen)(),
                                                   "document_base64":docBase64 ?? "",
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { [self] (response) in
            print(response as Any)
            if uploadDocumentCancel == false{
                let validateOTPModel = OmniResponseModel(JSON: response as! [String : Any])!
                if validateOTPModel.Response?.Body?.status == "Success"{
                    
                    if validateOTPModel.Response?.Body?.Result?.data?.valid == 1{
                        //--
                        self.scanPasswordData = validateOTPModel.Response?.Body?.Result?.data
                        
                        //-- Check Passport expire date
                        let exp_date = AppHelper.stringToDate(strDate: self.scanPasswordData?.exp_date ?? "", strFormate: "yyyy-MM-dd", localise: "en")
                        if Date().ticks < exp_date.ticks{
                            //--
                            LoadingView.shared.dismissLoadingView()
                            //--
                            let vc = PersonalInfoVC(nibName: "PersonalInfoVC", bundle: bundleIdentifireGlob)
                            vc.scanPasswordData = scanPasswordData
                            vc.scanBackDocData = scanBackDocData
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            //--
                            openErrorAlert(title: Localize(key: "Error"), details: Localize(key: "passport_expire_msg"))
                        }
                        LoadingView.shared.dismissLoadingView()
                    }else{
                        //self.view.makeToast(validateOTPModel.Response?.Body?.Result?.data?.error_response ?? "")
                        LoadingView.shared.dismissLoadingView()
                        let msg = validateOTPModel.Response?.Body?.Result?.data?.error_response ?? ""
                        showAlertForInvalidDoc(details: "\(Localize(key: "passport_title"))\n\n\(msg)")
                    }
                }else{
                    //self.view.makeToast(validateOTPModel.Response?.Body?.Result?.data?.error_response ?? "")
                    LoadingView.shared.dismissLoadingView()
                    let msg = validateOTPModel.Response?.Body?.Result?.data?.error_response == "" ? validateOTPModel.message : validateOTPModel.Response?.Body?.Result?.data?.error_response ?? ""
                    showAlertForInvalidDoc(details: "\(Localize(key: "passport_title"))\n\n\(msg)")
                }
            }
        }) { (error) in
            print(error)
            self.popover.dismiss()
            self.showAlertForInvalidDoc(details: "\(Localize(key: "passport_title"))\n\n\(Localize(key: "something_went_wrong"))")
        }
    }

}

extension GCCNationalsCitizenshipDocVC: LightboxControllerDismissalDelegate, LightboxControllerPageDelegate{
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        print(page)
    }
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        
    }
}
