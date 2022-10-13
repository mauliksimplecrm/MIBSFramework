//
//  SelectCitizenshipVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 22/01/22.
//

import UIKit

var openPreSelectCitizenshipScreen = ""
class SelectCitizenshipVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var headerView: CustomHeaderView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblOmani_title: UILabel!
    @IBOutlet weak var lblOmani_detail: UILabel!
    @IBOutlet weak var lblExpatriate_title: UILabel!
    @IBOutlet weak var lblExpatriate_detail: UILabel!
    @IBOutlet weak var lblGCCnational_title: UILabel!
    @IBOutlet weak var lblGCCNational_detail: UILabel!
    
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupBasic()
        localization()
    }
    func setupHeader(){

        headerView.nav = self.navigationController!
        headerView.btnScheduleaCall.setTitle(Localize(key: "Schedule a Call"), for: .normal)
        headerView.didTappedBack = { (sender) in
            if openPreSelectCitizenshipScreen == "application_Status"{
                let vc = ApplicationStatusVC(nibName: "ApplicationStatusVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: false)
            }else{
                let vc = EnterMobileEmailVC(nibName: "EnterMobileEmailVC", bundle: bundleIdentifireGlob)
                self.navigationController?.pushViewController(vc, animated: false)
            }
            
        }
    }
    func setupBasic(){
        //--
        
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()

        let length_ = Managelanguage.getLanguageCode() == "A" ? 7 : 11
        let location_ = Managelanguage.getLanguageCode() == "A" ? 0 : 7
        lblTitle.attributedText = Localize(key: "Select Citizenship").attributedStringWithColorNew(location_, length: length_, color: .DARKGREENTINT)
        lblDetail.text = Localize(key: "Select_Citizenship_Detail")
        
        lblOmani_title.text = Localize(key: "Omani")
        lblOmani_detail.text = Localize(key: "We will need you to scan your Omani National ID")
        
        lblExpatriate_title.text = Localize(key: "Expatriate")
        lblExpatriate_detail.text = Localize(key: "We will need you to scan your Resident ID, Passport, and upload valid visa copy")
        
        lblGCCnational_title.text = Localize(key: "GCC National")
        lblGCCNational_detail.text = Localize(key: "We will need you to scan your National ID, and Passport")
        
    }
    
    //MARK: @IBAction
    @IBAction func btnOmani(_ sender: Any) {
        /*//--
        let vc = ReviewApplicationVC(nibName: "ReviewApplicationVC", bundle: nil)
        //vc.citizenshipType = CitizenshipType.omani
        self.navigationController?.pushViewController(vc, animated: false)
        //Temp
        //--
        let vc = RegularityDeclVC(nibName: "RegularityDeclVC", bundle: nil)
        vc.citizenshipType = CitizenshipType.omani
        self.navigationController?.pushViewController(vc, animated: false)*/
        //--
        citizenshipType = CitizenshipType.omani
        
        //--
        let vc = OmaniCitizenshipDocVC(nibName: "OmaniCitizenshipDocVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnExpatriate(_ sender: Any) {
        /*//--
        let vc = PersonalInfoVC(nibName: "PersonalInfoVC", bundle: nil)
        vc.citizenshipType = CitizenshipType.omani
        self.navigationController?.pushViewController(vc, animated: false)
        */
        //--
        citizenshipType = CitizenshipType.expatriate
        
        //--
        let vc = ExpatrIateCitizenshipDoc(nibName: "ExpatrIateCitizenshipDoc", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnGCCNational(_ sender: Any) {
        //--
        citizenshipType = CitizenshipType.gcc
        
        //--
        let vc = GCCNationalsCitizenshipDocVC(nibName: "GCCNationalsCitizenshipDocVC", bundle: bundleIdentifireGlob)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


