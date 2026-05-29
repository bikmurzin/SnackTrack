//
//  MacrosSummaryView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 29.05.2026.
//

import UIKit
import SnapKit

extension MacrosSummaryView {
    private struct Constants {
        static let cornerRadius = 24.0

        static let verticalOffset = 20.0
        static let horizontalOffset = 8.0

        static let stackSpacing = 0.0

        static let separatorWidth = 1.0
        static let separatorVerticalInset = 16.0

        static let shadowOpacity = 0.08
        static let shadowRadius = 16.0
        static let shadowOffset = CGSize(width: 0, height: 4)
    }
}

final class MacrosSummaryView: UIView {
    private let contentStackView = UIStackView()

    private let proteinsView = MacroItemView()
    private let fatsView = MacroItemView()
    private let carbsView = MacroItemView()

    private let firstSeparatorView = UIView()
    private let secondSeparatorView = UIView()

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupAppearance()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with data: MacrosSummaryData) {
        proteinsView.configure(with: data.proteins)
        fatsView.configure(with: data.fats)
        carbsView.configure(with: data.carbs)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: Constants.cornerRadius
        ).cgPath
    }

    private func addSubviews() {
        addSubview(contentStackView)

        contentStackView.addArrangedSubview(proteinsView)
        contentStackView.addArrangedSubview(firstSeparatorView)
        contentStackView.addArrangedSubview(fatsView)
        contentStackView.addArrangedSubview(secondSeparatorView)
        contentStackView.addArrangedSubview(carbsView)
    }

    private func setupAppearance() {
        backgroundColor = .systemBackground

        layer.cornerRadius = Constants.cornerRadius
        layer.cornerCurve = .continuous
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = Float(Constants.shadowOpacity)
        layer.shadowRadius = Constants.shadowRadius
        layer.shadowOffset = Constants.shadowOffset

        contentStackView.axis = .horizontal
        contentStackView.spacing = Constants.stackSpacing
        contentStackView.alignment = .center

        firstSeparatorView.backgroundColor = .separator
        secondSeparatorView.backgroundColor = .separator
    }

    private func makeConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(Constants.verticalOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalOffset)
        }

        firstSeparatorView.snp.makeConstraints { make in
            make.width.equalTo(Constants.separatorWidth)
        }

        secondSeparatorView.snp.makeConstraints { make in
            make.width.equalTo(Constants.separatorWidth)
        }

        proteinsView.snp.makeConstraints { make in
            make.width.equalTo(fatsView)
            make.width.equalTo(carbsView)
        }

        firstSeparatorView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.separatorVerticalInset)
        }

        secondSeparatorView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.separatorVerticalInset)
        }
    }
}
