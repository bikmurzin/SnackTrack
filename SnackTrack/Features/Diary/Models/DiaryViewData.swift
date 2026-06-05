//
//  DiaryViewDataModel.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

/// Полный набор данных для отображения экрана дневника питания.
struct DiaryViewData {
    let headerModel: DiaryHeaderData
    let calorieSummary: CalorieSummaryData
    let macrosSummary: MacrosSummaryData
    let mealsSummary: MealsSummaryData
}

extension DiaryViewData {
    static let mock = DiaryViewData(
        headerModel: DiaryHeaderData.mock,
        calorieSummary: CalorieSummaryData.mock,
        macrosSummary: MacrosSummaryData.mock,
        mealsSummary: MealsSummaryData.mock
    )
}
