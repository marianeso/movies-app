//
//  ReviewsTableViewCell.swift
//  MariFlix
//
//  Created by Wellington Bezerra on 6/30/22.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewsCollection: UICollectionView!
    
    var movieID: String = ""
    var reviewsMovies: [Reviews] = []  // criando uma variavel do tipo Movie
    let reviewsManager = ReviewsManager ()  // colocando a classe dentro da variavel
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.reviewsCollection.dataSource = self
        self.reviewsCollection.delegate = self
        
        reviewsCollection.registerNib(ReviewCollectionViewCell.self)
    }
    
    func setup(movieID: String) {
        self.movieID = movieID
        
        self.reviewsManager.fetchReviewsMovieWithCompletion(movieID: self.movieID) { review in
            
            DispatchQueue.main.async {
                self.reviewsMovies = review ?? []
                self.reviewsBackgroundSetup()
                self.reviewsCollection.reloadData()
            }
        }
    }
}

extension ReviewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewsMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as? ReviewCollectionViewCell else  {
            return UICollectionViewCell()
        }

        let review = self.reviewsMovies[indexPath.row]
        cell.setup_Review(reviewUser: review.content ?? "" )

        
        return cell
    }
}

extension ReviewsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension ReviewsTableViewCell {
    func reviewsBackgroundSetup () {
        if self.reviewsMovies.count == 0 {
            
            let reviewsBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.reviewsCollection.frame.width, height: self.reviewsCollection.frame.height))
            reviewsBackground.backgroundColor = .black
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: self.reviewsCollection.frame.width/2, y: self.reviewsCollection.frame.height/2)
            label.textColor = .white
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 20)
            label.text = "No reviews"
            reviewsBackground.addSubview(label)
            
            self.reviewsCollection.backgroundView = reviewsBackground
        } else {
            self.reviewsCollection.backgroundView = nil
        }
    }
}
