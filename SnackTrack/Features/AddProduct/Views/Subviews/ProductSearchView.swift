//
//  ProductSearchView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 02.06.2026.
//

import UIKit
import SnapKit

extension ProductSearchView {
    private struct Appearance {
        static let titleToSearchOffset = 10.0
        static let searchBarHeight = 44.0
        static let titleFontSize = 13.0
    }

    private struct Texts {
        static let title = "ПОИСК ПРОДУКТА"
        static let placeholder = "Поиск продукта"
    }
}

final class ProductSearchView: UIView {
    var onTextChanged: ((String) -> Void)?
    var onSearchButtonTap: ((String) -> Void)?

    private let titleLabel = UILabel()
    private let searchTextField = UISearchTextField()

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

    func setText(_ text: String) {
        searchTextField.text = text
    }

    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(searchTextField)
    }

    private func setupAppearance() {
        backgroundColor = .clear
        
        titleLabel.text = Texts.title
        titleLabel.font = .systemFont(
            ofSize: Appearance.titleFontSize,
            weight: .semibold
        )
        titleLabel.textColor = .secondaryLabel
        
        searchTextField.placeholder = Texts.placeholder
        searchTextField.backgroundColor = .secondarySystemBackground
        searchTextField.delegate = self
        searchTextField.autocapitalizationType = .none
        searchTextField.autocorrectionType = .no
        searchTextField.returnKeyType = .search
        searchTextField.font = .preferredFont(forTextStyle: .body)
        searchTextField.adjustsFontForContentSizeCategory = true
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }

        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Appearance.titleToSearchOffset)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(Appearance.searchBarHeight)
        }
    }

    private func setupActions() {
        searchTextField.addTarget(
            self,
            action: #selector(searchTextChanged),
            for: .editingChanged
        )
    }

    @objc private func searchTextChanged() {
        onTextChanged?(searchTextField.text ?? "")
    }
}

extension ProductSearchView: UISearchTextFieldDelegate {
    func searchTextField(_ searchTextField: UISearchTextField, didSelect suggestion: any UISearchSuggestion) {
        searchTextField.text = suggestion.localizedSuggestion
        onSearchButtonTap?(searchTextField.text ?? "")
    }
}
