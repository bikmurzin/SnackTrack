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
        let viewModel = DiaryViewModel(storage: diaryStorage, currentDate: Date())
        viewModel.onAddProductRequested = { [weak self] currentDate, mealCategoryId in
            self?.goToAddProductScreen(currentDate: currentDate, mealCategoryId: mealCategoryId)
        }
        let startViewController = DiaryViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([startViewController], animated: false)
        return navigationController
    }
    
    private func goToAddProductScreen(currentDate: Date, mealCategoryId: UUID) {
        let viewModel = AddProductViewModel(
            storage: diaryStorage,
            currentDate: currentDate,
            mealCategoryId: mealCategoryId
        )
        viewModel.closeScreenRequested = { [weak self] in
            self?.popViewController(animated: true)
        }
        let builder = AddProductBuilder(viewModel: viewModel)
        navigationController.pushViewController(builder.build(), animated: true)
    }
    
    private func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}
