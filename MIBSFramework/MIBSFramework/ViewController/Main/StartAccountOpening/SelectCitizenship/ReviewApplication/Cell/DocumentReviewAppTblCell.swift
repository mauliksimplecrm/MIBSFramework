//
//  DocumentReviewAppTblCell.swift
//  Maisarah
//
//  Created by Maulik Vora on 02/07/22.
//

import UIKit

class DocumentReviewAppTblCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var viewbgFront: UIView!
    @IBOutlet weak var imgFront: UIImageView!
    @IBOutlet weak var btnFimage: UIButton!
    @IBOutlet weak var lblFront: UILabel!
    @IBOutlet weak var viewbgBack: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBimage: UIButton!
    @IBOutlet weak var lblBack: UILabel!
    
    var didTappedFbtn: ((UIButton) -> (Void))? = nil
    var didTappedBbtn: ((UIButton) -> (Void))? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnFimg(_ sender: UIButton) {
        if self.didTappedFbtn != nil {
            self.didTappedFbtn!(sender)
        }
    }
    @IBAction func btnBimg(_ sender: UIButton) {
        if self.didTappedBbtn != nil {
            self.didTappedBbtn!(sender)
        }
    }
    
    
}
