//
//  AddProductViewController.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

import UIKit

extension AddProductViewController {
    private struct Constants {
        static let title = "Добавить продукт"
    }

    private struct Images {
        static let close = "xmark"
        static let confirm = "checkmark"
    }
}

final class AddProductViewController: UIViewController {
    private let addProductView = AddProductView()
    
    override func loadView() {
        view = addProductView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addProductView.configure(with: .mock)
    }
    
    private func setupNavigationBar() {
        title = Constants.title

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Images.close),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Images.confirm),
            style: .prominent,
            target: self,
            action: #selector(confirmButtonTapped)
        )

        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func confirmButtonTapped() {
        print("confirm tapped")
    }
}
