//
//  MealOptionView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

import UIKit
import SnapKit

extension MealOptionView {
    private struct Appearance {
        static let contentVerticalOffset = 10.0
        static let contentHorizontalOffset = 8.0

        static let cornerRadius = 16.0

        static let stackSpacing = 6.0

        static let iconPointSize = 24.0
        static let titleFontSize = 10.0
        static let titleMinimumScaleFactor = 0.8

        static let selectedBackgroundAlpha = 0.12
        static let unselectedBackgroundColor = UIColor.secondarySystemBackground
    }
}

/// Интерактивная карточка одного варианта приёма пищи.
final class MealOptionView: UIControl {
    private let stackView = UIStackView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    
    init(option: MealOptionData) {
        super.init(frame: .zero)
        addSubviews()
        setupAppearance()
        makeConstraints()
        configure(with: option)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(with data: MealOptionData) {
        titleLabel.text = data.title
        titleLabel.textColor = data.isSelected ? data.tintColor : .secondaryLabel

        iconImageView.tintColor = data.isSelected ? data.tintColor : .secondaryLabel

        let configuration = UIImage.SymbolConfiguration(
            pointSize: Appearance.iconPointSize,
            weight: .regular
        )

        iconImageView.image = UIImage(
            systemName: data.iconSystemName,
            withConfiguration: configuration
        )

        backgroundColor = data.isSelected
            ? data.tintColor.withAlphaComponent(Appearance.selectedBackgroundAlpha)
            : Appearance.unselectedBackgroundColor
    }

    private func addSubviews() {
        addSubview(stackView)

        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
    }

    private func setupAppearance() {
        layer.cornerRadius = Appearance.cornerRadius
        layer.cornerCurve = .continuous

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Appearance.stackSpacing
        stackView.isUserInteractionEnabled = false

        iconImageView.contentMode = .scaleAspectFit

        titleLabel.font = .systemFont(
            ofSize: Appearance.titleFontSize,
            weight: .semibold
        )
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = Appearance.titleMinimumScaleFactor
        titleLabel.numberOfLines = 1
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(Appearance.contentVerticalOffset)
            make.horizontalEdges.equalToSuperview().inset(Appearance.contentHorizontalOffset)
        }
    }
}
