//
//  DiaryData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 04.06.2026.
//

/// Общие данные дневника с категориями приёмов пищи и записями о продуктах.
struct DiaryData {
    let mealCategories: [MealCategory]
    let mealEntries: [MealEntry]
}
