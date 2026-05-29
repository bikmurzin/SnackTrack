//
//  MacroItemView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 29.05.2026.
//

import UIKit
import SnapKit

extension MacroItemView {
    private struct Constants {
        static let verticalSpacing = 8.0
        static let valueStackSpacing = 4.0

        static let progressWidth = 82.0

        static let titleFontSize = 16.0
        static let valueFontSize = 26.0
        static let unitFontSize = 18.0
        static let goalFontSize = 14.0

        static let progressMinimumScaleFactor = 0.8
    }

    private struct Texts {
        static func goal(_ value: Int, unit: String) -> String {
            "из \(value) \(unit)"
        }
    }
}

final class MacroItemView: UIView {
    private let stackView = UIStackView()

    private let titleLabel = UILabel()

    private let valueStackView = UIStackView()
    private let valueLabel = UILabel()
    private let unitLabel = UILabel()

    private let progressView = UIProgressView(progressViewStyle: .default)

    private let goalLabel = UILabel()

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupAppearance()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with data: MacroItemData) {
        titleLabel.text = data.title
        titleLabel.textColor = data.color

        valueLabel.text = String(data.currentValue)
        unitLabel.text = data.unit

        goalLabel.text = Texts.goal(data.goalValue, unit: data.unit)

        progressView.progressTintColor = data.color
        progressView.setProgress(Float(data.progress), animated: false)
    }

    private func addSubviews() {
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueStackView)
        stackView.addArrangedSubview(progressView)
        stackView.addArrangedSubview(goalLabel)

        valueStackView.addArrangedSubview(valueLabel)
        valueStackView.addArrangedSubview(unitLabel)
    }

    private func setupAppearance() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.verticalSpacing
        stackView.distribution = .fill

        titleLabel.font = .systemFont(
            ofSize: Constants.titleFontSize,
            weight: .medium
        )
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = Constants.progressMinimumScaleFactor

        valueStackView.axis = .horizontal
        valueStackView.alignment = .lastBaseline
        valueStackView.spacing = Constants.valueStackSpacing

        valueLabel.font = .systemFont(
            ofSize: Constants.valueFontSize,
            weight: .semibold
        )
        valueLabel.textColor = .label
        valueLabel.textAlignment = .center

        unitLabel.font = .systemFont(
            ofSize: Constants.unitFontSize,
            weight: .regular
        )
        unitLabel.textColor = .label

        progressView.trackTintColor = .systemGray5
        progressView.progress = 0

        goalLabel.font = .systemFont(
            ofSize: Constants.goalFontSize,
            weight: .regular
        )
        goalLabel.textColor = .secondaryLabel
        goalLabel.textAlignment = .center
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }

        progressView.snp.makeConstraints { make in
            make.width.equalTo(Constants.progressWidth)
        }
    }
}
