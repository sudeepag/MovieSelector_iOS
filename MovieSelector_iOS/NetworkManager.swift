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
                    ref.childByAppendingPath("users").childByAppendingPath(authData.uid).observeEventType(.Value, withBlock: { (snapshot) in
                        let data = snapshot.children.allObjects[0] as! FDataSnapshot
                        let userDict = data.value
                        let email = userDict["email"] as! String
                        let password = userDict["password"] as! String
                        let major = userDict["major"] as! String
                        let uid = userDict["uid"] as! String
                        let desc = userDict["description"] as! String
                        UserManager.sharedManager.currentUser = User(email: email, password: password, desc: desc, major: major, uid: uid)
                        ref.childByAppendingPath("users").childByAppendingPath(authData.uid).removeAllObservers()
                    })
                    self.fetchMovies({ (success) -> Void in
                        completion(success: success)
                    })
                }
        })
    }
    
    func createUser(email: String, password: String, major: String, completion: (success: Bool) -> Void) {
        let ref = Firebase(url: "https://muvee.firebaseio.com")
        ref.createUser(email, password: password,
                             withValueCompletionBlock: { error, result in
                                if error != nil {
                                    // There was an error creating the account
                                    print(error)
                                } else {
                                    let uid = result["uid"] as? String
                                    let user = User(email: email, password: password, desc: "", major: major, uid: uid!)
                                    let path = ["data" : self.userDict(user)] as NSDictionary
                                    ref.childByAppendingPath("users").childByAppendingPath(uid).setValue(path)
                                    print("Successfully created user account with uid: \(uid)")
                                    self.authUser(email, password: password, completion: { (success) in
                                        completion(success: success)
                                    })
                                }
        })
    }
    
    func userDict(user: User) -> NSDictionary {
        let dict = NSMutableDictionary()
        dict.setObject(user.uid!, forKey: "uid")
        dict.setObject(user.email, forKey: "email")
        dict.setObject(user.password, forKey: "password")
        dict.setObject(user.major!, forKey: "major")
        dict.setObject(user.desc!, forKey: "description")
        dict.setObject(false, forKey: "locked")
        dict.setObject(false, forKey: "banned")
        dict.setObject(false, forKey: "admin")
        return dict
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
                        let id = movie["id"].stringValue
                        let title = movie["title"].stringValue
                        let description = movie["synopsis"].stringValue
                        let posterArray = movie["posters"]
                        let imageURL = posterArray["original"].stringValue
                        self.fetchImageForURL(imageURL, completion: { (image) -> Void in
                            MovieManager.sharedManager.addMovie(title, description: description, image: image, id: id)
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
    
    func fetchMovieRating(movie: Movie, completion: (rating: Int) -> Void) {
        let ref = Firebase(url: "https://muvee.firebaseio.com")
        ref.childByAppendingPath("movies").childByAppendingPath(movie.id).observeEventType(.Value, withBlock: { (snapshot) in
            let list = snapshot.children.allObjects
            if (!list.isEmpty) {
                let data = snapshot.children.allObjects[0] as! FDataSnapshot
                let ratingDict = data.value as! NSDictionary
                let major = UserManager.sharedManager.currentUser.major!
                ref.childByAppendingPath("movies").childByAppendingPath(movie.id).removeAllObservers()
                completion(rating: ratingDict["average"]![major] as! Int)
            }
        })
        
    }
    
    func updateMovieRating(movie: Movie, rating: Int) {
        print("called")
        let ref = Firebase(url: "https://muvee.firebaseio.com")
        ref.childByAppendingPath("movies").childByAppendingPath(movie.id).observeEventType(.Value, withBlock: { (snapshot) in
            let list = snapshot.children.allObjects
            if (list.isEmpty) {
                let path = ["data" : self.newRatingDict(movie, rating: rating)] as NSDictionary
                ref.childByAppendingPath("movies").childByAppendingPath(movie.id).setValue(path)
                ref.childByAppendingPath("movies").childByAppendingPath(movie.id).removeAllObservers()
            } else {
                let data = snapshot.children.allObjects[0] as! FDataSnapshot
                let ratingDict = data.value as! NSDictionary
                print(ratingDict)
                let path = ["data" : self.updatedRatingDict(ratingDict, movie: movie, rating: rating)] as NSDictionary
                ref.childByAppendingPath("movies").childByAppendingPath(movie.id).setValue(path)
                ref.childByAppendingPath("movies").childByAppendingPath(movie.id).removeAllObservers()
            }
            
            
        })
    }
    
    func newRatingDict(movie: Movie, rating: Int) -> NSDictionary {
        let dict = NSMutableDictionary()
        let major = UserManager.sharedManager.currentUser.major!
        let averageDict: [String:Int] = [major:rating]
        dict.setObject(averageDict, forKey: "average")
        let numRatingDict: [String:Int] = [major:1]
        dict.setObject(numRatingDict, forKey: "numRating")
        let sumDict: [String:Int] = [major:rating]
        dict.setObject(sumDict, forKey: "sum")
        dict.setObject(movie.title, forKey: "title")
        dict.setObject(movie.id, forKey: "uid")
        dict.setObject("", forKey: "review")
        return dict
    }
    
    func updatedRatingDict(dict: NSDictionary, movie: Movie, rating: Int) -> NSDictionary {
        let updatedDict = NSMutableDictionary()
        let major = UserManager.sharedManager.currentUser.major!
        let currSum = dict["sum"]![major] as! Int
        let currNum = dict["numRating"]![major] as! Int
        let numRatingDict: [String:Int] = [major:(currNum + 1)]
        updatedDict.setObject(numRatingDict, forKey: "numRating")
        let sumDict: [String:Int] = [major:(currSum + rating)]
        let averageDict: [String:Int] = [major:((currSum + rating) / (currNum + 1))]
        updatedDict.setObject(averageDict, forKey: "average")
        updatedDict.setObject(sumDict, forKey: "sum")
        updatedDict.setObject(movie.title, forKey: "title")
        updatedDict.setObject(movie.id, forKey: "uid")
        updatedDict.setObject("", forKey: "review")
        return updatedDict
    }
    
}