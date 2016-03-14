//
//  NetworkManager.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
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
                    self.fetchMovies({ (success) -> Void in
                        completion(success: success)
                    })
                }
        })
    }
    
    func fetchMovies(completion: (success: Bool) -> Void) {
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
                        let title = movie["title"].stringValue
                        let description = movie["synopsis"].stringValue
                        let posterArray = movie["posters"]
                        let imageURL = posterArray["original"].stringValue
                        self.fetchImageForURL(imageURL, completion: { (image) -> Void in
                            MovieManager.sharedManager.addMovie(title, description: description, image: image)
                            if (MovieManager.sharedManager.movieList.count == movies.count) {
                                completion(success: true)
                            }
                        })
                    }
                }
        }
    }
    
    func fetchImageForURL(urlString: String, completion: (image: UIImage) -> Void) {
        Alamofire.request(.GET, urlString)
            .responseImage { response in
                //print(response.request)
                //print(response.response)
                //debugPrint(response.result)
                if let image = response.result.value {
                    let scaledImage = self.scaleUIImageToSize(image, size: CGSize(width: image.size.width * 3.0, height: image.size.height * 3.0))
                    completion(image: scaledImage)
                }
        }
    }
    
    func scaleUIImageToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
}