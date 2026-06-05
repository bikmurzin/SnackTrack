//
//  AddProductActionsData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 02.06.2026.
//

import UIKit

/// Данные для блока быстрых действий на экране добавления продукта.
struct AddProductActionsData: Equatable {
    let barcodeAction: AddProductActionData
    let voiceInputAction: AddProductActionData
}

/// Данные одной кнопки быстрого действия.
struct AddProductActionData: Equatable {
    let title: String
    let iconSystemName: String
    let tintColor: UIColor
}

#if DEBUG
extension AddProductActionsData {
    static let mock = AddProductActionsData(
        barcodeAction: AddProductActionData(
            title: "Сканировать штрих-код",
            iconSystemName: "barcode.viewfinder",
            tintColor: .systemBlue
        ),
        voiceInputAction: AddProductActionData(
            title: "Голосовой ввод",
            iconSystemName: "mic",
            tintColor: .systemBlue
        )
    )
}
#endif
