//
//  DiaryViewDataModel.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

struct DiaryViewData {
    let headerModel: DiaryHeaderData
    let calorieSummary: CalorieSummaryData
    let macrosSummary: MacrosSummaryData
}

extension DiaryViewData {
    static let mock = DiaryViewData(
        headerModel: DiaryHeaderData.mock,
        calorieSummary: CalorieSummaryData.mock,
        macrosSummary: MacrosSummaryData.mock
    )
}

