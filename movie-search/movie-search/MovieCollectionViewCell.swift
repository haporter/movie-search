//
//  MovieCollectionViewCell.swift
//  movie-search
//
//  Created by Andrew Porter on 5/5/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                
                movieTitleLabel.text = movie.title
                
                if let posterEndpoint = movie.posterPath, image = MovieController.imageAtEndpoint(posterEndpoint) {
                    
                    moviePoster.image = image
                } else {
                    moviePoster.image = UIImage(named: "poster_image_placeholder")
                }
                
            }
        }
    }
}
