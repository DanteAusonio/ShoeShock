//
//  ShoeDetailsCV.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/26/22.
//

import UIKit

class ShoeDetailsVC: UIViewController {
    
    var shoe: Shoe!
    @IBOutlet weak var shoeImageView: UIImageView!
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var shoeBrandLabel: UILabel!
    @IBOutlet weak var shoePriceLabel: UILabel!
    @IBOutlet weak var shoeDescription: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityDisplayLabel: UILabel!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoeImageView.image = UIImage(named: shoe.imgName)
        shoeNameLabel.text = shoe.name
        shoeBrandLabel.text = shoe.brand
        shoePriceLabel.text = shoe.price
        
        shoeDescription.layer.cornerRadius = 5
        shoeDescription.text = "If I were extracting all of the data for the shoes from a larger data source then they would likely have a description property which I would insert here in the same way I have with the shoes name, brand, etc..."
        
        self.shoe.itemCartCount = DataService.instance.getShoeFromCart(shoe: self.shoe).itemCartCount
        quantityStepper.value = Double(self.shoe.itemCartCount)
        quantityDisplayLabel.text = String(DataService.instance.getShoeFromCart(shoe: self.shoe).itemCartCount)
        
        if DataService.instance.getFavorites().contains(self.shoe) {
            favoriteBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteBtn.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        cartBtn.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        quantityStepper.isHidden = true
        quantityDisplayLabel.isHidden = true
        quantityDisplayLabel.layer.cornerRadius = 5
    }
    
    
    @IBAction func favBtnPressed() {
        // Remove Fav
        if DataService.instance.getFavorites().contains(self.shoe) {
            favoriteBtn.setImage(UIImage(systemName: "star"), for: .normal)
            DataService.instance.removeFavorite(shoe: self.shoe, index: nil)
        } else {
            favoriteBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
            DataService.instance.addFavorite(shoe: self.shoe)
        }
    }
    
    
    @IBAction func cartBtnPressed() {
        quantityStepper.isHidden.toggle()
        quantityDisplayLabel.isHidden.toggle()
        if cartBtn.currentImage == UIImage(systemName: "cart.badge.plus") {
            cartBtn.setImage(UIImage(systemName: "cart.badge.plus.fill"), for: .normal)
        } else if cartBtn.currentImage == UIImage(systemName: "cart.badge.plus.fill") {
            cartBtn.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        self.shoe.itemCartCount = Int(sender.value)
        if self.shoe.itemCartCount > 0 {
            DataService.instance.addCartItem(shoe: self.shoe)
        } else if self.shoe.itemCartCount == 0 {
            DataService.instance.removeCartItem(shoe: self.shoe, index: nil)
        }
        quantityDisplayLabel.text = String(DataService.instance.getShoeFromCart(shoe: self.shoe).itemCartCount)
    }
    

}
