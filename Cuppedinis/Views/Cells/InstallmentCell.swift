//
//  InstallmentCell.swift
//  Cuppedinis
//
//  Created by Jesus Nieves on 9/7/18.
//  Copyright © 2018 Jesus Nieves. All rights reserved.
//

import UIKit

class InstallmentCell: UICollectionViewCell {

    @IBOutlet weak var viewInstallment: UIView!
    @IBOutlet weak var lblInstallmentQty: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override var isSelected: Bool {
        didSet {
            self.viewInstallment.alpha = isSelected ? 0.75 : 1.0
        }
    }
    
    var payerCost: payerCost? {
        didSet {
            if let payer = payerCost {
                self.lblInstallmentQty.text =  "\(payer.installments ?? 0)"
                self.lblDescription.text = payer.recommendedMessage
            }
        }
    }
    
}
