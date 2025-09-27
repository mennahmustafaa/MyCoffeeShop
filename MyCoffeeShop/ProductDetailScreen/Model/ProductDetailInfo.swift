//
//  ProductDetailInfo.swift
//  MyCoffeeShop
//
//  Created by Mennah on 25/07/2025.
//
import Foundation
struct ProductDetailItem: Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let type: String
    let description: String
    let price: Double
    let imageName: String
}
