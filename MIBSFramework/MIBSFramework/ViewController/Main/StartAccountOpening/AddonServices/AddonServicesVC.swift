//
//  AddonServicesVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 19/02/22.
//

import UIKit
////import Popover

class AddonServicesVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle_DebitCard: UILabel!
    @IBOutlet weak var lblDetail_DebitCard: UILabel!
    @IBOutlet weak var imgDebitCard: UIImageView!
    @IBOutlet weak var lblTitle_MobileBanking: UILabel!
    @IBOutlet weak var lblDetail_MobileBanking: UILabel!
    @IBOutlet weak var imgMobileBanking: UIImageView!
    @IBOutlet weak var lblTitle_Both: UILabel!
    @IBOutlet weak var lblDetail_Both: UILabel!
    @IBOutlet weak var imgBoth: UIImageView!
    @IBOutlet weak var lblNext: UILabel!
    @IBOutlet weak var viewbtnNext: UIView!
    //Intro Popup
    @IBOutlet var viewbg_intro_alert: UIView!
    @IBOutlet weak var img_intro_alert: UIImageView!
    @IBOutlet weak var lblTitle_intro_alert: UILabel!
    @IBOutlet weak var lblDetail_intro_alert: UILabel!
    @IBOutlet weak var btnGotit_intro_alert: UIButton!
    
    // MARK: Veriable
    var popover = Popover()
    var addonServices = AddonServices.non
    var displayBothIntro = false
    var isComeFromNotification = false
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        setupBasic()
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblTitle.text = Localize(key: "Add-on Services")
        lblDetail.text = Localize(key: "Add-on Services detail")
        lblTitle_DebitCard.text = Localize(key: "Debit Card")
        lblDetail_DebitCard.text = Localize(key: "Debit Card detail")
        lblTitle_MobileBanking.text = Localize(key: "Mobile Banking")
        lblDetail_MobileBanking.text = Localize(key: "Mobile Banking detail")
        lblTitle_Both.text = Localize(key: "Both")
        lblDetail_Both.text = Localize(key: "Both detail")
        
        lblNext.text = Localize(key: "NEXT")
        btnGotit_intro_alert.setTitle(Localize(key: "GOT IT"), for: .normal)
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
        if applyValidation{
            AppHelper.disableNextBTN(view_: viewbtnNext)
        }
       
    }
  
    func manageSelectOption(){
        imgDebitCard.image = nil
        imgMobileBanking.image = nil
        imgBoth.image = nil
        
        if addonServices == .debitcard{
            imgDebitCard.image = .IMGDoneGreen
        }else if addonServices == .mobilebanking{
            imgMobileBanking.image = .IMGDoneGreen
        }else if addonServices == .both{
            imgBoth.image = .IMGDoneGreen
        }
        validateEnput()
    }
    func validateEnput(){
        if addonServices == .debitcard || addonServices == .mobilebanking || addonServices == .both{
            AppHelper.enableNextBTN(view_: viewbtnNext)
        }else{
            AppHelper.disableNextBTN(view_: viewbtnNext)
        }
    }
    
    //MARK: @IBAction
    @IBAction func btnDebitcard(_ sender: Any) {
        lblTitle_intro_alert.text = Localize(key: "Debit Card details")
        lblDetail_intro_alert.text = Localize(key: "Debit Card details 1")
        img_intro_alert.image = UIImage(named: "Debit_Card_Details", in: bundleIdentifireGlob, with: nil)
        addonServices = .debitcard
        manageSelectOption()
    }
    @IBAction func btnMobilebanking(_ sender: Any) {
        lblTitle_intro_alert.text = Localize(key: "Mobile banking details")
        lblDetail_intro_alert.text = Localize(key: "Mobile banking details 1")
        img_intro_alert.image = UIImage(named: "", in: bundleIdentifireGlob, with: nil)
        addonServices = .mobilebanking
        manageSelectOption()
    }
    @IBAction func btnBoth(_ sender: Any) {
        //Debit Card details
        lblTitle_intro_alert.text = Localize(key: "Debit Card details")
        lblDetail_intro_alert.text = Localize(key: "Debit Card details 1")
        addonServices = .both
        manageSelectOption()
    }
    @IBAction func btnNext(_ sender: Any) {
        openIntroAlert()
    }
    
    
    //MARK: @IBAction Intro Popup
    func openIntroAlert(){
        //--
        viewbg_intro_alert.frame.size = CGSize(width: self.view.frame.width-20, height: viewbg_intro_alert.frame.height)
        let aView = UIView()
        aView.frame = viewbg_intro_alert.frame
        aView.addSubview(viewbg_intro_alert)
        
        popover = Popover()
        popover.dismissOnBlackOverlayTap = true
        popover.blackOverlayColor = popoverBackgroundColor
        popover.showAsDialog(aView, inView: self.view)
    }
    @IBAction func btnGotit_intro_alert(_ sender: Any) {
        popover.dismiss()
       
        //--
        if addonServices == .debitcard {
            //--
            let vc = DebitCardVC(nibName: "DebitCardVC", bundle: bundleIdentifireGlob)
            vc.addonServices = .debitcard
            self.navigationController?.pushViewController(vc, animated: true)
        }else if addonServices == .mobilebanking{
            //--
            let vc = MobileBankingVC(nibName: "MobileBankingVC", bundle: bundleIdentifireGlob)
            vc.addonServices = .mobilebanking
            self.navigationController?.pushViewController(vc, animated: true)
        }else if addonServices == .both{
            if displayBothIntro {
                //--
                let vc = DebitCardVC(nibName: "DebitCardVC", bundle: bundleIdentifireGlob)
                vc.addonServices = .both
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                //Mobile banking details
                displayBothIntro = true
                lblTitle_intro_alert.text = Localize(key: "Mobile banking details")
                lblDetail_intro_alert.text = Localize(key: "Mobile banking details 1")
                openIntroAlert()
            }
        }
    }
    
}

