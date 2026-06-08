//
//  AddProductActionsView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 02.06.2026.
//

import UIKit
import SnapKit

extension AddProductActionsView {
    private struct Appearance {
        static let buttonsSpacing = 12.0
        
        static let barcodeButtonData = AddProductActionData(
            title: "Сканировать штрих-код",
            iconSystemName: "barcode.viewfinder",
            tintColor: .systemBlue
        )
        
        static let createNewProductButtonData = AddProductActionData(
            title: "Создать новый продукт",
            iconSystemName: "plus.circle",
            tintColor: .systemBlue
        )
    }
}

/// View действий для добавления продукта.
final class AddProductActionsView: UIView {
    /// Вызывается при выборе сканирования штрих-кода.
    var onBarcodeTap: (() -> Void)?

    /// Вызывается при выборе создания нового продукта.
    var createNewProductTap: (() -> Void)?

    private let stackView = UIStackView()

    private let barcodeButtonView = AddProductActionButtonView()
    private let createNewProductButtonView = AddProductActionButtonView()

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

    private func addSubviews() {
        addSubview(stackView)

        stackView.addArrangedSubview(barcodeButtonView)
        stackView.addArrangedSubview(createNewProductButtonView)
    }

    private func setupAppearance() {
        backgroundColor = .clear

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Appearance.buttonsSpacing
        
        barcodeButtonView.configure(with: Appearance.barcodeButtonData)
        createNewProductButtonView.configure(with: Appearance.createNewProductButtonData)
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupActions() {
        barcodeButtonView.addTarget(
            self,
            action: #selector(barcodeButtonTapped),
            for: .touchUpInside
        )

        createNewProductButtonView.addTarget(
            self,
            action: #selector(createNewProductButtonTapped),
            for: .touchUpInside
        )
    }

    @objc private func barcodeButtonTapped() {
        onBarcodeTap?()
    }

    @objc private func createNewProductButtonTapped() {
        createNewProductTap?()
    }
}
