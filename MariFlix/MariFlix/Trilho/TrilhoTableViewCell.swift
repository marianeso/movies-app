//
//  TrilhoTableViewCell.swift
//  MariFlix
//
//  Created by Wellington Bezerra on 7/29/22.
//

import UIKit

class TrilhoTableViewCell: UITableViewCell {

    @IBOutlet weak var TrilhoCollectionView: UICollectionView!
    
    private var items: [Movie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.TrilhoCollectionView.dataSource = self
        self.TrilhoCollectionView.delegate = self
        
        TrilhoCollectionView.registerNib(FilmsCollectionViewCell.self)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(items: [Movie]) {
        self.items = items
        
        self.TrilhoCollectionView.reloadData()
    }
}

extension TrilhoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmsCollectionViewCell", for: indexPath) as? FilmsCollectionViewCell else  {
            return UICollectionViewCell()
        }
        
        
        
        return cell
    }
}

extension TrilhoTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 300)
    }
}
