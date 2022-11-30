//
//  SegmentedControlTableViewCell.swift
//  MariFlix
//
//  Created by Wellington on 01/06/22.
//

import UIKit

// Criação do delegate
protocol SegmentedManagerDelegate: AnyObject {
    func didClickSegmentedControl(click: Int) //funcao para fazer a chamada da requisicao
}

class SegmentedControlTableViewCell: UITableViewCell {

    // variável do delegate
    weak var delegate: SegmentedManagerDelegate?
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.segmentedControl.backgroundColor = UIColor.black
//        self.segmentedControl.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func segmentedControl(_ sender: Any) {
        segmentedControl.backgroundColor = .white
        
        let index = segmentedControl.selectedSegmentIndex
        self.delegate?.didClickSegmentedControl(click: index)
    }
    
}
