//
//  NotificationSBVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 07/09/22.
//

import UIKit
//import ReadMoreTextView

import JitsiMeetSDK
import AVKit
import Photos
//import Lottie


class NotificationSBVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblList: UITableView! {
        didSet {
            tblList.estimatedRowHeight = 100
            tblList.rowHeight = UITableView.automaticDimension
        }
    }
    @IBOutlet weak var viewbgNoData: UIView!
    @IBOutlet weak var lblDataNotAvailable: UILabel!
    
    //MARK: - Veriable
    var getNotificationDetailsList:[GetNotificationDetailsList] = []
    var expandedCells = Set<Int>()
    var serviceType: ServiceType?
    //Jitsi
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        //registerCell()
        setupbasic()
        apiCall_getNotificationDetails(showProgress: false)
        
        //--
        askPermissionPhotos()
    }
    override func viewDidLayoutSubviews() {
        tblList.reloadData()
    }
    func setupHeader(){
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    func setupbasic(){
        viewbgNoData.isHidden = true
        if serviceType == .StartVideoCall{
            let location_ = Managelanguage.getLanguageCode() == "A" ? 5 : 8
            let length_ = Managelanguage.getLanguageCode() == "A" ? 12 : 11
            lblTitle.attributedText = Localize(key: "Schedule Video Call").attributedStringWithColorNew(location_, length: length_, color: .DARKGREENTINT)
            lblDataNotAvailable.text = Localize(key: "no_video_call_scheduled")
        }else{
            lblTitle.text = Localize(key: "notifications")
            lblDataNotAvailable.text = Localize(key: "no_notifications")
        }
    }
    func registerCell(){
        
        
    }
    
    
    //MARK: - @IBAction
    @IBAction func btnStartVideoCallTblCell(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblList)
        guard let indexPath = self.tblList.indexPathForRow(at: buttonPosition) else { return }
        
        if self.getNotificationDetailsList[indexPath.row].type == "add_on_services"{
            //--
            let vc = AddonServicesVC(nibName: "AddonServicesVC", bundle: bundleIdentifireGlob)
            vc.isComeFromNotification = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if self.getNotificationDetailsList[indexPath.row].type == "additional_info_required"{
            //--
            let vc = ProofofAddressVC(nibName: "ProofofAddressVC", bundle: bundleIdentifireGlob)
            vc.isComeFromNotification = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if self.getNotificationDetailsList[indexPath.row].type == "startvideocall"{
            //
            let link = self.getNotificationDetailsList[indexPath.row].link
            self.openVideoCall(roomID: link)
        }
       
        apiCall_updateReadNotification(notification_crmid: self.getNotificationDetailsList[indexPath.row].notification_crmid)
        
    }
    
    
    
}

extension NotificationSBVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNotificationDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTBlSBCell", for: indexPath) as! NotificationTBlSBCell
        cell.selectionStyle = .none
        let lbltitle = cell.contentView.viewWithTag(2) as! UILabel
        let viewbgStatus = cell.contentView.viewWithTag(3)!
        let lbldate = cell.contentView.viewWithTag(4) as! UILabel
        let readMoreTextView = cell.contentView.viewWithTag(5) as! ReadMoreTextView
        let viewbgLine = cell.contentView.viewWithTag(100)!
        let btnStartVideoCall = cell.contentView.viewWithTag(6) as! UIButton
        
        //--
        let underLineStyle = NSUnderlineStyle.single.rawValue
        let readMoreTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2590000033, green: 0.5329999924, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "Gotham-Book", size: 16.0) as Any,
            NSAttributedString.Key.underlineStyle: underLineStyle,
            NSAttributedString.Key.underlineColor: #colorLiteral(red: 0.2590000033, green: 0.5329999924, blue: 0, alpha: 1)
        ]
        let readLessTextAttributes = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2590000033, green: 0.5329999924, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "Gotham-Book", size: 16.0) as Any,
            NSAttributedString.Key.underlineStyle: underLineStyle,
            NSAttributedString.Key.underlineColor: #colorLiteral(red: 0.2590000033, green: 0.5329999924, blue: 0, alpha: 1)
        ] as [NSAttributedString.Key : Any]
        readMoreTextView.attributedReadMoreText = NSAttributedString(string: Localize(key: "view_more"), attributes: readMoreTextAttributes)
        readMoreTextView.attributedReadLessText = NSAttributedString(string: Localize(key: "view_less"), attributes: readLessTextAttributes as [NSAttributedString.Key : Any])
        
        //--
        let dicData = getNotificationDetailsList[indexPath.row]
        lbltitle.text = dicData.name
        readMoreTextView.text = dicData.description
        lbldate.text = dicData.date
        
        if dicData.read_status == 0{
            viewbgStatus.backgroundColor = .DARKGREENTINT
        }else{
            viewbgStatus.backgroundColor = .LIGHTGREY
        }
        
        //--
        if dicData.type == "add_on_services"{
            viewbgLine.isHidden = false
            cell.btnStartVideoCall_height.constant = 40
            //btnStartVideoCall.heightAnchor.constraint(equalToConstant: 40).isActive = true
            btnStartVideoCall.isHidden = false
            btnStartVideoCall.setTitle(Localize(key: "Add-on Services"), for: .normal)
        }else if dicData.type == "additional_info_required"{
            viewbgLine.isHidden = false
            cell.btnStartVideoCall_height.constant = 40
            //btnStartVideoCall.heightAnchor.constraint(equalToConstant: 40).isActive = true
            btnStartVideoCall.isHidden = false
            btnStartVideoCall.setTitle(Localize(key: "Additional Information"), for: .normal)
        }else if dicData.type == "startvideocall"{
            viewbgLine.isHidden = false
            cell.btnStartVideoCall_height.constant = 40
            //btnStartVideoCall.heightAnchor.constraint(equalToConstant: 40).isActive = true
            btnStartVideoCall.isHidden = false
            btnStartVideoCall.setTitle(Localize(key: "start_video_call"), for: .normal)
        }else{
            viewbgLine.isHidden = true
            cell.btnStartVideoCall_height.constant = 0
            //btnStartVideoCall.heightAnchor.constraint(equalToConstant: 0).isActive = true
            btnStartVideoCall.isHidden = true
            btnStartVideoCall.setTitle("", for: .normal)
            viewbgStatus.backgroundColor = .DARKGREENTINT
        }
        
        //--
        readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.row)
        readMoreTextView.setNeedsUpdateTrim()
        readMoreTextView.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let readMoreTextView = cell.contentView.viewWithTag(5) as! ReadMoreTextView
        readMoreTextView.onSizeChange = { [unowned tableView, unowned self] r in
            let point = tableView.convert(r.bounds.origin, from: r)
            guard let indexPath = tableView.indexPathForRow(at: point) else { return }
            if r.shouldTrim {
                self.expandedCells.remove(indexPath.row)
            } else {
                self.expandedCells.insert(indexPath.row)
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        let readMoreTextView = cell.contentView.viewWithTag(5) as! ReadMoreTextView
        readMoreTextView.shouldTrim = !readMoreTextView.shouldTrim
    }
    
}

//MARK: - Api Call
extension NotificationSBVC{
    func apiCall_updateReadNotification(notification_crmid: String)  {
        
        let dicParam:[String:AnyObject] = ["operation":"updateReadNotification" as AnyObject,
                                           "data":["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                   "notification_crmid": notification_crmid,
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { (response) in
            
            print(response as Any)
            self.apiCall_getNotificationDetails(showProgress: false)
            
        }) { (error) in
            print(error)
        }
    }
    
    func apiCall_getNotificationDetails(showProgress: Bool)  {
        
        let dicParam:[String:AnyObject] = ["operation":"getNotificationDetails" as AnyObject,
                                           "data":["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                   "language":Managelanguage.getLanguageCode(),
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: showProgress, completion: { [self] (response) in
            
            print(response as Any)
            let getNotificationDetailsModel = GetNotificationDetailsModel(JSON: response as! [String : Any])!
            if let notifications = getNotificationDetailsModel.Response?.Body?.Result?.notifications{
                if serviceType == .StartVideoCall{
                    getNotificationDetailsList = notifications.filter({ getNotificationDetailsList_ in
                        getNotificationDetailsList_.type == "startvideocall"
                    })
                }else{
                    getNotificationDetailsList = notifications //.filter({ getNotificationDetailsList_ in
                    //                    getNotificationDetailsList_.type == "startvideocall"
                    //                })
                }
                
                tblList.reloadData()
            }
            tblList.reloadData()
            if getNotificationDetailsList.count == 0{
                showNoDataFound()
            }else{
                hideNoDataFound()
            }
            
            if getNotificationDetailsModel.Response?.Body?.status == "Success"{
                
            }else{
                self.view.makeToast(getNotificationDetailsModel.Response?.Body?.statusMsg ?? "")
            }
        }) { (error) in
            print(error)
            //--
            showAlertForRetryApiCall(view_: AppHelper.returnTopNavigationController().view) { [self] onClickRetry in
                if onClickRetry{
                    apiCall_getNotificationDetails(showProgress: true)
                }
            }
        }
    }
    func showNoDataFound(){
        viewbgNoData.isHidden = false
    }
    func hideNoDataFound(){
        viewbgNoData.isHidden = true
    }
    
}

class NotificationTBlSBCell : UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtDetail: ReadMoreTextView!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var lblDate: UILabel!
    //@IBOutlet weak var txtDetail_Height: NSLayoutConstraint!
    @IBOutlet weak var btnStartVideoCall: UIButton!
    @IBOutlet weak var btnStartVideoCall_height: NSLayoutConstraint!
    @IBOutlet weak var viewLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        txtDetail.onSizeChange = { _ in }
        txtDetail.shouldTrim = true
    }
    
}


//MARK: - JitsiMeetViewDelegate
extension NotificationSBVC: JitsiMeetViewDelegate{
    func openVideoCall(roomID: String){
        if(AVCaptureDevice.authorizationStatus(for: .video) == .authorized && AVAudioSession.sharedInstance().recordPermission == .granted) {
            
            let room = roomID
            if(room.count < 1) {
                return
            }
            let jitsiMV = JitsiMeetView()
            jitsiMV.delegate = self
            self.jitsiMeetView = jitsiMV
            
            let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                //builder.serverURL = URL(string: "https://meettest.simplebotzdevelopment.com")//"https://mibsvideokyctest.dob.bankdhofar.com") //"https://meettest.simplebotzdevelopment.com")//"https://mibsvideokyctest.dob.bankdhofar.com/")
                builder.room = room
                //builder.welcomePageEnabled = false
                
                builder.setFeatureFlag("chat.enabled", withBoolean: false)
                builder.setFeatureFlag("notifications.enabled", withBoolean: false)
                builder.setFeatureFlag("invite.enabled", withBoolean: false)
                
                builder.setFeatureFlag("ios.recording.enabled", withBoolean: true)
                builder.setFeatureFlag("speakerstats.enabled", withBoolean: false)
                
                //Overeflow menu
                builder.setFeatureFlag("live-streaming.enabled", withBoolean: false)
                
                //--SECURITY
                builder.setFeatureFlag("lobby-mode.enabled", withBoolean: false)
                builder.setFeatureFlag("meeting-password.enabled", withBoolean: false)
                builder.setFeatureFlag("security-options.enabled", withBoolean: false)
                
                builder.setFeatureFlag("video-share.enabled", withBoolean: false)
                builder.setFeatureFlag("tile-view.enabled", withBoolean: false)
                
                builder.setFeatureFlag("reactions.enabled", withBoolean: false)
                builder.setFeatureFlag("raise-hand.enabled", withBoolean: false)
                
                builder.setFeatureFlag("disableKick", withBoolean: true)
                
                builder.setFeatureFlag("overflow-menu.enabled", withBoolean: false)
                
                //builder.setFeatureFlag("pip.enabled", withBoolean: false)
                //builder.setFeatureFlag("reactions.enabled", withBoolean: false)
                //builder.setFeatureFlag("close-captions.enabled", withBoolean: false)
                
//                builder.setFeatureFlag("meeting-password.enabled", withBoolean: false)
//                builder.setFeatureFlag("pip.enabled", withBoolean: false)
//                builder.setFeatureFlag("raise-hand.enabled", withBoolean: false)
//                builder.setFeatureFlag("video-share.enabled", withBoolean: false)
//
//
//                builder.setFeatureFlag("tile-view.enabled", withBoolean: false)
//                builder.setFeatureFlag("kick-out.enabled", withBoolean: false)
//                builder.setFeatureFlag("call-integration.enabled", withBoolean: false)
//                builder.setFeatureFlag("close-captions.enabled", withBoolean: false)
//                builder.setFeatureFlag("server-url-change.enabled", withBoolean: false)
//                builder.setFeatureFlag("calendar.enabled", withBoolean: false)
//
//                builder.setFeatureFlag("overflow-menu.enabled", withBoolean: true)
//
//                builder.setFeatureFlag("recording.enabled", withBoolean: true)
//                //builder.setFeatureFlag("toolbox.enabled", withBoolean: true)
//                builder.setFeatureFlag("meeting-name.enabled", withBoolean: true)
//                builder.setFeatureFlag("audio-mute.enabled", withBoolean: true)
//               builder.setFeatureFlag("video-mute.enabled", withBoolean: true)
                
            }
            
            let vc = UIViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.view = jitsiMV
            
            jitsiMV.join(options)
            present(vc, animated: true, completion: nil)
        } else {
            if(AVCaptureDevice.authorizationStatus(for: .video) != .authorized) {
                alertPromptToAllowCameraAccessViaSettings()
            }
            if(AVAudioSession.sharedInstance().recordPermission != .granted) {
                alertPromptToAllowMicrophoneAccessViaSettings()
            }
        }
    }
    
    fileprivate func cleanUp() {
        if(jitsiMeetView != nil) {
            dismiss(animated: true, completion: nil)
            jitsiMeetView = nil
        }
    }

    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        cleanUp()
        print(data as Any)
        
        //fetchVideoCallEndStatus(callStatus: "success")
    }
    func ready(toClose data: [AnyHashable : Any]!) {
        print("cancel")
    }
    
    
    //MARK: - Permission
    func askPermissionPhotos(){
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{

                } else {

                }
                
                self.cameraPermission()
            })
        }else{
            cameraPermission()
        }
    }
    
    func cameraPermission() {
        // check if the device has a camera
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            self.microphonePermission()
            let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch authStatus {
            case .authorized:
                print("camera permission is already granted")
                //                    microphonePermission()
                
            case .denied:
                //                    alertPromptToAllowCameraAccessViaSettings()
                print("camera permission is denied")
                permissionForCameraAccess()
            case .notDetermined:
                permissionForCameraAccess()
                
            default:
                permissionForCameraAccess()
            }
        } else {
            self.microphonePermission()
            
            let alertController = UIAlertController(title: "Error", message: "Device has no camera", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            //videoConfButton.isEnabled = false
            //smileDetectorButton.isEnabled = false
            present(alertController, animated: true, completion: nil)
        }
    }
    func permissionForCameraAccess() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            DispatchQueue.main.async {
                //                self?.cameraPermission()
                
            }
        })
    }
    
    func microphonePermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            print("microphone permission is already granted")
            
        case .denied:
            //                alertPromptToAllowMicrophoneAccessViaSettings()
            print("microphone permission is denied")
            permissionForCameraAccess()
        case .undetermined:
            permissionForMicrophoneAccess()
            
        default:
            permissionForMicrophoneAccess()
        }
    }
    
   
    func permissionForMicrophoneAccess() {
        AVAudioSession.sharedInstance().requestRecordPermission({ granted in
            DispatchQueue.main.async {
                //                self?.microphonePermission()
            }
        })
    }
    func alertPromptToAllowCameraAccessViaSettings() {
        let alert = UIAlertController(title: "This app would like to access the camera", message: "Please grant permission to use the Camera.", preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Open Settings", style: .cancel) { alert in
            if let appSettingsURL = NSURL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettingsURL as URL)
            }
        })
        present(alert, animated: true, completion: nil)
    }
    func alertPromptToAllowMicrophoneAccessViaSettings() {
        let alert = UIAlertController(title: "This app would like to access the microphone", message: "Please grant permission to use the Microphone.", preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Open Settings", style: .cancel) { alert in
            if let appSettingsURL = NSURL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettingsURL as URL)
            }
        })
        present(alert, animated: true, completion: nil)
    }
}
