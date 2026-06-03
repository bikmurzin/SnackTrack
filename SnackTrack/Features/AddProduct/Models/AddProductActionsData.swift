//
//  AddProductActionsData.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 02.06.2026.
//

import UIKit

struct AddProductActionsData: Equatable {
    let barcodeAction: AddProductActionData
    let voiceInputAction: AddProductActionData
}

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
