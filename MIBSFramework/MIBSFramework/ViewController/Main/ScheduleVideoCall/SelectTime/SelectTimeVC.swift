//
//  SelectTimeVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 26/01/22.
//

import UIKit


protocol didSelectTimeSlot_Protocol {
    func didSelectTimeSlot(timeSlot: String, backendValue: String)
}

class SelectTimeVC: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lblSelectTimeSlot: UILabel!
    @IBOutlet weak var viewbgContainer_top: NSLayoutConstraint!
    @IBOutlet weak var viewbgHeader: UIView!
    
    //MARK: Veriable
    var delegate_didSelectTimeSlot_Protocol: didSelectTimeSlot_Protocol?
    var arrTimeList = ManageDropDownOption.getDropDownValue(dropdown_filed: .contact_time_preference_c)
    var selectTimeSlotIndex = ""
    var tableViewHeight: CGFloat {
        tblList.layoutIfNeeded()
        
        return tblList.contentSize.height
    }
    var selectDateBackendValue = ""
    var localize = Managelanguage.getLanguageCode() == "A" ? "ar" : "en"
    
    var isComeFromScreen = ""
    
    
    //MARK: Func
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        localization()
        
        
        if isComeFromScreen == "schedule_video_call"{
            arrTimeList = ManageDropDownOption.getDropDownValue(dropdown_filed: .contact_time_preference_c)
            
            checkAnySlotAvailable_ScheduleCall()
        }else{
            arrTimeList = ManageDropDownOption.getDropDownValue(dropdown_filed: .debit_card_collection_time_c)
            
            checkAnySlotAvailable_debit_card_collection_time()
        }
        
        
    }
    override func viewDidLayoutSubviews() {
        let window = keyWindow //UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0.0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
        let height = UIScreen.main.bounds.height - topPadding - bottomPadding
        
        let fixHeight = 60
        let lbl1Height = lblSelectTimeSlot.systemLayoutSizeFitting(CGSize(width: lblSelectTimeSlot.frame.width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        let tblheight = tableViewHeight
        let containHeight = (CGFloat(fixHeight) + lbl1Height + tblheight)
        
        
        //--
        if height >= containHeight{
            viewbgContainer_top.constant = height - containHeight
        }else{
            viewbgContainer_top.constant = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            print("done")
            if height >= containHeight{
                self.viewbgContainer_top.constant = height - containHeight
            }else{
                self.viewbgContainer_top.constant = 0
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            print("done")
            if height >= containHeight{
                self.viewbgContainer_top.constant = height - containHeight
            }else{
                self.viewbgContainer_top.constant = 0
            }
        })
        
    }
    
    func checkAnySlotAvailable_ScheduleCall(){
        //----
        var availableAnySlot = false
        arrTimeList.forEach { title in
            let arr = title.components(separatedBy: "(")
            //--
            let timeSlot = "\(arr[1])".replacingOccurrences(of: ")", with: "")
            let timeSlotArr = timeSlot.components(separatedBy: "-")
            if timeSlotArr.count > 1{
                let currentDateTime = AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd", localise: localize)
                let endDate = selectDateBackendValue == "" ? currentDateTime : selectDateBackendValue
                let endTime = "\(timeSlotArr[1])".replacingOccurrences(of: " ", with: "")
                
                let apiDateTime = "\(endDate) \(endTime)"
                
                
                print(apiDateTime)
                print(currentDateTime)
                
                let date_apidDateTime = AppHelper.stringToDate(strDate: apiDateTime, strFormate: "yyyy-MM-dd hha", localise: localize).millisecondsSince1970
                let date_currentDateTime = AppHelper.stringToDate(strDate: currentDateTime, strFormate: "yyyy-MM-dd hha", localise: localize).millisecondsSince1970
                
                if date_currentDateTime > date_apidDateTime{
                }else{
                    availableAnySlot = true
                }
            }
        }
        if availableAnySlot == false{
            arrTimeList.removeAll()
            tblList.reloadData()
            
            showAlert(detail: "\(Localize(key: "not_available_time_slot"))")
        }
        tblList.reloadData()
    }
    
    func checkAnySlotAvailable_debit_card_collection_time(){
        //----
        var availableAnySlot = false
        arrTimeList.forEach { title in
            
            let timeSlotArr = title.components(separatedBy: "-")
            if timeSlotArr.count > 1{
                
                let endDate = selectDateBackendValue == "" ? AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd", localise: localize) : selectDateBackendValue
                let endTime = "\(timeSlotArr[1])".replacingOccurrences(of: " ", with: "")
                
                let apiDateTime = "\(endDate) \(endTime)"
                
                print(apiDateTime)
                
                let date_apidDateTime = AppHelper.stringToDate(strDate: apiDateTime, strFormate: "yyyy-MM-dd hh:mma", localise: localize).millisecondsSince1970
                let date_currentDateTime = AppHelper.stringToDate(strDate: AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd hh:mma", localise: localize), strFormate: "yyyy-MM-dd hh:mma", localise: localize).millisecondsSince1970
                
                if date_currentDateTime > date_apidDateTime{
                }else{
                    availableAnySlot = true
                }
            }
        }
        if availableAnySlot == false{
            arrTimeList.removeAll()
            tblList.reloadData()
            
            showAlert(detail: "\(Localize(key: "not_available_time_slot"))")
        }
        tblList.reloadData()
    }
    
    func registerCell(){
        tblList.register(UINib(nibName: "TimeSlotTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "TimeSlotTblCell")
    }
    func localization(){
        Managelanguage.setUIAccordingLanguage()
        lblSelectTimeSlot.text = Localize(key: "Select Time slot")
        
    }
    func showAlert(detail: String){
        //--
        let popover = Popover()
        let alert = InProgressAppAlertView.instanceFromNib()
        //--
        alert.lblTitle.text = Localize(key: "Sorry!")
        alert.lblMessage.text = detail
        alert.btnGotoApplication.isHidden = true
        alert.btnContinueApplication.isHidden = true
        alert.btnCancel.setTitle(Localize(key: "GOT IT"), for: .normal)
        alert.didTappedCancel = { (sender) in
            popover.dismiss()
            self.dismiss(animated: true, completion: nil)
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
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension SelectTimeVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTimeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeSlotTblCell", for: indexPath) as! TimeSlotTblCell
        cell.selectionStyle = .none
        let title = arrTimeList[indexPath.row]
        
        if isComeFromScreen == "schedule_video_call"{
            let arr = title.components(separatedBy: "(")
            if arr.count != 0 {
                cell.lblTitle.text = arr.first
            }
            if arr.count > 1 {
                cell.lblTimeSlot.text = "(\(arr[1])"
            }
            
            //cell.lblTimeSlot.text = arrTimeList[indexPath.row]
            
            //----
            var slotAvailable = true
            let timeSlot = "\(arr[1])".replacingOccurrences(of: ")", with: "")
            let timeSlotArr = timeSlot.components(separatedBy: "-")
            if timeSlotArr.count > 1{
                let endDate = selectDateBackendValue == "" ? AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd", localise: localize) : selectDateBackendValue
                let endTime = "\(timeSlotArr[1])".replacingOccurrences(of: " ", with: "")
                
                let apiDateTime = "\(endDate) \(endTime)"
                let currentDateTime = AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd", localise: localize)
                
                print(apiDateTime)
                print(currentDateTime)
                
                let date_apidDateTime = AppHelper.stringToDate(strDate: apiDateTime, strFormate: "yyyy-MM-dd hha", localise: localize).millisecondsSince1970
                let date_currentDateTime = AppHelper.stringToDate(strDate: currentDateTime, strFormate: "yyyy-MM-dd hha", localise: localize).millisecondsSince1970
                
                if date_currentDateTime > date_apidDateTime{
                    slotAvailable = false
                }
            }
            
            //----
            let contact_time_preference_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .contact_time_preference_c, index: indexPath.row)
            if selectTimeSlotIndex == contact_time_preference_c{
                cell.viewContainer.backgroundColor = .DARKGREENTINT
                cell.lblTitle.textColor = .WHITE
                cell.lblTimeSlot.textColor = .WHITE
            }else if slotAvailable == false{
                cell.viewContainer.backgroundColor = .WHITE
                cell.lblTitle.textColor = .LIGHTGREY
                cell.lblTimeSlot.textColor = .LIGHTGREY
            }else{
                cell.viewContainer.backgroundColor = .WHITE
                cell.lblTitle.textColor = .DARKGREY
                cell.lblTimeSlot.textColor = .DARKGREY
            }
            
        }else{
            cell.lblTitle.text = ""
            cell.lblTimeSlot.text = title
            
            //----
            var slotAvailable = true
            let timeSlotArr = title.components(separatedBy: "-")
            if timeSlotArr.count > 1{
                
                let endDate = selectDateBackendValue == "" ? AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd", localise: localize) : selectDateBackendValue
                let endTime = "\(timeSlotArr[1])".replacingOccurrences(of: " ", with: "")
                
                let apiDateTime = "\(endDate) \(endTime)"
                
                print(apiDateTime)
                
                let date_apidDateTime = AppHelper.stringToDate(strDate: apiDateTime, strFormate: "yyyy-MM-dd hh:mma", localise: localize).millisecondsSince1970
                let date_currentDateTime = AppHelper.stringToDate(strDate: AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd hh:mma", localise: localize), strFormate: "yyyy-MM-dd hh:mma", localise: localize).millisecondsSince1970
                
                if date_currentDateTime > date_apidDateTime{
                    slotAvailable = false
                }
            }
            
            //----
            let debit_card_collection_time_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_time_c, index: indexPath.row)
            if selectTimeSlotIndex == debit_card_collection_time_c{
                cell.viewContainer.backgroundColor = .DARKGREENTINT
                cell.lblTitle.textColor = .WHITE
                cell.lblTimeSlot.textColor = .WHITE
            }else if slotAvailable == false{
                cell.viewContainer.backgroundColor = .WHITE
                cell.lblTitle.textColor = .LIGHTGREY
                cell.lblTimeSlot.textColor = .LIGHTGREY
            }else{
                cell.viewContainer.backgroundColor = .WHITE
                cell.lblTitle.textColor = .DARKGREY
                cell.lblTimeSlot.textColor = .DARKGREY
            }
            
        }
     
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let title = arrTimeList[indexPath.row]
        if isComeFromScreen == "schedule_video_call"{
            let arr = title.components(separatedBy: "(")
            //----
            var slotAvailable = true
            let timeSlot = "\(arr[1])".replacingOccurrences(of: ")", with: "")
            let timeSlotArr = timeSlot.components(separatedBy: "-")
            if timeSlotArr.count > 1{
                let endDate = selectDateBackendValue == "" ? AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd", localise: localize) : selectDateBackendValue
                let endTime = "\(timeSlotArr[1])".replacingOccurrences(of: " ", with: "")
                
                let apiDateTime = "\(endDate) \(endTime)"
                let currentDateTime = AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd", localise: localize)
                
                print(apiDateTime)
                print(currentDateTime)
                
                let date_apidDateTime = AppHelper.stringToDate(strDate: apiDateTime, strFormate: "yyyy-MM-dd hha", localise: localize).millisecondsSince1970
                let date_currentDateTime = AppHelper.stringToDate(strDate: currentDateTime, strFormate: "yyyy-MM-dd hha", localise: localize).millisecondsSince1970
                
                if date_currentDateTime > date_apidDateTime{
                    slotAvailable = false
                }
            }
            if slotAvailable{
                let contact_time_preference_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .contact_time_preference_c, index: indexPath.row)

                //--
                delegate_didSelectTimeSlot_Protocol?.didSelectTimeSlot(timeSlot: title, backendValue: contact_time_preference_c)
                dismiss(animated: true, completion: nil)
            }
        }else{
            //----
            var slotAvailable = true
            let timeSlotArr = title.components(separatedBy: "-")
            if timeSlotArr.count > 1{
                let endDate = selectDateBackendValue == "" ? AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd", localise: localize) : selectDateBackendValue
                let endTime = "\(timeSlotArr[1])".replacingOccurrences(of: " ", with: "")
                
                let apiDateTime = "\(endDate) \(endTime)"
                
                
                print(apiDateTime)
                
                
                let date_apidDateTime = AppHelper.stringToDate(strDate: apiDateTime, strFormate: "yyyy-MM-dd hh:mma", localise: localize).millisecondsSince1970
                let date_currentDateTime = AppHelper.stringToDate(strDate: AppHelper.getCurrentDate(dateFormate: "yyyy-MM-dd hh:mma", localise: localize), strFormate: "yyyy-MM-dd hh:mma", localise: localize).millisecondsSince1970
                
                if date_currentDateTime > date_apidDateTime{
                    slotAvailable = false
                }
            }
            if slotAvailable{
                let debit_card_collection_time_c = ManageDropDownOption.getDropDownBackendValue(dropdown_filed: .debit_card_collection_time_c, index: indexPath.row)
                //--
                delegate_didSelectTimeSlot_Protocol?.didSelectTimeSlot(timeSlot: title, backendValue: debit_card_collection_time_c)
                dismiss(animated: true, completion: nil)
            }
        }
    }
}


extension SelectTimeVC: didSelectTimeSlot_Protocol{
    func didSelectTimeSlot(timeSlot: String, backendValue: String){
        
    }
}

