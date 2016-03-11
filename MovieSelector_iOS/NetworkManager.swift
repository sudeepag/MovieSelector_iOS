//
//  NetworkManager.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
import SwiftyJSON

class NetworkManager {
    
    static let sharedManager = NetworkManager()
    
    func authUser(email: String, password: String, completion: (success: Bool) -> Void) {
        let ref = Firebase(url: "https://muvee.firebaseio.com")
        ref.authUser(email, password: password,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                    print("login failed")
                    completion(success: false)
                } else {
                    // We are now logged in
                    print("login successful")
                    completion(success: true)
                }
        })
    }
    
    func fetchMovies() {
        Alamofire.request(.GET, kRottenTomatoesAPI)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let json = response.result.value {
                    let data = JSON(response.result.value!)
                    let movies = data["movies"].arrayValue
                    for movie in movies {
                        MovieManager.sharedManager.addMovie(movie["title"].stringValue)
                    }
                }
        }
    }
    
}