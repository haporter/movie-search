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
    @IBOutlet var ratingImageView: UIImageView!
    
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
        //ratingTextLabel.text = "Average rating: \(movie.vote_average)"
        
        if let backdropImage = movie.backdropImage {
            backdropImageView.image = backdropImage
            
        } else {
            
            backdropImageView.image = UIImage(named: "poster_image_placeholder")
        }
        
        ratingImageView.image = starRating(movie.vote_average)
        ratingImageView.tintColor = AppearanceController.movieOrange()
        
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
    
    func starRating(rating: Float) -> UIImage? {
        
        if rating > 0.0 && rating <= 2.0 {
            // 1 Star
            print("1 Star Rating")
            return UIImage(named: "1_stars")
            
        } else if rating > 2.0 && rating <= 4.0 {
            // 2 Star
            print("2 Star Rating")
            return UIImage(named: "2_stars")
            
        } else if rating > 4.0 && rating < 6.0 {
            // 3 Star
            print("3 Star Rating")
            return UIImage(named: "3_stars")
            
        } else if rating > 6.0 && rating < 8.0 {
            // 4 Star
            print("4 Star Rating")
            return UIImage(named: "4_stars")
            
        } else if rating > 8.0 && rating <= 10.0 {
            // 5 Star
            print("5 Star Rating")
            return UIImage(named: "5_stars")
            
        } else {
            return nil
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
