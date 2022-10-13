//
//  VirtualDebitCardVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 21/02/22.
//

import UIKit

class VirtualDebitCardVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblAlertMsg: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblAccountNo_title: UILabel!
    @IBOutlet weak var lblAccountNo: UILabel!
    @IBOutlet weak var lblYourVirtualDebitCard: UILabel!
    @IBOutlet weak var imgVertualDebitcard: UIImageView!
    @IBOutlet weak var lblGPay: UILabel!
    @IBOutlet weak var lblAddto_ApplePay: UILabel!
    @IBOutlet weak var lblAddWallet_ApplePay: UILabel!
    @IBOutlet weak var lblBottomDetail: UILabel!
    @IBOutlet weak var viewNext: UIView!
    @IBOutlet weak var lblNext: UILabel!
    
    
    //MARK: - Veriable
    var addonServices = AddonServices.debitcard
    
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        setupBasic()
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblAlertMsg.text = Localize(key: "Debit card collection details submitted successfully!")
        lblTitle.text = Localize(key: "Your Virtual Debit Card")
        lblDetail.text = Localize(key: "You can start using your card right away, for any kind of online transaction")
        lblAccountNo_title.text = Localize(key: "Account No.")
        lblYourVirtualDebitCard.text = Localize(key: "Your Virtual Debit Card")
        lblBottomDetail.text = Localize(key: "Use your debit card with Apple Pay and Google Pay for secure payments.")
        lblNext.text = Localize(key: "NEXT")
    }
    func setupHeader(){
        
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    func setupBasic(){
        
    }
    
    
    //MARK: - @IBAction
    @IBAction func btnAppleWallet(_ sender: Any) {
    }
    @IBAction func btnGPay(_ sender: Any) {
    }
    @IBAction func btnNext(_ sender: Any) {
        //--
        if addonServices == .both{
            //--
            let vc = MobileBankingVC(nibName: "MobileBankingVC", bundle: bundleIdentifireGlob)
            vc.addonServices = addonServices
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            //--
            let vc = MobileBankingSubmittedVC(nibName: "MobileBankingSubmittedVC", bundle: bundleIdentifireGlob)
            vc.addonServices = addonServices
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBAction func btnShareAcountNumber(_ sender: Any) {
        //--
        let text = "Account Number: 80101675199"
        
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view 
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

