//
//  MobileBankingSubmittedVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 22/02/22.
//

import UIKit

class MobileBankingSubmittedVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var viewGotoLogin: UIView!
    @IBOutlet weak var lblGotoLogin: UILabel!
    
    
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
        lblGotoLogin.text = Localize(key: "GO TO DASHBOARD")
        
        if addonServices == .debitcard{
            lblTitle.text = Localize(key: "Debit_Card_details_submitted")
            lblDetail.text = Localize(key: "Submitted_debit_Card_msg")
            
        }else if addonServices == .mobilebanking{
            lblTitle.text = Localize(key: "Mobile Banking details submitted")
            lblDetail.text = Localize(key: "Your details have been submitted. You can now login with the your account details.")
        }else{
            lblTitle.text = Localize(key: "Debit_Mobile_Banking_Details_Submitted")
            lblDetail.text = Localize(key: "Your details have been submitted. You can now login with the your account details.")
        }
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
    @IBAction func btnGotoLogin(_ sender: Any) {
        let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
  
}

