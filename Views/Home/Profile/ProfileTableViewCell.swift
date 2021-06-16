//
//  ProfileTableViewCell.swift
//  SampleApp
//
//  Created by Ishipo on 07/06/2021.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var discriptionLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
