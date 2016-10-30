//
//  LibraryTableViewCell.swift
//  LibraryOfCongress
//
//  Created by Eric Chang on 10/30/16.
//  Copyright © 2016 Eric Chang. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {

  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
