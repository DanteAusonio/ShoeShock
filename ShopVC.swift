//
//  ShopVC.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/22/22.
//

import UIKit

class ShopVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var ShoeCollection: UICollectionView!
    @IBOutlet weak var BrandCollection: UICollectionView!
    
    var selectedBrand = DataService.instance.getShoes(forBrand: DataService.instance.getSelectedBrand())
    
    
    override func viewWillAppear(_ animated: Bool) {
        ShoeCollection.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Brand Btn Notification
        NotificationCenter.default.addObserver(self, selector: #selector(switchBrandNotificationCall(_:)), name: NSNotification.Name("switchBrandNotification"), object: nil)
        
        // Set up Shoe Collection View
        if let ShoeLayout = ShoeCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            ShoeLayout.scrollDirection = .horizontal
        }
        ShoeCollection.dataSource = self
        ShoeCollection.delegate = self
        
        // Set up Brand Collection View
        if let BrandLayout = BrandCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            BrandLayout.scrollDirection = .horizontal
        }
        BrandCollection.dataSource = self
        BrandCollection.delegate = self
        
    }
    
    // Num Cells per Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.ShoeCollection {
            return selectedBrand.count
        } else {
            return DataService.instance.getBrands().count
        }
    }
    
    
    // Load in new Cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Shoe Collection Cells
        if collectionView == self.ShoeCollection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoeCell", for: indexPath) as? ShoeCell {
                
                cell.contentView.layer.cornerRadius = 15.0
                cell.contentView.layer.borderWidth = 0.5
                cell.contentView.layer.masksToBounds = true
                
                
                let shoe = selectedBrand[indexPath.row]
                cell.updateViews(shoe: shoe)
                return cell
            }
        }
        // Brand Collection Cells
        if collectionView == self.BrandCollection {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as? BrandCell {
                let brand = DataService.instance.getBrands()[indexPath.row]
                cell.updateViews(brand: brand)
                return cell
            }
        }
        return ShoeCell()
    }

    
    // Set Size of Collection Views
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Shoe CV Size
        if collectionView == self.ShoeCollection {
            return CGSize(width: 284, height: 325)
        }
        // Brand CV Size
        if collectionView == self.BrandCollection {
            return CGSize(width: 130, height: 50)
        }
        return CGSize(width: 0, height: 0)
    }
    
    
    // Switch Brands When BrandBtn Pressed
    @objc func switchBrandNotificationCall(_ notification: NSNotification) {

        selectedBrand = DataService.instance.getShoes(forBrand: DataService.instance.getSelectedBrand())
        let indexPath = self.ShoeCollection.indexPathsForSelectedItems?.last ?? IndexPath(item: 0, section: 0)
        self.ShoeCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        ShoeCollection.reloadData()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShoeDetailsVC" {
            let destination = segue.destination as? ShoeDetailsVC
            let cell = ShoeCollection.cellForItem(at: ShoeCollection.indexPathsForSelectedItems![0]) as? ShoeCell
            destination!.shoe = cell!.shoe
        }
    }
}
