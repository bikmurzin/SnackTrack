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
        static let horizontalOffset = 24.0
        static let verticalOffset = 12.0
        static let dateLabelTopOffset = 4.0
        static let horizontalOffsetBetweenElements = 12.0
        static let profileButtonSize = 44.0
    }
}

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
            make.leading.equalToSuperview().offset(Appearance.horizontalOffset)
            make.top.equalToSuperview().offset(Appearance.verticalOffset)
            make.trailing.lessThanOrEqualTo(profileButton.snp.leading).offset(-Appearance.horizontalOffsetBetweenElements)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayNameLabel)
            make.bottom.equalToSuperview().inset(Appearance.verticalOffset)
            make.top.equalTo(dayNameLabel.snp.bottom).offset(Appearance.dateLabelTopOffset)
            make.trailing.lessThanOrEqualTo(profileButton.snp.leading).offset(-Appearance.horizontalOffsetBetweenElements)
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Appearance.horizontalOffset)
            make.trailing.equalToSuperview().inset(Appearance.horizontalOffset)
            make.size.equalTo(Appearance.profileButtonSize)
        }
    }
    
    private func setupAppearance() {
        dayNameLabel.font = .preferredFont(forTextStyle: .largeTitle)
        dayNameLabel.adjustsFontForContentSizeCategory = true
        dayNameLabel.numberOfLines = 0
        
        let dateLabelFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        dateLabel.font = UIFontMetrics(forTextStyle: .title3).scaledFont(for: dateLabelFont)
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.textColor = .secondaryLabel
        dateLabel.numberOfLines = 0
        
        profileButton.backgroundColor = .secondarySystemBackground
        profileButton.layer.cornerRadius = Appearance.profileButtonSize / 2
        profileButton.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
        profileButton.tintColor = .label
        profileButton.clipsToBounds = true
    }
}
