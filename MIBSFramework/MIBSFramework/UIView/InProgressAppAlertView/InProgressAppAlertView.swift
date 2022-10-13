//
//  InProgressAppAlertView.swift
//  Maisarah
//
//  Created by Maulik Vora on 10/07/22.
//

import UIKit
//import Lottie

class InProgressAppAlertView: UIView {
    //MARK: - @IBOutlet
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnGotoApplication: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnContinueApplication: UIButton!
    @IBOutlet weak var viewSuccessPopup: UIView!
    @IBOutlet weak var animatedTick: AnimationView!
    @IBOutlet weak var lblTitle_AnimatedTick: UILabel!
    @IBOutlet weak var lblDetail_AnimatedTick: UILabel!
    
    var didTappedGoToDashboard: ((UIButton) -> (Void))? = nil
    var didTappedContinueAPP: ((UIButton) -> (Void))? = nil
    var didTappedCancel: ((UIButton) -> (Void))? = nil
    
    //MARK: - Veriable
    let nibName = "InProgressAppAlertView"
    var contentView: UIView?
    
    
    
    
    //MARK: - Func
    class func instanceFromNib() -> InProgressAppAlertView {
            let myClassNib = UINib(nibName: "InProgressAppAlertView", bundle: bundleIdentifireGlob)
            return myClassNib.instantiate(withOwner: nil, options: nil)[0] as! InProgressAppAlertView
        
    }

    //MARK: - @IBAction
    @IBAction func btnGotoDashboard(_ sender: UIButton) {
        if self.didTappedGoToDashboard != nil {
            self.didTappedGoToDashboard!(sender)
        }
    }
    @IBAction func btnContinueApp(_ sender: UIButton) {
        if self.didTappedContinueAPP != nil {
            self.didTappedContinueAPP!(sender)
        }
    }
    @IBAction func btnCancel(_ sender: UIButton) {
        if self.didTappedCancel != nil {
            self.didTappedCancel!(sender)
        }
    }
    
}
