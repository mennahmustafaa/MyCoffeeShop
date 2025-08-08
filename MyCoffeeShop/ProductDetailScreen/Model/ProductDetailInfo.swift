//
//  ProductDetailInfo.swift
//  MyCoffeeShop
//
//  Created by Mennah on 25/07/2025.
//
struct ProductDetailItem: Identifiable,Hashable{
    let id: Int
    let name: String
    let type: String
    let description: String
    let price: Double
    let imageName: String
}

