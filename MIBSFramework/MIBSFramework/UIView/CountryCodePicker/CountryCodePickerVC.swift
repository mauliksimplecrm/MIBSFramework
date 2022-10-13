//
//  CountryCodePickerVC.swift
//  Maisarah
//
//  Created by Maulik Vora on 17/07/22.
//

import UIKit


enum CountryPickerType: String {
    case countryCode = "countryCode"
    case currency = "currency"
    
}
class CountryCodePickerVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var lblNoResultFound: UILabel!
    
    //MARK: - Veriable
    var arrListOfDropDown:[Dropdown_Values] = []
    var arrListOfDropDownMain:[Dropdown_Values] = []
    var arrListOfDropDownSection:[[String: [Dropdown_Values]]] = []
    
    
    var getListOfCountriesDataLocalVCMain = [GetListOfCountriesData]()
    var getListOfCountriesDataLocalVC = [GetListOfCountriesData]()
    var arrCountryListApiSection:[[String: [GetListOfCountriesData]]] = []
    
    static let shared = CountryCodePickerVC(nibName: "CountryCodePickerVC", bundle: bundleIdentifireGlob)
    var didSelectCountry: ((_ countryName:String, _ countryCode:String, _ selectIndex:Int) -> (Void))? = nil
    var countryPickerType: CountryPickerType = .countryCode
    var arrSection:[String] = []
    var headerTitle = ""
    var isComeFromNationality = true
    
    //MARK: - func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        tblList.reloadData()
        lblNoResultFound.isHidden = true
        
        //--
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        searchBar.searchTextField.text = ""
        //--
        if isComeFromNationality{
            if citizenshipType == .expatriate{
                var getListOfCountriesData_Temp = [GetListOfCountriesData]()
                getListOfCountriesData.forEach { getListOfCountriesData_ in
                    if getListOfCountriesData_.country_code == "OMN" ||
                        getListOfCountriesData_.country_code == "BHR" ||
                        getListOfCountriesData_.country_code == "KWT" ||
                        getListOfCountriesData_.country_code == "QAT" ||
                        getListOfCountriesData_.country_code == "ARE" ||
                        getListOfCountriesData_.country_code == "SAU"{
                    }else{
                        getListOfCountriesData_Temp.append(getListOfCountriesData_)
                    }
                }
                getListOfCountriesDataLocalVCMain = getListOfCountriesData_Temp
                getListOfCountriesDataLocalVC = getListOfCountriesData_Temp
            }
            if citizenshipType == .gcc{
                var getListOfCountriesData_Temp = [GetListOfCountriesData]()
                getListOfCountriesData.forEach { getListOfCountriesData_ in
                    if getListOfCountriesData_.country_code == "BHR" ||
                        getListOfCountriesData_.country_code == "KWT" ||
                        getListOfCountriesData_.country_code == "QAT" ||
                        getListOfCountriesData_.country_code == "ARE" ||
                        getListOfCountriesData_.country_code == "SAU" {
                        getListOfCountriesData_Temp.append(getListOfCountriesData_)
                    }
                }
                getListOfCountriesDataLocalVCMain = getListOfCountriesData_Temp
                getListOfCountriesDataLocalVC = getListOfCountriesData_Temp
            }
            
        }else{
            getListOfCountriesDataLocalVCMain = getListOfCountriesData
            getListOfCountriesDataLocalVC = getListOfCountriesData
        }
        sortArraySeaction()
        
        localization()
        tblList.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.searchTextField.text = ""
        
//        getListOfCountriesDataLocalVC = getListOfCountriesDataLocalVCMain
//        sortArraySeaction()
    }
    func registerCell(){
        tblList.register(UINib(nibName: "CountryCodePickerTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "CountryCodePickerTblCell")
        tblList.register(UINib(nibName: "CountryCodePickerSectionTblCell", bundle: bundleIdentifireGlob), forCellReuseIdentifier: "CountryCodePickerSectionTblCell")
    }
    func localization(){
        if countryPickerType == .countryCode{
            lblHeaderTitle.text = headerTitle
            searchBar.searchTextField.placeholder = Localize(key: "country_dialog_hint_text1") // for a country code"
        }else{
            lblHeaderTitle.text = headerTitle
            searchBar.searchTextField.placeholder = Localize(key: "country_dialog_hint_text1") //for a country country code"
        }
        lblNoResultFound.text = Localize(key: "no_country_found")
    }
    
    func sortArraySeaction(){
        //--sort section array
        arrCountryListApiSection.removeAll()
        tblList.reloadData()
        
        
        //--
        var nameArr:[String] = []
        if Managelanguage.getLanguageCode() == "A"{
            nameArr = getListOfCountriesDataLocalVC.map({ (dropdown_Values) in
                return dropdown_Values.ar_label
            })
        }else{
            nameArr = getListOfCountriesDataLocalVC.map({ (dropdown_Values) in
                return dropdown_Values.en_label
            })
        }
        
        let allFirstLatter = nameArr.map({ value in
            String(value.prefix(1))
        })
        arrSection = allFirstLatter.removingDuplicates()
        arrSection = arrSection.sorted(by: { str1, str2 in
            return str1 < str2
        })
        arrSection.forEach { titleSection in
            var arrList:[GetListOfCountriesData] = []
            
            getListOfCountriesDataLocalVC.forEach { getListOfCountriesData_ in
                let name = Managelanguage.getLanguageCode() == "A" ? getListOfCountriesData_.ar_label:getListOfCountriesData_.en_label
                let firsLatterName = name.prefix(1)
                if titleSection == firsLatterName{
                    arrList.append(getListOfCountriesData_)
                }
            }

            arrCountryListApiSection.append([titleSection: arrList])
        }
        
        //--
        tblList.reloadData()
        
        if arrCountryListApiSection.count == 0{
            lblNoResultFound.isHidden = false
        }else{
            lblNoResultFound.isHidden = true
        }
        /*
         //--sort section array
         arrListOfDropDownSection.removeAll()
         tblList.reloadData()
         
         //--
         let nameArr = arrListOfDropDown.map({ dropdown_Values in
         return dropdown_Values.label
         })
         let allFirstLatter = nameArr.map({ value in
         String(value.prefix(1))
         })
         arrSection = allFirstLatter.removingDuplicates()
         arrSection = arrSection.sorted(by: { str1, str2 in
         return str1 < str2
         })
         arrSection.forEach { titleSection in
         var arrList:[Dropdown_Values] = []
         arrListOfDropDown.forEach { dropdown_Values in
         let name = dropdown_Values.label
         let firsLatterName = name.prefix(1)
         if titleSection == firsLatterName{
         arrList.append(dropdown_Values)
         }
         }
         arrListOfDropDownSection.append([titleSection: arrList])
         }
         
         
         //--
         tblList.reloadData()
         
         if arrListOfDropDown.count == 0{
         lblNoResultFound.isHidden = false
         }else{
         lblNoResultFound.isHidden = true
         }
         */
    }
    
    class func presentCountroller(on viewController: UIViewController, list: [Dropdown_Values], countrypicketType: CountryPickerType? = .countryCode, headerTitle: String, isComeFromNationality: Bool? = false){
        
        let vc = CountryCodePickerVC.shared
        vc.headerTitle = headerTitle
        vc.arrListOfDropDown = list
        vc.arrListOfDropDownMain = list
        vc.countryPickerType = countrypicketType ?? .countryCode
        vc.isComeFromNationality = isComeFromNationality ?? false
        let navigationController = UINavigationController(rootViewController: vc)
        viewController.present(navigationController, animated: true, completion: nil)
        //on.present(CountryCodePickerVC.shared, animated: true, completion: nil)
    }
    
    
    //MARK: - @IBAction
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension CountryCodePickerVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        arrCountryListApiSection.count //arrListOfDropDownSection.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCodePickerSectionTblCell") as! CountryCodePickerSectionTblCell
        //cell.lblTitle.text = arrListOfDropDownSection[section].keys.first
        cell.lblTitle.text = arrCountryListApiSection[section].keys.first
        
        if Managelanguage.getLanguageCode() == "A"{
            cell.lblTitle.textAlignment = .right
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionKey = arrCountryListApiSection[section].keys.first else { return 0 }
        let arrRow = arrCountryListApiSection[section][sectionKey]
        return arrRow?.count ?? 0
        
        /*guard let sectionKey = arrListOfDropDownSection[section].keys.first else { return 0 }
         let arrRow = arrListOfDropDownSection[section][sectionKey]
         return arrRow?.count ?? 0*/
        //return arrListOfDropDown.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCodePickerTblCell", for: indexPath) as! CountryCodePickerTblCell
        cell.selectionStyle = .none
        
        guard let sectionKey = arrCountryListApiSection[indexPath.section].keys.first else { return cell }
        let arrRow = arrCountryListApiSection[indexPath.section][sectionKey]
        
        let dicData = arrRow?[indexPath.row]
        cell.lblTitle.text = Managelanguage.getLanguageCode() == "A" ? dicData?.ar_label : dicData?.en_label
        if countryPickerType == .countryCode{
            cell.lblDetail.text = dicData?.country_code
        }else{
            let key = dicData?.country_code
            let filter = countryListLocal.filter { countryData in
                countryData.countryCode == key
            }
            if filter.count != 0{
                cell.lblDetail.text = filter.first?.currency ?? ""
            }else{
                cell.lblDetail.text = dicData?.country_code
            }
        }
        cell.imgFlag.image = UIImage(named: dicData?.country_code ?? "", in: bundleIdentifireGlob, with: nil)
        
        
        /*
         let dicData = arrListOfDropDown[indexPath.row]
         cell.lblTitle.text = dicData.label
         if countryPickerType == .countryCode{
         cell.lblDetail.text = "\(dicData.key as? String ?? "")"
         }else{
         let key = "\(dicData.key as? String ?? "")"
         let filter = countryListLocal.filter { countryData in
         countryData.countryCode == key
         }
         if filter.count != 0{
         cell.lblDetail.text = filter.first?.currency ?? ""
         }else{
         cell.lblDetail.text = "\(dicData.key as? String ?? "")"
         }
         }
         cell.imgFlag.image = UIImage(named: "\(dicData.key as? String ?? "")")
         */
        
        /*
         //--
         if indexPath.row == selectIndex{
         cell.imgSelectIcon.isHidden = false
         }else{
         cell.imgSelectIcon.isHidden = true
         }*/
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionKey = arrCountryListApiSection[indexPath.section].keys.first else { return  }
        let arrRow = arrCountryListApiSection[indexPath.section][sectionKey]
        
        let dicData = arrRow?[indexPath.row]
        let selectLable = Managelanguage.getLanguageCode() == "A" ? dicData?.ar_label ?? "" : dicData?.en_label ?? ""
        
        if self.didSelectCountry != nil {
            self.searchBar.text = ""
            if countryPickerType == .countryCode{
                self.didSelectCountry!(selectLable,dicData?.country_code ?? "",indexPath.row)
            }else{
                let key = dicData?.country_code
                let filter = countryListLocal.filter { countryData in
                    countryData.countryCode == key
                }
                if filter.count != 0{
                    self.didSelectCountry!(selectLable,filter.first?.currency ?? "",indexPath.row)
                }else{
                    self.didSelectCountry!(selectLable,dicData?.country_code ?? "",indexPath.row)
                }
            }
            dismiss(animated: true, completion: nil)
        }
    }
}

extension CountryCodePickerVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //if Managelanguage.getLanguageCode() == "A"{
            getListOfCountriesDataLocalVC = searchText.isEmpty ? getListOfCountriesDataLocalVCMain : getListOfCountriesDataLocalVCMain.filter { $0.ar_label.contains(searchText) || $0.en_label.contains(searchText) }
        /*}else{
            getListOfCountriesDataLocalVC = searchText.isEmpty ? getListOfCountriesDataLocalVCMain : getListOfCountriesDataLocalVCMain.filter { $0.en_label.contains(searchText) }
        }*/
        //arrListOfDropDown = searchText.isEmpty ? arrListOfDropDownMain : arrListOfDropDownMain.filter { $0.label.contains(searchText) }
        sortArraySeaction()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.searchTextField.text ?? ""
        //if Managelanguage.getLanguageCode() == "A"{
            getListOfCountriesDataLocalVC = searchText.isEmpty ? getListOfCountriesDataLocalVCMain : getListOfCountriesDataLocalVCMain.filter { $0.ar_label.contains(searchText) || $0.en_label.contains(searchText) }
        /*}else{
            getListOfCountriesDataLocalVC = searchText.isEmpty ? getListOfCountriesDataLocalVCMain : getListOfCountriesDataLocalVCMain.filter { $0.en_label.contains(searchText) }
        }*/
        //return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        sortArraySeaction()
        
        
        self.view.endEditing(true)
    }
}
/*
 extension String {
 
 var length: Int {
 return count
 }
 
 subscript (i: Int) -> String {
 return self[i ..< i + 1]
 }
 
 func substring(fromIndex: Int) -> String {
 return self[min(fromIndex, length) ..< length]
 }
 
 func substring(toIndex: Int) -> String {
 return self[0 ..< max(0, toIndex)]
 }
 
 subscript (r: Range<Int>) -> String {
 let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
 upper: min(length, max(0, r.upperBound))))
 let start = index(startIndex, offsetBy: range.lowerBound)
 let end = index(start, offsetBy: range.upperBound - range.lowerBound)
 return String(self[start ..< end])
 }
 }
 */
