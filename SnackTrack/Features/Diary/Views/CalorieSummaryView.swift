//
//  CalorieSummaryView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 28.05.2026.
//

import UIKit
import SnapKit

extension CalorieSummaryView {
    private struct Constants {
        static let horizontalOffset = 24.0
        static let verticalOffset = 18.0
        static let cornerRadius = 24.0

        static let titleToCaloriesOffset = 10.0
        static let caloriesToGoalOffset = 4.0
        static let goalToConsumedOffset = 18.0

        static let contentToCircularProgressOffset = 16.0

        static let circularProgressSize = 120.0
        static let caloriesStackSpacing = 8.0

        static let caloriesFontSize = 48.0
        static let caloriesMinimumScaleFactor = 0.75
        static let caloriesUnitFontSize = 18.0
        static let goalFontSize = 18.0
        static let consumedLabelFontSize = 14.0

        static let shadowOpacity = 0.08
        static let shadowRadius = 16.0
        static let shadowOffset = CGSize(width: 0, height: 4)
    }

    private struct Texts {
        static let title = "Осталось"
        static let calorieUnit = "ккал"
        static let circularProgressSubtitle = "от цели"

        static func goal(_ calories: Int) -> String {
            "из \(calories.formattedWithSeparator) ккал"
        }

        static func consumed(_ calories: Int) -> String {
            "Съедено: \(calories.formattedWithSeparator) ккал"
        }

        static func progressPercent(_ progress: Double) -> String {
            "\(Int(progress * 100))%"
        }
    }
}

final class CalorieSummaryView: UIView {
    private let titleLabel = UILabel()
    private let caloriesStackView = UIStackView()
    private let caloriesLabel = UILabel()
    private let caloriesUnitLabel = UILabel()
    private let goalLabel = UILabel()

    private let circularProgressView = CircularProgressView()

    private let consumedLabel = UILabel()

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupAppearance()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with data: CalorieSummaryData) {
        titleLabel.text = Texts.title
        caloriesLabel.text = data.remainingCalories.formattedWithSeparator
        goalLabel.text = Texts.goal(data.goalCalories)
        consumedLabel.text = Texts.consumed(data.consumedCalories)

        circularProgressView.setProgress(data.progress)
        circularProgressView.centerText = Texts.progressPercent(data.progress)
        circularProgressView.bottomText = Texts.circularProgressSubtitle
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: Constants.cornerRadius
        ).cgPath
    }

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(caloriesStackView)
        addSubview(goalLabel)
        addSubview(circularProgressView)
        addSubview(consumedLabel)

        caloriesStackView.addArrangedSubview(caloriesLabel)
        caloriesStackView.addArrangedSubview(caloriesUnitLabel)
    }

    private func setupAppearance() {
        backgroundColor = .systemBackground

        layer.cornerRadius = Constants.cornerRadius
        layer.cornerCurve = .continuous
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = Float(Constants.shadowOpacity)
        layer.shadowRadius = Constants.shadowRadius
        layer.shadowOffset = Constants.shadowOffset

        titleLabel.font = .preferredFont(forTextStyle: .title3)
        titleLabel.textColor = .secondaryLabel
        titleLabel.adjustsFontForContentSizeCategory = true

        caloriesStackView.axis = .horizontal
        caloriesStackView.alignment = .lastBaseline
        caloriesStackView.spacing = Constants.caloriesStackSpacing

        caloriesLabel.font = .systemFont(
            ofSize: Constants.caloriesFontSize,
            weight: .bold
        )
        caloriesLabel.textColor = .systemGreen
        caloriesLabel.adjustsFontSizeToFitWidth = true
        caloriesLabel.minimumScaleFactor = Constants.caloriesMinimumScaleFactor

        caloriesUnitLabel.text = Texts.calorieUnit
        caloriesUnitLabel.font = .systemFont(
            ofSize: Constants.caloriesUnitFontSize,
            weight: .medium
        )
        caloriesUnitLabel.textColor = .secondaryLabel

        goalLabel.font = .systemFont(
            ofSize: Constants.goalFontSize,
            weight: .regular
        )
        goalLabel.textColor = .secondaryLabel

        consumedLabel.font = .systemFont(
            ofSize: Constants.consumedLabelFontSize,
            weight: .regular
        )
        consumedLabel.textColor = .secondaryLabel
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Constants.verticalOffset)
            make.trailing.lessThanOrEqualTo(circularProgressView.snp.leading)
                .offset(-Constants.contentToCircularProgressOffset)
        }

        caloriesStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.titleToCaloriesOffset)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(circularProgressView.snp.leading)
                .offset(-Constants.contentToCircularProgressOffset)
        }

        goalLabel.snp.makeConstraints { make in
            make.top.equalTo(caloriesStackView.snp.bottom).offset(Constants.caloriesToGoalOffset)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualTo(circularProgressView.snp.leading)
                .offset(-Constants.contentToCircularProgressOffset)
        }

        circularProgressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalOffset)
            make.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            make.size.equalTo(Constants.circularProgressSize)
        }

        consumedLabel.snp.makeConstraints { make in
            make.top.equalTo(goalLabel.snp.bottom).offset(Constants.goalToConsumedOffset)
            make.leading.equalTo(titleLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(Constants.horizontalOffset)
            make.bottom.equalToSuperview().inset(Constants.verticalOffset)
        }
    }
}
