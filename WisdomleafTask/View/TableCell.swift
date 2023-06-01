//
//  TableCell.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 01/06/23.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var imageHeight: NSLayoutConstraint!

    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
