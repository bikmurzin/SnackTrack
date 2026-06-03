//
//  AddProductActionButtonView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 02.06.2026.
//

import UIKit
import SnapKit

extension AddProductActionButtonView {
    private struct Appearance {
        static let height = 52.0

        static let cornerRadius = 16.0

        static let horizontalOffset = 14.0
        static let iconSize = 22.0
        static let iconToTitleOffset = 10.0

        static let titleFontSize = 10.0
        static let titleMinimumScaleFactor = 0.8
    }
}

final class AddProductActionButtonView: UIControl {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupAppearance()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with data: AddProductActionData) {
        titleLabel.text = data.title
        iconImageView.image = UIImage(systemName: data.iconSystemName)
        iconImageView.tintColor = data.tintColor
    }

    private func addSubviews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
    }

    private func setupAppearance() {
        backgroundColor = .secondarySystemBackground

        layer.cornerRadius = Appearance.cornerRadius
        layer.cornerCurve = .continuous

        iconImageView.contentMode = .scaleAspectFit

        titleLabel.font = .systemFont(
            ofSize: Appearance.titleFontSize,
            weight: .semibold
        )
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = Appearance.titleMinimumScaleFactor
        titleLabel.textAlignment = .center
    }

    private func makeConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(Appearance.height)
        }

        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Appearance.horizontalOffset)
            make.centerY.equalToSuperview()
            make.size.equalTo(Appearance.iconSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(Appearance.iconToTitleOffset)
            make.trailing.equalToSuperview().inset(Appearance.horizontalOffset)
            make.centerY.equalToSuperview()
        }
    }
}
