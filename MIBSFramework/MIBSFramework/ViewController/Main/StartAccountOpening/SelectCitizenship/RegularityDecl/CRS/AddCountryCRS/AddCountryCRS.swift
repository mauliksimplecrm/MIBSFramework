//
//  AddCountryCRSView.swift
//  Maisarah
//
//  Created by Maulik Vora on 14/02/22.
//

import UIKit

protocol AddCountry_protocol {
    func btnRemove()
    
}

class AddCountryCRS: UIView {
    //MARK: - @IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var txtCountry: UIFloatingTextField!
    @IBOutlet weak var txtTIN: UIFloatingTextField!
    @IBOutlet weak var lblIfNoTIN: UILabel!
    
    @IBOutlet weak var imgA: UIImageView!
    @IBOutlet weak var lblTitleA: UILabel!
    @IBOutlet weak var lblDetailA: UILabel!
    @IBOutlet weak var imgB: UIImageView!
    @IBOutlet weak var lblTitleB: UILabel!
    @IBOutlet weak var lblDetailB: UILabel!
    @IBOutlet weak var imgC: UIImageView!
    @IBOutlet weak var lblTitleC: UILabel!
    @IBOutlet weak var lblDetailC: UILabel!
    
    
    
    //MARK: Veriable
    let nibName = "AddCountryCRS"
    var contentView: UIView?
    var delegate_AddCountry_protocol: AddCountry_protocol?
    var didTappedABC: ((UIButton)->Void)? = nil
    
    
    //MARK: func
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = bundleIdentifireGlob//Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
    //MARK: - @IBAction
    @IBAction func btnRemove(_ sender: Any) {
        delegate_AddCountry_protocol?.btnRemove()
    }
    @IBAction func btnA(_ sender: UIButton) {
        if self.didTappedABC != nil {
            sender.tag = 100
            self.didTappedABC!(sender)
        }
    }
    @IBAction func btnB(_ sender: UIButton) {
        if self.didTappedABC != nil {
            sender.tag = 200
            self.didTappedABC!(sender)
        }
    }
    @IBAction func btnC(_ sender: UIButton) {
        if self.didTappedABC != nil {
            sender.tag = 300
            self.didTappedABC!(sender)
        }
    }
    
    
    
}
