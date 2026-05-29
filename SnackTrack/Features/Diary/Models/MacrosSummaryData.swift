//
//  MacrosSummaryData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 29.05.2026.
//

import UIKit

struct MacrosSummaryData {
    let proteins: MacroItemData
    let fats: MacroItemData
    let carbs: MacroItemData
}

struct MacroItemData {
    let title: String
    let currentValue: Int
    let goalValue: Int
    let unit: String
    let color: UIColor

    var progress: Double {
        guard goalValue > 0 else { return 0 }
        return min(max(Double(currentValue) / Double(goalValue), 0), 1)
    }
}

extension MacrosSummaryData {
    static let mock = MacrosSummaryData(
        proteins: MacroItemData(
            title: "Белки",
            currentValue: 64,
            goalValue: 120,
            unit: "г",
            color: .systemGreen
        ),
        fats: MacroItemData(
            title: "Жиры",
            currentValue: 38,
            goalValue: 70,
            unit: "г",
            color: .systemOrange
        ),
        carbs: MacroItemData(
            title: "Углеводы",
            currentValue: 120,
            goalValue: 300,
            unit: "г",
            color: .systemBlue
        )
    )
}
