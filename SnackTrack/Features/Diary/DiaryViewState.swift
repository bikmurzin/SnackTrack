//
//  DiaryViewState.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

/// Состояние экрана дневника питания.
enum DiaryViewState {
    /// Данные дневника загружаются.
    case loading

    /// Экран готов к отображению с подготовленными view data.
    case content(DiaryViewData)
}
