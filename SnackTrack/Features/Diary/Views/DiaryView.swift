//
//  DiaryView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

import UIKit
import SnapKit

extension DiaryView {
    private struct Appearance {
        static let stackViewSpacing = 16.0
    }
}

final class DiaryView: UIView {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let headerView = DiaryHeaderView()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        setupAppearance()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: DiaryViewData) {
        headerView.configure(with: viewModel.headerModel)
    }
    
    private func setupAppearance() {
        stackView.axis = .vertical
        stackView.spacing = Appearance.stackViewSpacing
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(headerView)
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

#if DEBUG
import SwiftUI

private struct DiaryViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> DiaryView {
        let view = DiaryView()
        view.configure(with: .mock)
        return view
    }

    func updateUIView(_ uiView: DiaryView, context: Context) {}
}

#Preview {
    DiaryViewPreview()
        .ignoresSafeArea()
}
#endif
