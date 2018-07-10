//
//  PaymentMethodCell.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 7/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit
import Kingfisher

class PaymentMethodCell: UICollectionViewCell {

    @IBOutlet weak var methodView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    var issuer: Issuer? {
        didSet {
            if let issuer = issuer {
                self.lblType.isHidden = true
                self.lblTitle.text = issuer.name
                if  issuer.secureThumbnail != "" {
                    self.imgLogo.kf.setImage(with: URL(string:issuer.secureThumbnail!))
                }
            }
        }
    }
    
    
}
