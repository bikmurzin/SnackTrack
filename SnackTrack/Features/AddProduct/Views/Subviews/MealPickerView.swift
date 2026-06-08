//
//  MealPickerView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

import UIKit
import SnapKit

extension MealPickerView {
    private struct Appearance {
        static let titleToContainerOffset = 10.0

        static let containerCornerRadius = 18.0
        static let containerVerticalOffset = 12.0
        static let containerHorizontalOffset = 12.0

        static let optionsSpacing = 10.0

        static let titleFontSize = 13.0

        static let optionHeight = 74.0

        static let shadowOpacity = 0.06
        static let shadowRadius = 14.0
        static let shadowOffset = CGSize(width: 0, height: 6)
    }

    private struct Texts {
        static let title = "ПРИЕМ ПИЩИ"
    }
}

/// View выбора приёма пищи для добавляемого продукта.
final class MealPickerView: UIView {
    /// Вызывается при выборе варианта приёма пищи.
    var onMealTap: ((MealOptionData) -> Void)?

    private let titleLabel = UILabel()
    private let containerView = UIView()
    private let optionsStackView = UIStackView()

    init() {
        super.init(frame: .zero)

        addSubviews()
        setupAppearance()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Перестраивает варианты приёмов пищи.
    func configure(with options: [MealOptionData]) {
        optionsStackView.arrangedSubviews.forEach {
            optionsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        options.forEach { option in
            let optionView = MealOptionView(option: option)

            optionView.addAction(
                UIAction { [weak self] _ in
                    self?.onMealTap?(option)
                },
                for: .touchUpInside
            )

            optionsStackView.addArrangedSubview(optionView)

            optionView.snp.makeConstraints { make in
                make.height.equalTo(Appearance.optionHeight)
            }
        }
    }

    /// Обновляет путь тени контейнера после расчёта размеров.
    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.shadowPath = UIBezierPath(
            roundedRect: containerView.bounds,
            cornerRadius: Appearance.containerCornerRadius
        ).cgPath
    }

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(containerView)

        containerView.addSubview(optionsStackView)
    }

    private func setupAppearance() {
        backgroundColor = .clear

        titleLabel.text = Texts.title
        titleLabel.font = .systemFont(
            ofSize: Appearance.titleFontSize,
            weight: .semibold
        )
        titleLabel.textColor = .secondaryLabel
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = Appearance.containerCornerRadius
        containerView.layer.cornerCurve = .continuous
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = Float(Appearance.shadowOpacity)
        containerView.layer.shadowRadius = Appearance.shadowRadius
        containerView.layer.shadowOffset = Appearance.shadowOffset

        optionsStackView.axis = .horizontal
        optionsStackView.alignment = .fill
        optionsStackView.distribution = .fillEqually
        optionsStackView.spacing = Appearance.optionsSpacing
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Appearance.titleToContainerOffset)
            make.horizontalEdges.bottom.equalToSuperview()
        }

        optionsStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(Appearance.containerVerticalOffset)
            make.horizontalEdges.equalToSuperview().inset(Appearance.containerHorizontalOffset)
        }
    }
}
