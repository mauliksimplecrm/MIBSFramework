//
//  ProofofAddressVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 23/02/22.
//

import UIKit
//import Lightbox
////import Popover

class ProofofAddressVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblListofDoc: UILabel!
    @IBOutlet weak var lblNext: UILabel!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lblUploadProofofAddress: UILabel!
    
    @IBOutlet weak var imgDoneProofOfAddress: UIImageView!
    @IBOutlet weak var viewbtnNext: UIView!
    
    @IBOutlet weak var viewbgAddressProof: UIView!
    @IBOutlet weak var imgViewTakePhoto: UIImageView!
    @IBOutlet weak var btnViewTakePhotoHoldingId: UIButton!
    
    @IBOutlet weak var viewbgEmpl: UIView!
    @IBOutlet weak var viewSectionEmp: UIView!
    @IBOutlet weak var lblTitleEmp: UILabel!
    @IBOutlet weak var lblDetailEmp: UILabel!
    @IBOutlet weak var imgViewEmp: UIImageView!
    @IBOutlet weak var btnViewEmp: UIButton!
    @IBOutlet weak var imgDoneEmp: UIImageView!
    @IBOutlet weak var lblInfoEmp: UILabel!
    
    @IBOutlet weak var viewbgVisa: UIView!
    @IBOutlet weak var viewSectionVisa: UIView!
    @IBOutlet weak var imgDoneVisa: UIImageView!
    @IBOutlet weak var lblTitleVisa: UILabel!
    @IBOutlet weak var lblDetailVisa: UILabel!
    @IBOutlet weak var imgViewVisa: UIImageView!
    @IBOutlet weak var btnViewVisa: UIButton!
    
    
    
    //MARK: - Veriable
    var isSelectProofOfAddressDoc = false
    var takedProofOfAddressDoc = UIImageView()
    
    var isSelectEmp = false
    var takedEmp = UIImageView()
    
    var isSelectVisa = false
    var takedVisa = UIImageView()
    
    let list = ManageDropDownOption.getDropDownValue(dropdown_filed: .proof_of_address_doctype_c)
    var takePhotoFor = ""
    var isComeFromNotification = false
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        registerCell()
        setupHeader()
        setupBasic()
        hideTakePhotoHolding()
        hideViewEmp()
        hideViewVisa()
        //getDocumentsList()
        
        tblList.reloadData()
        
        
    }
    
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        let location_ = Managelanguage.getLanguageCode() == "A" ? 7 : 10
        let length_ = Managelanguage.getLanguageCode() == "A" ? 6 : 11
        lblTitle.attributedText = Localize(key: "Additional Information").attributedStringWithColorNew(location_, length: length_, color: .DARKGREENTINT)
        
        lblDetail.text = Localize(key: "To check your liveness, please upload a photo of your face at present")
        
        lblUploadProofofAddress.text = Localize(key: "Upload Proof of Address")
        lblListofDoc.text = Localize(key: "List of documents considered as Proof of Address:")
        
        lblNext.text = Localize(key: "NEXT")
        
        if Managelanguage.getLanguageCode() == "A"
        {
            lblTitle.semanticContentAttribute = .forceRightToLeft
        
        }
    }
    func setupHeader(){
         
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            if self.isComeFromNotification{
                //--
                let vc = objMainSB.instantiateViewController(withIdentifier: "NotificationSBVC") as! NotificationSBVC
                vc.serviceType = .AllNotifications
                self.navigationController?.pushViewController(vc, animated: false)
            }else{
                //--
                let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    func setupBasic(){
        //        if applyValidation{
        //            AppHelper.disableNextBTN(view_: viewbtnNext)
        //        }
        //--
        validateDoc()
        
        //--
        hideAllDoc()
        
        //--
        getReqDocument()
    }
    func getReqDocument()  {
        //--
        apiCall_getApplicationData (showProgress: true, completionOut: { [self] result in
            let additional_documents_c = (result.additional_documents_c as? String ?? "")
            if additional_documents_c.count != 0{
                let additional_documents_cArr = additional_documents_c.components(separatedBy: ",")
                if additional_documents_cArr.contains("address_proof"){
                    viewbgAddressProof.isHidden = false
                }
                if additional_documents_cArr.contains("employment_letter"){
                    viewbgEmpl.isHidden = false
                    if additional_documents_cArr.contains("address_proof"){
                        viewSectionEmp.isHidden = false
                    }
                }
                if additional_documents_cArr.contains("visa"){
                    viewbgVisa.isHidden = false
                    if additional_documents_cArr.contains("address_proof"){
                        viewSectionVisa.isHidden = false
                    }
                }
                
                //--
                validateDoc()
            }else{
                showAlert()
            }
        })
    }
    func hideAllDoc()  {
        viewbgAddressProof.isHidden = true
        viewbgEmpl.isHidden = true
        viewbgVisa.isHidden = true
    }
    func registerCell(){
        tblList.register(UINib(nibName: "ProofofAddressTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "ProofofAddressTblCell")
    }
    func showAlert(){
        //--
        let popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = Localize(key: "No_Additional_Documents_required")
        alert.btnGotoApplication.isHidden = true
        
        alert.btnContinueApplication.setTitle(Localize(key: "CANCEL"), for: .normal)
        alert.didTappedContinueAPP = { (sender) in
            popover.dismiss()
        }
        alert.btnCancel.setTitle(Localize(key: "RETRY"), for: .normal)
        alert.didTappedCancel = { (sender) in
            popover.dismiss()
            self.getReqDocument()
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
    @IBAction func btnUploadDoc(_ sender: Any) {
        takePhotoFor = "address"
        //--
        let vc = CustomCameraVC(nibName: "CustomCameraVC", bundle: bundleIdentifireGlob)
        vc.delegate_didTakeCustomPhoto = self
        vc.headerTitle = Localize(key: "Take_photo_the_your_address_proof")
        vc.avCaptureDevicePosition = .back
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnViewTakePhotoHoldingId(_ sender: Any) {
        if let img_ = takedProofOfAddressDoc.image{
            setupLightBoxImageArray(imgOpen: img_, msg: "")
        }
    }
    @IBAction func btnUploadEmp(_ sender: Any) {
        takePhotoFor = "emp"
        //--
        let vc = CustomCameraVC(nibName: "CustomCameraVC", bundle: bundleIdentifireGlob)
        vc.headerTitle = Localize(key: "Proof_Employment_letter_msg")
        vc.delegate_didTakeCustomPhoto = self
        vc.modalPresentationStyle = .fullScreen
        vc.avCaptureDevicePosition = .back
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnViewEmp(_ sender: Any) {
        if let img_ = takedEmp.image{
            setupLightBoxImageArray(imgOpen: img_, msg: "")
        }
    }
    @IBAction func btnUploadVisa(_ sender: Any) {
        takePhotoFor = "visa"
        //--
        let vc = CustomCameraVC(nibName: "CustomCameraVC", bundle: bundleIdentifireGlob)
        vc.headerTitle = Localize(key: "Take_photo_visa")
        vc.delegate_didTakeCustomPhoto = self
        vc.avCaptureDevicePosition = .back
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnViewVisa(_ sender: Any) {
        if let img_ = takedEmp.image{
            setupLightBoxImageArray(imgOpen: img_, msg: "")
        }
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if viewbgAddressProof.isHidden == false {
            apiCall_UploadImage()
        }else if viewbgEmpl.isHidden == false {
            apiCall_UploadDoc_IncomeDetailEmployed()
        }else if viewSectionVisa.isHidden == false {
            apiCall_UploadValidVisa()
        }
        
    }
    
    
}

extension ProofofAddressVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProofofAddressTblCell", for: indexPath) as! ProofofAddressTblCell
        cell.selectionStyle = .none
        
        cell.lblTitle.text = list[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ProofofAddressVC: didTakeCustomPhoto_protocol{
    func didTakeCustomPhoto_protocol(image_: UIImage) {
        if takePhotoFor == "address"{
            isSelectProofOfAddressDoc = true
            takedProofOfAddressDoc.image = image_
            selectTakePhotoHolding()
            
            validateDoc()
        }else if takePhotoFor == "emp"{
            isSelectEmp = true
            takedEmp.image = image_
            
            btnViewEmp.isHidden = false
            imgViewEmp.isHidden = false
            imgDoneEmp.image = .IMGDoneGreen
            lblDetailEmp.text = "Proof Of Employment.png"
            lblDetailEmp.isHidden = false
            
            validateDoc()
        }else{
            isSelectVisa = true
            takedVisa.image = image_
            
            btnViewVisa.isHidden = false
            imgViewVisa.isHidden = false
            imgDoneVisa.image = .IMGDoneGreen
            lblDetailVisa.text = "Visa.png"
            lblDetailVisa.isHidden = false
            
            validateDoc()
        }
        
    }
    
    func selectTakePhotoHolding(){
        btnViewTakePhotoHoldingId.isHidden = false
        imgViewTakePhoto.isHidden = false
        imgDoneProofOfAddress.image = .IMGDoneGreen
    }
    func hideTakePhotoHolding(){
        btnViewTakePhotoHoldingId.isHidden = true
        imgViewTakePhoto.isHidden = true
    }
    func hideViewEmp(){
        btnViewEmp.isHidden = true
        imgViewEmp.isHidden = true
    }
    func hideViewVisa(){
        btnViewVisa.isHidden = true
        imgViewVisa.isHidden = true
    }
    func validateDoc(){
        var selectAll = false
        if viewbgAddressProof.isHidden == false {
            if isSelectProofOfAddressDoc{
                selectAll = true
            }else{
                selectAll = false
            }
        }
        if viewbgEmpl.isHidden == false {
            if isSelectEmp{
                selectAll = true
            }else{
                selectAll = false
            }
        }
        if viewbgVisa.isHidden == false {
            if isSelectVisa{
                selectAll = true
            }else{
                selectAll = false
            }
        }
        if selectAll{
            AppHelper.enableNextBTN(view_: viewbtnNext)
        }else{
            AppHelper.disableNextBTN(view_: viewbtnNext)
        }
    }
}

//MARK: - Api Call
extension ProofofAddressVC{
    /*func getDocumentsList(){
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
     takedProofOfAddressDoc.setImage(url: url)
     
     selectTakePhotoHolding()
     }
     }
     }
     }
     }*/
    
    func apiCall_UploadImage()  {
        //--
        let docBase64 = takedProofOfAddressDoc.image?.convertImageToBase64String()
        
        LoadingView.shared.openLodingAlert(btnCancelHide: true, view: self.view)
        let dicParam:[String:AnyObject] = ["operation":"documentValidation" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "doc_type":docType.getValue(.address_proof)(),
                                                   "view_type":viewType.other.getValue(),
                                                   "document_base64":docBase64 ?? "",
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { [self] (response) in
            LoadingView.shared.dismissLoadingView()
            
            print(response as Any)
            let validateOTPModel = OmniResponseModel(JSON: response as! [String : Any])!
            if validateOTPModel.Response?.Body?.status == "Success"{
                if viewbgEmpl.isHidden == false {
                    apiCall_UploadDoc_IncomeDetailEmployed()
                }else if viewSectionVisa.isHidden == false {
                    apiCall_UploadValidVisa()
                }else{
                    //--
                    apiCall_updateApplication()
                }
            }else{
                self.view.makeToast(validateOTPModel.Response?.Body?.Result?.data?.error_response ?? "")
            }
        }) { (error) in
            LoadingView.shared.dismissLoadingView()
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_UploadImage()
                }
            }
        }
    }
    
    func apiCall_UploadDoc_IncomeDetailEmployed()  {
        //--
        let docBase64 = takedEmp.image?.convertImageToBase64String()
        
        LoadingView.shared.openLodingAlert(btnCancelHide: true, view: self.view)
        let dicParam:[String:AnyObject] = ["operation":"documentValidation" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "doc_type":docType.employment_letter.getValue(),
                                                   "view_type":viewType.other.getValue(),
                                                   "document_base64":docBase64 ?? "",
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { [self] (response) in
            LoadingView.shared.dismissLoadingView()
            print(response as Any)
            let validateOTPModel = OmniResponseModel(JSON: response as! [String : Any])!
            if validateOTPModel.Response?.Body?.status == "Success"{
                if viewSectionVisa.isHidden == false {
                    apiCall_UploadValidVisa()
                }else{
                    apiCall_updateApplication()
                }
            }else{
                self.view.makeToast(validateOTPModel.Response?.Body?.Result?.data?.error_response ?? "")
            }
        }) { (error) in
            LoadingView.shared.dismissLoadingView()
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_UploadDoc_IncomeDetailEmployed()
                }
            }
        }
    }
    
    func apiCall_UploadValidVisa()  {
        //--
        let docBase64 = takedVisa.image?.convertImageToBase64String()
        
        LoadingView.shared.openLodingAlert(btnCancelHide: true, view: self.view)
        let dicParam:[String:AnyObject] = ["operation":"documentValidation" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "doc_type":docType.visa.getValue(),
                                                   "view_type":viewType.other.getValue(),
                                                   "document_base64":docBase64 ?? "",
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { [self] (response) in
            LoadingView.shared.dismissLoadingView()
            print(response as Any)
            
            let validateOTPModel = OmniResponseModel(JSON: response as! [String : Any])!
            if validateOTPModel.Response?.Body?.status == "Success"{
                apiCall_updateApplication()
            }else{
                self.view.makeToast(validateOTPModel.Response?.Body?.Result?.data?.error_response ?? "")
            }
            
        }) { (error) in
            print(error)
            LoadingView.shared.dismissLoadingView()
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_UploadValidVisa()
                }
            }
        }
    }
    
    
    func apiCall_updateApplication()  {
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.proofOfAddressScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": [
                                                        "application_status_c": ApplicationStatus.application_submitted.rawValue
                                                    ]
                                                   ] as AnyObject]
        LoadingView.shared.openLodingAlert(btnCancelHide: true, view: self.view)
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { [self] (response) in
            print(response as Any)
            
            LoadingView.shared.dismissLoadingView()
            
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "200"{
                if oTPGenerationModel.Response?.Body?.status == "Success"{
                    
                    //--
                    let vc = ThankYouVC(nibName: "ThankYouVC", bundle: bundleIdentifireGlob)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    
                    self.view.makeToast(oTPGenerationModel.Response?.Body?.statusMsg ?? "")
                }
            }else{
                
                self.view.makeToast(oTPGenerationModel.message)
            }
        }) { (error) in
            LoadingView.shared.dismissLoadingView()
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

extension ProofofAddressVC: LightboxControllerDismissalDelegate, LightboxControllerPageDelegate{
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
