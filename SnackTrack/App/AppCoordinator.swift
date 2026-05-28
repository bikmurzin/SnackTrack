//
//  AppCoordinator.swift
//  SnackTrack
//

import UIKit

final class AppCoordinator {
    private let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    func start() -> UIViewController {
        let startViewController = DiaryViewController()
        navigationController.setViewControllers([startViewController], animated: true)
        return navigationController
    }
}
