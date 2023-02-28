//
//  Shoe.swift
//  ShoeShock2
//
//  Created by Dante Ausonio on 12/22/22.
//

import Foundation

struct Shoe: Equatable {
    private(set) public var imgName: String
    private(set) public var name: String
    private(set) public var brand: String
    private(set) public var price: String
    public var isFavorite: Bool
    public var itemCartCount: Int
    
    
    init(imgName: String, name: String, brand: String, price: String, isFavorite: Bool) {
        self.imgName = imgName
        self.name = name
        self.brand = brand
        self.price = price
        self.isFavorite = isFavorite
        self.itemCartCount = 0
    }
    
    static func == (lhs: Shoe, rhs: Shoe) -> Bool {
        return (lhs.name == rhs.name) && (lhs.brand == rhs.brand)
    }
    
}
