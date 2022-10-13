//
//  RequestSentLivenesscheckVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 27/01/22.
//

import UIKit
//import Popover

class RequestSentLivenesscheckVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblGotoDashboard: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    //MARK: - Veriable
    var popover = Popover()
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        localization()
    
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblTitle.text = Localize(key: "request_sent")
        lblDetail.text = Localize(key: "livenss_failed_schedule_video_call_desc")
        
        lblGotoDashboard.text = Localize(key: "GO TO DASHBOARD")
        btnContinue.setTitle(Localize(key: "CONTINUE APPLICATION"), for: .normal)
    }
    func setupHeader(){
         
        headerView.nav = self.navigationController!
        headerView.lblHeaderTitle.text = Localize(key: "ScheduleVideoCall_title")
        headerView.didTappedBack = { (sender) in
            //self.openAlert()
            self.navigationController?.popViewController(animated: true)
        }
    }
    /*func openAlert(){
       
        //--
        popover.dismiss()
        popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Alert")
        alert.lblMessage.text = Localize(key: "cannot_go_to_back_liveness_success")
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
        popover.showAsDialog(alert, inView: self.view)
    }*/

    //MARK: @IBAction
    @IBAction func btnGoToDashboard(_ sender: Any) {
        //--
        let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnContinue(_ sender: Any) {
        //--
        let vc = TermsConditionsVC(nibName: "TermsConditionsVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}


