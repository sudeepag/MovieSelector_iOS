//
//  MovieDetailViewController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/14/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movieDescriptionLabel: UILabel!
    
    var movie: Movie!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = true
        print(movie.title)
        titleLabel.text = movie.title
        
        posterImageView.image = movie.image
        movieDescriptionLabel.text = movie.description
    }

    @IBAction func backButtonSelected(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
