//
//  TitleReviewAppTblCell.swift
//  Maisarah
//
//  Created by Maulik Vora on 02/07/22.
//

import UIKit

class TitleReviewAppTblCell: UITableViewCell {

    //MARK: - @IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var viewbgLine_height: NSLayoutConstraint!
    
    var didTappedEdit: ((UIButton) -> (Void))? = nil
    
    //MARK: - Func
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - @IBAction
    @IBAction func btnEdit(_ sender: UIButton) {
        if self.didTappedEdit != nil {
            self.didTappedEdit!(sender)
        }
        
    }
    
    
}
