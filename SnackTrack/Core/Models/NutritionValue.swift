//
//  NutritionValue.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

/// Набор пищевых показателей: калории, белки, жиры и углеводы.
struct NutritionValue: Equatable {
    let calories: Double
    let proteins: Double
    let fats: Double
    let carbs: Double
}

extension NutritionValue {
    /// Нулевая пищевая ценность для начальных значений и суммирования.
    static let zero = NutritionValue(calories: 0, proteins: 0, fats: 0, carbs: 0)

    /// Складывает две пищевые ценности по каждому показателю.
    static func + (lhs: NutritionValue, rhs: NutritionValue) -> NutritionValue {
        NutritionValue(
            calories: lhs.calories + rhs.calories,
            proteins: lhs.proteins + rhs.proteins,
            fats: lhs.fats + rhs.fats,
            carbs: lhs.carbs + rhs.carbs
        )
    }

    /// Умножает пищевую ценность на числовой коэффициент.
    static func * (lhs: NutritionValue, rhs: Double) -> NutritionValue {
        NutritionValue(
            calories: lhs.calories * rhs,
            proteins: lhs.proteins * rhs,
            fats: lhs.fats * rhs,
            carbs: lhs.carbs * rhs
        )
    }
}
