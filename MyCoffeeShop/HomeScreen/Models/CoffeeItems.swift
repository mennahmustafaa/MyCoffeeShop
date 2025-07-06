//
//  CoffeeItems.swift
//  MyCoffeeShop
//
//  Created by Mennah on 27/06/2025.
import Foundation

struct CoffeeItem: Identifiable, Codable {
    let id: Int
    let name: String
    let subtitle: String
    let price: Double
    let imageName: String
   
}
