//
//  DailyDiary.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import Foundation

struct DailyDiary: Equatable {
    let date: Date
    let mealCategories: [MealCategory]
    let entries: [MealEntry]
}
