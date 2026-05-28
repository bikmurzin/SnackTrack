//
//  DiaryViewDataModel.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

struct DiaryViewData {
    let headerModel: DiaryHeaderData
}

#if DEBUG
extension DiaryViewData {
    static let mock = DiaryViewData(
        headerModel: DiaryHeaderData(
            dayName: "Сегодня",
            date: "27 мая, среда"
        )
    )
}
#endif
