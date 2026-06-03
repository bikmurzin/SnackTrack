//
//  MealsSummaryView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 29.05.2026.
//

import UIKit
import SnapKit

extension MealsSummaryView {
    private struct Appearance {
        static let titleToCardOffset = 12.0

        static let cardCornerRadius = 24.0
        static let cardVerticalInset = 4.0

        static let shadowOpacity = 0.08
        static let shadowRadius = 16.0
        static let shadowOffset = CGSize(width: 0, height: 4)

        static let titleFontSize = 20.0
        static let editButtonFontSize = 17.0

        static let titleToEditButtonMinOffset = 12.0
    }

    private struct Texts {
        static let title = "Приёмы пищи"
        static let edit = "Изменить"
    }
}

/// View списка приёмов пищи с возможностью выбора строки и добавления продукта.
final class MealsSummaryView: UIView {
    /// Вызывается при нажатии на кнопку редактирования.
    var onEditTap: (() -> Void)?

    /// Вызывается при выборе строки приёма пищи.
    var onMealTap: ((MealRowData) -> Void)?

    /// Вызывается при нажатии на добавление продукта в строке приёма пищи.
    var onAddMealTap: ((MealRowData) -> Void)?

    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let editButton = UIButton(type: .system)

    private let cardView = UIView()
    private let rowsStackView = UIStackView()

    private var meals: [MealRowData] = []

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

    /// Перестраивает список строк приёмов пищи.
    func configure(with data: MealsSummaryData) {
        meals = data.meals

        rowsStackView.arrangedSubviews.forEach {
            rowsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        data.meals.enumerated().forEach { index, meal in
            let rowView = MealRowView()
            rowView.configure(with: meal)

            rowView.onTap = { [weak self] in
                self?.onMealTap?(meal)
            }

            rowView.onAddTap = { [weak self] in
                self?.onAddMealTap?(meal)
            }

            rowsStackView.addArrangedSubview(rowView)

            if index < data.meals.count - 1 {
                rowsStackView.addArrangedSubview(makeSeparatorView())
            }
        }
    }

    /// Обновляет путь тени карточки после расчёта финальных размеров.
    override func layoutSubviews() {
        super.layoutSubviews()

        cardView.layer.shadowPath = UIBezierPath(
            roundedRect: cardView.bounds,
            cornerRadius: Appearance.cardCornerRadius
        ).cgPath
    }

    private func addSubviews() {
        addSubview(headerView)
        addSubview(cardView)

        headerView.addSubview(titleLabel)
        headerView.addSubview(editButton)

        cardView.addSubview(rowsStackView)
    }

    private func setupAppearance() {
        titleLabel.text = Texts.title
        titleLabel.font = .systemFont(
            ofSize: Appearance.titleFontSize,
            weight: .medium
        )
        titleLabel.textColor = .label

        editButton.setTitle(Texts.edit, for: .normal)
        editButton.titleLabel?.font = .systemFont(
            ofSize: Appearance.editButtonFontSize,
            weight: .regular
        )

        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = Appearance.cardCornerRadius
        cardView.layer.cornerCurve = .continuous
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = Float(Appearance.shadowOpacity)
        cardView.layer.shadowRadius = Appearance.shadowRadius
        cardView.layer.shadowOffset = Appearance.shadowOffset

        rowsStackView.axis = .vertical
        rowsStackView.spacing = 0
    }

    private func makeConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }

        editButton.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(Appearance.titleToEditButtonMinOffset)
        }

        cardView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(Appearance.titleToCardOffset)
            make.horizontalEdges.bottom.equalToSuperview()
        }

        rowsStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(Appearance.cardVerticalInset)
            make.horizontalEdges.equalToSuperview()
        }
    }

    private func setupActions() {
        editButton.addTarget(
            self,
            action: #selector(editButtonTapped),
            for: .touchUpInside
        )
    }

    private func makeSeparatorView() -> UIView {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray5

        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }

        return separatorView
    }

    @objc private func editButtonTapped() {
        onEditTap?()
    }
}
