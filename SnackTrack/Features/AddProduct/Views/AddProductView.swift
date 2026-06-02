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

final class AddProductView: UIView {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private let mealPickerView = MealPickerView()

    init() {
        super.init(frame: .zero)
        setupAppearance()
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: AddProductViewData) {
        mealPickerView.configure(with: data.mealOptions)
    }

    private func setupAppearance() {
        backgroundColor = .systemBackground

        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true

        stackView.axis = .vertical
        stackView.spacing = Appearance.stackViewSpacing
        stackView.alignment = .fill
    }

    private func addSubviews() {
        addSubview(scrollView)

        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(mealPickerView)
    }

    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView.contentLayoutGuide)
            make.leading.trailing.equalTo(scrollView.contentLayoutGuide)
                .inset(Appearance.horizontalOffset)
            make.width.equalTo(scrollView.frameLayoutGuide)
                .offset(-Appearance.horizontalOffset * 2)
        }
    }
    
#if DEBUG
func configureMock() {
    mealPickerView.configure(with: MealOptionData.mockItems)
}

#endif
}

#if DEBUG
import SwiftUI

private struct AddProductViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> AddProductView {
        let view = AddProductView()
        view.configureMock()
        return view
    }

    func updateUIView(_ uiView: AddProductView, context: Context) {}
}

#Preview {
    AddProductViewPreview()
        .ignoresSafeArea()
}
#endif
