//
//  DiaryViewDataModel.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

struct DiaryViewData {
    let headerModel: DiaryHeaderData
    let calorieSummary: CalorieSummaryData
}

#if DEBUG
extension DiaryViewData {
    static let mock = DiaryViewData(
        headerModel: DiaryHeaderData(
            dayName: "Сегодня",
            date: "27 мая, среда"
        ),
        calorieSummary: CalorieSummaryData(remainingCalories: 1240, goalCalories: 2200, consumedCalories: 960, progress: 0.44)
    )
}
#endif
