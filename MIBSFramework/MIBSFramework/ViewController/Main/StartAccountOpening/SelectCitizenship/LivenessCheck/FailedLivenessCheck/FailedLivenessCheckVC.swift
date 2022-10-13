//
//  FailedLivenessCheckVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 27/01/22.
//

import UIKit
////import Popover

class FailedLivenessCheckVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValidation: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblScheduleVideoCall_title: UILabel!
    @IBOutlet weak var lblDetail_ScheduelVideoCall: UILabel!
    @IBOutlet weak var lblGotodashboard: UILabel!
    @IBOutlet weak var lblHeaderTitle_: UILabel!
    
    //MARK: - Veriable
    var popover = Popover()
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupBasic()
        localization()
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
    
        lblHeaderTitle_.text = Localize(key: "Liveness Check")
        //--
        //lblTitle.attributedText = Localize(key: "Facial Match or other details verification failed").attributedStringWithColor(["verification"], color: .DARKGREENTINT)
        lblDetail.text = Localize(key: "Please schedule a video call with one of our agents")
        
        lblValidation.text = Localize(key: "You have failed 3 attempts for liveness check")
        lblScheduleVideoCall_title.text = Localize(key: "Schedule Video Call")
        lblDetail_ScheduelVideoCall.text = Localize(key: "Schedule Video Call Detail")
        
        lblGotodashboard.text = Localize(key: "GO TO DASHBOARD")
        
    }
    func setupHeader(){

        headerView.nav = self.navigationController!
        headerView.lblHeaderTitle.text = ""
        headerView.didTappedBack = { (sender) in
            //self.navigationController?.popViewController(animated: true)
            self.openAlert()
        }
    }
    func setupBasic(){
     
   
        
        
    }
    func openAlert(){
       
        //--
        popover.dismiss()
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = Localize(key: "cannot_got_back_liveness_failed")
        alert.btnGotoApplication.isHidden = true
        alert.btnContinueApplication.isHidden = true
        
        alert.btnCancel.setTitle(Localize(key: "GOT IT"), for: .normal)
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
    //MARK: @IBAction
    @IBAction func btnScheduleVideoCall(_ sender: Any) {
        //--
        let vc = ScheduleVideoCallVC(nibName: "ScheduleVideoCallVC", bundle: bundleIdentifireGlob)
        vc.isComeFromLivenessCheck = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnGotoDashboard(_ sender: Any) {
        //--
        let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}


