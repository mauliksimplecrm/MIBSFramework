//
//  FloatingTextFieldWithCode.swift
//  Maisarah
//
//  Created by Maulik Vora on 03/02/22.
//

import Foundation
import UIKit


protocol FloatingTextFieldWithCode_Protocol {
    func btnOpenCountryCodePicker(textField: UITextField)
    func shouldChangeCharactersIn(textField: UITextField, txt: String) -> Bool
    func editingChanged(textField: UITextField)
    func textFieldDidBeginEditing(textField: UITextField)
}

class FloatingTextFieldWithCode: UIView {
    
    //MARK:  IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    //@IBOutlet weak var txtType: UITextView!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var btnSelectCode: UIButton!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var viewbgBottomLine: UIView!
    @IBOutlet weak var lblError: UILabel!
    
    
    
    //MARK: Veriable
    let nibName = "FloatingTextFieldWithCode"
    var contentView: UIView?
    var delegate_FloatingTextFieldWithCode_Protocol:FloatingTextFieldWithCode_Protocol?
    var didChangeCharacter: ((UITextField) -> (Bool))? = nil
    var isAllowToChangeActiveColor = true
    
    //MARK: func
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = bundleIdentifireGlob //Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
    //MARK: Func
    func setTitlePlaceholder(text_: String, placeholder_: String, isUserInteraction: Bool, allowToChangeActiveColor: Bool? = true){
        lblTitle.text = text_
        txtType.placeholder = placeholder_
        txtType.placeholderColor = .LIGHTGREY
        txtType.isUserInteractionEnabled = isUserInteraction
        txtType.delegate = self
        isAllowToChangeActiveColor = allowToChangeActiveColor ?? true
        
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
    }
    

    //MARK: @IBAction
    @IBAction func btnSelectCode(_ sender: Any) {
        delegate_FloatingTextFieldWithCode_Protocol?.btnOpenCountryCodePicker(textField: txtType)
    }
    @IBAction func editingChanged(_ sender: Any) {
        delegate_FloatingTextFieldWithCode_Protocol?.editingChanged(textField: txtType)
    }
    
}
/*
extension FloatingTextFieldWithCode: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        //delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textView, txt: newText) ?? true
        let returnValue = delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textView, txt: newText, range: range, replacementText: text) ?? true
        return returnValue
        /*
        if let text = textView.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: text)
            let returnValue = delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textView, txt: updatedText) ?? true
            return returnValue
        }else{
            let returnValue = delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textView, txt: "") ?? true
            return returnValue
        }*/
        
        //return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        lblTitle.textColor = .GREEN
        viewbgBottomLine.backgroundColor = .GREEN
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        lblTitle.textColor = .MIDGREY
        viewbgBottomLine.backgroundColor = .LIGHTGREY
        
        delegate_UIFloatingTextField_Protocol?.editingChanged(textField: textView)
    }
    
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        lblTitle.textColor = .MIDGREY
//        viewbgBottomLine.backgroundColor = .LIGHTGREY
//        delegate_UIFloatingTextField_Protocol?.editingChanged(textField: textView)
//        return true
//    }
}
*/

extension FloatingTextFieldWithCode: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            let returnValue = delegate_FloatingTextFieldWithCode_Protocol?.shouldChangeCharactersIn(textField: textField, txt: updatedText) ?? true
            return returnValue
        }else{
            let returnValue = delegate_FloatingTextFieldWithCode_Protocol?.shouldChangeCharactersIn(textField: textField, txt: "") ?? true
            return returnValue
        }
     
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isAllowToChangeActiveColor{
            lblTitle.textColor = .GREEN
            viewbgBottomLine.backgroundColor = .GREEN
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isAllowToChangeActiveColor{
            lblTitle.textColor = .MIDGREY
            viewbgBottomLine.backgroundColor = .LIGHTGREY
        }
    }
}


