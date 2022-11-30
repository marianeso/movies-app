//
//  FIlmTableViewCell.swift
//  MariFlix
//
//  Created by Wellington on 08/06/22.
//

import UIKit
import SDWebImage

// Criação do delegate
protocol FIlmTableViewCellDelegate: AnyObject {
    func didClickFavoriteButton(movieID: Int, isFavorite:Bool) //funcao para fazer a chamada da requisicao
}

class FIlmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var nameFilm: UILabel!
    @IBOutlet weak var yearFIlm: UILabel!
    @IBOutlet weak var rateFilme: UILabel!
    @IBOutlet weak var favoriteFilm: UIImageView!
    
    // variável do delegate
    weak var delegate: FIlmTableViewCellDelegate?
    
    var isFavorite: Bool = false
    
    var movieID: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupTapGesture()
        
        //reduzir transparencia
       
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    func setup(movieID: Int, image: String, nameFilm: String, yearFIlm: String, rateFilme: Double, isFavorite: Bool) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + image)
        filmImage.sd_setImage(with: url)
        
        self.nameFilm.text = nameFilm
        self.yearFIlm.text = yearFIlm
        self.rateFilme.text = String(rateFilme)
        self.movieID = movieID
        
        self.isFavorite = isFavorite
        self.setupFavoriteImageView()
    }
    
    // MARK: - Controle do estado do botão favoritar
    
    func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        favoriteFilm.addGestureRecognizer(tap)
        favoriteFilm.isUserInteractionEnabled = true
    }
    

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        isFavorite = !isFavorite
        self.setupFavoriteImageView()
        //avisar para a classe que esta esperando o dado que ele chegou
        self.delegate?.didClickFavoriteButton(movieID: self.movieID, isFavorite: self.isFavorite)
    }
    
    func setupFavoriteImageView() {

        if isFavorite == false {
            favoriteFilm.image = UIImage(systemName: "star")
        } else {
            favoriteFilm.image = UIImage(systemName: "star.fill")
        }
    }
    
    
}
