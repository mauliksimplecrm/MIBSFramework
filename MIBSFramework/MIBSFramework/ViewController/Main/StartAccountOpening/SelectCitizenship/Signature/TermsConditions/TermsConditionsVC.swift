//
//  TermsConditionsVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 15/02/22.
//

import UIKit

class TermsConditionsVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblNext: UILabel!
    @IBOutlet weak var lblBottomDetail: UILabel!
    
    //MARK: Veriable
    var screenNameEnum : ScreenNameEnum?
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setupHeader()
        setupBasic()
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblTitle.text = Localize(key: "Terms & Conditions")
        lblDetail.text = Localize(key: "TermAndCond_Text")
        lblBottomDetail.attributedText = Localize(key: "My clicking Next, you agree to our Terms & Conditions").underlineWords(words: [Localize(key: "Terms & Conditions")], color: .DARKGREENTINT)
        
        //attributedStringWithColor([Localize(key: "Terms & Conditions")], color: .DARKGREY)
        
        //Localize(key: "My_clicking_Next_you_agree_to_our")
        //lblTCClick.text = Localize(key: "Terms & Conditions")
        lblNext.text = Localize(key: "NEXT")
    }
    func setupHeader(){

        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { [self] (sender) in
            
            //--
            let vc = LivenessCheckVC(nibName: "LivenessCheckVC", bundle: bundleIdentifireGlob)
            vc.isComeTc = true
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
    }
    func setupBasic(){
        //--
        
    }
    
    
    //MARK: - @IBAction
    @IBAction func btnNext(_ sender: Any) {
        //--
        let vc = AddSignatureVC(nibName: "AddSignatureVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnTC(_ sender: Any) {
        AppHelper.openDocuemtnBrowser(docUrl: termAndConditionURL, nav: self.navigationController!)
    }
    

}

//MARK: - Api Call
extension TermsConditionsVC{
  
}
