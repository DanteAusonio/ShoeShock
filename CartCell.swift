//
//  CartCell.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/25/22.
//

import UIKit

class CartCell: UITableViewCell {

    static let cellIdentifier = "CartCell"
    
    var shoe: Shoe!
    @IBOutlet weak var shoeImageView: UIImageView!
    @IBOutlet weak var shoeNameLabel: UILabel!
    @IBOutlet weak var shoeBrandLabel: UILabel!
    @IBOutlet weak var shoePriceLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    func updateViews(shoe: Shoe) {
        self.shoe = shoe
        self.shoe.itemCartCount = DataService.instance.getShoeFromCart(shoe: self.shoe).itemCartCount
        shoeImageView.image = UIImage(named: shoe.imgName)
        shoeNameLabel.text = shoe.name
        shoeBrandLabel.text = shoe.brand
        shoePriceLabel.text = shoe.price
        quantityStepper.value = Double(self.shoe.itemCartCount)
        quantityLabel.text = String(DataService.instance.getShoeFromCart(shoe: self.shoe).itemCartCount)
        quantityLabel.layer.cornerRadius = 5
        
        
        let quantity: Int = Int(shoe.price.filter{$0 != "$"}) ?? 0
        totalCostLabel.text = "$\(String(self.shoe.itemCartCount * quantity))"
        
    }
    
    
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        self.shoe.itemCartCount = Int(sender.value)
        if self.shoe.itemCartCount > 0 {
            DataService.instance.addCartItem(shoe: self.shoe)
        } else if self.shoe.itemCartCount == 0 {
            DataService.instance.removeCartItem(shoe: self.shoe, index: nil)
        }
        updateViews(shoe: self.shoe)
        NotificationCenter.default.post(name: NSNotification.Name("cartChange"), object: nil)
    }

    
    
    

}
