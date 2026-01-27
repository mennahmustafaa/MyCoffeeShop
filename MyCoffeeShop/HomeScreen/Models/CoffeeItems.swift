//
//  CoffeeItems.swift
//  MyCoffeeShop
//
//  Created by Mennah on 27/06/2025.
import Foundation

struct CoffeeItem: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let subtitle: String
    let price: Double
    let imageName: String
   
}
extension CoffeeItem {
    var asProductDetail: ProductDetailItem {
        ProductDetailItem(
            id: self.id,
            name: self.name,
            type: self.subtitle,
            description: "A rich and flavorful coffee made with love.", // or real description if available
            price: self.price,
            imageName: self.imageName
        )
    }
}
