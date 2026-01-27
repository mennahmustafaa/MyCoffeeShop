//
//  CartItem.swift
//  MyCoffeeShop
//
//  Created by Mennah on 08/09/2025.
//
import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let product: ProductDetailItem
    let size: String
    var quantity: Int = 1
    
    var adjustedPrice: Double {
        switch size {
        case "S": return product.price
        case "M": return product.price + 1.0
        case "L": return product.price + 2.0
        default: return product.price
        }
    }
}
