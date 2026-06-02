//
//  MealOptionData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

import UIKit

struct MealOptionData: Identifiable, Equatable {
    let id: UUID
    let title: String
    let iconSystemName: String
    let tintColor: UIColor
    let isSelected: Bool
}

#if DEBUG
extension MealOptionData {
    static let mockItems: [MealOptionData] = [
        MealOptionData(
            id: UUID(),
            title: "Завтрак",
            iconSystemName: "sunrise.fill",
            tintColor: .systemOrange,
            isSelected: true
        ),
        MealOptionData(
            id: UUID(),
            title: "Обед",
            iconSystemName: "sun.max.fill",
            tintColor: .secondaryLabel,
            isSelected: false
        ),
        MealOptionData(
            id: UUID(),
            title: "Ужин",
            iconSystemName: "moon.fill",
            tintColor: .secondaryLabel,
            isSelected: false
        ),
        MealOptionData(
            id: UUID(),
            title: "Перекус",
            iconSystemName: "takeoutbag.and.cup.and.straw.fill",
            tintColor: .secondaryLabel,
            isSelected: false
        ),
        MealOptionData(
            id: UUID(),
            title: "Другое",
            iconSystemName: "ellipsis",
            tintColor: .secondaryLabel,
            isSelected: false
        )
    ]
}
#endif
