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
    @IBOutlet fileprivate var movieSearchBar: UISearchBar!
    
    var movieSearchResults: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = AppearanceController.movieGrey()
        self.tabBarController?.tabBar.barTintColor = UIColor.darkGray
        self.view.backgroundColor = UIColor.darkGray
        self.navigationItem.title = "Movie Search"
        self.navigationController?.navigationBar.tintColor = UIColor.white


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Data Source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSearchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            
            MovieController.searchMoviesWithTitle(text) { (success) in
                if success {
                    
                    self.movieSearchResults = MovieController.sharedController.searchedMovies
                    
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                        
                    })
                } else {
                    
                    print("failed to search movies with search text")
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    // TODO: - searchBar resignFirstResponder when 
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            movieSearchResults = []
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToDetail" {
            if let destinationViewController = segue.destination as? MovieDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                
                let movie = movieSearchResults[indexPath.row]
                
                destinationViewController.movie = movie
                
            }
        }
    }

}
