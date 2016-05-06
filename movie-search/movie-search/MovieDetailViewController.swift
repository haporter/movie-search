//
//  MovieDetailViewController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var ratingTextLabel: UILabel!
    
    // MARK: - Properties
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.frame.size.height = self.view.frame.height * 0.3
        self.navigationController?.navigationBar.barTintColor = AppearanceController.movieGrey()
        self.tabBarController?.tabBar.barTintColor = UIColor.darkGrayColor()
        self.view.backgroundColor = UIColor.darkGrayColor()

        if let movie = movie {
            
            //updateViewWithMovie(movie)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    func updateViewWithMovie(movie: Movie) {
        
        overviewTextView.text = movie.overview
        ratingTextLabel.text = String(movie.vote_average)
        
        if let imageEndpoint = movie.backdrop_path {
            backdropImageView.image = MovieController.imageAtEndpoint(imageEndpoint)
            backdropImageView.alpha = 0.45
        }
    }
    
    func createAlertWithMessage(message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
    
    // MARK: - Buttons
    
    @IBAction func addToWatchlistButtonTapped() {
        
        if let movie = movie {
            
            if MovieController.isOnwatchlist(movie) {
                
                presentViewController(createAlertWithMessage("\(movie.title) was removed from your watchlist"), animated: true, completion: nil)
                MovieController.removeMovieFromWatchlist(movie)
                
            } else {
                
                presentViewController(createAlertWithMessage("\(movie.title) will be added to your watchlist."), animated: true, completion: nil)
                MovieController.addMovieToWatchList(movie)
            }
        }
    }
    

}
