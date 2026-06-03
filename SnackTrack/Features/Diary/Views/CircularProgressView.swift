//
//  CircularProgressView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 28.05.2026.
//

import UIKit
import SnapKit

extension CircularProgressView {
    private struct Appearance {
        static let lineWidth = 11.0
        static let minProgress = 0.0
        static let maxProgress = 1.0

        static let startAngle = -CGFloat.pi / 2
        static let endAngle = 1.5 * CGFloat.pi

        static let labelsSpacing = 2.0

        static let centerLabelFontSize = 28.0
        static let bottomLabelFontSize = 16.0

        static let initialStrokeEnd = 0.0
    }
}

/// Круговой индикатор прогресса с текстом в центре.
final class CircularProgressView: UIView {
    /// Основной текст в центре кругового индикатора.
    var centerText: String = "" {
        didSet { centerLabel.text = centerText }
    }

    /// Дополнительный текст под основным значением.
    var bottomText: String = "" {
        didSet { bottomLabel.text = bottomText }
    }

    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    private let centerLabel = UILabel()
    private let bottomLabel = UILabel()
    private let labelsStackView = UIStackView()

    private var progress: Double = Appearance.initialStrokeEnd

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        setupLabels()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Устанавливает прогресс в диапазоне от 0 до 1.
    func setProgress(_ progress: Double) {
        self.progress = min(
            max(progress, Appearance.minProgress),
            Appearance.maxProgress
        )
        setNeedsLayout()
    }

    /// Перестраивает окружности прогресса под текущий размер view.
    override func layoutSubviews() {
        super.layoutSubviews()

        let radius = (min(bounds.width, bounds.height) - Appearance.lineWidth) / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: Appearance.startAngle,
            endAngle: Appearance.endAngle,
            clockwise: true
        )

        backgroundLayer.path = path.cgPath
        backgroundLayer.lineWidth = Appearance.lineWidth

        progressLayer.path = path.cgPath
        progressLayer.lineWidth = Appearance.lineWidth
        progressLayer.strokeEnd = progress
    }

    private func setupLayers() {
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.systemGray5.cgColor
        backgroundLayer.lineCap = .round

        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.systemGreen.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = Appearance.initialStrokeEnd

        layer.addSublayer(backgroundLayer)
        layer.addSublayer(progressLayer)
    }

    private func setupLabels() {
        addSubview(labelsStackView)

        labelsStackView.axis = .vertical
        labelsStackView.alignment = .center
        labelsStackView.spacing = Appearance.labelsSpacing

        centerLabel.font = .systemFont(
            ofSize: Appearance.centerLabelFontSize,
            weight: .bold
        )
        centerLabel.textColor = .systemGreen
        centerLabel.textAlignment = .center

        bottomLabel.font = .systemFont(
            ofSize: Appearance.bottomLabelFontSize,
            weight: .regular
        )
        bottomLabel.textColor = .secondaryLabel
        bottomLabel.textAlignment = .center

        labelsStackView.addArrangedSubview(centerLabel)
        labelsStackView.addArrangedSubview(bottomLabel)

        labelsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
