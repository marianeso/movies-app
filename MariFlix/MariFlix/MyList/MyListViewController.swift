//
//  MyListViewController.swift
//  MariFlix
//
//  Created by Wellington on 01/06/22.
//

import UIKit

class MyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    private let movieStorage = MovieStorage()
    private var movies: [LocalMovie] = []
    
    @IBOutlet weak var favoriteTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoriteTable.dataSource = self
        self.favoriteTable.delegate = self

        
        let nib = UINib(nibName: "FIlmTableViewCell", bundle: nil)
        self.favoriteTable.register(nib, forCellReuseIdentifier:"FIlmTableViewCell")
        
        self.navigationItem.title = "Favorite Movies"
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let moviesDict = self.movieStorage.getMovies() ?? [:]
        let moviesNotOrdered = moviesDict.compactMap({ $0.value })
        self.movies = moviesNotOrdered.sorted(by: { $0.originalTitle < $1.originalTitle })
       
        if self.movies.count == 0 {
            
            let favoriteBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.favoriteTable.frame.width, height: self.favoriteTable.frame.height))
            favoriteBackground.backgroundColor = .black
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: self.favoriteTable.frame.width/2, y: self.favoriteTable.frame.height/2)
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 15)
            label.textAlignment = .center
            label.text = "NO FAVORITE MOVIES"
            favoriteBackground.addSubview(label)
            
            self.favoriteTable.backgroundView = favoriteBackground
        } else {
            self.favoriteTable.backgroundView = nil
        }
        
        self.favoriteTable.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FIlmTableViewCell", for: indexPath) as? FIlmTableViewCell else {
            return UITableViewCell()
        }
        
        //escuta o clique que tiver na celula
        cell.delegate = self
        
        let movie = self.movies[indexPath.row]
        
        //acesso ao banco para saber se o drink.id está favoritado ou nao
        let storageMovie = self.movieStorage.getMovie(movieID: movie.movieID)
        let isFavorite = storageMovie != nil ? true : false
        
        cell.setup(movieID: movie.movieID,
                   image: movie.backdrop_path,
                   nameFilm: movie.originalTitle,
                   yearFIlm: movie.releaseDate,
                   rateFilme: movie.voteAverage,
                   isFavorite: isFavorite)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]

        let detailsView = DetailsViewController()
        detailsView.movie = Movie(id: movie.movieID,
                                  originalTitle: movie.originalTitle,
                                  overview: movie.overview,
                                  backdrop_path: movie.backdrop_path,
                                  title: movie.originalTitle,
                                  voteAverage: movie.voteAverage,
                                  releaseDate: movie.releaseDate)
        
       // self.present(detailsView, animated: true)
        self.navigationController?.pushViewController(detailsView, animated: true)
        self.navigationController?.navigationBar.tintColor = .white

    }
}

// MARK: - FIlmTableViewCellDelegate

extension MyListViewController: FIlmTableViewCellDelegate {
    
    func didClickFavoriteButton(movieID: Int, isFavorite: Bool) {
        
        // pega no array o move que foi clicado
        guard let selectMovie = self.movies.filter({ $0.movieID ==  movieID }).first else { return }
        
        if isFavorite == true {
            self.movieStorage.save(movieID: movieID, movie: selectMovie)
        } else {
            self.movieStorage.delete(movieID: movieID)
        }
        
        let moviesDict = self.movieStorage.getMovies() ?? [:]
        let moviesNotOrdered = moviesDict.compactMap({ $0.value }) //pega o valor do item no dicionario
        self.movies = moviesNotOrdered.sorted(by: { $0.originalTitle < $1.originalTitle })
        
        if self.movies.count == 0 {
            
            let favoriteBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.favoriteTable.frame.width, height: self.favoriteTable.frame.height))
            favoriteBackground.backgroundColor = .darkGray
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: self.favoriteTable.frame.width/2, y: self.favoriteTable.frame.height/2)
            label.textColor = .white
            label.textAlignment = .center
            label.text = "No favorite movies"
            favoriteBackground.addSubview(label)
            
            self.favoriteTable.backgroundView = favoriteBackground
        } else {
            self.favoriteTable.backgroundView = nil
        }
        self.favoriteTable.reloadData()
    }
}



