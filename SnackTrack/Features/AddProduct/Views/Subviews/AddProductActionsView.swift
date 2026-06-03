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
    }
}

final class AddProductActionsView: UIView {
    var onBarcodeTap: (() -> Void)?
    var onVoiceInputTap: (() -> Void)?

    private let stackView = UIStackView()

    private let barcodeButtonView = AddProductActionButtonView()
    private let voiceInputButtonView = AddProductActionButtonView()

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

    func configure(with data: AddProductActionsData) {
        barcodeButtonView.configure(with: data.barcodeAction)
        voiceInputButtonView.configure(with: data.voiceInputAction)
    }

    private func addSubviews() {
        addSubview(stackView)

        stackView.addArrangedSubview(barcodeButtonView)
        stackView.addArrangedSubview(voiceInputButtonView)
    }

    private func setupAppearance() {
        backgroundColor = .clear

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Appearance.buttonsSpacing
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

        voiceInputButtonView.addTarget(
            self,
            action: #selector(voiceInputButtonTapped),
            for: .touchUpInside
        )
    }

    @objc private func barcodeButtonTapped() {
        onBarcodeTap?()
    }

    @objc private func voiceInputButtonTapped() {
        onVoiceInputTap?()
    }
}
