//
//  AddProductView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

import UIKit
import SnapKit

extension AddProductView {
    private struct Appearance {
        static let stackViewSpacing = 24.0
        static let horizontalOffset = 16.0
    }
}

/// Корневая view экрана добавления продукта с выбором приёма пищи, поиском и недавними продуктами.
final class AddProductView: UIView {
    private let stackView = UIStackView()

    private let mealPickerView = MealPickerView()
    private let productSearchView = ProductSearchView()
    private let addProductActionsView = AddProductActionsView()
    private let recentProductsView = RecentProductsView()

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

    /// Обновляет секции экрана подготовленными данными.
    func configure(with data: AddProductViewData) {
        mealPickerView.configure(with: data.mealOptions)
        
        // TODO: Вынести данные для кнопок штрихкода и голосового ввода из моков
        addProductActionsView.configure(with: AddProductActionsData.mock)
        
        recentProductsView.configure(with: data.recentProductsData)
    }

    private func setupAppearance() {
        backgroundColor = .systemBackground

        stackView.axis = .vertical
        stackView.spacing = Appearance.stackViewSpacing
        stackView.alignment = .fill
    }

    private func setupActions() {
        productSearchView.onTextChanged = { text in
            print("search text:", text)
        }

        productSearchView.onSearchButtonTap = { text in
            print("search button tapped:", text)
        }
        
        mealPickerView.onMealTap = { data in
            
        }
    }

    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(mealPickerView)
        stackView.addArrangedSubview(productSearchView)
        stackView.addArrangedSubview(addProductActionsView)
        stackView.addArrangedSubview(recentProductsView)
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(Appearance.horizontalOffset)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
