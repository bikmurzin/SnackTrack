//
//  FoodProduct.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import Foundation

/// Продукт питания с пищевой ценностью, указанной на 100 граммов.
struct FoodProduct: Identifiable, Equatable {
    let id: UUID
    let name: String
    let nutritionPer100g: NutritionValue

    init(id: UUID = UUID(), name: String, nutritionPer100g: NutritionValue) {
        self.id = id
        self.name = name
        self.nutritionPer100g = nutritionPer100g
    }
}
