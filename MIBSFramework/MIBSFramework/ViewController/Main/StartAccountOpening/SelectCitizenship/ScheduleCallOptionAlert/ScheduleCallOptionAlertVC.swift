//
//  ScheduleCallOptionAlertVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 31/01/22.
//

import UIKit

class ScheduleCallOptionAlertVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var lblScheduleaCall: UILabel!
    
    var didTappedBtnSchedualCall:((UIButton) -> (Void))? = nil
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
    
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
    
        
        lblScheduleaCall.text = Localize(key: "Schedule a Call")
    }

    
    //MARK: @IBAction
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnScheduleaCall(_ sender: UIButton) {
        if didTappedBtnSchedualCall != nil{
            self.dismiss(animated: true, completion: nil)
            didTappedBtnSchedualCall!(sender)
        }
        
    }
    

}

