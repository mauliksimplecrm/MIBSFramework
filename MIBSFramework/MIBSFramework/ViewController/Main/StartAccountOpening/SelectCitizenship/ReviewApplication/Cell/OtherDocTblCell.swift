//
//  OtherDocTblCell.swift
//  Maisarah
//
//  Created by Maulik Vora on 20/07/22.
//

import UIKit

class OtherDocTblCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnOpenDoc: UIButton!
    
    var didTappedOpenOtherDoc: ((UIButton) -> (Void))? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnOpenDoc(_ sender: UIButton) {
        if self.didTappedOpenOtherDoc != nil {
            self.didTappedOpenOtherDoc!(sender)
        }
    }
}
