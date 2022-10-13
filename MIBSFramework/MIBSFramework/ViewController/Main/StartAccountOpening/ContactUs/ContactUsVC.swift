//
//  ContactUsVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 22/01/22.
//

import UIKit

class ContactUsVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblCallUs_title: UILabel!
    @IBOutlet weak var lblPhonenumber: UILabel!
    @IBOutlet weak var lblEmail_title: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        localization()
    }
    func setupHeader(){
         
        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblTitle.text = Localize(key: "Contact Us")
        lblDetail.text = Localize(key: "Contact Us detail")
        lblCallUs_title.text = Localize(key: "Call Us")
        lblEmail_title.text = Localize(key: "Email Us")
        
    }

   //MARK: @IBAction
    @IBAction func btnPhone(_ sender: Any) {
    }
    @IBAction func btnEmail(_ sender: Any) {
    }
    
}


