//
//  ThankYouVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 19/02/22.
//

import UIKit

class ThankYouVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblGoToDashboard: UILabel!
    
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        localization()
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblTitle.text = Localize(key: "Thank you!")
        lblDetail.text = Localize(key: "thank_you_desc_4")
        
        lblGoToDashboard.text = Localize(key: "GO TO DASHBOARD")
    }
    func setupHeader(){

        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            //self.navigationController?.popViewController(animated: true)
            //--
            let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //MARK: - @IBAction
    @IBAction func btnGoToDashboard(_ sender: Any) {
        //--
        let vc = objMainSB.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

