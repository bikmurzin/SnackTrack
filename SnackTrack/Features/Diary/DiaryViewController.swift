//
//  DiaryViewController.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

import Combine
import UIKit

/// Контроллер экрана дневника питания, который связывает View с ViewModel.
final class DiaryViewController: UIViewController {
    private lazy var diaryView = DiaryView()
    private let viewModel: DiaryViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: DiaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = diaryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupActions()
        viewModel.viewDidLoad()
    }

    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.render(state)
            }
            .store(in: &cancellables)
    }

    private func render(_ state: DiaryViewState) {
        switch state {
        case .loading:
            break
        case .content(let data):
            diaryView.configure(with: data)
        }
    }

    private func setupActions() {
        diaryView.onAddMealTap = { [weak self] data in
            self?.addMealTap(data)
        }
        diaryView.onEditTap = { [weak self] in
            self?.editTap()
        }
        diaryView.onMealTap = { [weak self] data in
            self?.mealTap(data)
        }
    }

    private func addMealTap(_ data: MealRowData) {
        viewModel.onAddMealTap(data)
    }

    private func editTap() {
        viewModel.onEditTap()
    }

    private func mealTap(_ data: MealRowData) {
        viewModel.onMealTap(data)
    }
}
