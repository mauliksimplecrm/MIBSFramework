
//
//  ReviewApplicationVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 15/02/22.
//

import UIKit
////import Popover
//import Lightbox

class ReviewApplicationVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var scrollContainer: UIScrollView!
    @IBOutlet weak var lblOnScrollHeader: UILabel!
    @IBOutlet weak var onscrollHeaderView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblSharePDF: UILabel!
    @IBOutlet weak var lblDownloadPDF: UILabel!
    @IBOutlet weak var lblConfirm: UILabel!
    @IBOutlet weak var btnIllReturnLater: UIButton!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var tblListHeight: NSLayoutConstraint!
    
    //--
    @IBOutlet var viewAlertPopup: UIView!
    @IBOutlet weak var viewInnerAlertPopup: UIView!
    @IBOutlet weak var lblTitleAlertPopup: UILabel!
    @IBOutlet weak var lblDetailAlertPopup: UILabel!
    @IBOutlet weak var btnGotitAlertPopup: UIButton!
    
    
    //MARK: - Veriable
    
    var arrReviewAppData:[RAData] = []
    
    var popover = Popover()
    var checkCRAModel = CheckCRAModel()
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        setupBasic()
        registerCell()
        apiCall_getApplicationData { result in
            apiCall_getDocumentsList (showProgress: false){ [self] docResult in
                self.setFormData(result: result, docResult: docResult)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        tblListHeight.constant = tblList.contentSize.height
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.tblListHeight.constant = self.tblList.contentSize.height
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.tblListHeight.constant = self.tblList.contentSize.height
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.tblListHeight.constant = self.tblList.contentSize.height
        })
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblOnScrollHeader.attributedText = Localize(key: "Review your application").attributedStringWithColorNew(0, length: 6, color: .DARKGREENTINT)
        lblTitle.attributedText = Localize(key: "Review your application").attributedStringWithColorNew(0, length: 6, color: .DARKGREENTINT)
        lblDetail.text = Localize(key: "Review your application detail")
        
        lblDownloadPDF.text = Localize(key: "DOWNLOAD PDF")
        lblSharePDF.text = Localize(key: "SHARE PDF")
        lblConfirm.text = Localize(key: "CONFIRM")
        btnIllReturnLater.setTitle(Localize(key: "i_ll_return_later"), for: .normal)
        btnGotitAlertPopup.setTitle(Localize(key: "CONTINUE"), for: .normal)
    }
    func setupHeader(){

        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            self.clickBack()
        }
    }
    func clickBack(){
        //--
        let vc = RegularityDeclVC(nibName: "RegularityDeclVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func registerCell(){
        tblList.register(UINib(nibName: "TitleReviewAppTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "TitleReviewAppTblCell")
        tblList.register(UINib(nibName: "SubTitleReviewAppTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "SubTitleReviewAppTblCell")
        tblList.register(UINib(nibName: "DocumentReviewAppTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "DocumentReviewAppTblCell")
        tblList.register(UINib(nibName: "TitleDetailReviewAppTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "TitleDetailReviewAppTblCell")
        tblList.register(UINib(nibName: "OtherDocTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "OtherDocTblCell")
        
    }
    func setupBasic(){
        
        
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
    func showAlertForRetry(details: String, type: String){
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

        }
        alert.btnCancel.setTitle(Localize(key: "RETRY"), for: .normal)
        alert.didTappedCancel = { (sender) in
            self.popover.dismiss()
            self.downloadSharePDFClick(type: type)
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
    @IBAction func btnBackOnScrollHeader(_ sender: Any) {
        self.clickBack()
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
    @IBAction func btnGotitAlertPopup(_ sender: Any) {
        popover.dismiss()
        
        if checkCRAModel.Response?.Body?.risk_level == "3"{
            //3=High Risk
            //--
            let vc = HighCustomerVC(nibName: "HighCustomerVC", bundle: bundleIdentifireGlob)
            vc.screenNameEnum = .reviewApplicationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if checkCRAModel.Response?.Body?.risk_level == "4"{
            //4= Very High Risk
            //--
            let vc = VeryHighCustomerVC(nibName: "VeryHighCustomerVC", bundle: bundleIdentifireGlob)
            vc.screenNameEnum = .reviewApplicationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if checkCRAModel.Response?.Body?.risk_level == "5"{
            //--
            let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func btnDownloadPDF(_ sender: Any) {
        downloadSharePDFClick(type: "download")
    }
    func downloadSharePDFClick(type: String){
        getApplicationPreviewLink { application_preview_link, errorMsg in
            if errorMsg.count == 0{
                if type == "download"{
                    self.savePdf(urlString: application_preview_link, fileName: "")
                }else{
                    self.shareTEXT(url_: application_preview_link)
                }
            }else{
                //self.view.makeToast("Not get PDF")
                self.showAlertForRetry(details: errorMsg, type: type)
            }
        }
    }
    func savePdf(urlString:String, fileName:String) {
        //let urlString = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
        DispatchQueue.main.async {
            guard let url = URL(string: urlString) else { return }
            
            /*let fileName = url.lastPathComponent
            let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentDirectoryPath:String = path[0]
            let fileManager = FileManager()
            var destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appending("/PDF"))
            */
            
            let pdfData = try? Data.init(contentsOf: url)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = url.lastPathComponent
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                /*try fileManager.createDirectory(at: destinationURLForFile, withIntermediateDirectories: true, attributes: nil)
                destinationURLForFile.appendPathComponent(String(describing: fileName))
                try fileManager.moveItem(at: url, to: destinationURLForFile)*/
                
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
                //self.view.makeToast("PDF successfully saved!")
                AppHelper.openDocuemtnBrowser(docUrl: urlString, nav: self.navigationController!)
            } catch {
                print("Pdf could not be saved")
                //self.view.makeToast("PDF could not be saved")
            }
        }
    }
    @IBAction func btnSharePDF(_ sender: Any) {
        downloadSharePDFClick(type: "share")
    }
    @IBAction func btnConfirm(_ sender: Any) {
        apiCall_checkCRA()
        
    }
    @IBAction func btnIllReturnLater(_ sender: Any) {
        showAlertIllReturnLaterBtn()
    }
    
    func shareTEXT(url_: String){
        // text to share
        let text = url_
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
}

extension ReviewApplicationVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReviewAppData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = arrReviewAppData[indexPath.row].cellType
        switch type {
        case .rTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleReviewAppTblCell", for: indexPath) as! TitleReviewAppTblCell
            cell.selectionStyle = .none
            
            cell.lblTitle.text = arrReviewAppData[indexPath.row].title ?? ""
            
            cell.btnEdit.setTitle(Localize(key: "edit"), for: .normal)
            //--
            cell.didTappedEdit = { [self] (sender) in
                if arrReviewAppData[indexPath.row].formType == .regularityDeclaration{
                    //--
                    let vc = RegularityDeclVC(nibName: "RegularityDeclVC", bundle: bundleIdentifireGlob)
                    vc.screenNameEnum = .reviewApplicationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    showAlertEditCitizenship(indexPath: indexPath)   
                }
            }
            return cell
        case .rDocument:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentReviewAppTblCell", for: indexPath) as! DocumentReviewAppTblCell
            cell.selectionStyle = .none
            cell.viewbgFront.isHidden = true
            cell.viewbgBack.isHidden = true
            
            cell.lblTitle.text = arrReviewAppData[indexPath.row].title ?? ""
            cell.lblDetail.text = arrReviewAppData[indexPath.row].detail ?? ""
            
            cell.lblFront.text = Localize(key: "Front")
            cell.lblBack.text = Localize(key: "Back")
            
            let frontImg = arrReviewAppData[indexPath.row].frontImg ?? ""
            if frontImg.count != 0{
                cell.viewbgFront.isHidden = false
                if let url = URL(string: frontImg){
                    cell.imgFront.af.setImage(withURL: url)
                }
            }
            let backImg = arrReviewAppData[indexPath.row].backImg ?? ""
            if backImg.count != 0{
                cell.viewbgBack.isHidden = false
                if let url = URL(string: backImg){
                    cell.imgBack.af.setImage(withURL: url)
                }
            }
            
            cell.didTappedFbtn = { [self] (sender) in
                let frontImg = arrReviewAppData[indexPath.row].frontImg ?? ""
                if frontImg.count != 0{
                    if let url = URL(string: frontImg){
                        setupLightBoxImageArray(imgOpen: nil, msg: "", imgURL: url)
                    }
                }
            }
            
            cell.didTappedBbtn = { [self] (sender) in
                let frontImg = arrReviewAppData[indexPath.row].backImg ?? ""
                if frontImg.count != 0{
                    if let url = URL(string: frontImg){
                        setupLightBoxImageArray(imgOpen: nil, msg: "", imgURL: url)
                    }
                }
            }
            
            return cell
        case .rOtherDoc:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherDocTblCell", for: indexPath) as! OtherDocTblCell
            cell.selectionStyle = .none
            
            cell.lblTitle.text = arrReviewAppData[indexPath.row].title ?? ""
            cell.lblDetail.text = arrReviewAppData[indexPath.row].detail ?? ""
            
            //--
            cell.didTappedOpenOtherDoc = { [self] (sender) in
                let frontImg = arrReviewAppData[indexPath.row].frontImg ?? ""
                if frontImg.count != 0{
                    if let url = URL(string: frontImg){
                        setupLightBoxImageArray(imgOpen: nil, msg: "", imgURL: url)
                    }
                }
            }
            return cell
        case .rSubTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubTitleReviewAppTblCell", for: indexPath) as! SubTitleReviewAppTblCell
            cell.selectionStyle = .none
            
            cell.lblTitle.text = arrReviewAppData[indexPath.row].title ?? ""
            
            return cell
        case .rTitleDetail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleDetailReviewAppTblCell", for: indexPath) as! TitleDetailReviewAppTblCell
            cell.selectionStyle = .none
            
            cell.lblTitle.text = arrReviewAppData[indexPath.row].title ?? ""
            cell.lblDetail.text = arrReviewAppData[indexPath.row].detail ?? ""
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDropDownTblCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func showAlertEditCitizenship(indexPath: IndexPath){
        //--
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = Localize(key: "edit_button_alert_text")
        alert.btnGotoApplication.isHidden = true
        alert.btnContinueApplication.setTitle(Localize(key: "CONTINUE APPLICATION"), for: .normal)
        alert.didTappedContinueAPP = { [self] (sender) in
            self.popover.dismiss()
            
            if arrReviewAppData[indexPath.row].formType == .citizenship{
                if citizenshipType == .omani{
                    //--
                    let vc = OmaniCitizenshipDocVC(nibName: "OmaniCitizenshipDocVC", bundle: bundleIdentifireGlob)
                    vc.screenNameEnum = .reviewApplicationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                if citizenshipType == .expatriate{
                    //--
                    let vc = ExpatrIateCitizenshipDoc(nibName: "ExpatrIateCitizenshipDoc", bundle: bundleIdentifireGlob)
                    vc.screenNameEnum = .reviewApplicationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                if citizenshipType == .gcc{
                    //--
                    let vc = GCCNationalsCitizenshipDocVC(nibName: "GCCNationalsCitizenshipDocVC", bundle: bundleIdentifireGlob)
                    vc.screenNameEnum = .reviewApplicationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                if arrReviewAppData[indexPath.row].formType == .personalInformation{
                    //--
                    let vc = PersonalInfoVC(nibName: "PersonalInfoVC", bundle: bundleIdentifireGlob)
                    vc.screenNameEnum = .reviewApplicationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                if arrReviewAppData[indexPath.row].formType == .financialInformation{
                    //--
                    let vc = FinancialInfoVC(nibName: "FinancialInfoVC", bundle: bundleIdentifireGlob)
                    vc.screenNameEnum = .reviewApplicationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                if arrReviewAppData[indexPath.row].formType == .regularityDeclaration{
                    //--
                    let vc = RegularityDeclVC(nibName: "RegularityDeclVC", bundle: bundleIdentifireGlob)
                    vc.screenNameEnum = .reviewApplicationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            

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
    func showAlertIllReturnLaterBtn(){
        //--
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = Localize(key: "2_steps_away_creating_account")
        alert.btnGotoApplication.isHidden = true
        
        alert.btnContinueApplication.setTitle(Localize(key: "GO TO DASHBOARD"), for: .normal)
        alert.didTappedContinueAPP = { [self] (sender) in
            self.popover.dismiss()
            
            //--
            let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.navigationController?.pushViewController(vc, animated: false)
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
}

//MARK: - Api Call
extension ReviewApplicationVC{
    
    func apiCall_checkCRA()  {
        //--
        let dicParam:[String:AnyObject] = ["operation":"checkCRA" as AnyObject,
                                           "data":["crmid":Login_LocalDB.getApplicationInfo().crmid,
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: true, completion: { [self] (response) in
            print(response as Any)
            self.popover.dismiss()
            checkCRAModel = CheckCRAModel(JSON: response as! [String : Any])!
            if checkCRAModel.Response?.Code == "200"{
                if checkCRAModel.Response?.Body?.status == "Success"{
                    if checkCRAModel.Response?.Body?.risk_level == "1" || checkCRAModel.Response?.Body?.risk_level == "2"{
                        //--
                        let vc = LivenessCheckVC(nibName: "LivenessCheckVC", bundle: bundleIdentifireGlob)
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        //--
                        apiCall_updateApplication()
                    }else if checkCRAModel.Response?.Body?.risk_level == "3" || checkCRAModel.Response?.Body?.risk_level == "4"{
                        //--
                        openErrorAlert(title: Localize(key: "Almost done!"), details: Localize(key: "We just need to ensure we have all the information to set up your account.\nPlease fill the following form."))
                        
                        //--
                        apiCall_updateApplication()
                    }else{
                        btnGotitAlertPopup.setTitle(Localize(key: "GO TO DASHBOARD"), for: .normal)
                        openErrorAlert(title: checkCRAModel.Response?.Body?.statusMsg ?? "", details: "")
                    }
                }else{
                    openErrorAlert(title: Localize(key: "Error"), details: checkCRAModel.Response?.Body?.statusMsg ?? "")
                }
            }else{
                openErrorAlert(title: Localize(key: "Error"), details: checkCRAModel.Response?.Body?.statusMsg ?? "")
            }
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_checkCRA()
                }
            }
        }
    }
    
    func apiCall_updateApplication()  {
  
        //--
        let dicParam:[String:AnyObject] = ["operation": "updateApplication" as AnyObject,
                                           "data": ["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                    "device_info": deviceInfo,
                                                    "step":STEPS_FRONT_END_NAME.getValue(.reviewApplicationScreen)()
                                                    
                                                   ] as AnyObject]
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], completion: { (response) in
            print(response as Any)
            let oTPGenerationModel = OTPGenerationModel(JSON: response as! [String : Any])!
            if oTPGenerationModel.Response?.Code == "200"{
                if oTPGenerationModel.Response?.Body?.status == "Success"{
                    
                }else{
                   // self.view.makeToast(oTPGenerationModel.Response?.Body?.statusMsg ?? "")
                }
            }else{
                //self.view.makeToast(oTPGenerationModel.message)
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
    
    func setFormData(result: GetApplicationDataResult, docResult: GetDocumentsListResponse){
        //--
        arrReviewAppData.removeAll()
        tblList.reloadData()
        
        //--
        arrReviewAppData.append(RAData(title: Localize(key: "Citizenship"), cellType: .rTitle, formType: .citizenship))
        //let citizenship_c_ = (result.citizenship_c as? String ?? "").replacingOccurrences(of: "_", with: " ")
        //arrReviewAppData.append(RAData(title: Localize(key: "Type"), detail: citizenship_c_, cellType: .rTitleDetail, formType: .citizenship))
        
        //getDocumentsList(result: result)
        if "\(result.citizenship_c as? String ?? "")" == CitizenshipType.omani.rawValue{
            arrReviewAppData.append(RAData(title: Localize(key: "Type"), detail: Localize(key: "Omani"), cellType: .rTitleDetail, formType: .citizenship))
            
            let docObj = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.national.rawValue) && obj.card_type == viewType.getValue(.front)()
            }
            let frontImagURL = docObj.first?.document_link ?? ""
            
            let docObjB = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.national.rawValue) && obj.card_type == viewType.getValue(.rear)()
            }
            let backImgURL = docObjB.first?.document_link ?? ""
            
            arrReviewAppData.insert(RAData(title: Localize(key: "Documents"), detail: Localize(key: "Omani_National_ID"), cellType: .rDocument, formType: .citizenship, frontImg: frontImagURL, backImg: backImgURL), at: 2)
            tblList.reloadData()
            viewDidLayoutSubviews()
            
        }else if "\(result.citizenship_c as? String ?? "")" == CitizenshipType.expatriate.rawValue{
            arrReviewAppData.append(RAData(title: Localize(key: "Type"), detail: Localize(key: "Expatriate"), cellType: .rTitleDetail, formType: .citizenship))
            
            //Resident
            let docObjresident = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.resident.rawValue) && obj.card_type == viewType.getValue(.front)()
            }
            let frontImagURLresident = docObjresident.first?.document_link ?? ""
            
            let docObjBresident = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.resident.rawValue) && obj.card_type == viewType.getValue(.rear)()
            }
            let backImgURLresident = docObjBresident.first?.document_link ?? ""
            
            arrReviewAppData.insert(RAData(title: Localize(key: "Documents"), detail: Localize(key: "Resident ID"), cellType: .rDocument, formType: .citizenship, frontImg: frontImagURLresident, backImg: backImgURLresident), at: 2)
            
            //Password
            let docObjPassport = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.passport.rawValue) && obj.card_type == viewType.getValue(.front)()
            }
            let backImgURLpassport = docObjPassport.first?.document_link ?? ""
            
            arrReviewAppData.insert(RAData(title: "", detail: Localize(key: "Passport"), cellType: .rDocument, formType: .citizenship, frontImg: backImgURLpassport, backImg: ""), at: 3)
            
            //Visa Card
            let docObjvisa = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.visa.rawValue) && obj.card_type == viewType.getValue(.other)()
            }
            let backImgURLVisa = docObjvisa.first?.document_link ?? ""
            
            arrReviewAppData.insert(RAData(title: "", detail: Localize(key: "Valid Visa"), cellType: .rDocument, formType: .citizenship, frontImg: backImgURLVisa, backImg: ""), at: 4)
            
            tblList.reloadData()
            viewDidLayoutSubviews()
            
        }else if "\(result.citizenship_c as? String ?? "")" == CitizenshipType.gcc.rawValue{
            arrReviewAppData.append(RAData(title: Localize(key: "Type"), detail: Localize(key: "GCC Nationals"), cellType: .rTitleDetail, formType: .citizenship))
            
            //gcc
            //National id
            let docObjgcc = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.gcc.rawValue) && obj.card_type == viewType.getValue(.front)()
            }
            let frontImgURLgcc = docObjgcc.first?.document_link ?? ""
            
            let docObjBgcc = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.gcc.rawValue) && obj.card_type == viewType.getValue(.rear)()
            }
            let backImgURLgcc = docObjBgcc.first?.document_link ?? ""
            
            arrReviewAppData.insert(RAData(title: Localize(key: "Documents"), detail: Localize(key: "National ID"), cellType: .rDocument, formType: .citizenship, frontImg: frontImgURLgcc, backImg: backImgURLgcc), at: 2)
            
            //Password
            let docObjPassport = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.passport.rawValue) && obj.card_type == viewType.getValue(.front)()
            }
            let backImgURLpassport = docObjPassport.first?.document_link ?? ""
            
            arrReviewAppData.insert(RAData(title: "", detail: Localize(key: "Passport"), cellType: .rDocument, formType: .citizenship, frontImg: backImgURLpassport, backImg: ""), at: 3)
            
            tblList.reloadData()
            viewDidLayoutSubviews()
        }

        //--
        arrReviewAppData.append(RAData(title: Localize(key: "Personal Information"), cellType: .rTitle, formType: .personalInformation))
        let salutation_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .salutation_c, backendvalue: result.salutation_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Name"), detail: "\(salutation_c.0) \(result.full_name_c as? String ?? "")", cellType: .rTitleDetail, formType: .citizenship))
        let date_of_birth_c = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "dd/MM/yyyy", strDate: result.date_of_birth_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Date of Birth"), detail: date_of_birth_c, cellType: .rTitleDetail, formType: .citizenship))
        let gender_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .gender_c, backendvalue: result.gender_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Gender"), detail: gender_c.0, cellType: .rTitleDetail, formType: .citizenship))
        let nationality_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .nationality_c, backendvalue: result.nationality_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Nationality"), detail: nationality_c.0, cellType: .rTitleDetail, formType: .citizenship))
        arrReviewAppData.append(RAData(title: Localize(key: "ID No."), detail: result.civil_id_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
        let civil_id_expiry_date_c = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "dd/MM/yyyy", strDate: result.civil_id_expiry_date_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "ID Expiry Date"), detail: civil_id_expiry_date_c, cellType: .rTitleDetail, formType: .citizenship))
        
        if "\(result.citizenship_c as? String ?? "")" != CitizenshipType.omani.rawValue{
            arrReviewAppData.append(RAData(title: Localize(key: "Passport No"), detail: result.passport_number_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
            let passport_expiry_date_c = AppHelper.datetoconvertSpecificFormate(dateOldFTR: "yyyy-MM-dd", dateNewFTR: "dd/MM/yyyy", strDate: result.passport_expiry_date_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Passport Expiry Date"), detail: passport_expiry_date_c, cellType: .rTitleDetail, formType: .citizenship))
        }
        let country_of_birth_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.country_of_birth_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Country of Birth"), detail: country_of_birth_c.0, cellType: .rTitleDetail, formType: .citizenship))
        arrReviewAppData.append(RAData(title: Localize(key: "City of Birth"), detail: result.city_of_birth_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
        
        //customer_photo
        let docCustomer_photo = docResult.documents.filter { obj in
            return obj.document_type == docTypeBackendValue(value: docType.customer_photo.rawValue) && obj.card_type == viewType.getValue(.other)()
        }
        if docCustomer_photo.count != 0{
            let document_link = docCustomer_photo.first?.document_link ?? ""
            arrReviewAppData.append(RAData(title: Localize(key: "Profile_Pic"), detail: "Profile Pic.png", cellType: .rOtherDoc, formType: .citizenship, frontImg: document_link, backImg: ""))
        }
        
        //Address Detail
        arrReviewAppData.append(RAData(title: Localize(key: "Address Details"), cellType: .rSubTitle, formType: .personalInformation))

        let resident_country_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.resident_country_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Country"), detail: resident_country_c.0, cellType: .rTitleDetail, formType: .citizenship))
        let resident_status_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .resident_status_c, backendvalue: result.resident_status_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Residential Status"), detail: resident_status_c.0, cellType: .rTitleDetail, formType: .citizenship))
        if (result.resident_status_c as? String ?? "") == "S"{
            arrReviewAppData.append(RAData(title: Localize(key: "Please Specify"), detail: result.other_resident_country_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
        }
        arrReviewAppData.append(RAData(title: Localize(key: "P.O Box"), detail: result.resident_po_box_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
        arrReviewAppData.append(RAData(title: Localize(key: "Postal Code"), detail: result.resident_postal_code_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
        if (result.resident_house_no_c as? String ?? "").count != 0{
            arrReviewAppData.append(RAData(title: Localize(key: "House/Flat Number"), detail: result.resident_house_no_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
        }
        //arrReviewAppData.append(RAData(title: Localize(key: "Enter City"), detail: result.city_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
        arrReviewAppData.append(RAData(title: Localize(key: "Area"), detail: result.area_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
        
        //Employment Details
        arrReviewAppData.append(RAData(title: Localize(key: "Employment Details"), cellType: .rSubTitle, formType: .personalInformation))
        let employment_status_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .employment_status_c, backendvalue: result.employment_status_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Employment status"), detail: employment_status_c.0, cellType: .rTitleDetail, formType: .citizenship))
        
        let education_level_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .education_level_c, backendvalue: result.education_level_c as? String ?? "")
        if (result.employment_status_c as? String ?? "") == "1"{
            //Employed
            let industry_type_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .industry_type_c, backendvalue: result.industry_type_c as? String ?? "")
            if industry_type_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Industry"), detail: industry_type_c.0, cellType: .rTitleDetail, formType: .citizenship))
            }
            let employment_sector_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .employment_sector_c, backendvalue: result.employment_sector_c as? String ?? "")
            if employment_sector_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Employment sector"), detail: employment_sector_c.0, cellType: .rTitleDetail, formType: .citizenship))
            }
            let profession_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .profession_c, backendvalue: result.profession_c as? String ?? "")
            if profession_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Profession"), detail: profession_c.0, cellType: .rTitleDetail, formType: .citizenship))
            }
            if (result.employer_name_c as? String ?? "").count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Employer Name"), detail: result.employer_name_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
            }
            if education_level_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Education_level"), detail: education_level_c.0, cellType: .rTitleDetail, formType: .citizenship))
            }
        }else if (result.employment_status_c as? String ?? "") == "6_6" || (result.employment_status_c as? String ?? "") == "6_7"{
            //"Business man", "Self-Employed", "Investor",
            let industry_type_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .industry_type_c, backendvalue: result.industry_type_c as? String ?? "")
            if industry_type_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Industry"), detail: industry_type_c.0, cellType: .rTitleDetail, formType: .citizenship))
            }
            let profession_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .profession_c, backendvalue: result.profession_c as? String ?? "")
            if profession_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Profession"), detail: profession_c.0, cellType: .rTitleDetail, formType: .citizenship))
            }
            if (result.name_of_business_c as? String ?? "").count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Name of Business"), detail: result.name_of_business_c as? String ?? "", cellType: .rTitleDetail, formType: .citizenship))
            }
            if education_level_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Education_level"), detail: education_level_c.0, cellType: .rTitleDetail, formType: .citizenship))
            }
        }else{
            //Housewife, Student, Minor, or Un-Employed
            if education_level_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Education_level"), detail: education_level_c.0, cellType: .rTitleDetail, formType: .citizenship))
            }
        }
        
        //--
        arrReviewAppData.append(RAData(title: Localize(key: "Financial_Information"), cellType: .rTitle, formType: .financialInformation))
        //--
        let have_other_source_of_income_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .have_other_source_of_income_c, backendvalue: result.have_other_source_of_income_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Do you have other income source?"), detail: have_other_source_of_income_c.0, cellType: .rTitleDetail, formType: .financialInformation))
        if (result.have_other_source_of_income_c as? String ?? "") == "Yes"{
            arrReviewAppData.append(RAData(title: Localize(key: "Other_Income_Source"), detail: result.specify_source_of_income_c as? String ?? "", cellType: .rTitleDetail, formType: .financialInformation))
        }
        
        arrReviewAppData.append(RAData(title: Localize(key: "Monthly Transactions"), cellType: .rSubTitle, formType: .personalInformation))
        if  (result.employment_status_c as? String ?? "") == "1"{
            //Employed
            if let salary_income_c = result.salary_income_c as? Float, salary_income_c > 0{
                let salary_income_flagcode_c = result.salary_income_flagcode_c as? String ?? ""
                let result = moneyFormatter.format(NSNumber(value: salary_income_c)) ?? ""
                arrReviewAppData.append(RAData(title: Localize(key: "Salary Income"), detail: "\(salary_income_flagcode_c) \(result)", cellType: .rTitleDetail, formType: .financialInformation))
            }
            let sources_of_fund_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .sources_of_fund_c, backendvalue: result.sources_of_fund_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Source of Funds"), detail: sources_of_fund_c.0, cellType: .rTitleDetail, formType: .financialInformation))
           
            let docEmployment_letter = docResult.documents.filter { obj in
                return obj.document_type == docTypeBackendValue(value: docType.employment_letter.rawValue) && obj.card_type == viewType.getValue(.other)()
            }
            if docEmployment_letter.count != 0{
                let document_link = docEmployment_letter.first?.document_link ?? ""
                arrReviewAppData.append(RAData(title: Localize(key: "Proof of Employment could be salary certificate or employment letter"), detail: "Filename.png", cellType: .rOtherDoc, formType: .financialInformation, frontImg: document_link, backImg: ""))
            }
        }else if (result.employment_status_c as? String ?? "") == "6_6" || (result.employment_status_c as? String ?? "") == "6_7"{
            //Investor, "Self-Employed", Business man
            
            //Show Business Detail
            let have_other_source_of_income_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .have_other_source_of_income_c, backendvalue: result.have_other_source_of_income_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Do you have other income source?"), detail: have_other_source_of_income_c.0, cellType: .rTitleDetail, formType: .financialInformation))
            arrReviewAppData.append(RAData(title: Localize(key: "Please Specify"), detail: result.specify_source_of_income_c as? String ?? "", cellType: .rTitleDetail, formType: .financialInformation))
            
            //--
            arrReviewAppData.append(RAData(title: Localize(key: "Name of Business"), detail: result.name_of_business_c as? String ?? "", cellType: .rTitleDetail, formType: .financialInformation))
            let percentage_of_ownership_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .percentage_of_ownership_c, backendvalue: result.percentage_of_ownership_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Percentage of ownership"), detail: percentage_of_ownership_c.0, cellType: .rTitleDetail, formType: .financialInformation))
            arrReviewAppData.append(RAData(title: Localize(key: "Monthly Income"), detail: result.monthly_income_c as? String ?? "", cellType: .rTitleDetail, formType: .financialInformation))
            
        }else{
            //Housewife, Student, Minor, or Un-Employed
            let name_of_fund_provider_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .name_of_fund_provider_c, backendvalue: result.name_of_fund_provider_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Source of fund/ Name of provider"), detail: name_of_fund_provider_c.0, cellType: .rTitleDetail, formType: .financialInformation))
            let relation_with_funds_provider_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .relation_with_funds_provider_c, backendvalue: result.relation_with_funds_provider_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Relationship with Customer"), detail: relation_with_funds_provider_c.0, cellType: .rTitleDetail, formType: .financialInformation))
            let occupation_of_fund_provider_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .occupation_of_fund_provider_c, backendvalue: result.occupation_of_fund_provider_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Occupation of Fund Provider"), detail: occupation_of_fund_provider_c.0, cellType: .rTitleDetail, formType: .financialInformation))
            if let monthly_income_range_c = Float("\(result.monthly_income_range_c as? String ?? "")"), monthly_income_range_c > 0{
                let monthly_incomerange_flagcode_c = result.monthly_incomerange_flagcode_c as? String ?? ""
                let result = moneyFormatter.format(NSNumber(value: monthly_income_range_c)) ?? ""
                arrReviewAppData.append(RAData(title: Localize(key: "Monthly income range of fund provider"), detail: "\(monthly_incomerange_flagcode_c) \(result)", cellType: .rTitleDetail, formType: .financialInformation))
            }
        }
        
        let expected_no_of_credit_trans_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .expected_no_of_credit_trans_c, backendvalue: result.expected_no_of_credit_trans_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Expected_Monthly_credit_transactions"), detail: expected_no_of_credit_trans_c.0, cellType: .rTitleDetail, formType: .financialInformation))
        if let expected_credit_amount_omr_c = Float("\(result.expected_credit_amount_omr_c as? String ?? "")"), expected_credit_amount_omr_c > 0{
            let expected_creditamt_flagcode_c = result.expected_creditamt_flagcode_c as? String ?? ""
            let result = moneyFormatter.format(NSNumber(value: expected_credit_amount_omr_c)) ?? ""
            arrReviewAppData.append(RAData(title: Localize(key: "Expected Credit Amount"), detail: "\(expected_creditamt_flagcode_c) \(result)", cellType: .rTitleDetail, formType: .financialInformation))
        }
        
        let expected_no_of_debit_trans_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .expected_no_of_debit_trans_c, backendvalue: result.expected_no_of_debit_trans_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Expected No of Monthly debit transactions"), detail: expected_no_of_debit_trans_c.0, cellType: .rTitleDetail, formType: .financialInformation))
        if let expected_debit_amount_omr_c = Float("\(result.expected_debit_amount_omr_c as? String ?? "")"), expected_debit_amount_omr_c > 0{
            let expected_debitamt_flagcode_c = result.expected_debitamt_flagcode_c as? String ?? ""
            let result = moneyFormatter.format(NSNumber(value: expected_debit_amount_omr_c)) ?? ""
            arrReviewAppData.append(RAData(title: Localize(key: "Expected Debit Amount"), detail: "\(expected_debitamt_flagcode_c) \(result)", cellType: .rTitleDetail, formType: .financialInformation))
        }
        
        //--Usual Mode of transactions
        if (result.usual_mode_of_transactions_c as? String ?? "").count != 0{
            var selectOtherUsualModeTransaction = false
            var selectUsualArr:[String] = []
            let usual_mode_of_transactions_c = (result.usual_mode_of_transactions_c as? String ?? "").components(separatedBy: ",")
            usual_mode_of_transactions_c.forEach { selectIndex in
                let title_ = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .usual_mode_of_transactions_c, backendvalue: selectIndex)
                selectUsualArr.append(title_.0)
                if selectIndex == "8"{
                    selectOtherUsualModeTransaction = true
                }
            }
            arrReviewAppData.append(RAData(title:  Localize(key: "Usual Mode of transactions"), detail: selectUsualArr.joined(separator: ",\n"), cellType: .rTitleDetail, formType: .financialInformation))
            if selectOtherUsualModeTransaction{
                arrReviewAppData.append(RAData(title: Localize(key: "Mention other mode of transaction"), detail: result.other_mode_of_transaction_c as? String ?? "", cellType: .rTitleDetail, formType: .financialInformation))
            }
        }
        
        //--
        arrReviewAppData.append(RAData(title: Localize(key: "Regularity Declaration"), cellType: .rTitle, formType: .regularityDeclaration))
        //--
        arrReviewAppData.append(RAData(title: Localize(key: "Purpose of opening an account?"), cellType: .rSubTitle, formType: .regularityDeclaration))
        let purpose_of_account_opening_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .purpose_of_account_opening_c, backendvalue: result.purpose_of_account_opening_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Purpose"), detail: purpose_of_account_opening_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
        if (result.other_purpose_of_account_c as? String ?? "") == "8"{
            arrReviewAppData.append(RAData(title: Localize(key: "Other_Purpose_of_opening_account"), detail: result.other_purpose_of_account_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
        }
        
        arrReviewAppData.append(RAData(title: Localize(key: "Are you holder of any US Documents?"), cellType: .rSubTitle, formType: .regularityDeclaration))
        let fatca_classification_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .fatca_classification_c, backendvalue: result.fatca_classification_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Documents"), detail: fatca_classification_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
        
        if (result.fatca_classification_c as? String ?? "") == "1"{
            //USA Nationality
            arrReviewAppData.append(RAData(title: Localize(key: "USDocuments_Details"), cellType: .rSubTitle, formType: .regularityDeclaration))
            
            arrReviewAppData.append(RAData(title: Localize(key: "Name (as shown on your income tax return)"), detail: result.name_fatca_w9_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Address"), detail: result.address_number_w9_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Street Name"), detail: result.street_number_facta_w9_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Flat/Villa No."), detail: result.apt_suite_no_facta_w9_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "City"), detail: result.city_facta_w9_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "State"), detail: result.state_facta_w9_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Zip Code"), detail: result.zip_code_facta_w9_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Social security number / Employer identification number"), detail: "\(result.ustaxpayer_id_fatca_w9_c as? Int ?? 0)", cellType: .rTitleDetail, formType: .regularityDeclaration))
        }
        if (result.fatca_classification_c as? String ?? "") == "3"{
            //Tax Resident of USA
            arrReviewAppData.append(RAData(title: Localize(key: "USDocuments_Details"), cellType: .rSubTitle, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Name of individual who is the beneficial owner"), detail: result.name_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Country of Citizenship"), detail: result.country_of_citizenship_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            
            arrReviewAppData.append(RAData(title: Localize(key: "Address"), detail: result.address_number_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Street Name"), detail: result.street_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Flat/Villa No."), detail: result.apt_suite_no_facta_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "City"), detail: result.city_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "State"), detail: result.state_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Zip Code"), detail: result.zip_code_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Country"), detail: result.country_facta_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            
            if (result.mailing_address_same_w8_c as? String ?? "") == "others"{
                arrReviewAppData.append(RAData(title: Localize(key: "Mailing_Address_Details"), cellType: .rSubTitle, formType: .regularityDeclaration))
                arrReviewAppData.append(RAData(title: Localize(key: "Address"), detail: result.mailing_address_number_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
                arrReviewAppData.append(RAData(title: Localize(key: "Street Name"), detail: result.mailing_street_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
                arrReviewAppData.append(RAData(title: Localize(key: "Flat/Villa No."), detail: result.mailing_apt_suite_no_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
                arrReviewAppData.append(RAData(title: Localize(key: "City"), detail: result.mailing_city_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
                arrReviewAppData.append(RAData(title: Localize(key: "State"), detail: result.mailing_state_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
                arrReviewAppData.append(RAData(title: Localize(key: "Zip Code"), detail: result.mailing_postal_code_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
                arrReviewAppData.append(RAData(title: Localize(key: "Country"), detail: result.mailing_country_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            }
            
            arrReviewAppData.append(RAData(title: Localize(key: "U.S. taxpayer identification number (SSN or ITIN)"), detail: result.us_taxpayer_id_fatca_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Foreign tax identifying number"), detail: result.foreign_tax_id_number_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Reference number(s)"), detail: result.reference_number_w8_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
        }
        
        arrReviewAppData.append(RAData(title: Localize(key: "Are you Politically Exposed Person (PEP)?"), cellType: .rSubTitle, formType: .regularityDeclaration))
        let is_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .is_pep_c, backendvalue: result.is_pep_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Politically_Exposed_Person"), detail: is_pep_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
        if (result.is_pep_c as? String ?? "") == "Y"{
            arrReviewAppData.append(RAData(title: Localize(key: "PEP Details"), cellType: .rSubTitle, formType: .regularityDeclaration))
            let type_of_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .type_of_pep_c, backendvalue: result.type_of_pep_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Type of PEP"), detail: type_of_pep_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Name of the PEP"), detail: result.name_of_the_pep_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            arrReviewAppData.append(RAData(title: Localize(key: "Position of the PEP"), detail: result.position_of_pep_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
            
            let nationality_of_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .nationality_of_pep_c, backendvalue: result.nationality_of_pep_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Nationality of PEP"), detail: nationality_of_pep_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
            let country_of_residence_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.country_of_residence_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Country of Residence of PEP"), detail: country_of_residence_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
            let relationship_with_the_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .relationship_with_the_pep_c, backendvalue: result.relationship_with_the_pep_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Relationship with the PEP"), detail: relationship_with_the_pep_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
            let source_of_wealth_of_pep_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .source_of_wealth_of_pep_c, backendvalue: result.source_of_wealth_of_pep_c as? String ?? "")
            arrReviewAppData.append(RAData(title: Localize(key: "Source_wealth_PEP"), detail: source_of_wealth_of_pep_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
        }
        
        arrReviewAppData.append(RAData(title: Localize(key: "Are you a tax resident of a country other than Sultanate of Oman?"), cellType: .rSubTitle, formType: .regularityDeclaration))
        let is_crs_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .is_crs_c, backendvalue: result.is_crs_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "tax_resident_sultanate_oman"), detail: is_crs_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
        if (result.is_crs_c as? String ?? "") == "1"{
            let country_of_tax_residence_crs_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.country_of_tax_residence_crs_c as? String ?? "")
            if country_of_tax_residence_crs_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Country_Jurisdiction_of_Tax_residence"), detail: country_of_tax_residence_crs_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
                if (result.tin_c as? String ?? "").count != 0{
                    arrReviewAppData.append(RAData(title: Localize(key: "Taxpayer Identification Number (TIN)"), detail: result.tin_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
                }else{
                    let reason_if_no_taxpayerid_crs_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .reason_if_no_taxpayerid_crs_c, backendvalue: "\(Int(result.reason_if_no_taxpayerid_crs_c as? String ?? "") ?? 1)")
                    arrReviewAppData.append(RAData(title: Localize(key: "no_TIN_available"), detail: "\(getCRSReasonTitle(selectIndex: reason_if_no_taxpayerid_crs_c.1))\n\n\(Localize(key: "Country1ADetail"))", cellType: .rTitleDetail, formType: .regularityDeclaration))
                }
            }
            
            let country_of_tax_residence2_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.country_of_tax_residence2_c as? String ?? "")
            if country_of_tax_residence2_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Country_Jurisdiction_of_Tax_residence"), detail: country_of_tax_residence2_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
                if (result.tin2_c as? String ?? "").count != 0{
                    arrReviewAppData.append(RAData(title: Localize(key: "Taxpayer Identification Number (TIN)"), detail: result.tin2_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
                }else{
                    let reason_if_no_taxpayerid_crs2_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .reason_if_no_taxpayerid_crs_c, backendvalue: "\(Int(result.reason_if_no_taxpayerid_crs2_c as? String ?? "") ?? 1)")
                    arrReviewAppData.append(RAData(title: Localize(key: "no_TIN_available"), detail: "\(getCRSReasonTitle(selectIndex: reason_if_no_taxpayerid_crs2_c.1))\n\n\(Localize(key: "Country1BDetail"))", cellType: .rTitleDetail, formType: .regularityDeclaration))
                }
            }
            
            let country_of_tax_residence3_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .country_of_birth_c, backendvalue: result.country_of_tax_residence3_c as? String ?? "")
            if country_of_tax_residence3_c.0.count != 0{
                arrReviewAppData.append(RAData(title: Localize(key: "Country_Jurisdiction_of_Tax_residence"), detail: country_of_tax_residence3_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
                if (result.tin3_c as? String ?? "").count != 0{
                    arrReviewAppData.append(RAData(title: Localize(key: "Taxpayer Identification Number (TIN)"), detail: result.tin3_c as? String ?? "", cellType: .rTitleDetail, formType: .regularityDeclaration))
                }else{
                    let reason_if_no_taxpayerid_crs3_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .reason_if_no_taxpayerid_crs_c, backendvalue: "\(Int(result.reason_if_no_taxpayerid_crs3_c as? String ?? "") ?? 1)")
                    arrReviewAppData.append(RAData(title: Localize(key: "no_TIN_available"), detail: "\(getCRSReasonTitle(selectIndex: reason_if_no_taxpayerid_crs3_c.1))\n\n\(Localize(key: "Country1CDetail"))", cellType: .rTitleDetail, formType: .regularityDeclaration))
                }
            }
        }
        
        arrReviewAppData.append(RAData(title: Localize(key: "Proof of Address"), cellType: .rSubTitle, formType: .regularityDeclaration))
        let proof_of_address_doctype_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .proof_of_address_doctype_c, backendvalue: result.proof_of_address_doctype_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Documents"), detail: proof_of_address_doctype_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
        
        //address_proof
        let docAddress_proof = docResult.documents.filter { obj in
            return obj.document_type == docTypeBackendValue(value: docType.address_proof.rawValue) && obj.card_type == viewType.getValue(.other)()
        }
        if docAddress_proof.count != 0{
            let document_link = docAddress_proof.first?.document_link ?? ""
            arrReviewAppData.append(RAData(title: proof_of_address_doctype_c.0, detail: "Filename.png", cellType: .rOtherDoc, formType: .citizenship, frontImg: document_link, backImg: ""))
        }
        
        arrReviewAppData.append(RAData(title: Localize(key: "Nearest_Branch"), cellType: .rSubTitle, formType: .regularityDeclaration))
        let branch_c = ManageDropDownOption.getDropDownBackendValueToLabelAndIndex(dropdown_filed: .branch_c, backendvalue: result.branch_c as? String ?? "")
        arrReviewAppData.append(RAData(title: Localize(key: "Location"), detail: branch_c.0, cellType: .rTitleDetail, formType: .regularityDeclaration))
        
        
        tblList.reloadData()
        
        
        viewDidLayoutSubviews()
    }
    func getCRSReasonTitle(selectIndex: Int) -> String{
        
        if selectIndex == 1{
            //A
            return Localize(key: "Country1ATitle")
        }else if selectIndex == 2{
            //B
            return Localize(key: "Country1BTitle")
        }else if selectIndex == 3{
            //C - 300
            return Localize(key: "Country1CTitle")
        }else{
            return ""
        }
    }
    
   /*
    func getDocumentsList(result: GetApplicationDataResult){
        //LoadingView.shared.openLodingAlert(view: self.view)
        apiCall_getDocumentsList (showProgress: false){ [self] docResult in
            LoadingView.shared.dismissLoadingView()
            
            if "\(result.citizenship_c as? String ?? "")" == CitizenshipType.omani.rawValue{
                let docObj = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.national.rawValue) && obj.card_type == viewType.getValue(.front)()
                }
                let frontImagURL = docObj.first?.document_link ?? ""
                
                let docObjB = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.national.rawValue) && obj.card_type == viewType.getValue(.rear)()
                }
                let backImgURL = docObjB.first?.document_link ?? ""
                
                arrReviewAppData.insert(RAData(title: "Documents", detail: "Omani National ID", cellType: .rDocument, formType: .citizenship, frontImg: frontImagURL, backImg: backImgURL), at: 2)
                tblList.reloadData()
                viewDidLayoutSubviews()
                
            }else if "\(result.citizenship_c as? String ?? "")" == CitizenshipType.expatriate.rawValue{
                //Resident
                let docObjresident = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.resident.rawValue) && obj.card_type == viewType.getValue(.front)()
                }
                let frontImagURLresident = docObjresident.first?.document_link ?? ""
                
                let docObjBresident = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.resident.rawValue) && obj.card_type == viewType.getValue(.rear)()
                }
                let backImgURLresident = docObjBresident.first?.document_link ?? ""
                
                arrReviewAppData.insert(RAData(title: "Documents", detail: Localize(key: "Resident ID"), cellType: .rDocument, formType: .citizenship, frontImg: frontImagURLresident, backImg: backImgURLresident), at: 2)
                
                //Password
                let docObjPassport = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.passport.rawValue) && obj.card_type == viewType.getValue(.front)()
                }
                let backImgURLpassport = docObjPassport.first?.document_link ?? ""
                
                arrReviewAppData.insert(RAData(title: "", detail: Localize(key: "Passport"), cellType: .rDocument, formType: .citizenship, frontImg: backImgURLpassport, backImg: ""), at: 3)
                
                //Visa Card
                let docObjvisa = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.visa.rawValue) && obj.card_type == viewType.getValue(.other)()
                }
                let backImgURLVisa = docObjvisa.first?.document_link ?? ""
                
                arrReviewAppData.insert(RAData(title: "", detail: Localize(key: "Valid Visa"), cellType: .rDocument, formType: .citizenship, frontImg: backImgURLVisa, backImg: ""), at: 4)
                
                tblList.reloadData()
                viewDidLayoutSubviews()
                
            }else if "\(result.citizenship_c as? String ?? "")" == CitizenshipType.gcc.rawValue{
                //gcc
                //National id
                let docObjgcc = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.gcc.rawValue) && obj.card_type == viewType.getValue(.front)()
                }
                let frontImgURLgcc = docObjgcc.first?.document_link ?? ""
                
                let docObjBgcc = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.gcc.rawValue) && obj.card_type == viewType.getValue(.rear)()
                }
                let backImgURLgcc = docObjBgcc.first?.document_link ?? ""
                
                arrReviewAppData.insert(RAData(title: "Documents", detail: Localize(key: "National ID"), cellType: .rDocument, formType: .citizenship, frontImg: frontImgURLgcc, backImg: backImgURLgcc), at: 2)
                
                //Password
                let docObjPassport = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.passport.rawValue) && obj.card_type == viewType.getValue(.front)()
                }
                let backImgURLpassport = docObjPassport.first?.document_link ?? ""
                
                arrReviewAppData.insert(RAData(title: "", detail: Localize(key: "Passport"), cellType: .rDocument, formType: .citizenship, frontImg: backImgURLpassport, backImg: ""), at: 3)
                
                tblList.reloadData()
                viewDidLayoutSubviews()
            }else{
                //customer_photo
                let docCustomer_photo = docResult.documents.filter { obj in
                    return obj.document_type == docTypeBackendValue(value: docType.customer_photo.rawValue) && obj.card_type == viewType.getValue(.other)()
                }
                if docCustomer_photo.count != 0{
                    let document_link = docCustomer_photo.first?.document_link ?? ""
                    arrReviewAppData.insert(RAData(title: "Profile Pic", detail: "Profile Pic.png", cellType: .rOtherDoc, formType: .citizenship, frontImg: document_link, backImg: ""), at: 3)
                    
                    tblList.reloadData()
                    viewDidLayoutSubviews()
                }
            }
            
        }
    }*/
    
}


extension ReviewApplicationVC: LightboxControllerDismissalDelegate, LightboxControllerPageDelegate{
    func setupLightBoxImageArray(imgOpen:UIImage? = nil, msg: String, imgURL: URL? = nil){
        //--
        var images_LightBox:[LightboxImage] = []
        
        if imgURL != nil{
            if let imgURL_ = imgURL{
                images_LightBox.append(LightboxImage(imageURL: imgURL_))
            }
        }else{
            if let imgOpen_ = imgOpen{
                images_LightBox.append(LightboxImage(image: imgOpen_, text: msg))
            }
        }
        
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

extension ReviewApplicationVC: UIScrollViewDelegate{
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
