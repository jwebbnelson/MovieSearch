//
//  HomeViewController.swift
//  MovieDBSearchMiniLesson
//
//  Created by Jordan Nelson on 2/24/16.
//  Copyright © 2016 Jordan Nelson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    var results: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setUpSearchController()
        MovieController.searchForPopularMovies { (movieArray) -> Void in
            if let movies = movieArray {
                self.results = movies
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieTableCell", forIndexPath: indexPath)
        if let movies = results {
            let movie = movies[indexPath.row]
            cell.textLabel?.text = movie.title
            cell.detailTextLabel?.text = movie.summary
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
}

extension HomeViewController: UISearchResultsUpdating {
    
    
    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("resultsViewController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search movie titles"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let lowercaseSearchTerm = searchController.searchBar.text!.lowercaseString
        
        MovieController.searchForMovies(lowercaseSearchTerm) { (movies) -> Void in
            if let movies = movies {
                
                if let resultsController = searchController.searchResultsController as? ResultsViewController {
        
                    resultsController.filteredMovies = movies
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        resultsController.collectionView.reloadData()
                    })
                }
            }
        }
    }
    
}

