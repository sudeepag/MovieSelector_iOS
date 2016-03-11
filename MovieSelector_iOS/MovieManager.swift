//
//  MovieManager.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import Foundation

class MovieManager {
    
    static let sharedManager = MovieManager()
    
    var movieList = [Movie]()
    
    func addMovie(title: String) {
        let movie = Movie()
        movie.title = title
        movieList.append(movie)
    }
    
    
}