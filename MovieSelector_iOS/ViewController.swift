//
//  ViewController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet var tableView: UITableView!
    var selectedMovie: Movie!
    var filteredMovies: [Movie]!
    var searchController: UISearchController!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredMovies = [Movie]()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(rgba: "#009688")
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        //searchController.searchBar.barTintColor = UIColor(rgba: "#009688")
        searchController.searchBar.tintColor = UIColor(rgba: "#009688")
        tableView.tableHeaderView = searchController.searchBar
    }
    
    @IBAction func menuButtonSelected(sender: AnyObject) {
        let controller = navigationController as! NavigationController
        controller.showMenu() 
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.definesPresentationContext = true
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredMovies = MovieManager.sharedManager.movieList.filter { movie in
            return movie.title.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredMovies.count
        }
        return MovieManager.sharedManager.movieList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("movieCell") as! MovieTableViewCell
        let movie: Movie
        if searchController.active && searchController.searchBar.text != "" {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = MovieManager.sharedManager.movieList[indexPath.row]
        }
        cell.backgroundColor = UIColor.whiteColor()
        cell.movieTitle.text = movie.title
        cell.movieDescription.text = movie.description
        cell.imageView?.image = movie.image
        cell.imageView!.contentMode = .Center
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedMovie = MovieManager.sharedManager.movieList[indexPath.row]
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "pushMovie") {
            let dvc = segue.destinationViewController as! MovieDetailViewController
            dvc.movie = selectedMovie
        }
        
    }


}

