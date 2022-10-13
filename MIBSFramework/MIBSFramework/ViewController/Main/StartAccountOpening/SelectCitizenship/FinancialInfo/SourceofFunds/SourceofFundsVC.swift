
//
//  SourceofFundsVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 03/02/22.
//

import UIKit
////import Popover

protocol didSelectSourceofFunds_protocol {
    func didSelectSourceofFunds(text: String, otherEnterText: String, index: Int)
}
class SourceofFundsVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var viewbgStep1_top: NSLayoutConstraint!
    @IBOutlet weak var lblSourceofFundsStep1: UILabel!
    @IBOutlet weak var tblSourceofFundsStep1: UITableView!
    
    @IBOutlet weak var viewbgStep2: UIView!
    @IBOutlet weak var lblSourceofFundsStep2: UILabel!
    @IBOutlet weak var lblOtherStep2: UILabel!
    @IBOutlet weak var lblOtherDetailsStep2: UILabel!
    @IBOutlet weak var txtPleaseSpecifyStep2: UIFloatingTextField!
    @IBOutlet weak var viewbgBtnSubmitStep2: UIView!
    @IBOutlet weak var lblSubmitStep2: UILabel!
    
    @IBOutlet weak var viewbgStep3: UIView!
    @IBOutlet weak var viewbgStep3_height: NSLayoutConstraint! //209
    @IBOutlet weak var lblOtherDetailsStep3: UILabel!
    @IBOutlet weak var txtPlaseSpecifyStep3: UIFloatingTextField! //209
    @IBOutlet weak var viewbgBtnSubmitStep3: UIView!
    @IBOutlet weak var lblSubmitStep3: UILabel!
    
    
    //MARK: Veriable
    var arrListOfDropDown:[String] = []
    var selectIndex = 0
    var pleaseSpecifyText = ""
    var pleaseSpecifyTextPlaceHolder = ""
    var stepTitle = ""
    var delegate_didSelectSourceofFunds_protocol: didSelectSourceofFunds_protocol?
    var otherTextSourceofFund = ""
    var step3Show = false
    
    var openFromScreen = ""
    
    var tableViewHeight: CGFloat {
        tblSourceofFundsStep1.layoutIfNeeded()

        return tblSourceofFundsStep1.contentSize.height
    }
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        registerCell()

        //--
        lblSourceofFundsStep1.text = stepTitle
        lblSourceofFundsStep2.text = stepTitle
        
        //--
        txtPleaseSpecifyStep2.setTitlePlaceholder(text_: pleaseSpecifyText, placeholder_: pleaseSpecifyTextPlaceHolder, isUserInteraction: true)
        txtPleaseSpecifyStep2.delegate_UIFloatingTextField_Protocol = self
        txtPlaseSpecifyStep3.setTitlePlaceholder(text_: pleaseSpecifyText, placeholder_: pleaseSpecifyTextPlaceHolder, isUserInteraction: true)
        txtPlaseSpecifyStep3.delegate_UIFloatingTextField_Protocol = self
        
        txtPleaseSpecifyStep2.txtType.text = ""
        txtPleaseSpecifyStep2.txtType.insertText(otherTextSourceofFund)
        txtPlaseSpecifyStep3.txtType.text = ""
        txtPlaseSpecifyStep3.txtType.insertText(otherTextSourceofFund)
        
        if openFromScreen == "financial"{
            let sources_of_fund_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .sources_of_fund_c, index: selectIndex)
            if sources_of_fund_c == "Others"{
                //--
                showStep3()
            }else{
                //--
                hideStep3()
            }
        }else{
            let purpose_of_account_opening_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .purpose_of_account_opening_c, index: selectIndex)
            if purpose_of_account_opening_c == "8" { //if selectIndex == arrListOfDropDown.count - 1{//if step3Show == true{
                //--
                showStep3()
            }else{
                //--
                hideStep3()
            }
        }
        
        tblSourceofFundsStep1.reloadData()
        validateEnput()
    }
    override func viewDidLayoutSubviews() {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0.0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
        let height = UIScreen.main.bounds.height - topPadding - bottomPadding
        //let lblHeader_height = lblSourceofFundsStep1.frame.height
        
        let height_ = lblSourceofFundsStep1.systemLayoutSizeFitting(CGSize(width: lblSourceofFundsStep1.frame.width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        
        var otherView3Height = 0.0
        if step3Show == true{
            otherView3Height = 209.0
        }
        let tblContainHeight = tableViewHeight //tblList.contentSize.height
        let headerHeight = otherView3Height + 60.0 + height_
        let finalHeight = tblContainHeight + headerHeight
        if height >= finalHeight{
            viewbgStep1_top.constant = height - finalHeight
        }else{
            viewbgStep1_top.constant = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("done" + "\(self.tblSourceofFundsStep1.contentSize.height)")
            let tblContainHeight = self.tblSourceofFundsStep1.contentSize.height
            let headerHeight = otherView3Height + 60.0 + height_
            let finalHeight = tblContainHeight + headerHeight
            if height >= finalHeight{
                self.viewbgStep1_top.constant = height - finalHeight
            }else{
                self.viewbgStep1_top.constant = 0
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            print("done" + "\(self.tblSourceofFundsStep1.contentSize.height)")
            let tblContainHeight = self.tblSourceofFundsStep1.contentSize.height
            let headerHeight = otherView3Height + 60.0 + height_
            let finalHeight = tblContainHeight + headerHeight
            if height >= finalHeight{
                self.viewbgStep1_top.constant = height - finalHeight
            }else{
                self.viewbgStep1_top.constant = 0
            }
        })
        
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        
        //--
        lblSubmitStep2.text = Localize(key: "SUBMIT")
        lblSubmitStep3.text = Localize(key: "SUBMIT")
        lblOtherDetailsStep2.text = Localize(key: "other_details")
        
        //--
        if Managelanguage.getLanguageCode() == "A"
        {
            txtPleaseSpecifyStep2.txtType.textAlignment = .right
            txtPlaseSpecifyStep3.txtType.textAlignment = .right
        }
    }
    func registerCell(){
        tblSourceofFundsStep1.register(UINib(nibName: "CustomDropDownTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "CustomDropDownTblCell")
    }

    func showStep3()
    {
        step3Show = true
        //viewbgStep1_top.constant = 0
        viewbgStep3.isHidden = false
        viewbgStep3_height.constant = 209
        //tblSourceofFundsStep1.tableFooterView = viewbgStep3
        //tblSourceofFundsStep1.reloadData()
        viewDidLayoutSubviews()
        
        validateEnput()
    }
    func hideStep3(){
        step3Show = false
        
        viewbgStep3.isHidden = true
        viewbgStep3_height.constant = 0
        //tblSourceofFundsStep1.tableFooterView = nil
        //tblSourceofFundsStep1.reloadData()
        viewDidLayoutSubviews()
        validateEnput()
    }
    func showAlert(){
        //--
        let popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Sorry!")
        alert.lblMessage.text = Localize(key: "Make sure you fill all mandatory details and then submit the form")
        alert.btnGotoApplication.isHidden = true
        alert.btnContinueApplication.isHidden = true
        alert.btnCancel.setTitle(Localize(key: "GOT IT"), for: .normal)
        alert.didTappedCancel = { (sender) in
            popover.dismiss()
        }
        
        //--
        alert.frame.size = CGSize(width: UIScreen.main.bounds.width-30, height: alert.viewBG.frame.height)
        let aView = UIView()
        aView.frame = alert.frame
        aView.addSubview(alert)
        popover.dismissOnBlackOverlayTap = false
        popover.blackOverlayColor = popoverBackgroundColor
        popover.showAsDialog(alert, inView: self.view)
    }

    //MARK: @IBAction
    @IBAction func btnCloseStep1(_ sender: Any) {
        if openFromScreen == "financial"{
            let sources_of_fund_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .sources_of_fund_c, index: selectIndex)
            if sources_of_fund_c == "Others" && otherTextSourceofFund.count != 0{
                showAlert()
            }
            else
            {
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            let purpose_of_account_opening_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .purpose_of_account_opening_c, index: selectIndex)
            if purpose_of_account_opening_c == "8" && otherTextSourceofFund.count != 0{
                showAlert()
            }
            else
            {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func btnSubmitStep2(_ sender: Any) {
        //--
        delegate_didSelectSourceofFunds_protocol?.didSelectSourceofFunds(text: arrListOfDropDown[selectIndex], otherEnterText: txtPleaseSpecifyStep2.txtType.text!, index: selectIndex)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnCloseStep2(_ sender: Any) {
        if openFromScreen == "financial"{
            let sources_of_fund_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .sources_of_fund_c, index: selectIndex)
            if sources_of_fund_c == "Others" && otherTextSourceofFund.count != 0{
                showAlert()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            let purpose_of_account_opening_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .purpose_of_account_opening_c, index: selectIndex)
            if purpose_of_account_opening_c == "8" && otherTextSourceofFund.count != 0{
                showAlert()
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func btnOther_Step2(_ sender: Any) {
        viewbgStep2.isHidden = true
        showStep3()
    }
    @IBAction func btnSubmitStep3(_ sender: Any) {
        
        //--
        delegate_didSelectSourceofFunds_protocol?.didSelectSourceofFunds(text: arrListOfDropDown[selectIndex], otherEnterText: txtPlaseSpecifyStep3.txtType.text!, index: selectIndex)
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension SourceofFundsVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListOfDropDown.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDropDownTblCell", for: indexPath) as! CustomDropDownTblCell
        cell.selectionStyle = .none
        
        cell.lblTitle.text = arrListOfDropDown[indexPath.row]
        
        if indexPath.row == selectIndex{
            cell.imgSelectIcon.isHidden = false
        }else{
            cell.imgSelectIcon.isHidden = true
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //--
        selectIndex = indexPath.row
        tblSourceofFundsStep1.reloadData()
        
        //--
        if openFromScreen == "financial"{
            //--
            let sources_of_fund_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .sources_of_fund_c, index: selectIndex)
            if sources_of_fund_c == "Others"{
                viewbgStep2.isHidden = false
                step3Show = false
                validateEnput()
            }else{
                
                //--
                delegate_didSelectSourceofFunds_protocol?.didSelectSourceofFunds(text: arrListOfDropDown[indexPath.row], otherEnterText: "", index: selectIndex)
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            //--
            let purpose_of_account_opening_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .purpose_of_account_opening_c, index: selectIndex)
            if purpose_of_account_opening_c == "8"{
                viewbgStep2.isHidden = false
                step3Show = false
                validateEnput()
            }else{
                
                //--
                delegate_didSelectSourceofFunds_protocol?.didSelectSourceofFunds(text: arrListOfDropDown[indexPath.row], otherEnterText: "", index: selectIndex)
                self.dismiss(animated: true, completion: nil)
            }
        }        
    }
}

extension SourceofFundsVC: UIFloatingTextField_Protocol{
    
    
    func shouldChangeCharactersIn(textField: UITextView, txt: String, range: NSRange, replacementText: String, containSize: CGSize) -> Bool {
        if AppHelper.allowSomeCharactesOnly(txt: txt) == false{
            return false
        }
        
        validateErrorMsg(textField: textField, txt: txt)
        
        if txt.count >= defaultTextLimit{
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextView) {
    }
    func btnOpenCountryCodePicker(textField: UITextView) {
        
    }
    func editingChanged(textField: UITextView) {
        validateErrorMsg(textField: textField)
    }
    
   
    
    //Validation
    func validateErrorMsg(textField: UITextView,txt: String? = ""){
        let txtValue = textField.text == "" ? txt : textField.text!
        
        if txtPleaseSpecifyStep2.txtType == textField{
            txtPleaseSpecifyStep2.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPleaseSpecifyStep2.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true

        }
        if txtPlaseSpecifyStep3.txtType == textField{
            txtPlaseSpecifyStep3.lblError.isHidden = AppHelper.isNull(txtValue!) == false ? true : false
            txtPlaseSpecifyStep3.iconFill.isHidden = AppHelper.isNull(txtValue!) == false ? false : true

        }
        
        //--
        validateEnput()
    }
    func validateEnput() {
        var returnValue = true

        if step3Show {
            if AppHelper.isNull(txtPlaseSpecifyStep3.txtType.text!){
                //txtOtherIncomeSource.lblError.isHidden = false
                returnValue = false
            }
            
            
            if returnValue{
                AppHelper.enableNextBTN(view_: viewbgBtnSubmitStep3)
            }else{
                AppHelper.disableNextBTN(view_: viewbgBtnSubmitStep3)
            }
            
        }else{
            //--
            if AppHelper.isNull(txtPleaseSpecifyStep2.txtType.text!){
                //txtOtherIncomeSource.lblError.isHidden = false
                returnValue = false
            }
            
            if returnValue{
                AppHelper.enableNextBTN(view_: viewbgBtnSubmitStep2)
            }else{
                AppHelper.disableNextBTN(view_: viewbgBtnSubmitStep2)
            }
            
        }
        
        //return returnValue
    }
    
}
