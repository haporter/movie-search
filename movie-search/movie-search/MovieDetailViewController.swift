//
//  MovieDetailViewController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var ratingTextLabel: UILabel!
    
    // MARK: - Properties
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            
            updateViewWithMovie(movie)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    func updateViewWithMovie(movie: Movie) {
        
        self.navigationItem.title = movie.title
        overviewTextView.text = movie.overview
        ratingTextLabel.text = String(movie.rating)
        
        if let imageEndpoint = movie.backDropPath {
            backdropImageView.image = MovieController.imageAtEndpoint(imageEndpoint)
        }
    }
    
    // MARK: - Buttons
    
    @IBAction func addToWatchlistButtonTapped() {
        
        if let movie = movie {
            
            MovieController.addMovieToWatchList(movie)
        }
    }
    

}
