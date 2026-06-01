//
//  MealCategory.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 30.05.2026.
//

import Foundation

struct MealCategory: Identifiable, Equatable {
    let id: UUID
    var title: String
    var iconSystemName: String
    var sortOrder: Int
    
    init(id: UUID = UUID(), title: String, iconSystemName: String, sortOrder: Int) {
        self.id = id
        self.title = title
        self.iconSystemName = iconSystemName
        self.sortOrder = sortOrder
    }
}
