//
//  MealsSummaryData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 29.05.2026.
//

import UIKit

/// Данные для списка приёмов пищи на экране дневника.
struct MealsSummaryData {
    let meals: [MealRowData]
}

/// Данные одной строки приёма пищи.
struct MealRowData {
    let id: UUID
    let title: String
    let calories: Int
    let subtitle: String
    let iconSystemName: String
    let iconTintColor: UIColor
    let iconBackgroundColor: UIColor
}

extension MealsSummaryData {
    static let mock = MealsSummaryData(
        meals: [
            MealRowData(
                id: UUID(),
                title: "Завтрак",
                calories: 420,
                subtitle: "Овсянка, банан, кофе",
                iconSystemName: "sunrise.fill",
                iconTintColor: .systemOrange,
                iconBackgroundColor: .systemOrange.withAlphaComponent(0.12)
            ),
            MealRowData(
                id: UUID(),
                title: "Обед",
                calories: 680,
                subtitle: "Курица, рис, салат",
                iconSystemName: "sun.max.fill",
                iconTintColor: .systemOrange,
                iconBackgroundColor: .systemOrange.withAlphaComponent(0.12)
            ),
            MealRowData(
                id: UUID(),
                title: "Ужин",
                calories: 0,
                subtitle: "Добавьте продукты",
                iconSystemName: "moon.fill",
                iconTintColor: .systemPurple,
                iconBackgroundColor: .systemPurple.withAlphaComponent(0.12)
            ),
            MealRowData(
                id: UUID(),
                title: "Перекус",
                calories: 0,
                subtitle: "Добавьте продукты",
                iconSystemName: "takeoutbag.and.cup.and.straw.fill",
                iconTintColor: .systemBlue,
                iconBackgroundColor: .systemBlue.withAlphaComponent(0.10)
            )
        ]
    )
}
