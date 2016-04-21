//
//  MovieDetailViewController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/14/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit
import Cosmos
import SAConfettiView

class MovieDetailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movieDescriptionLabel: UILabel!
    
    var confettiView: SAConfettiView!
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
        
        ratingView.didFinishTouchingCosmos = didFinishTouchingCosmos
        
        NetworkManager.sharedManager.fetchMovieRating(movie) { (rating) in
            self.ratingView.rating = Double(rating)
        }
        
        confettiView = SAConfettiView(frame: self.view.bounds)
        confettiView.intensity = 0.75
        confettiView.userInteractionEnabled = false
        self.view.addSubview(confettiView)
    }

    @IBAction func backButtonSelected(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func didFinishTouchingCosmos(rating: Double) {
        confettiView.startConfetti()
        NetworkManager.sharedManager.updateMovieRating(movie, rating: Int(rating)) { (success) in
            if (success) {
                self.confettiView.stopConfetti()
            }
        }
    }
}
