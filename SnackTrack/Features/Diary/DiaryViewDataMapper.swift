//
//  DiaryViewDataMapper.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import UIKit

extension DiaryViewDataMapper {
    private struct Constants {
        static let dailyCaloriesGoal = 2_200
        static let proteinsGoal = 120
        static let fatsGoal = 70
        static let carbsGoal = 300

        static let maxRelativeDayDistance = 1

        static let ruLocaleIdentifier = "ru_RU"

        static let dayMonthDateFormat = "d MMMM"
        static let weekdayDateFormat = "EEEE"

        static let todayTitle = "Сегодня"
        static let yesterdayTitle = "Вчера"
        static let tomorrowTitle = "Завтра"

        static let proteinsTitle = "Белки"
        static let fatsTitle = "Жиры"
        static let carbsTitle = "Углеводы"
        static let gramUnit = "г"

        static let emptyProductSummary = "Добавьте продукты"

        static let iconBackgroundAlpha = 0.12
    }
}

/// Маппер, который преобразует доменную модель дневника в данные для UI.
struct DiaryViewDataMapper {
    private let calendar: Calendar
    private let locale: Locale

    init(
        calendar: Calendar = .current,
        locale: Locale = Locale(identifier: Constants.ruLocaleIdentifier)
    ) {
        self.calendar = calendar
        self.locale = locale
    }

    /// Преобразует дневник питания в полный набор данных для экрана дневника.
    func map(
        diary: DailyDiary,
        calculationService: DiaryCalculationService
    ) -> DiaryViewData {
        let totalNutrition = calculationService.totalNutrition(from: diary.entries)

        return DiaryViewData(
            headerModel: makeHeaderData(from: diary.date),
            calorieSummary: makeCalorieSummary(from: totalNutrition),
            macrosSummary: makeMacrosSummary(from: totalNutrition),
            mealsSummary: makeMealsSummary(
                categories: diary.mealCategories,
                entries: diary.entries,
                calculationService: calculationService
            )
        )
    }

    private func makeHeaderData(from date: Date) -> DiaryHeaderData {
        DiaryHeaderData(
            dayName: makeMainDateTitle(from: date),
            date: makeSubtitleDateTitle(from: date)
        )
    }

    private func makeMainDateTitle(from date: Date) -> String {
        if calendar.isDateInToday(date) {
            return Constants.todayTitle
        }

        if calendar.isDateInYesterday(date) {
            return Constants.yesterdayTitle
        }

        if calendar.isDateInTomorrow(date) {
            return Constants.tomorrowTitle
        }

        return makeFormattedDate(
            from: date,
            format: Constants.dayMonthDateFormat,
            shouldCapitalizeFirstLetter: false
        )
    }

    private func makeSubtitleDateTitle(from date: Date) -> String {
        if isRelativeDate(date) {
            return makeFormattedDate(
                from: date,
                format: Constants.dayMonthDateFormat,
                shouldCapitalizeFirstLetter: false
            )
        }

        return makeFormattedDate(
            from: date,
            format: Constants.weekdayDateFormat,
            shouldCapitalizeFirstLetter: true
        )
    }

    private func isRelativeDate(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
            || calendar.isDateInYesterday(date)
            || calendar.isDateInTomorrow(date)
    }

    private func makeFormattedDate(
        from date: Date,
        format: String,
        shouldCapitalizeFirstLetter: Bool
    ) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = format
        formatter.calendar = calendar
        formatter.timeZone = calendar.timeZone

        let value = formatter.string(from: date)

        guard shouldCapitalizeFirstLetter else {
            return value
        }

        return value.prefix(1).uppercased() + value.dropFirst()
    }

    private func makeCalorieSummary(
        from nutrition: NutritionValue
    ) -> CalorieSummaryData {
        let consumedCalories = Int(nutrition.calories.rounded())
        let remainingCalories = max(Constants.dailyCaloriesGoal - consumedCalories, 0)
        let progress = Double(consumedCalories) / Double(Constants.dailyCaloriesGoal)

        return CalorieSummaryData(
            remainingCalories: remainingCalories,
            goalCalories: Constants.dailyCaloriesGoal,
            consumedCalories: consumedCalories,
            progress: progress
        )
    }

    private func makeMacrosSummary(
        from nutrition: NutritionValue
    ) -> MacrosSummaryData {
        MacrosSummaryData(
            proteins: MacroItemData(
                title: Constants.proteinsTitle,
                currentValue: Int(nutrition.proteins.rounded()),
                goalValue: Constants.proteinsGoal,
                unit: Constants.gramUnit,
                color: .systemGreen
            ),
            fats: MacroItemData(
                title: Constants.fatsTitle,
                currentValue: Int(nutrition.fats.rounded()),
                goalValue: Constants.fatsGoal,
                unit: Constants.gramUnit,
                color: .systemOrange
            ),
            carbs: MacroItemData(
                title: Constants.carbsTitle,
                currentValue: Int(nutrition.carbs.rounded()),
                goalValue: Constants.carbsGoal,
                unit: Constants.gramUnit,
                color: .systemBlue
            )
        )
    }

    private func makeMealsSummary(
        categories: [MealCategory],
        entries: [MealEntry],
        calculationService: DiaryCalculationService
    ) -> MealsSummaryData {
        let meals = categories.map { category in
            let categoryEntries = calculationService.entries(
                for: category,
                from: entries
            )

            let nutrition = calculationService.totalNutrition(from: categoryEntries)

            let subtitle = productSummary(
                for: categoryEntries,
                emptyText: Constants.emptyProductSummary
            )

            return MealRowData(
                id: category.id,
                title: category.title,
                calories: Int(nutrition.calories.rounded()),
                subtitle: subtitle,
                iconSystemName: category.iconSystemName,
                iconTintColor: iconTintColor(for: category),
                iconBackgroundColor: iconBackgroundColor(for: category)
            )
        }

        return MealsSummaryData(meals: meals)
    }

    private func productSummary(
        for entries: [MealEntry],
        emptyText: String
    ) -> String {
        guard !entries.isEmpty else { return emptyText }

        return entries
            .map { $0.product.name }
            .joined(separator: ", ")
    }

    private func iconTintColor(for category: MealCategory) -> UIColor {
        switch category.sortOrder {
        case 0:
            return .systemOrange
        case 1:
            return .systemOrange
        case 2:
            return .systemPurple
        default:
            return .systemBlue
        }
    }

    private func iconBackgroundColor(for category: MealCategory) -> UIColor {
        iconTintColor(for: category).withAlphaComponent(Constants.iconBackgroundAlpha)
    }
}
