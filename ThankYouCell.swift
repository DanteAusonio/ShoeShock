//
//  ThankYouCell.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/28/22.
//

import UIKit

class ThankYouCell: UICollectionViewCell {
 
    static let thankYouCellIdentifier = "ThankYouCell"
    
    @IBOutlet weak var shoeImage: UIImageView!
    
    func updateViews(shoe: Shoe) {
        shoeImage.image = UIImage(named: shoe.imgName)
    }
    
}
