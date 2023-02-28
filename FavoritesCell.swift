//
//  FavoritesCell.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/24/22.
//

import UIKit

class FavoritesCell: UITableViewCell {

    var shoe: Shoe!
    @IBOutlet weak var shoeImage: UIImageView!
    @IBOutlet weak var shoeName: UILabel!
    @IBOutlet weak var shoeBrand: UILabel!
    @IBOutlet weak var shoePrice: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var cartStepper: UIStepper!
    @IBOutlet weak var countLbl: UILabel!
    
    func updateViews(shoe: Shoe) {
        self.shoe = shoe
        shoeImage.image = UIImage(named: shoe.imgName)
        shoeName.text = shoe.name
        shoeBrand.text = shoe.brand
        shoePrice.text = shoe.price
        self.shoe.itemCartCount = DataService.instance.getShoeFromCart(shoe: self.shoe).itemCartCount
        cartStepper.value = Double(self.shoe.itemCartCount)
        countLbl.text = String(DataService.instance.getShoeFromCart(shoe: self.shoe).itemCartCount)
        
        if DataService.instance.getFavorites().contains(self.shoe) {
            favBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favBtn.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        cartBtn.setImage(UIImage(systemName: "cart.badge.plus"), for: .normal)
        cartStepper.isHidden = true
        countLbl.isHidden = true
        countLbl.layer.cornerRadius = 5
    }
    
    
    
    @IBAction func favBtnPressed() {
        // Remove Fav
        if DataService.instance.getFavorites().contains(self.shoe) {
            favBtn.setImage(UIImage(systemName: "star"), for: .normal)
            DataService.instance.removeFavorite(shoe: self.shoe, index: nil)
            NotificationCenter.default.post(name: NSNotification.Name("unFavNotification"), object: nil)
        }
    }
    
    
    @IBAction func cartBtnPressed() {
        cartStepper.isHidden.toggle()
        countLbl.isHidden.toggle()
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
        countLbl.text = String(DataService.instance.getShoeFromCart(shoe: self.shoe).itemCartCount)
    }

    

}
