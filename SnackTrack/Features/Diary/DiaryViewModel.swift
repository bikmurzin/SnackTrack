//
//  DiaryViewModel.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

import Combine
import Foundation

/// ViewModel экрана дневника, которая загружает записи и формирует состояние UI.
final class DiaryViewModel {
    @Published private(set) var state: DiaryViewState = .loading

    private let storage: DiaryStorageProtocol
    private let calculationService: DiaryCalculationService
    private let mapper: DiaryViewDataMapper
    private var isLoaded = false

    private var cancellables = Set<AnyCancellable>()

    init(
        storage: DiaryStorageProtocol,
        calculationService: DiaryCalculationService = DiaryCalculationService(),
        mapper: DiaryViewDataMapper = DiaryViewDataMapper()
    ) {
        self.storage = storage
        self.calculationService = calculationService
        self.mapper = mapper
    }

    /// Запускает первичную подписку на дневник питания.
    func viewDidLoad() {
        guard !isLoaded else { return }

        isLoaded = true
        storage.observeDiary(for: Date())
            .map { [calculationService, mapper] diary in
                mapper.map(
                    diary: diary,
                    calculationService: calculationService
                )
            }
            .map { DiaryViewState.content($0) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.state = state
            }
            .store(in: &cancellables)
    }

    /// Обрабатывает нажатие на добавление продукта в выбранный приём пищи.
    func onAddMealTap(_ data: MealRowData) {
        // TODO: Открыть экран добавления продукта
    }

    /// Обрабатывает нажатие на редактирование дневной сводки.
    func onEditTap() {
        // TODO: Открыть экран с общей сводкой по добавленным продуктам за день
    }

    /// Обрабатывает выбор строки приёма пищи.
    func onMealTap(_ data: MealRowData) {
        // TODO: Открыть экран со сводкой по таппнутому приему пищи
    }
}
