//
//  DiaryCalculationService.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import Foundation

final class DiaryCalculationService {
    func totalNutrition(from entries: [MealEntry]) -> NutritionValue {
        entries.reduce(.zero) { result, entry in
            result + entry.nutrition
        }
    }
    
    func entries(
        for category: MealCategory,
        from entries: [MealEntry]
    ) -> [MealEntry] {
        entries.filter { $0.mealCategoryId == category.id }
    }
}
