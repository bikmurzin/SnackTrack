//
//  MealEntry.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import Foundation

/// Запись о съеденном продукте в рамках конкретного приёма пищи.
struct MealEntry: Identifiable, Equatable {
    let id: UUID
    let mealCategoryId: UUID
    let product: FoodProduct
    let weight: Double
    let date: Date

    init(id: UUID = UUID(), mealCategoryId: UUID, product: FoodProduct, weight: Double, date: Date) {
        self.id = id
        self.mealCategoryId = mealCategoryId
        self.product = product
        self.weight = weight
        self.date = date
    }

    /// Рассчитывает пищевую ценность записи с учётом указанного веса продукта.
    var nutrition: NutritionValue {
        let ratio = weight / 100
        return product.nutritionPer100g * ratio
    }
}
