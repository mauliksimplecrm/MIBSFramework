//
//  LoadingView.swift
//  Maisarah
//
//  Created by Maulik Vora on 10/03/22.
//

import UIKit
import Foundation
//import Popover

/*protocol LoadingView_Protocol {
 func btnCancelLoding()
 }*/
class LoadingView: UIView {
    //MARK: - @IBOutlet
    @IBOutlet var viewbg_loading: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblTitle_loading: UILabel!
    @IBOutlet weak var lblDetail_loading: UILabel!
    @IBOutlet weak var imgLoading: UIImageView!
    
    
    
    //MARK: - Veriable
    let nibName = "LoadingView"
    var contentView: UIView?
    //var delegate_LoadingView_Protocol:LoadingView_Protocol?
    let popover = Popover()
    static let shared = LoadingView.instanceFromNib()
    var didTappedCancelBtn: ((UIButton) -> (Void))? = nil
    
    //MARK: - Func
    class func instanceFromNib() -> LoadingView {
        let myClassNib = UINib(nibName: "LoadingView", bundle: bundleIdentifireGlob)
        return myClassNib.instantiate(withOwner: nil, options: nil)[0] as! LoadingView
    }
    
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblTitle_loading.text = Localize(key: "verifying_your_details")
        lblDetail_loading.text = Localize(key: "this_might_take_a_minute_or_two")
        btnCancel.setTitle(Localize(key: "CANCEL"), for: .normal)
    }
    //    class func instanceFromNib() -> UIView {
    //        return UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    //    }
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //
    //        guard let view = loadViewFromNib() else { return }
    //        view.frame = self.bounds
    //        self.addSubview(view)
    //        contentView = view
    //
    //
    //    }
    //
    //    func loadViewFromNib() -> UIView? {
    //        let bundle = Bundle(for: type(of: self))
    //        let nib = UINib(nibName: nibName, bundle: bundle)
    //        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    //    }
    
    func openLodingAlert(btnCancelHide:Bool = true, view: UIView){
        
        
        //--
        let loadingView = LoadingView.instanceFromNib()
        loadingView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let aView = UIView()
        aView.frame = loadingView.frame
        aView.addSubview(loadingView)
        popover.dismissOnBlackOverlayTap = true
        popover.blackOverlayColor = popoverBackgroundColor
        popover.showAsDialog(loadingView, inView: view)
        
        loadingView.viewbg_loading.rotate()
        //loadingView.delegate_LoadingView_Protocol = self
        loadingView.btnCancel.isHidden = btnCancelHide
        
        loadingView.lblTitle_loading.text = Localize(key: "verifying_your_details")
        loadingView.lblDetail_loading.text = Localize(key: "this_might_take_a_minute_or_two")
        loadingView.btnCancel.setTitle(Localize(key: "CANCEL"), for: .normal)
        
        loadingView.btnCancel.addTarget(self, action: #selector(btnCancel_loading(_:)), for: .touchUpInside)
    }
    func dismissLoadingView()
    {
        popover.dismiss()
    }
    
    //MARK: - @IBAction
    @objc func btnCancel_loadi(sender: UIButton){
        if self.didTappedCancelBtn != nil {
            self.didTappedCancelBtn!(sender)
        }
    }
    @IBAction func btnCancel_loading(_ sender: UIButton) {
        //popover.dismiss()
        if self.didTappedCancelBtn != nil {
            self.didTappedCancelBtn!(sender)
        }
    }
    
}
