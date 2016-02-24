//
//  ResultsViewController.swift
//  MovieDBSearchMiniLesson
//
//  Created by Jordan Nelson on 2/24/16.
//  Copyright © 2016 Jordan Nelson. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var filteredMovies:[Movie] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension ResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("resultsCell", forIndexPath: indexPath) as! MovieCollectionViewCell
        
        let movie = filteredMovies[indexPath.item]
        cell.titleLabel.text = movie.title
        cell.summary.text = movie.summary
        cell.ratingLabel.text = "\(movie.rating)"
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/2 - 1, height: self.view.frame.size.height/3 - 1)
    }
    
}
