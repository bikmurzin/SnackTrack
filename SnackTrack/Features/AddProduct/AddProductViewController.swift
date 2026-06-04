//
//  AddProductViewController.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

import UIKit
import Combine

extension AddProductViewController {
    private struct Constants {
        static let title = "Добавить продукт"
    }
    
    private struct Images {
        static let close = "xmark"
        static let confirm = "checkmark"
    }
}

/// Контроллер экрана добавления продукта.
final class AddProductViewController: UIViewController {
    private let addProductView = AddProductView()
    private let viewModel: AddProductViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: AddProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = addProductView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addKeyboardDismissLogic()
        bindViewModel()
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
    
    private func render(_ state: AddProductViewState) {
        switch state {
        case .loading:
            break
            
        case .content(let addProductViewData):
            addProductView.configure(with: addProductViewData)
        }
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
    
    private func addKeyboardDismissLogic() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func closeButtonTapped() {
        viewModel.onCloseButtonTap()
    }
    
    @objc private func confirmButtonTapped() {
        print("confirm tapped")
    }
}
