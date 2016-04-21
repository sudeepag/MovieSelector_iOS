//
//  MovieManager.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import Foundation
import UIKit

class MovieManager {
    
    static let sharedManager = MovieManager()
    
    var movieList = [Movie]()
    
    func addMovie(title: String, description: String, image: UIImage, id: String) {
        let movie = Movie()
        movie.title = title
        movie.description = description
        movie.image = image
        movie.id = id
        movieList.append(movie)
    }
    
    func rateMovie(movie: Movie, withRating rating: Int) {
        
    }
    
    
}