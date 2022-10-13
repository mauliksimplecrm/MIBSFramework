//
//  TimePickerVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 04/08/22.
//

import UIKit

class TimePickerVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var lblConfirm: UILabel!
    
    var didTappedSubmit: ((UIButton, String) -> (Void))? = nil
    var titleStr = ""
    
    //MARK: - Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        
        lblTitle.text = titleStr
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        lblConfirm.text = Localize(key: "CONFIRM")
        
        if Managelanguage.getLanguageCode() == "A"{
            datePicker.locale = Locale(identifier: "ar")
        }else{
            datePicker.locale = Locale(identifier: "en")
        }
    }
    
    //MARK: - @IBAction
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSubmit(_ sender: UIButton) {
        
        let date = datePicker.date
        let time  = AppHelper.dateToString(date: date, strFormate: "hh:mm a")
        
        if self.didTappedSubmit != nil {
            self.didTappedSubmit!(sender, time)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didChangeValue(_ sender: Any) {
        
        
    }
    

}
