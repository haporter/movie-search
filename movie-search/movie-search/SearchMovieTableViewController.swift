//
//  SearchMovieTableViewController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class SearchMovieTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    @IBOutlet private var movieSearchBar: UISearchBar!
    
    var movieSearchResults: [Movie] = []
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = AppearanceController.movieGrey()
        self.tabBarController?.tabBar.barTintColor = UIColor.darkGrayColor()
        self.view.backgroundColor = UIColor.darkGrayColor()
        self.navigationItem.title = "Movie Search"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        // Activity Indicator
        self.view.addSubview(activityIndicator)
        activityIndicator.center.x = self.view.center.x
        activityIndicator.center.y = self.view.center.y - 110
        activityIndicator.hidesWhenStopped = true


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Data Source methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSearchResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath)
        
        let movie = movieSearchResults[indexPath.row]
        
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.overview
        
        if let posterImage = movie.posterImage {
            cell.imageView?.image = posterImage
        }
        
//        if let posterEndpoint = movie.poster_path {
//            cell.imageView?.image = MovieController.imageAtEndpoint(posterEndpoint)
//        }
        
        return cell
    }
    
    // MARK: - SearchBar Delegate methods
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        activityIndicator.startAnimating()
        
        if let text = searchBar.text {
            
            MovieController.searchMoviesWithTitle(text) { (success) in
                if success {
                    
                    self.movieSearchResults = MovieController.sharedController.searchedMovies
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                        self.activityIndicator.stopAnimating()
                        
                    })
                } else {
                    
                    print("failed to search movies with search text")
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    // TODO: - searchBar resignFirstResponder when 
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            movieSearchResults = []
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "searchToDetail" {
            if let destinationViewController = segue.destinationViewController as? MovieDetailViewController, indexPath = tableView.indexPathForSelectedRow {
                
                let movie = movieSearchResults[indexPath.row]
                
                destinationViewController.movie = movie
                
            }
        }
    }

}
