//
//  TrilhoFilmsViewController.swift
//  MariFlix
//
//  Created by Wellington Bezerra on 7/29/22.
//

import UIKit

class TrilhoFilmsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var TrilhoTable: UITableView!
    
    private let topMoviesManager = TopMovieManager()
    private let popularMoviesManager = PopularMovieManager()
    
    private var topMovies: [Movie] = []
    private var popularMovies: [Movie] = []

    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TrilhoTable.dataSource = self
        self.TrilhoTable.delegate = self

        self.TrilhoTable.registerNib(TrilhoTableViewCell.self)
        
        self.dispatchGroup.enter()
        self.topMoviesManager.fetchTopMovieWithCompletion { movies in
            self.topMovies = movies ?? []
            
            self.dispatchGroup.leave()
        }
        
        self.dispatchGroup.enter()
        self.popularMoviesManager.fetchPopularMovieWithCompletion { movies in
            self.popularMovies = movies ?? []
            
            self.dispatchGroup.leave()
        }
        
        self.dispatchGroup.notify(queue: .main) {
            self.TrilhoTable.reloadData()
        }
        
        //self.dispatchGroup.leave()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrilhoTableViewCell") as? TrilhoTableViewCell else {
            return UITableViewCell()
        }
       
        cell.setup(items: self.topMovies)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

