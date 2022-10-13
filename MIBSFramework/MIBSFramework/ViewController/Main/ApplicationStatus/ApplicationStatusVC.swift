//
//  ApplicationStatusVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 12/07/22.
//

import UIKit
//import Lottie

var validateOTPApplicationsGlob:ValidateOTPApplications?
class ApplicationStatusVC: UIViewController {

    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var lblApplicationNumber_title: UILabel!
    @IBOutlet weak var lblApplicationNumber_value: UILabel!
    
    @IBOutlet weak var lblAppStatus_title: UILabel!
    @IBOutlet weak var lblAppStatus_value: UILabel!
    
    @IBOutlet weak var lblAppSubmitted_title: UILabel!
    @IBOutlet weak var lblAppSubmitted_value: UILabel!
    
    @IBOutlet weak var lblGoToDashboard: UILabel!
    @IBOutlet weak var lblContinueApplication: UILabel!
    @IBOutlet weak var viewbgApplicationSubmitted: UIView!
    @IBOutlet weak var viewbgContinueApp: UIView!
    @IBOutlet var viewAnimated: AnimationView!
    
    //MARK: - Veriable
    
    
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setApplicationData()
        setupBasic()
        localization()
    }
    func setupHeader(){
     
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        let length_ = Managelanguage.getLanguageCode() == "A" ? 5 : 12
        let location_ = Managelanguage.getLanguageCode() == "A" ? 7 : 6
        lblTitle.attributedText = Localize(key: "Application_Status").attributedStringWithColorNew(length_, length: location_, color: .DARKGREENTINT)
            //.attributedStringWithColor(["Status"], color: UIColor(named: "DARKGREENTINT")!)
        lblApplicationNumber_title.text = Localize(key: "Application_Number")
        lblAppStatus_title.text = Localize(key: "Application_Status")
        lblAppSubmitted_title.text = Localize(key: "Application_Submitted_Date")
        
        lblContinueApplication.text = Localize(key: "CONTINUE APPLICATION")
        lblGoToDashboard.text = Localize(key: "GO TO DASHBOARD")
    }
    func setupBasic(){
       
    }
    func setApplicationData(){
        lblApplicationNumber_value.text = validateOTPApplicationsGlob?.application_id ?? ""
        lblAppStatus_value.text = validateOTPApplicationsGlob?.status_display ?? ""
        
        if validateOTPApplicationsGlob?.status == ApplicationStatus.application_submitted.rawValue{
            apiCall_getApplicationData { result in
                let application_submitted_date_c = result.application_submitted_date_c as? String ?? ""
                self.lblAppSubmitted_value.text = AppHelper.convertDateString(dateString: application_submitted_date_c, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd/MM/yyyy")
                
                self.viewbgApplicationSubmitted.isHidden = false
                self.viewAnimated.isHidden = false
                self.initAnimatedTikMark()
                
            }
            
        }else{
            viewbgApplicationSubmitted.isHidden = true
            viewAnimated.isHidden = true
        }
        
        if validateOTPApplicationsGlob?.status == ApplicationStatus.InProgress.rawValue ||
            validateOTPApplicationsGlob?.status == ApplicationStatus.New.rawValue{
            viewbgContinueApp.isHidden = false
        }else{
            viewbgContinueApp.isHidden = true
        }
        
    }
    func initAnimatedTikMark(){
        
        //viewAnimated = .init(name: "success_tick")
        //viewAnimated.set
        //animationView!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: animatedView.frame.height)
//        viewAnimated!.contentMode = .scaleAspectFit
//        viewAnimated!.loopMode = .playOnce
//        viewAnimated!.animationSpeed = 0.5
        //viewAnimated.addSubview(animationView!)
        //viewAnimated!.play()
        
        let animationView = AnimationView(name: "success_tick", bundle: bundleIdentifireGlob!)
        animationView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        animationView.contentMode = .scaleAspectFit
        viewAnimated.addSubview(animationView)
        animationView.play()
    }


    //MARK: - @IBAction
    @IBAction func btnGoToDashboard(_ sender: Any) {
        //--
        let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnContinueApplication(_ sender: Any) {
        openPreSelectCitizenshipScreen = "application_Status"
        self.findLastApplicationStep()
    }
    

}


