//
//  FavoritesVC.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/24/22.
//

import UIKit

class FavoritesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favoritesTable: UITableView!
    //var favesArray = DataService.instance.getFavorites()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTable.delegate = self
        favoritesTable.dataSource = self
        
        // Set up Fav Btn Communication
        NotificationCenter.default.addObserver(self, selector: #selector(unFavNotificationCall(_:)), name: NSNotification.Name("unFavNotification"), object: nil)
    }
    
    
    // Update array from Data Service
    override func viewWillAppear(_ animated: Bool) {
        //favesArray = DataService.instance.getFavorites()
        favoritesTable.reloadData()
    }
    
    
    
    // Get number of items in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getFavorites().count
    }
    
    
    // Set up Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell") as? FavoritesCell {
            let favorite = DataService.instance.getFavorites()[indexPath.row]
            cell.updateViews(shoe: favorite)
            return cell
        } else {
            return FavoritesCell()
        }
    }
    
    // Set Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    // Delete Rows with Swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            // Delete the row from the data source
            DataService.instance.removeFavorite(shoe: nil, index: indexPath.row)
            // Then, delete the row from the table itself
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // Delete Rows with Btn
    @objc func unFavNotificationCall(_ notification: NSNotification) {
        favoritesTable.reloadData()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShoeDetailsVC" {
            let destination = segue.destination as? ShoeDetailsVC
            let indexPath = favoritesTable.indexPathForSelectedRow
            let cell = favoritesTable.cellForRow(at: indexPath!) as? FavoritesCell
            destination!.shoe = cell!.shoe
        }
    }
    
}

