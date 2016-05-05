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

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        return cell
    }
    
    // MARK: - SearchBar Delegate methods
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            
            MovieController.searchMoviesWithTitle(text) { (success) in
                if success {
                    
                    self.movieSearchResults = MovieController.sharedController.searchedMovies
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                        
                    })
                } else {
                    
                    print("failed to search movies with search text")
                }
            }
        }
        searchBar.resignFirstResponder()
    }

}
