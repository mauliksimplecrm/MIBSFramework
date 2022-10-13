//
//  TimeSlotTblCell.swift
//  Maisarah
//
//  Created by Maulik Vora on 26/01/22.
//

import UIKit

class TimeSlotTblCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTimeSlot: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
