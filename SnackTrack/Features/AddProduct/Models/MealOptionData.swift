//
//  MealOptionData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

import UIKit

extension MealOptionData {
    private struct Constants {
        static let choosenCategoryColor: UIColor = .systemOrange
        static let usualCategoryColor: UIColor = .secondaryLabel
    }
}

/// Данные варианта приёма пищи для выбора на экране добавления продукта.
struct MealOptionData: Identifiable, Equatable {
    let id: UUID
    let title: String
    let iconSystemName: String
    let tintColor: UIColor
    let isSelected: Bool
    
    init(id: UUID, title: String, iconSystemName: String, isSelected: Bool) {
        self.id = id
        self.title = title
        self.iconSystemName = iconSystemName
        self.isSelected = isSelected
        tintColor = isSelected ? Constants.choosenCategoryColor : Constants.usualCategoryColor
    }
}

#if DEBUG
extension MealOptionData {
    static let mockItems: [MealOptionData] = [
        MealOptionData(
            id: UUID(),
            title: "Завтрак",
            iconSystemName: "sunrise.fill",
            isSelected: true
        ),
        MealOptionData(
            id: UUID(),
            title: "Обед",
            iconSystemName: "sun.max.fill",
            isSelected: false
        ),
        MealOptionData(
            id: UUID(),
            title: "Ужин",
            iconSystemName: "moon.fill",
            isSelected: false
        ),
        MealOptionData(
            id: UUID(),
            title: "Перекус",
            iconSystemName: "takeoutbag.and.cup.and.straw.fill",
            isSelected: false
        ),
        MealOptionData(
            id: UUID(),
            title: "Другое",
            iconSystemName: "ellipsis",
            isSelected: false
        )
    ]
}
#endif
