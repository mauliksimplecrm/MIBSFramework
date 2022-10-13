//
//  VideoCallTblCell.swift
//  Maisarah
//
//  Created by Maulik Vora on 14/07/22.
//

import UIKit

class VideoCallTblCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnStartVideoCall: UIButton!
    
    var didTappedStartCall: ((UIButton) -> (Void))? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnStartVideoCall(_ sender: UIButton) {
        if self.didTappedStartCall != nil {
            self.didTappedStartCall!(sender)
        }
    }
    
}
