//
//  BrandCell.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/22/22.
//

import UIKit

class BrandCell: UICollectionViewCell {
    
    @IBOutlet weak var brandBtn: UIButton!
    var currentBrand: BrandOption?
    
    func updateViews(brand: BrandOption) {
        brandBtn.setTitle(brand.title, for: .normal)
        currentBrand = brand
    }
    
    @IBAction func brandBtnPressed() {
        DataService.instance.setSelectedBrand(brand: currentBrand ?? .Adidas)
        NotificationCenter.default.post(name: NSNotification.Name("switchBrandNotification"), object: nil)
    }
    
}
