//
//  DiscoverMovieCollectionViewController.swift
//  movie-search
//
//  Created by Andrew Porter on 5/4/16.
//  Copyright © 2016 Andrew Porter. All rights reserved.
//

import UIKit

class DiscoverMovieCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Now Playing"

        MovieController.nowPlayingMovies { (success) in
            if success {
                //print(MovieController.sharedController.nowPlayingMovies.first!.title)
                //print(MovieController.sharedController.nowPlayingMovies.first!.overview)
                
                dispatch_async(dispatch_get_main_queue(), { 
                    self.collectionView?.reloadData()
                })
            } else {
                print("The test failed")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - CollectionView Data Source
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieController.sharedController.nowPlayingMovies.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath) as? MovieCollectionViewCell {
            let movie = MovieController.sharedController.nowPlayingMovies[indexPath.row]
            
            cell.movie = movie
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movieCell", forIndexPath: indexPath)
            
            return cell
        }
        
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "discoverToDetail" {
            if let destinationViewController = segue.destinationViewController as? MovieDetailViewController, indexPaths = collectionView?.indexPathsForSelectedItems(), selectedIndexPath = indexPaths.first {
                
                let movie = MovieController.sharedController.nowPlayingMovies[selectedIndexPath.item]
                
                destinationViewController.movie = movie
            }
        }
    }

}
