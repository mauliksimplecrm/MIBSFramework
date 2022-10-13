//
//  AddSignatureVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 15/02/22.
//

import UIKit
//import MBDocCapture
////import Popover

class AddSignatureVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblCreateAccount: UILabel!
    @IBOutlet weak var imgSignature: UIImageView!
    @IBOutlet weak var viewSignature_height: NSLayoutConstraint!
    @IBOutlet weak var viewSignUploadSignature: UIView!
    @IBOutlet weak var lblSignOnScreen: UILabel!
    @IBOutlet weak var lblUploadSignature: UILabel!
    @IBOutlet weak var viewChangeSingnature: UIView!
    @IBOutlet weak var lblChangeSignature: UILabel!
    @IBOutlet weak var viewSignature: UIView!
    
    //--
    @IBOutlet var viewAlertPopup: UIView!
    @IBOutlet weak var viewInnerAlertPopup: UIView!
    @IBOutlet weak var lblTitleAlertPopup: UILabel!
    @IBOutlet weak var lblDetailAlertPopup: UILabel!
    @IBOutlet weak var btnGotitAlertPopup: UIButton!
    @IBOutlet weak var viewCreateAccount: UIView!
    
    
    //MARK: - Veriable
    var popover = Popover()
    
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        setDefaultUI()
        validateEnput()
        
    }
    override func viewDidLayoutSubviews() {
        //--
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
    
        lblTitle.text = Localize(key: "Add Signature")
        lblDetail.text = Localize(key: "Add Signature detail")
        lblChangeSignature.text = Localize(key: "CHANGE SIGNATURE")
        lblSignOnScreen.text = Localize(key: "SIGN ON SCREEN")
        lblUploadSignature.text = Localize(key: "UPLOAD SIGNATURE")
        lblCreateAccount.text = Localize(key: "CREATE ACCOUNT")
        
        btnGotitAlertPopup.setTitle(Localize(key: "CONTINUE"), for: .normal)
    }
    
    func setupHeader(){

        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    func setDefaultUI(){
        //Default UI
        viewSignature_height.constant = 0
        viewSignature.isHidden = true
        viewSignUploadSignature.isHidden = false
        viewChangeSingnature.isHidden = true
        
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
    
    //MARK: - @IBAction
    @IBAction func btnGotitAlertPopup(_ sender: Any) {
        popover.dismiss()
        //--
        let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: true)
        //--
        //let vc = HighCustomerVC(nibName: "HighCustomerVC", bundle: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btbVeryH(_ sender: Any) {
        //--
        //let vc = VeryHighCustomerVC(nibName: "VeryHighCustomerVC", bundle: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnAddonService(_ sender: Any) {
        //--
        let vc = AddonServicesVC(nibName: "AddonServicesVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCreateAccount(_ sender: Any) {
        apiCall_UploadImage()
        
    }
    @IBAction func btnSingOnScreen(_ sender: Any) {
        //--
        let vc = SignSignatureVC(nibName: "SignSignatureVC", bundle: bundleIdentifireGlob)
        vc.delegate_didSignSignature_protocol = self
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func btnUploadSignature(_ sender: Any) {
        let vc = CustomCameraVC(nibName: "CustomCameraVC", bundle: bundleIdentifireGlob)
        vc.delegate_didTakeCustomPhoto = self
        vc.headerTitle = Localize(key: "take_clear_photo_of_signature")
        vc.modalPresentationStyle = .overCurrentContext
        vc.avCaptureDevicePosition = .back
        self.present(vc, animated: true, completion: nil)
        
        /*let scannerViewController = ImageScannerController(delegate: self)
        scannerViewController.shouldScanTwoFaces = false // Use this to scan the front and the back of a document
        self.present(scannerViewController, animated: true)*/
    }
    @IBAction func btnChangeSignature(_ sender: Any) {
        viewSignUploadSignature.isHidden = false
        viewChangeSingnature.isHidden = true
    } 
    
    //--
    func setSignedImageUI(img_: UIImage){
        imgSignature.image = img_
        viewSignature_height.constant = 200
        viewSignature.isHidden = false
        viewSignUploadSignature.isHidden = true
        viewChangeSingnature.isHidden = false
        
        validateEnput()
    }

    func validateEnput() {
        var returnValue = true
        if viewSignature.isHidden == true{
            returnValue = false
        }
        
        if returnValue{
            AppHelper.enableNextBTN(view_: viewCreateAccount)
        }else{
            AppHelper.disableNextBTN(view_: viewCreateAccount)
        }
    }
}

extension AddSignatureVC: didTakeCustomPhoto_protocol{
    func didTakeCustomPhoto_protocol(image_: UIImage) {
        setSignedImageUI(img_: image_)
    }
    

}

/*
extension AddSignatureVC: ImageScannerControllerDelegate{
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        scanner.dismiss(animated: true)
        setSignedImageUI(img_: results.scannedImage)
        
    }
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithPage1Results page1Results: ImageScannerResults, andPage2Results page2Results: ImageScannerResults) {
        scanner.dismiss(animated: true, completion: nil)
    }
    func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        scanner.dismiss(animated: true, completion: nil)
    }
    func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        scanner.dismiss(animated: true, completion: nil)
    }
}
 */
extension AddSignatureVC: didSignSignature_protocol{
    func didSignSignature_protocol(img: UIImage) {
        setSignedImageUI(img_: img)
    }
}

//MARK: - Api Call
extension AddSignatureVC{
    func apiCall_updateApplication()  {
        
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "step": STEPS_FRONT_END_NAME.getValue(.signatureUploadScreen)(),
                                                    "device_info": deviceInfo,
                                                    "crm_data": [
                                                                 "application_status_c": ApplicationStatus.application_submitted.rawValue
                                                                 ]
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
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
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_updateApplication()
                }
            }
        }
    }
    func apiCall_UploadImage()  {
        //--
        //if isFront{
            //self.openLodingAlert()
        //}
        let docBase64 = imgSignature.image?.convertImageToBase64String()
        let dicParam:[String:AnyObject] = ["operation":"updateDigitalSignature" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "doc_type":docType.eSignature.getValue(),
                                                   "view_type": viewType.other.getValue(),
                                                   "step":STEPS_FRONT_END_NAME.getValue(.signatureUploadScreen)(),
                                                   "document_base64":docBase64 ?? "",
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
            let validateOTPModel = OmniResponseModel(JSON: response as! [String : Any])!
            if validateOTPModel.Response?.status == "Success"{
                apiCall_updateApplication()
            }else{
                
                self.view.makeToast(validateOTPModel.Response?.Body?.Result?.data?.error_response == "" ? validateOTPModel.message : validateOTPModel.Response?.Body?.Result?.data?.error_response ?? "")
            }
            
        }) { (error) in
            print(error)
            self.popover.dismiss()
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_UploadImage()
                }
            }
        }
    }
}
