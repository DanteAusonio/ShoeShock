//
//  ThankYouVC.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/28/22.
//

import UIKit

class ThankYouVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    
    @IBOutlet weak var PurchasedShoesCV: UICollectionView!
    
    var purchasedShoes: [Shoe]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PurchasedShoesCV.dataSource = self
        PurchasedShoesCV.delegate = self
        if let PurchasedShoeLayout = PurchasedShoesCV.collectionViewLayout as? UICollectionViewFlowLayout {
            PurchasedShoeLayout.scrollDirection = .horizontal
        }
    }
        
 
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return purchasedShoes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = PurchasedShoesCV.dequeueReusableCell(withReuseIdentifier: ThankYouCell.thankYouCellIdentifier, for: indexPath) as? ThankYouCell {
            let shoe: Shoe = purchasedShoes[indexPath.row]
            cell.updateViews(shoe: shoe)
            return cell
        }
        return ThankYouCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 224)
    }

}
