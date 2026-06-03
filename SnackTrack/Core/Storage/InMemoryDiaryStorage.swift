//
//  InMemoryDiaryStorage.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import Combine
import Foundation

/// Временное in-memory хранилище дневника питания с mock-данными для разработки.
final class InMemoryDiaryStorage: DiaryStorageProtocol {
    private let calendar: Calendar
    private let mealCategories: [MealCategory]
    private let mealEntriesSubject: CurrentValueSubject<[MealEntry], Never>

    init(calendar: Calendar = .current) {
        self.calendar = calendar
        self.mealCategories = Self.makeDefaultMealCategories()
        self.mealEntriesSubject = CurrentValueSubject(Self.makeMockEntries())
    }

    func observeDiary(for date: Date) -> AnyPublisher<DailyDiary, Never> {
        mealEntriesSubject
            .map { [calendar, mealCategories] entries in
                let dayEntries = entries.filter {
                    calendar.isDate($0.date, inSameDayAs: date)
                }

                return DailyDiary(
                    date: date,
                    mealCategories: mealCategories.sorted { $0.sortOrder < $1.sortOrder },
                    entries: dayEntries
                )
            }
            .eraseToAnyPublisher()
    }

    func addMealEntry(_ entry: MealEntry) {
        var entries = mealEntriesSubject.value
        entries.append(entry)
        mealEntriesSubject.send(entries)
    }

    func deleteMealEntry(id: UUID) {
        let entries = mealEntriesSubject.value.filter { $0.id != id }
        mealEntriesSubject.send(entries)
    }
}

extension InMemoryDiaryStorage {
    static let breakfastId = UUID(uuidString: "11111111-1111-1111-1111-111111111111")!
    static let lunchId = UUID(uuidString: "22222222-2222-2222-2222-222222222222")!
    static let dinnerId = UUID(uuidString: "33333333-3333-3333-3333-333333333333")!
    static let snackId = UUID(uuidString: "44444444-4444-4444-4444-444444444444")!

    private static func makeDefaultMealCategories() -> [MealCategory] {
        [
            MealCategory(
                id: breakfastId,
                title: "Завтрак",
                iconSystemName: "sunrise.fill",
                sortOrder: 0
            ),
            MealCategory(
                id: lunchId,
                title: "Обед",
                iconSystemName: "sun.max.fill",
                sortOrder: 1
            ),
            MealCategory(
                id: dinnerId,
                title: "Ужин",
                iconSystemName: "moon.fill",
                sortOrder: 2
            ),
            MealCategory(
                id: snackId,
                title: "Перекус",
                iconSystemName: "takeoutbag.and.cup.and.straw.fill",
                sortOrder: 3
            )
        ]
    }
    private static func makeMockEntries() -> [MealEntry] {
        let oatmeal = FoodProduct(
            name: "Овсянка",
            nutritionPer100g: NutritionValue(
                calories: 370,
                proteins: 12,
                fats: 6,
                carbs: 65
            )
        )
        let banana = FoodProduct(
            name: "Банан",
            nutritionPer100g: NutritionValue(
                calories: 89,
                proteins: 1.1,
                fats: 0.3,
                carbs: 23
            )
        )
        let chicken = FoodProduct(
            name: "Курица",
            nutritionPer100g: NutritionValue(
                calories: 165,
                proteins: 31,
                fats: 3.6,
                carbs: 0
            )
        )
        let rice = FoodProduct(
            name: "Рис",
            nutritionPer100g: NutritionValue(
                calories: 130,
                proteins: 2.7,
                fats: 0.3,
                carbs: 28
            )
        )
        return [
            MealEntry(
                mealCategoryId: breakfastId,
                product: oatmeal,
                weight: 80,
                date: Date()
            ),
            MealEntry(
                mealCategoryId: breakfastId,
                product: banana,
                weight: 120,
                date: Date()
            ),
            MealEntry(
                mealCategoryId: lunchId,
                product: chicken,
                weight: 180,
                date: Date()
            ),
            MealEntry(
                mealCategoryId: lunchId,
                product: rice,
                weight: 200,
                date: Date()
            )
        ]
    }
}
