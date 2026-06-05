//
//  Int+Extensions.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 28.05.2026.
//

import Foundation

extension Int {
    /// Форматирует число с пробелами в качестве разделителей тысяч для русской локали.
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.locale = Locale(identifier: "ru_RU")

        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
