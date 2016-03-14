//
//  ViewController.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieManager.sharedManager.movieList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("movieCell") as! MovieTableViewCell
        let movie = MovieManager.sharedManager.movieList[indexPath.row]
        cell.movieTitle.text = movie.title
        cell.movieDescription.text = movie.description
        cell.imageView?.image = movie.image
        cell.imageView!.contentMode = .Center
        return cell
    }


}

