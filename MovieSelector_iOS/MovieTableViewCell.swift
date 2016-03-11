//
//  MovieTableViewCell.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/11/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
