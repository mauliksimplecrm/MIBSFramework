//
//  CustomDorpDownVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 29/01/22.
//

import UIKit

protocol didSelectCustomDropDown_Protocol {
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String)
}
//97 Header
class CustomDorpDownVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var viewContainer_Top: NSLayoutConstraint!
    
    
    //MARK: Veriable
    var arrListOfDropDown:[String] = []
    var selectIndex = 0
    var delegate_didSelectCustomDropDown_Protocol: didSelectCustomDropDown_Protocol?
    var dropDownType = ""
    var headerTitle = ""
    var tableViewHeight: CGFloat {
        tblList.layoutIfNeeded()

        return tblList.contentSize.height
    }
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        lblHeaderTitle.text = headerTitle
        tblList.reloadData()
        viewDidLayoutSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.endEditing(true)
        tblList.reloadData()
    }
    override func viewDidLayoutSubviews() {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0.0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
        let height = UIScreen.main.bounds.height - topPadding - bottomPadding
        
        let height_ = lblHeaderTitle.systemLayoutSizeFitting(CGSize(width: lblHeaderTitle.frame.width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height

        
        let tblContainHeight = tableViewHeight //tblList.contentSize.height
        let headerHeight = 57.0 + height_
        let finalHeight = tblContainHeight + headerHeight
        if height >= finalHeight{
            viewContainer_Top.constant = height - finalHeight
        }else{
            viewContainer_Top.constant = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            let tblContainHeight = self.tblList.contentSize.height
            let headerHeight = 57.0 + height_
            let finalHeight = tblContainHeight + headerHeight
            if height >= finalHeight{
                self.viewContainer_Top.constant = height - finalHeight
            }else{
                self.viewContainer_Top.constant = 0
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            print(self.lblHeaderTitle.frame.height)
            let tblContainHeight = self.tblList.contentSize.height
            let headerHeight = 57.0 + height_
            let finalHeight = tblContainHeight + headerHeight
            if height >= finalHeight{
                self.viewContainer_Top.constant = height - finalHeight
            }else{
                self.viewContainer_Top.constant = 0
            }
            
        })
        

    }
    func registerCell(){
        tblList.register(UINib(nibName: "CustomDropDownTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "CustomDropDownTblCell")
    }

    

    //MARK: @IBAction
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension CustomDorpDownVC: UITableViewDelegate, UITableViewDataSource
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
        
        selectIndex = indexPath.row
        tblList.reloadData()
        
        //--
        self.dismiss(animated: true, completion: nil)
        delegate_didSelectCustomDropDown_Protocol?.didSelectdidSelectCustomDropDown(title: arrListOfDropDown[indexPath.row], index: selectIndex, droDownType: dropDownType)
        
    }
}

extension CustomDorpDownVC: didSelectCustomDropDown_Protocol{
    func didSelectdidSelectCustomDropDown(title: String, index: Int, droDownType: String){
        
    }
}
