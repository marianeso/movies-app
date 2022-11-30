//
//  ReviewCollectionViewCell.swift
//  MariFlix
//
//  Created by Wellington on 18/07/22.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reviewDescription: UILabel!
    
    @IBOutlet weak var backgroudView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup_Review(reviewUser: String) {
       
        self.backgroudView.layer.cornerRadius = 10
        self.backgroudView.backgroundColor = .black
        self.reviewDescription.textColor = .white

        
      self.reviewDescription.text = reviewUser
    }

}
