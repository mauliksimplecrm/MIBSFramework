//
//  SelectAccountTypeVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 21/01/22.
//

import UIKit
////import Popover

var accountType = AccountType.saving
class SelectAccountTypeVC: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet var viewbg_intro_alert: UIView!
    @IBOutlet weak var img_intro_alert: UIImageView!
    @IBOutlet weak var lblTitle_intro_alert: UILabel!
    @IBOutlet weak var lblDetail_intro_alert: UILabel!
    @IBOutlet weak var btnGotit_intro_alert: UIButton!
    
    @IBOutlet weak var lblSavingAccount_title: UILabel!
    @IBOutlet weak var lblSavingAccount_detail: UILabel!
    @IBOutlet weak var lblCurrentAccount_title: UILabel!
    @IBOutlet weak var lblCurrentAccount_detail: UILabel!
    @IBOutlet weak var lblPrizeAccount_title: UILabel!
    @IBOutlet weak var lblPrizeAccount_detail: UILabel!
    
    @IBOutlet var prizeAR: UIView!
    @IBOutlet var prizeEN: UIView!
    @IBOutlet var savingAR: UIView!
    @IBOutlet var savingEN: UIView!
    @IBOutlet var currentAR: UIView!
    @IBOutlet var currentEN: UIView!
    
    
    // MARK: Veriable
    var popover = Popover()
    
    
    
    // MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasic()
        setupHeader()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        localization()
    }
    func setupHeader(){
        headerView.viewbgScheduleCall.isHidden = true
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            //--
            let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    func setupBasic(){
        let length_ = Managelanguage.getLanguageCode() == "A" ? 10 : 12
        let location_ = Managelanguage.getLanguageCode() == "A" ? 5 : 7
        lblTitle.attributedText = Localize(key: "Select Account Type").attributedStringWithColorNew(location_, length: length_, color: .DARKGREENTINT)
        lblDetail.text = Localize(key: "Select Account Type detail")
    }
    func openIntroAlert(alertView: UIView){
        //--
        viewbg_intro_alert.frame.size = CGSize(width: self.view.frame.width-20, height: alertView.frame.height)
        let aView = UIView()
        aView.frame = alertView.frame
        aView.addSubview(alertView)
        popover.blackOverlayColor = popoverBackgroundColor
        popover.dismissOnBlackOverlayTap = true
        popover.showAsDialog(aView, inView: self.view)
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblSavingAccount_title.text = Localize(key: "Saving Account")
        lblSavingAccount_detail.text = Localize(key: "Saving Account Detail")
        lblCurrentAccount_title.text = Localize(key: "Current Account")
        lblCurrentAccount_detail.text = Localize(key: "Current Account Detail")
        lblPrizeAccount_title.text = Localize(key: "Prize Account")
        lblPrizeAccount_detail.text = Localize(key: "Prize Account Detail")
        
        btnGotit_intro_alert.setTitle(Localize(key: "apply"), for: .normal)
    }

    // MARK: @IBAction
    @IBAction func btnClosePopup(_ sender: Any) {
        popover.dismiss()
    }
    @IBAction func btnSavingAccount(_ sender: Any) {
        /*lblTitle_intro_alert.text = Localize(key: "Saving Account")
        lblDetail_intro_alert.text = Localize(key: "Saving Account Detail 2")
        img_intro_alert.image = UIImage(named: "High_yield")*/
        accountType = .saving
        
        Managelanguage.getLanguageCode() == "A" ? openIntroAlert(alertView: savingAR) : openIntroAlert(alertView: savingEN)
        
    }
    @IBAction func btnCurrentAccount(_ sender: Any) {
        /*lblTitle_intro_alert.text = Localize(key: "Current Account")
        lblDetail_intro_alert.text = Localize(key: "Current Account Detail 2")
        img_intro_alert.image = UIImage(named: "Current_Ac")*/
        accountType = .current
        
        Managelanguage.getLanguageCode() == "A" ? openIntroAlert(alertView: currentAR) : openIntroAlert(alertView: currentEN)
    }
    @IBAction func btnPrizeAccount(_ sender: Any) {
        /*lblTitle_intro_alert.text = Localize(key: "Prize Account")
        lblDetail_intro_alert.text = Localize(key: "Prize Account Detail 2")
        img_intro_alert.image = UIImage(named: "Savings_Ac")*/
        accountType = .prize
     
        Managelanguage.getLanguageCode() == "A" ? openIntroAlert(alertView: prizeAR) : openIntroAlert(alertView: prizeEN)
    }
    
    @IBAction func btnGotit_intro_alert(_ sender: Any) {
        popover.dismiss()
        serviceType = .StartAccountOpening
        
        //--
        let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
        vc.comeForSelectAccountTypeVC = true
        self.navigationController?.pushViewController(vc, animated: true)
       
        /*
        //--
        if accountType == .saving {
            //--
            let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: nil)
            vc.serviceType = .StartAccountOpening
            self.navigationController?.pushViewController(vc, animated: true)
            
            /*
            //--Temp
            let vc = SelectCitizenshipVC(nibName: "SelectCitizenshipVC", bundle: nil)
            //vc.citizenshipType = CitizenshipType.omani
            self.navigationController?.pushViewController(vc, animated: false)
             */
        }else if accountType == .current{
            //--
            let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: nil)
            vc.serviceType = .StartAccountOpening
            self.navigationController?.pushViewController(vc, animated: true)
        }else if accountType == .prize{
            //--
            let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: nil)
            vc.serviceType = .StartAccountOpening
            self.navigationController?.pushViewController(vc, animated: true)
        }
         */
    }
    

}

