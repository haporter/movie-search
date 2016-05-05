//
//  MovieCollectionViewCell.swift
//  movie-search
//
//  Created by Andrew Porter on 5/5/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
 
    //@IBOutlet var moviePoster: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                let title = movie.title
                
                movieTitleLabel.text = title
            }
        }
    }
}
