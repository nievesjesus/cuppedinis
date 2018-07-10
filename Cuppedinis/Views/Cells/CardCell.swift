//
//  CardCell.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 9/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import Kingfisher

class CardCell: UICollectionViewCell {

    @IBOutlet weak var methodView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var paymentMethod: PaymentMethod? {
        didSet {
            if let method = paymentMethod {
                self.lblTitle.textColor = UIColor.darkGray
                self.lblTitle.text = method.name
                
                self.lblType.textColor = UIColor.darkGray
                self.lblType.text = method.paymentTypeId?.replacingOccurrences(of: "_", with: " ").capitalized
                if  method.secureThumbnail != "" {
                    self.imgLogo.kf.setImage(with: URL(string:method.secureThumbnail!))
                }
            }
        }
    }
    
}
