//
//  FichaTecnicaTableViewCell.swift
//  MariFlix
//
//  Created by Wellington on 01/06/22.
//

import UIKit

class FichaTecnicaTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func changeTitle(title: String) {
        self.title.text = title
    }
    
}

