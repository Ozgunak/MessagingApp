//
//  ContentCell.swift
//  Views
//
//  Created by ozgun on 13.01.2022.
//

import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet weak var youImage: UIImageView!
    @IBOutlet weak var contentBubble: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentBubble.layer.cornerRadius = contentBubble.frame.height / 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
