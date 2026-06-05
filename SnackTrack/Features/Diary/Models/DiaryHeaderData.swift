//
//  DiaryHeaderDataModel.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

/// Данные заголовка дневника с названием дня и датой.
struct DiaryHeaderData {
    let dayName: String
    let date: String
}

extension DiaryHeaderData {
    static let mock = DiaryHeaderData(dayName: "Сегодня", date: "29 мая, пятница")
}
