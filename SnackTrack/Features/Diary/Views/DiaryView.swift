//
//  DiaryView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

import UIKit
import SnapKit

extension DiaryView {
    private struct Appearance {
        static let stackViewSpacing = 16.0
        static let horizontalOffset = 16.0
    }
}

/// Корневая view экрана дневника, собирающая все секции в вертикальный scroll.
final class DiaryView: UIView {
    /// Вызывается при нажатии на добавление продукта в приём пищи.
    var onAddMealTap: ((MealRowData) -> Void)?

    /// Вызывается при нажатии на редактирование списка приёмов пищи.
    var onEditTap: (() -> Void)?

    /// Вызывается при выборе приёма пищи.
    var onMealTap: ((MealRowData) -> Void)?

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let headerView = DiaryHeaderView()
    private let calorieSummaryView = CalorieSummaryView()
    private let macrosSummaryView = MacrosSummaryView()
    private let mealsSummaryView = MealsSummaryView()

    init() {
        super.init(frame: .zero)
        setupAppearance()
        addSubviews()
        makeConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Обновляет все секции экрана подготовленными данными дневника.
    func configure(with viewData: DiaryViewData) {
        headerView.configure(with: viewData.headerModel)
        calorieSummaryView.configure(with: viewData.calorieSummary)
        macrosSummaryView.configure(with: viewData.macrosSummary)
        mealsSummaryView.configure(with: viewData.mealsSummary)
    }

    private func setupAppearance() {
        backgroundColor = .systemBackground

        stackView.axis = .vertical
        stackView.spacing = Appearance.stackViewSpacing
        stackView.alignment = .fill

        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
    }

    private func setupActions() {
        mealsSummaryView.onEditTap = { [weak self] in
            self?.onEditTap?()
        }
        mealsSummaryView.onMealTap = { [weak self] data in
            self?.onMealTap?(data)
        }
        mealsSummaryView.onAddMealTap = { [weak self] data in
            self?.onAddMealTap?(data)
        }
    }

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(calorieSummaryView)
        stackView.addArrangedSubview(macrosSummaryView)
        stackView.addArrangedSubview(mealsSummaryView)
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView.contentLayoutGuide)
            make.leading.trailing.equalTo(scrollView.contentLayoutGuide)
                .inset(Appearance.horizontalOffset)
            make.width.equalTo(scrollView.frameLayoutGuide)
                .offset(-Appearance.horizontalOffset * 2)
        }
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
}

#if DEBUG
import SwiftUI

private struct DiaryViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> DiaryView {
        let view = DiaryView()
        view.configure(with: .mock)
        return view
    }

    func updateUIView(_ uiView: DiaryView, context: Context) {}
}

#Preview {
    DiaryViewPreview()
        .ignoresSafeArea()
}
#endif
