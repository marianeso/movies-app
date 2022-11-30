//
//  SimilarMovieCollectionViewCell.swift
//  MariFlix
//
//  Created by Wellington on 20/09/22.
//

import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
 
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup_SimilarMovie(movieImage: String, movieTitle: String, overviewMovie: String) {
       
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + movieImage)
        self.movieImage.sd_setImage(with: url) { perfilImage, errorTest, type, urlRequest in
            if errorTest != nil {
                self.backgroundColor = .black
            } else {
                self.movieImage.image = perfilImage
            }
        }
    }

}
