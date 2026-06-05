//
//  DiaryHeaderView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

import SnapKit
import UIKit

extension DiaryHeaderView {
    private struct Appearance {
        static let verticalOffset = 4.0
        static let dateLabelTopOffset = 4.0
        static let horizontalOffsetBetweenElements = 12.0

        static let profileButtonSize = 44.0
        static let profileButtonCornerRadius = profileButtonSize / 2

        static let dateLabelFontSize = 20.0
        static let labelsNumberOfLines = 0
    }

    private struct Images {
        static let profileIconName = "person.crop.circle.fill"
    }
}

/// View заголовка дневника с названием дня, датой и кнопкой профиля.
final class DiaryHeaderView: UIView {
    private let dayNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let profileButton = UIButton(type: .system)

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupAppearance()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Заполняет заголовок названием дня и датой.
    func configure(with data: DiaryHeaderData) {
        dayNameLabel.text = data.dayName
        dateLabel.text = data.date
    }

    private func addSubviews() {
        addSubview(dayNameLabel)
        addSubview(dateLabel)
        addSubview(profileButton)
    }

    private func makeConstraints() {
        dayNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(Appearance.verticalOffset)
            make.trailing.lessThanOrEqualTo(profileButton.snp.leading)
                .offset(-Appearance.horizontalOffsetBetweenElements)
        }

        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayNameLabel)
            make.top.equalTo(dayNameLabel.snp.bottom).offset(Appearance.dateLabelTopOffset)
            make.trailing.lessThanOrEqualTo(profileButton.snp.leading)
                .offset(-Appearance.horizontalOffsetBetweenElements)
            make.bottom.equalToSuperview().inset(Appearance.verticalOffset)
        }

        profileButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Appearance.verticalOffset)
            make.trailing.equalToSuperview()
            make.size.equalTo(Appearance.profileButtonSize)
        }
    }

    private func setupAppearance() {
        dayNameLabel.font = .preferredFont(forTextStyle: .largeTitle)
        dayNameLabel.adjustsFontForContentSizeCategory = true
        dayNameLabel.numberOfLines = Appearance.labelsNumberOfLines

        let dateLabelFont = UIFont.systemFont(
            ofSize: Appearance.dateLabelFontSize,
            weight: .regular
        )
        dateLabel.font = UIFontMetrics(forTextStyle: .title3)
            .scaledFont(for: dateLabelFont)
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.textColor = .secondaryLabel
        dateLabel.numberOfLines = Appearance.labelsNumberOfLines

        profileButton.backgroundColor = .secondarySystemBackground
        profileButton.layer.cornerRadius = Appearance.profileButtonCornerRadius
        profileButton.setImage(UIImage(systemName: Images.profileIconName), for: .normal)
        profileButton.tintColor = .label
        profileButton.clipsToBounds = true
    }
}
