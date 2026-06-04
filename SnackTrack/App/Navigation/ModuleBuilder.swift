//
//  ModuleBuilder.swift
//  SnackTrack
//

import UIKit

/// Билдер модуля, создающий его корневой контроллер.
protocol ModuleBuilder {
    /// Создаёт и возвращает корневой контроллер модуля.
    func build() -> UIViewController
}
