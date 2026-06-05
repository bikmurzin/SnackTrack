//
//  AddProductViewData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 02.06.2026.
//

/// Полный набор данных для отображения экрана добавления продукта.
struct AddProductViewData {
    let mealOptions: [MealOptionData]
    let recentProductsData: [RecentProductRowData]
}

#if DEBUG
extension AddProductViewData {
    static let mock = AddProductViewData(
        mealOptions: MealOptionData.mockItems,
        recentProductsData: RecentProductRowData.mock
    )
}
#endif
