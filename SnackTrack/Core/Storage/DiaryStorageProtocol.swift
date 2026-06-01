//
//  DiaryStorageProtocol.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import Combine
import Foundation

protocol DiaryStorageProtocol {
    func observeDiary(for date: Date) -> AnyPublisher<DailyDiary, Never>
    func addMealEntry( _ entry: MealEntry)
    func deleteMealEntry(id: UUID)
}
