//
//  DiaryStorageProtocol.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import Combine
import Foundation

/// Хранилище дневника питания, которое отдаёт данные дня и управляет записями.
protocol DiaryStorageProtocol {
    /// Возвращает поток дневника питания для указанной даты.
    func observeDiary(for date: Date) -> AnyPublisher<DailyDiary, Never>

    /// Добавляет новую запись о продукте в дневник.
    func addMealEntry( _ entry: MealEntry)

    /// Удаляет запись дневника по идентификатору.
    func deleteMealEntry(id: UUID)
}
