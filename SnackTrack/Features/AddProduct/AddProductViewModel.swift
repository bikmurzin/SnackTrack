//
//  AddProductViewModel.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

import Combine
import Foundation

/// ViewModel экрана добавления продукта, которая готовит состояние для UI.
final class AddProductViewModel {
    @Published private(set) var state: AddProductViewState = .loading

    private let storage: DiaryStorageProtocol
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

    /// Запускает первичную загрузку данных для экрана.
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

    /// Обрабатывает нажатие на редактирование списка добавленных продуктов.
    func onEditTap() {
        // TODO: Открыть экран с общей сводкой по добавленным продуктам за день
    }

    /// Обрабатывает выбор приёма пищи.
    func onMealTap(_ data: MealRowData) {
        // TODO: Открыть экран со сводкой по таппнутому приему пищи
    }
}
