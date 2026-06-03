//
//  RecentProductRowData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 03.06.2026.
//

import Foundation

nonisolated struct RecentProductRowData: Hashable, Sendable {
    let id: UUID
    let productName: String
    let weightText: String
    let caloriesText: String
    
    init (id: UUID = UUID(), productName: String, weightText: String, caloriesText: String) {
        self.id = id
        self.productName = productName
        self.weightText = weightText
        self.caloriesText = caloriesText
    }
    
    @MainActor
    init(_ mealEntry: MealEntry) {
        self.id = mealEntry.id
        self.productName = mealEntry.product.name
        self.weightText = mealEntry.weight.description
        self.caloriesText = mealEntry.nutrition.calories.description
    }
}

extension RecentProductRowData {
    static let mock: [RecentProductRowData] = [
        .init(
            productName: "Куриная грудка",
            weightText: "100 г",
            caloriesText: "165"
        ),
        .init(
            productName: "Рис отварной",
            weightText: "100 г",
            caloriesText: "130"
        ),
        .init(
            productName: "Банан",
            weightText: "100 г",
            caloriesText: "89"
        ),
        .init(
            productName: "Овсянка",
            weightText: "100 г",
            caloriesText: "370"
        ),
        .init(
            productName: "Куриная грудка",
            weightText: "100 г",
            caloriesText: "165"
        ),
        .init(
            productName: "Рис отварной",
            weightText: "100 г",
            caloriesText: "130"
        ),
        .init(
            productName: "Банан",
            weightText: "100 г",
            caloriesText: "89"
        ),
        .init(
            productName: "Овсянка",
            weightText: "100 г",
            caloriesText: "370"
        ),
        .init(
            productName: "Куриная грудка",
            weightText: "100 г",
            caloriesText: "165"
        ),
        .init(
            productName: "Рис отварной",
            weightText: "100 г",
            caloriesText: "130"
        ),
        .init(
            productName: "Банан",
            weightText: "100 г",
            caloriesText: "89"
        ),
        .init(
            productName: "Овсянка",
            weightText: "100 г",
            caloriesText: "370"
        )
    ]
}
