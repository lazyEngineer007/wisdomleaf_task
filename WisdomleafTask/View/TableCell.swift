//
//  TableCell.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 01/06/23.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var imageHeight: NSLayoutConstraint!

    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    static let identifier = "TableCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = true
        cellImage.layer.masksToBounds = true
        checkBoxBtn.layer.cornerRadius = 4
        
    }
    
    override func prepareForReuse() {
        imageHeight.constant = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
