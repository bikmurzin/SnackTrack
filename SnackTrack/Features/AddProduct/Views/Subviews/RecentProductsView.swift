//
//  RecentProductView.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 03.06.2026.
//

import SnapKit
import UIKit

extension RecentProductsView {
    private struct Appearance {
        static let stackViewSpacing: CGFloat = 12
        static let titleFontSize: CGFloat = 13
        static let rowHeight: CGFloat = 64
    }

    private struct Texts {
        static let title = "НЕДАВНИЕ ПРОДУКТЫ"
    }
    
    private nonisolated enum RecentProductSection: Hashable, Sendable {
        case main
    }
}

final class RecentProductsView: UIView {
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .plain)

    private lazy var dataSource = makeDataSource()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setupAppearance()
        makeConstraints()
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with items: [RecentProductRowData]) {
        var snapshot = NSDiffableDataSourceSnapshot<RecentProductSection, RecentProductRowData>()

        snapshot.appendSections([RecentProductSection.main])
        snapshot.appendItems(items)

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func addSubviews() {
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(tableView)
    }

    private func setupAppearance() {
        stackView.axis = .vertical
        stackView.spacing = Appearance.stackViewSpacing

        titleLabel.text = Texts.title
        titleLabel.font = .systemFont(
            ofSize: Appearance.titleFontSize,
            weight: .semibold
        )
        titleLabel.textColor = .secondaryLabel

        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.rowHeight = Appearance.rowHeight
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupTableView() {
        tableView.register(
            RecentProductCell.self,
            forCellReuseIdentifier: RecentProductCell.reuseIdentifier
        )
    }

    private func makeDataSource()
    -> UITableViewDiffableDataSource<RecentProductSection, RecentProductRowData> {
        UITableViewDiffableDataSource(
            tableView: tableView
        ) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecentProductCell.reuseIdentifier,
                for: indexPath
            ) as? RecentProductCell else {
                return UITableViewCell()
            }

            cell.configure(with: item)

            return cell
        }
    }
}
