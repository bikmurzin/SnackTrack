//
//  AppCoordinator.swift
//  SnackTrack
//

import UIKit

final class AppCoordinator {
    private let navigationController = UINavigationController()
    private let diaryStorage: DiaryStorageProtocol = InMemoryDiaryStorage()
    
    func start() -> UIViewController {
        let viewModel = DiaryViewModel(storage: diaryStorage)
//        let startViewController = DiaryViewController(viewModel: viewModel)
        let startViewController = AddProductViewController()
        navigationController.setViewControllers([startViewController], animated: false)
        return navigationController
    }
}
