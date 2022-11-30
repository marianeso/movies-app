//
//  SimilarMovieTableViewCell.swift
//  MariFlix
//
//  Created by Wellington on 20/09/22.
//

import UIKit

protocol SimilarMovieTableViewCellDelegate: AnyObject {
    func didClickFilm(selectedMovie: SimilarMovie)
}

class SimilarMovieTableViewCell: UITableViewCell {
   
    @IBOutlet weak var similarMoviesCollection: UICollectionView!
    
    weak var delegate: SimilarMovieTableViewCellDelegate?
    
    var movieID: String = ""
    var similarMovies: [SimilarMovie] = []  // criando uma variavel do tipo Movie
    let similarMovieManager = SimilarMovieManager ()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.similarMoviesCollection.dataSource = self
        self.similarMoviesCollection.delegate = self
        
        similarMoviesCollection.registerNib(SimilarMovieCollectionViewCell.self)
    }
    
    func setup(movieID: String) {
        self.movieID = movieID
        
        self.similarMovieManager.fetchSimilarMovieWithCompletion(movieID: self.movieID) { similar in
            
            DispatchQueue.main.async {
                self.similarMovies = similar ?? []
        
                self.similarMoviesCollection.reloadData()
            }
        }
    }
}
    
extension SimilarMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMovieCollectionViewCell", for: indexPath) as? SimilarMovieCollectionViewCell else  {
            return UICollectionViewCell()
        }
        

        let movie = self.similarMovies[indexPath.row]
        
        cell.setup_SimilarMovie(movieImage: movie.posterPath ?? "" , movieTitle: movie.originalTitle ?? "", overviewMovie: movie.overview ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didClickFilm(selectedMovie: similarMovies[indexPath.row])
    }
}

extension SimilarMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 200)
    }
}



    
