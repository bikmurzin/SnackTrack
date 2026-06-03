//
//  AddProductViewData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 02.06.2026.
//

struct AddProductViewData {
    let mealOptions: [MealOptionData]
    let actionsData: AddProductActionsData
    let recentProductsData: [RecentProductRowData]
}

#if DEBUG
extension AddProductViewData {
    static let mock = AddProductViewData(
        mealOptions: MealOptionData.mockItems,
        actionsData: AddProductActionsData.mock,
        recentProductsData: RecentProductRowData.mock
    )
}
#endif
