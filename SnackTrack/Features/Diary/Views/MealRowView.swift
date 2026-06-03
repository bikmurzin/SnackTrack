//
//  MealRowView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 29.05.2026.
//

import UIKit
import SnapKit

extension MealRowView {
    private struct Appearance {
        static let horizontalOffset = 18.0
        static let verticalOffset = 14.0

        static let iconSize = 44.0
        static let iconCornerRadius = iconSize / 2
        static let iconImagePointSize = 22.0

        static let contentLeftOffset = 14.0
        static let addButtonLeftOffset = 12.0

        static let titleCaloriesSpacing = 8.0
        static let titleToSubtitleOffset = 4.0

        static let addButtonSize = 30.0
        static let addButtonImagePointSize = 14.0
        static let addButtonBorderWidth = 1.3

        static let titleFontSize = 17.0
        static let caloriesFontSize = 15.0
        static let subtitleFontSize = 15.0
    }

    private struct Texts {
        static func calories(_ value: Int) -> String {
            "\(value) ккал"
        }
    }
}

/// Строка приёма пищи с иконкой, названием, калориями и кнопкой добавления.
final class MealRowView: UIView {
    /// Вызывается при нажатии на строку.
    var onTap: (() -> Void)?

    /// Вызывается при нажатии на кнопку добавления продукта.
    var onAddTap: (() -> Void)?

    private let iconContainerView = UIView()
    private let iconImageView = UIImageView()

    private let textStackView = UIStackView()
    private let titleStackView = UIStackView()
    private let titleLabel = UILabel()
    private let caloriesLabel = UILabel()
    private let subtitleLabel = UILabel()

    private let addButton = UIButton(type: .system)

    private var data: MealRowData?

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupAppearance()
        makeConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Обновляет отображение строки данными приёма пищи.
    func configure(with data: MealRowData) {
        self.data = data

        titleLabel.text = data.title
        caloriesLabel.text = Texts.calories(data.calories)
        subtitleLabel.text = data.subtitle

        iconContainerView.backgroundColor = data.iconBackgroundColor
        iconImageView.tintColor = data.iconTintColor

        let configuration = UIImage.SymbolConfiguration(
            pointSize: Appearance.iconImagePointSize,
            weight: .regular
        )
        iconImageView.image = UIImage(
            systemName: data.iconSystemName,
            withConfiguration: configuration
        )
    }

    private func addSubviews() {
        addSubview(iconContainerView)
        addSubview(textStackView)
        addSubview(addButton)

        iconContainerView.addSubview(iconImageView)

        textStackView.addArrangedSubview(titleStackView)
        textStackView.addArrangedSubview(subtitleLabel)

        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(caloriesLabel)
    }

    private func setupAppearance() {
        backgroundColor = .clear

        iconContainerView.layer.cornerRadius = Appearance.iconCornerRadius
        iconContainerView.layer.cornerCurve = .continuous

        iconImageView.contentMode = .scaleAspectFit

        textStackView.axis = .vertical
        textStackView.alignment = .leading
        textStackView.spacing = Appearance.titleToSubtitleOffset

        titleStackView.axis = .horizontal
        titleStackView.alignment = .lastBaseline
        titleStackView.spacing = Appearance.titleCaloriesSpacing

        titleLabel.font = .systemFont(
            ofSize: Appearance.titleFontSize,
            weight: .semibold
        )
        titleLabel.textColor = .label

        caloriesLabel.font = .systemFont(
            ofSize: Appearance.caloriesFontSize,
            weight: .regular
        )
        caloriesLabel.textColor = .secondaryLabel

        subtitleLabel.font = .systemFont(
            ofSize: Appearance.subtitleFontSize,
            weight: .regular
        )
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 1

        addButton.layer.cornerRadius = Appearance.addButtonSize / 2
        addButton.layer.borderWidth = Appearance.addButtonBorderWidth
        addButton.layer.borderColor = UIColor.systemBlue.cgColor
        addButton.tintColor = .systemBlue

        let addConfiguration = UIImage.SymbolConfiguration(
            pointSize: Appearance.addButtonImagePointSize,
            weight: .regular
        )
        addButton.setImage(
            UIImage(systemName: "plus", withConfiguration: addConfiguration),
            for: .normal
        )
    }

    private func makeConstraints() {
        iconContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Appearance.horizontalOffset)
            make.centerY.equalToSuperview()
            make.size.equalTo(Appearance.iconSize)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        textStackView.snp.makeConstraints { make in
            make.leading.equalTo(iconContainerView.snp.trailing).offset(Appearance.contentLeftOffset)
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(Appearance.verticalOffset)
            make.bottom.lessThanOrEqualToSuperview().inset(Appearance.verticalOffset)
            make.trailing.lessThanOrEqualTo(addButton.snp.leading).offset(-Appearance.addButtonLeftOffset)
        }

        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Appearance.horizontalOffset)
            make.centerY.equalToSuperview()
            make.size.equalTo(Appearance.addButtonSize)
        }

        snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(68)
        }
    }

    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(rowTapped)
        )
        addGestureRecognizer(tapGesture)

        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside
        )
    }

    @objc private func rowTapped() {
        onTap?()
    }

    @objc private func addButtonTapped() {
        onAddTap?()
    }
}
