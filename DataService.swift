//
//  DataService.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/22/22.
//

import Foundation


enum BrandOption {
    case Adidas
    case Jordans
    case Nike
    case Sneakers
    case Vans
    
    var title: String {
        switch self {
        case .Adidas:
            return "Adidas"
        case .Jordans:
            return "Jordans"
        case .Nike:
            return "Nike"
        case .Sneakers:
            return "Sneakers"
        case . Vans:
            return "Vans"
        }
    }
    
}


class DataService {
    static let instance = DataService()
    
    
    // Declarations
    private let brands: [BrandOption] = [.Adidas, .Jordans, .Nike, .Sneakers, .Vans]
    
    private let adidas = [
        Shoe(imgName: "adidas1", name: "Adidas 1", brand: "Adidas", price: "$120", isFavorite: false),
        Shoe(imgName: "adidas2", name: "Adidas 2", brand: "Adidas", price: "$125", isFavorite: false),
        Shoe(imgName: "adidas3", name: "Adidas 3", brand: "Adidas", price: "$225", isFavorite: false),
        Shoe(imgName: "adidas4", name: "Adidas 4", brand: "Adidas", price: "$95", isFavorite: false),
        Shoe(imgName: "adidas5", name: "Adidas 5", brand: "Adidas", price: "$110", isFavorite: false),
        Shoe(imgName: "adidas6", name: "Adidas 6", brand: "Adidas", price: "$175", isFavorite: false)
    ]
    
    private let jordans = [
        Shoe(imgName: "jordans1", name: "Jordans 1", brand: "Jordans", price: "$230", isFavorite: false),
        Shoe(imgName: "jordans2", name: "Jordans 2", brand: "Jordans", price: "$200", isFavorite: false),
        Shoe(imgName: "jordans3", name: "Jordans 3", brand: "Jordans", price: "$195", isFavorite: false)
    ]
    
    private let nike = [
        Shoe(imgName: "nike1", name: "Nike 1", brand: "Nike", price: "$65", isFavorite: false),
        Shoe(imgName: "nike2", name: "Nike 2", brand: "Nike", price: "$80", isFavorite: false),
        Shoe(imgName: "nike3", name: "Nike 3", brand: "Nike", price: "$50", isFavorite: false),
    ]
    
    private let sneakers = [
        Shoe(imgName: "sneaker1", name: "Sneakers 1", brand: "Sneakers", price: "$30", isFavorite: false),
        Shoe(imgName: "sneaker2", name: "Sneakers 2", brand: "Sneakers", price: "$45", isFavorite: false),
        Shoe(imgName: "sneaker3", name: "Sneakers 3", brand: "Sneakers", price: "$65", isFavorite: false),
        Shoe(imgName: "sneaker4", name: "Sneakers 4", brand: "Sneakers", price: "$40", isFavorite: false),
    ]
    
    private let vans = [
        Shoe(imgName: "vans1", name: "Vans 1", brand: "Vans", price: "$70", isFavorite: false),
        Shoe(imgName: "vans2", name: "Vans 2", brand: "Vans", price: "$65", isFavorite: false),
        Shoe(imgName: "vans3", name: "Vans 3", brand: "Vans", price: "$75", isFavorite: false),
    ]
    
    private var selectedBrand: BrandOption = .Adidas
    
    private var favoriteShoes = [Shoe]()
    
    private var cart = [Shoe]()
    
    
    
    //Accessor & Mutator Methods
    
    
    func getShoes(forBrand brand: BrandOption) -> [Shoe] {
        switch brand {
        case .Adidas:
            return adidas
        case .Jordans:
            return jordans
        case .Nike:
            return nike
        case .Sneakers:
            return sneakers
        case .Vans:
            return vans
        }
    }
    
    
    // Access & Mutate Brands
    func getBrands() -> [BrandOption] {
        return brands
    }
    
    func setSelectedBrand(brand: BrandOption) {
        selectedBrand = brand
    }
    
    func getSelectedBrand() -> BrandOption {
        return selectedBrand
    }
    
    
    // Access & Mutate Favorites
    func addFavorite(shoe: Shoe) {
        favoriteShoes.append(shoe)
    }
    
    func removeFavorite(shoe: Shoe?, index: Int?) {
        if shoe != nil {
            for (i, favShoe) in favoriteShoes.enumerated() {
                if favShoe == shoe {
                    favoriteShoes.remove(at: i)
                    break
                }
            }
        } else if index != nil {
            favoriteShoes.remove(at: index!)
        }
    }
    
    func getFavorites() -> [Shoe] {
        return favoriteShoes
    }
    
    
    // Access & Mutate Cart
    func getCart() -> [Shoe] {
        return cart
        
    }
    
    
    func getShoeFromCart(shoe: Shoe) -> Shoe {
        for shoes in cart {
            if shoes == shoe {
                return shoes
            }
        }
        return adidas[0] //Create a default Empty Shoe
    }
        
        
        func addCartItem(shoe: Shoe) {
            // Add Cart Item
            if !cart.contains(shoe) {
                cart.append(shoe)
            }
            // Update Count of Cart Item
            for (i, cartShoe) in cart.enumerated() {
                if cartShoe == shoe {
                    cart[i].itemCartCount = shoe.itemCartCount
                }
            }
        }
        
        
        
    func removeCartItem(shoe: Shoe?, index: Int?) {
        if shoe != nil {
            for (i, cartShoe) in cart.enumerated() {
                if cartShoe == shoe {
                    cart.remove(at: i)
                    break
                }
            }
        } else if index != nil {
            cart[index!].itemCartCount = 0
            cart.remove(at: index!)
        }
    }
    
    func emptyCart() {
        cart.removeAll()
    }
    
}
