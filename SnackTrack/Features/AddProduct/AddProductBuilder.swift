//
//  AddProductBuilder.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 04.06.2026.
//

import UIKit

/// Билдер модуля добавления продукта с необходимыми зависимостями и входными данными.
final class AddProductBuilder: ModuleBuilder {
    private let viewModel: AddProductViewModel
    
    init(viewModel: AddProductViewModel) {
        self.viewModel = viewModel
    }
    
    func build() -> UIViewController {
        AddProductViewController(viewModel: viewModel)
    }
}
