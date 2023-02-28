//
//  CartVC.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/25/22.
//

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var CartTable: UITableView!
    @IBOutlet weak var grandTotal: UILabel!
    @IBOutlet weak var checkoutBtn: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        CartTable.reloadData()
        updateGrandTotal()
        checkoutBtn.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.2078431373, blue: 0.262745098, alpha: 1)
        checkoutBtn.layer.cornerRadius = 5
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CartTable.delegate = self
        CartTable.dataSource = self
        
        // Set btn shadow
        checkoutBtn.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.2078431373, blue: 0.262745098, alpha: 1)
        checkoutBtn.layer.shadowRadius = 5
        checkoutBtn.layer.shadowColor = UIColor.darkGray.cgColor
        checkoutBtn.layer.shadowOpacity = 1
        checkoutBtn.layer.masksToBounds = false
        
        updateGrandTotal()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartChange(_:)), name: NSNotification.Name("cartChange"), object: nil)
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getCart().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.cellIdentifier, for: indexPath) as? CartCell {
            let cartItem = DataService.instance.getCart()[indexPath.row]
            cell.updateViews(shoe: cartItem)
            return cell
        } else {
            return CartCell()
        }
        
    }
    
    
    func updateGrandTotal() {
        let cart = DataService.instance.getCart()
        var grandTotal: Int = 0
        for item in cart {
            let netPrice: Int = Int(item.price.filter{$0 != "$"}) ?? 0
            let quantity: Int = item.itemCartCount
            grandTotal += quantity * netPrice
        }
        self.grandTotal.text = "$\(grandTotal)"
    }
    
    
    @objc func cartChange(_ notification: NSNotification) {
        CartTable.reloadData()
        updateGrandTotal()
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
        {
            if editingStyle == .delete {
                DataService.instance.removeCartItem(shoe: nil, index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                updateGrandTotal()
            }
        }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShoeDetailsVC" {
            let destination = segue.destination as? ShoeDetailsVC
            let indexPath = CartTable.indexPathForSelectedRow
            let cell = CartTable.cellForRow(at: indexPath!) as? CartCell
            destination!.shoe = cell!.shoe
        }
        
        if segue.identifier == "CheckOut" {
            let destination = segue.destination as? ThankYouVC
            destination!.purchasedShoes = DataService.instance.getCart()
            DataService.instance.emptyCart()
            CartTable.reloadData()
            updateGrandTotal()
        }
    }
    
    
    
    
}
