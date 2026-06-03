//
//  CalorieSummaryData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 28.05.2026.
//

/// Данные для блока с дневной сводкой по калориям.
struct CalorieSummaryData {
    let remainingCalories: Int
    let goalCalories: Int
    let consumedCalories: Int
    let progress: Double
}

extension CalorieSummaryData {
    static let mock = CalorieSummaryData(remainingCalories: 1240, goalCalories: 2200, consumedCalories: 960, progress: 0.44)
}
