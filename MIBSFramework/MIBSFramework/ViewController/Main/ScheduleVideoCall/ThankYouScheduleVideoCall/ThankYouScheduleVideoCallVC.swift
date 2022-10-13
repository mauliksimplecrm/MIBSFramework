//
//  ThankYouScheduleVideoCallVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 26/01/22.
//

import UIKit

class ThankYouScheduleVideoCallVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblContinueApplication: UILabel!
    
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblTitle.text = Localize(key: "Thank you!")
        lblDetail.text = Localize(key: "Thank you detail1")
        
        lblContinueApplication.text = Localize(key: "GO TO DASHBOARD")
    }
    func setupHeader(){
         
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    //MARK: @IBAction
    @IBAction func btnContinueApplication(_ sender: Any) {
        let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
   
}
