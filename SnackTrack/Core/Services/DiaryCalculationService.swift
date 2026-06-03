//
//  DiaryCalculationService.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import Foundation

/// Сервис расчётов по записям дневника питания.
final class DiaryCalculationService {
    /// Возвращает суммарную пищевую ценность переданных записей.
    func totalNutrition(from entries: [MealEntry]) -> NutritionValue {
        entries.reduce(.zero) { result, entry in
            result + entry.nutrition
        }
    }

    /// Фильтрует записи, относящиеся к указанной категории приёма пищи.
    func entries(
        for category: MealCategory,
        from entries: [MealEntry]
    ) -> [MealEntry] {
        entries.filter { $0.mealCategoryId == category.id }
    }
}
