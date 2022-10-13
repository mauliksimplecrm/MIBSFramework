//
//  UIFloatingTextField.swift
//  Maisarah
//
//  Created by Maulik Vora on 29/01/22.
//

import Foundation
import UIKit


protocol UIFloatingTextField_Protocol {
    /*func btnOpenCountryCodePicker(textField: UITextField)
     func shouldChangeCharactersIn(textField: UITextField, txt: String) -> Bool
     func editingChanged(textField: UITextField)
     func textFieldDidBeginEditing(textField: UITextField)*/
    
    func btnOpenCountryCodePicker(textField: UITextView)
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool
    func editingChanged(textField: UITextView)
    func textFieldDidBeginEditing(textField: UITextView)
}

class UIFloatingTextField: UIView, NSTextStorageDelegate {
    
    //MARK:  IBOutlet
    @IBOutlet weak var txtType: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    //@IBOutlet weak var txtType: UITextField!
    //@IBOutlet weak var imgIconStatus: UIImageView!
    //@IBOutlet weak var imgIconStatus_leading: NSLayoutConstraint!
    //@IBOutlet weak var imgiconStatus_Width: NSLayoutConstraint!
    @IBOutlet weak var viewbgBottomLine: UIView!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnOpenDropDown: UIButton!
    @IBOutlet weak var iconDropDown: UIImageView!
    @IBOutlet weak var iconFill: UIImageView!
    //@IBOutlet weak var viewContainer_height: NSLayoutConstraint!
    
    
    
    var didTappedDropDown: ((UIButton) -> (Void))? = nil
    
    //MARK: Veriable
    let nibName = "UIFloatingTextField"
    var contentView: UIView?
    var delegate_UIFloatingTextField_Protocol:UIFloatingTextField_Protocol?
    var resignFirstResponder = false
    
    var placeholderLabel : UILabel!
    
    
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
    func setbtnDropDownUserInteraction(isUserInteraction: Bool){
        btnOpenDropDown.isUserInteractionEnabled = isUserInteraction
    }
    func setTitlePlaceholder(text_: String, placeholder_: String, isUserInteraction: Bool, type: UIFloatingTextFieldType? = nil, btnDropDownHide: Bool? = nil, isSecureTextEntry: Bool? = false, maximumNumberOfLines: Int? = 2){
        lblTitle.text = text_
        //txtType.placeholder = placeholder_
        //txtType.placeholderColor = .LIGHTGREY
        txtType.isUserInteractionEnabled = isUserInteraction
        txtType.delegate = self
        txtType.textContainerInset = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 0)
        //txtType.textStorage.delegate = self
        
        //---Set PlaceHolder
        placeholderLabel = UILabel()
        placeholderLabel.text = placeholder_
        placeholderLabel.font = UIFont(name: "Gotham-Medium", size: CGFloat(18.0))!
        placeholderLabel.sizeToFit()
        txtType.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: ((txtType.font?.pointSize)! / 2)-2)
        placeholderLabel.textColor = .LIGHTGREY
        placeholderLabel.isHidden = !txtType.text.isEmpty
        //---
        
        //txtType.setRightPaddingPoints(50)
        if Managelanguage.getLanguageCode() == "A"
        {
            lblTitle.semanticContentAttribute = .forceRightToLeft
            txtType.semanticContentAttribute = .forceRightToLeft
            
            lblError.textAlignment = .right
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
        
        //--
        txtType.textContainer.maximumNumberOfLines = maximumNumberOfLines ?? 2
        txtType.textContainer.lineBreakMode = .byTruncatingTail
        txtType.isSecureTextEntry = isSecureTextEntry ?? false
        
        txtType.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    //    func setICON(dropDownIcon ishide: Bool? = nil){
    //        iconDropDown.isHidden = ishide ?? true
    //
    //        /*if hidden{
    //            imgIconStatus.isHidden = hidden
    //            imgIconStatus_leading.constant = 0
    //            imgiconStatus_Width.constant = 0
    //        }else{
    //            imgIconStatus.image = img_
    //        }*/
    //    }
    
    func hiddenTextField(txtView: UIFloatingTextField, layoutConTop: NSLayoutConstraint, layoutConHeight: NSLayoutConstraint){
        txtView.isHidden = true
        layoutConTop.constant = 0
        layoutConHeight.constant = 0
    }
    func showTextField(txtView: UIFloatingTextField, layoutConTop: NSLayoutConstraint, layoutConHeight: NSLayoutConstraint){
        txtView.isHidden = false
        layoutConTop.constant = 10
        layoutConHeight.constant = 81
    }
    
    func setSelectedDropDownUI(){
        //lblTitle.textColor = .GREEN
        //viewbgBottomLine.backgroundColor = .GREEN
    }
    
    
    //MARK: - @IBAction
    @IBAction func editingChanged(_ sender: Any) {
        //delegate_UIFloatingTextField_Protocol?.editingChanged(textField: txtType)
        
    }
    
    @IBAction func btnOpenDropDown(_ sender: UIButton) {
        if self.didTappedDropDown != nil {
            self.didTappedDropDown!(sender)
        }
    }
    
    func manageSubViewHeight() -> CGFloat{
        print("*******************" + "\(txtType.contentSize.height)" + "*******************")
        let height_ = txtType.contentSize.height + 41
        //viewContainer_height.constant = height_
        return height_
    }
    
}
extension UIFloatingTextField: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        //delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textView, txt: newText)
        //textView.adjustUITextViewHeight()
        
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let returnValue = delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textView, txt: newText, range: range, replacementText: text, containSize: newSize) ?? true
        
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        return returnValue
        /*
         if let text = textView.text, let textRange = Range(range, in: text) {
         let updatedText = text.replacingCharacters(in: textRange, with: text)
         delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textView, txt: updatedText)
         
         }else{
         delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textView, txt: "")
         
         }*/
        
        //return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if resignFirstResponder{
            //textField.resignFirstResponder()
        }
        lblTitle.textColor = .GREEN
        viewbgBottomLine.backgroundColor = .GREEN
        
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        delegate_UIFloatingTextField_Protocol?.textFieldDidBeginEditing(textField: txtType)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        lblTitle.textColor = .MIDGREY
        viewbgBottomLine.backgroundColor = .LIGHTGREY
        
        placeholderLabel.isHidden = !textView.text.isEmpty
        
        delegate_UIFloatingTextField_Protocol?.editingChanged(textField: textView)
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    //    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    //        lblTitle.textColor = .MIDGREY
    //        viewbgBottomLine.backgroundColor = .LIGHTGREY
    //        delegate_UIFloatingTextField_Protocol?.editingChanged(textField: textView)
    //        return true
    //    }
}
/*
 extension UIFloatingTextField: UITextFieldDelegate{
 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
 if let text = textField.text, let textRange = Range(range, in: text) {
 let updatedText = text.replacingCharacters(in: textRange, with: string)
 delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textField, txt: updatedText)
 
 }else{
 delegate_UIFloatingTextField_Protocol?.shouldChangeCharactersIn(textField: textField, txt: "")
 
 }
 
 return true
 }
 //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
 //        return textFieldShouldBeginEditing
 //    }
 func textFieldDidBeginEditing(_ textField: UITextField) {
 if resignFirstResponder{
 //textField.resignFirstResponder()
 }
 lblTitle.textColor = .GREEN
 viewbgBottomLine.backgroundColor = .GREEN
 delegate_UIFloatingTextField_Protocol?.textFieldDidBeginEditing(textField: txtType)
 }
 func textFieldDidEndEditing(_ textField: UITextField) {
 lblTitle.textColor = .MIDGREY
 viewbgBottomLine.backgroundColor = .LIGHTGREY
 }
 }
 */
extension UIFloatingTextField: UIFloatingTextField_Protocol
{
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool {
        return true
    }
    
    func btnOpenCountryCodePicker(textField: UITextView){
        
    }
    func editingChanged(textField: UITextView){
        
    }
    func shouldChangeCharactersIn(textField: UITextView, txt: String){
        
    }
    func textFieldDidBeginEditing(textField: UITextView){
        
    }
    
    //    func shouldChangeCharactersIn(textField: UITextField, txt: String) -> Bool {
    //        return true
    //    }
    //
    //    func btnOpenCountryCodePicker(textField: UITextField){
    //
    //    }
    //    func editingChanged(textField: UITextField){
    //
    //    }
    //    func shouldChangeCharactersIn(textField: UITextField, txt: String){
    //
    //    }
    //    func textFieldDidBeginEditing(textField: UITextField){
    //
    //    }
}

enum UIFloatingTextFieldType {
    case normal
    case dropDown
}
extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
extension UITextView {
    func numberOfLines() -> Int {
        let layoutManager = self.layoutManager
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var lineRange: NSRange = NSMakeRange(0, 1)
        var index = 0
        var numberOfLines = 0
        
        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(
                forGlyphAt: index, effectiveRange: &lineRange
            )
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }
}

