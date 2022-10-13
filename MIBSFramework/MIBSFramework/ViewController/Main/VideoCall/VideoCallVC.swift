//
//  VideoCallVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 14/07/22.
//

import UIKit

import JitsiMeetSDK
import AVKit
import Photos

class VideoCallVC: UIViewController {

    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lblNoVideoCallscheduled: UILabel!
    @IBOutlet weak var viewbgNoVideoCall: UIView!
    @IBOutlet weak var viewbgbtnScheduleaCall: UIView!
    @IBOutlet weak var lblScheduleaCall: UILabel!
    
    
    //MARK: - Veriable
    var getNotificationDetailsList:[GetNotificationDetailsList] = []
    
    //Jitsi
    fileprivate var jitsiMeetView: JitsiMeetView?
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        registerCell()
        setupbasic()
        apiCall_getNotificationDetails()
        
        //--
        askPermissionPhotos()
        
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
        let location_ = Managelanguage.getLanguageCode() == "A" ? 5 : 8
        let length_ = Managelanguage.getLanguageCode() == "A" ? 12 : 11
        lblTitle.attributedText = Localize(key: "Schedule Video Call").attributedStringWithColorNew(location_, length: length_, color: .DARKGREENTINT)
    }
    func registerCell(){
        tblList.register(UINib(nibName: "VideoCallTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "VideoCallTblCell")
    }

    //MARK: - @IBAction
    @IBAction func btnSchedualVideoCall(_ sender: Any) {
        //--
        let vc = ScheduleVideoCallVC(nibName: "ScheduleVideoCallVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension VideoCallVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNotificationDetailsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCallTblCell", for: indexPath) as! VideoCallTblCell
        cell.selectionStyle = .none
        
        cell.lblTitle.text = getNotificationDetailsList[indexPath.row].name
        cell.lblDetail.text = getNotificationDetailsList[indexPath.row].description
        cell.lblDate.text = getNotificationDetailsList[indexPath.row].date
        
        cell.didTappedStartCall = { (sender) in
            
            let link = self.getNotificationDetailsList[indexPath.row].link
            self.openVideoCall(roomID: link)
//            if let url = URL(string: link){
//                self.openVideoCall(roomID: url.lastPathComponent)//"26750ce4-cd38-db9d-1633-62ce73e4c50e") //self.getNotificationDetailsList[indexPath.row].notification_crmid)
//            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


//MARK: - Api Call
extension VideoCallVC{
    
    func apiCall_getNotificationDetails()  {
        
        let dicParam:[String:AnyObject] = ["operation":"getNotificationDetails" as AnyObject,
                                           "data":["crmid": Login_LocalDB.getApplicationInfo().crmid,
                                                   "device_info":deviceInfo
                                                  ] as AnyObject]
        LoadingView.shared.openLodingAlert(view: self.view)
        HttpWrapper.requestWithPostMethod(url: a_mibs, dicsParams: dicParam, headers: ["Authorization":"Bearer \(Login_LocalDB.getLoginUserModel().mobileApiData?.access_token ?? "")"], showProgress: false, completion: { [self] (response) in
            LoadingView.shared.dismissLoadingView()
            print(response as Any)
            let getNotificationDetailsModel = GetNotificationDetailsModel(JSON: response as! [String : Any])!
            if let notifications = getNotificationDetailsModel.Response?.Body?.Result?.notifications{
                getNotificationDetailsList = notifications.filter({ getNotificationDetailsList_ in
                    getNotificationDetailsList_.type == "startvideocall"
                })
                tblList.reloadData()
            }
            
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
            LoadingView.shared.dismissLoadingView()
        }
    }
    func showNoDataFound(){
        viewbgbtnScheduleaCall.isHidden = false
        viewbgNoVideoCall.isHidden = false
    }
    func hideNoDataFound(){
        viewbgbtnScheduleaCall.isHidden = true
        viewbgNoVideoCall.isHidden = true
    }
    
}

//MARK: - JitsiMeetViewDelegate
extension VideoCallVC: JitsiMeetViewDelegate{
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
