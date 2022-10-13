//
//  CustomTextField.swift
//  Maisarah
//
//  Created by Maulik Vora on 19/08/22.
//
import Foundation
import UIKit


protocol CustomTextFieldDelegate {
    func shouldChangeCharactersIn(textField: UITextField, txt: String) -> Bool
    func textFieldDidBeginEditing(textField: UITextField)
    func textFieldDidEndEditing(textField: UITextField)
    func editingChanged(textField: UITextField)
}

class CustomTextField: UIView {

    //MARK:  IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var viewbgBottomLine: UIView!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnOpenDropDown: UIButton!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var iconFill: UIImageView!
    
    var didTappedDropDown: ((UIButton) -> (Void))? = nil
    
    
    //MARK: Veriable
    let nibName = "CustomTextField"
    var contentView: UIView?
    var delegate_CustomTextFieldDelegate:CustomTextFieldDelegate?
    var resignFirstResponder = false
    
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
    
    
    //MARK: Func
    func setTitlePlaceholder(text_: String, placeholder_: String, isUserInteraction: Bool, type: UIFloatingTextFieldType? = nil, btnDropDownHide: Bool? = nil, isSecureTextEntry: Bool? = false){
        lblTitle.text = text_
        txtType.placeholder = placeholder_
        txtType.isUserInteractionEnabled = isUserInteraction
        txtType.isSecureTextEntry = isSecureTextEntry ?? false
        txtType.delegate = self
        //txtType.setRightPaddingPoints(50)
        if Managelanguage.getLanguageCode() == "A"
        {
            lblTitle.semanticContentAttribute = .forceRightToLeft
            txtType.semanticContentAttribute = .forceRightToLeft
        }
        else
        {
            lblTitle.semanticContentAttribute = .forceLeftToRight
            txtType.semanticContentAttribute = .forceLeftToRight
        }
        
        //--
        if type == .dropDown{
            iconDropDown.isHidden = false
        }else{
            iconDropDown.isHidden = true
        }
        
        //--
        btnOpenDropDown.isHidden = btnDropDownHide ?? true
        
        //--
        lblError.text = Localize(key: "Field_is_Mandatory")
        
    }
    
    func setSelectedDropDownUI(){
        lblTitle.textColor = .GREEN
        viewbgBottomLine.backgroundColor = .GREEN
    }
    
    
    //MARK: - @IBAction
    @IBAction func btnOpenDropDown(_ sender: UIButton) {
        if self.didTappedDropDown != nil {
            self.didTappedDropDown!(sender)
        }
    }
    @IBAction func editingChanged(_ sender: Any) {
        delegate_CustomTextFieldDelegate?.editingChanged(textField: txtType)
        
    }
    
}

extension CustomTextField: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            return delegate_CustomTextFieldDelegate?.shouldChangeCharactersIn(textField: textField, txt: updatedText) ?? true
        }else{
            return delegate_CustomTextFieldDelegate?.shouldChangeCharactersIn(textField: textField, txt: "") ?? true
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if resignFirstResponder{
            //textField.resignFirstResponder()
        }
        lblTitle.textColor = .GREEN
        viewbgBottomLine.backgroundColor = .GREEN
        
        delegate_CustomTextFieldDelegate?.textFieldDidBeginEditing(textField: textField)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        lblTitle.textColor = .MIDGREY
        viewbgBottomLine.backgroundColor = .LIGHTGREY
        
        delegate_CustomTextFieldDelegate?.textFieldDidEndEditing(textField: textField)
    }
}


