//
//  MovieDetailViewController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewTextView: UITextView!
    @IBOutlet var ratingTextLabel: UILabel!
    
    // MARK: - Properties
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = AppearanceController.movieGrey()
        self.tabBarController?.tabBar.barTintColor = UIColor.darkGrayColor()
        self.view.backgroundColor = UIColor.darkGrayColor()

        if let movie = movie {
            
            updateViewWithMovie(movie)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.movie = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    func updateViewWithMovie(movie: Movie) {
        
        changeBarButtonTitle()
        overviewTextView.text = movie.overview
        titleLabel.text = movie.title
        ratingTextLabel.text = "Average rating: \(movie.vote_average)"
        
        if let imageEndpoint = movie.backdrop_path {
            backdropImageView.image = MovieController.imageAtEndpoint(imageEndpoint)
            
        } else {
            
            backdropImageView.image = UIImage(named: "poster_image_placeholder")
        }
        
    }
    
    func createAlertWithMessage(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
    
    func changeBarButtonTitle() {
        
        if let movie = movie {
            
            if MovieController.isOnwatchlist(movie) {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remove From Watchlist", style: .Done, target: self, action: #selector(MovieDetailViewController.watchlistButtonTapped))
                
            } else {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add To Watchlist", style: .Done, target: self, action: #selector(MovieDetailViewController.watchlistButtonTapped))
            }
        }
    }
    
    // MARK: - Buttons
    
    @IBAction func watchlistButtonTapped() {
        
        if let movie = movie {
            
            if MovieController.isOnwatchlist(movie) {
                
                presentViewController(createAlertWithMessage("\(movie.title) was removed from your watchlist"), animated: true, completion: nil)
                MovieController.removeMovieFromWatchlist(movie)
                changeBarButtonTitle()
                
            } else {
                
                presentViewController(createAlertWithMessage("\(movie.title) will be added to your watchlist."), animated: true, completion: nil)
                MovieController.addMovieToWatchList(movie)
                changeBarButtonTitle()
            }
        }
    }
    

}
