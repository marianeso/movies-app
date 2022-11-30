//
//  DetailsReviewTableViewCell.swift
//  MariFlix
//
//  Created by Wellington on 04/07/22.
//

import UIKit

class DetailsReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var reviewUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    func setup_Review(userImage: String, nameUser: String, rating: Int, reviewUser: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + userImage)
        
        self.userImage.sd_setImage(with: url)
        
        //Layout da imagem
        self.userImage.layer.cornerRadius = self.userImage.frame.width / 2
        self.userImage.layer.borderWidth = 1.0
        self.userImage.layer.borderColor = UIColor.black.cgColor
        
        self.nameUser.text = nameUser
        self.nameUser.text = nameUser + String(rating)
        self.reviewUser.text = reviewUser
    
    }
    
}
