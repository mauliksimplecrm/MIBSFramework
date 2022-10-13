//
//  AddCountryRiskCusCell.swift
//  Maisarah
//
//  Created by Maulik Vora on 17/02/22.
//

import UIKit

class AddCountryRiskCusCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtNameOfCountry: UIFloatingTextField!
    @IBOutlet weak var txtExpectedPurpose: UIFloatingTextField!
    @IBOutlet weak var btnRemove: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnRemove(_ sender: Any) {
    }
    
}
