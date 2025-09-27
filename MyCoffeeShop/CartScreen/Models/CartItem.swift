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
}
