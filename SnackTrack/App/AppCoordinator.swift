//
//  AppCoordinator.swift
//  SnackTrack
//

import UIKit

/// Координатор стартового flow приложения и корневого navigation controller.
final class AppCoordinator {
    private let navigationController = UINavigationController()
    private let diaryStorage: DiaryStorageProtocol = InMemoryDiaryStorage()

    /// Создаёт и возвращает корневой контроллер приложения.
    func start() -> UIViewController {
        let viewModel = DiaryViewModel(storage: diaryStorage)
//        let startViewController = DiaryViewController(viewModel: viewModel)
        let startViewController = AddProductViewController()
        navigationController.setViewControllers([startViewController], animated: false)
        return navigationController
    }
}
