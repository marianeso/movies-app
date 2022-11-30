//
//  Segmented.swift
//  MariFlix
//
//  Created by Wellington on 04/06/22.
//

import UIKit

class Segmented: UISegmentedControl {

    Segmented.backgroundColor = UIColor.black
    Segmented.layer.borderColor = UIColor.white.cgColor
    Segmented.selectedSegmentTintColor = UIColor.white
    Segmented.layer.borderWidth = 1
    
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    Segmented.setTitleTextAttributes(titleTextAttributes, for:.normal)

         let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
    Segmented.setTitleTextAttributes(titleTextAttributes1, for:.selected)

}
