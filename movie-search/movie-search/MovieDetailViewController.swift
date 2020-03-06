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
        self.tabBarController?.tabBar.barTintColor = UIColor.darkGray
        self.view.backgroundColor = UIColor.darkGray

        if let movie = movie {
            
            updateViewWithMovie(movie)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.movie = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    func updateViewWithMovie(_ movie: Movie) {
        
        changeBarButtonTitle()
        overviewTextView.text = movie.overview
        titleLabel.text = movie.title
        ratingTextLabel.text = "Average rating: \(movie.vote_average)"
        
        if let backdropImage = movie.backdropImage {
            backdropImageView.image = backdropImage
            
        } else {
            
            backdropImageView.image = UIImage(named: "poster_image_placeholder")
        }
        
//        if let imageEndpoint = movie.backdrop_path {
//            backdropImageView.image = MovieController.imageAtEndpoint(imageEndpoint)
//            
//        } else {
//            
//            backdropImageView.image = UIImage(named: "poster_image_placeholder")
//        }
        
    }
    
    func createAlertWithMessage(_ message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        return alert
    }
    
    func changeBarButtonTitle() {
        
        if let movie = movie {
            
            if MovieController.isOnwatchlist(movie) {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Remove From Watchlist", style: .done, target: self, action: #selector(MovieDetailViewController.watchlistButtonTapped))
                
            } else {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add To Watchlist", style: .done, target: self, action: #selector(MovieDetailViewController.watchlistButtonTapped))
            }
        }
    }
    
    // MARK: - Buttons
    
    @IBAction func watchlistButtonTapped() {
        
        if let movie = movie {
            
            if MovieController.isOnwatchlist(movie) {
                
                present(createAlertWithMessage("\(movie.title) was removed from your watchlist"), animated: true, completion: nil)
                MovieController.removeMovieFromWatchlist(movie)
                changeBarButtonTitle()
                
            } else {
                
                present(createAlertWithMessage("\(movie.title) will be added to your watchlist."), animated: true, completion: nil)
                MovieController.addMovieToWatchList(movie)
                changeBarButtonTitle()
            }
        }
    }
    

}
