//
//  DescriptionTableViewCell.swift
//  MariFlix
//
//  Created by Wellington on 01/06/22.
//

import UIKit

// Criação do delegate
protocol DescriptionTableViewCellDelegate: AnyObject {
    func didClickAddButton(movieID: Int, isSelect:Bool) //funcao para fazer a chamada da requisicao
}

class DescriptionTableViewCell: UITableViewCell {
    

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    // variável do delegate
    weak var delegate: DescriptionTableViewCellDelegate?
    
    var isSelect: Bool = false
    var movieID: Int = 0


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup_Details(image: String, nameFilm: String, voute: Double, details: String, movieID: Int, isSelect: Bool) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + image)
        backgroundImage.sd_setImage(with: url)
        
        self.name.text = nameFilm
        self.type.text = "Star: " + String(format: "%.1f",voute)
        self.details.text = details
        self.movieID = movieID
        
        self.isSelect = isSelect
        self.setupButton()
    }
    
    
    @IBAction func didSelect(_ sender: Any) {
        isSelect = !isSelect
//        //avisar para a classe que esta esperando o dado que ele chegou
        self.delegate?.didClickAddButton(movieID: self.movieID, isSelect: self.isSelect)
        self.setupButton()
    }
    

    func setupButton() {
        if self.isSelect == true {
            self.addButton.setTitle("Adicionado", for: .normal)
        } else {
            self.addButton.setTitle("Adicionar", for: .normal)
        }
    }
}
