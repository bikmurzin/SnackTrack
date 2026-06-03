//
//  RecentProductCell.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 03.06.2026.
//

import SnapKit
import UIKit

extension RecentProductCell {
    private struct Appearance {
        static let leftStackViewSpacing: CGFloat = 10
        static let rightStackViewSpacing: CGFloat = 4
        static let horizontalContentPadding: CGFloat = 10
        static let caloriesUnitText = "ккал"
    }
}

final class RecentProductCell: UITableViewCell {
    static let reuseIdentifier: String = "RecentProductCell"
    
    private let titleLabel = UILabel()
    private let weightLabel = UILabel()
    private let caloriesCountLabel = UILabel()
    private let caloriesUnitLabel = UILabel()
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraints()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: RecentProductRowData) {
        titleLabel.text = data.productName
        weightLabel.text = data.weightText
        caloriesCountLabel.text = data.caloriesText
    }
    
    private func setupAppearance() {
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = .label

        weightLabel.font = .preferredFont(forTextStyle: .subheadline)
        weightLabel.adjustsFontForContentSizeCategory = true
        weightLabel.textColor = .secondaryLabel

        caloriesCountLabel.font = .systemFont(
            ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize,
            weight: .medium
        )
        caloriesCountLabel.textColor = .label
        caloriesCountLabel.adjustsFontForContentSizeCategory = true

        caloriesUnitLabel.font = .preferredFont(forTextStyle: .subheadline)
        caloriesUnitLabel.adjustsFontForContentSizeCategory = true
        caloriesUnitLabel.textColor = .secondaryLabel
        caloriesUnitLabel.text = Appearance.caloriesUnitText
        
        leftStackView.axis = .vertical
        leftStackView.spacing = Appearance.leftStackViewSpacing
        
        rightStackView.axis = .horizontal
        rightStackView.spacing = Appearance.rightStackViewSpacing
    }
    
    private func addSubviews() {
        contentView.addSubview(leftStackView)
        contentView.addSubview(rightStackView)
        leftStackView.addArrangedSubview(titleLabel)
        leftStackView.addArrangedSubview(weightLabel)
        rightStackView.addArrangedSubview(caloriesCountLabel)
        rightStackView.addArrangedSubview(caloriesUnitLabel)
    }
    
    private func makeConstraints() {
        leftStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Appearance.horizontalContentPadding)
            make.trailing.lessThanOrEqualTo(rightStackView).offset(-Appearance.horizontalContentPadding)
        }
        rightStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(Appearance.horizontalContentPadding)
        }
    }
}
