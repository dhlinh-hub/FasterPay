//
//  TableViewCell.swift
//  SampleApp
//
//  Created by Ishipo on 07/06/2021.
//

import UIKit
import Kingfisher

class WalletTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleBuy: UILabel!
    @IBOutlet weak var placeBuy: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var discripLabel: UILabel!
    
    
    var dataOder : Order? {
        didSet {
           
            if let dataOder = dataOder {
                if dataOder.image != "" {
                    let url = URL(string: dataOder.image ?? "")
                    logoImage.kf.setImage(with: url)
                }else {
                    logoImage.image = UIImage(named: "pubg")
                }
            titleBuy.text = dataOder.title ?? ""
            placeBuy.text = dataOder.message ?? ""
            moneyLabel.text = "$ \(dataOder.amount ?? 0)"

            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logoImage.layer.cornerRadius = 15
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
