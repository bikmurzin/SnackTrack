//
//  AddProductViewState.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

/// Состояние экрана добавления продукта.
enum AddProductViewState {
    /// Данные экрана загружаются.
    case loading

    /// Экран готов к отображению содержимого.
    case content(AddProductViewData)
}
