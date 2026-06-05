//
//  AddProductViewModel.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 01.06.2026.
//

import Combine
import Foundation

/// ViewModel экрана добавления продукта, которая готовит состояние для UI.
@MainActor
final class AddProductViewModel {
    var closeScreenRequested: (() -> Void)?
    
    @Published private(set) var state: AddProductViewState = .loading
    private let inputSubject: CurrentValueSubject<AddProductInput, Never>
    
    private let currentDate: Date

    private let storage: DiaryStorageProtocol
    private var isLoaded = false
    private var cancellables = Set<AnyCancellable>()

    init(
        storage: DiaryStorageProtocol,
        currentDate: Date,
        mealCategoryId: UUID
    ) {
        self.storage = storage
        self.currentDate = currentDate
        inputSubject = .init(AddProductInput(selectedMealCategoryId: mealCategoryId))
        
    }

    /// Запускает первичную загрузку данных для экрана.
    func viewDidLoad() {
        guard !isLoaded else { return }
        
        isLoaded = true
        
        Publishers.CombineLatest(
            storage.observeDiaryData(),
            inputSubject
        )
        .map(makeViewData)
        .map(AddProductViewState.content)
        .sink { [weak self] state in
            self?.state = state
        }
        .store(in: &cancellables)
    }
    
    /// Обновляет выбранную категорию приёма пищи.
    func selectMealCategory(with id: UUID) {
        inputSubject.send(AddProductInput(selectedMealCategoryId: id))
    }
    
    private func makeViewData(
        data: DiaryData,
        input: AddProductInput
    ) -> AddProductViewData {
        let recentProducts = data.mealEntries
            .reversed()
            .prefix(10)
            .map(RecentProductRowData.init)
        
        let mealOptions: [MealOptionData] = data.mealCategories
            .map { category in
                MealOptionData(
                    id: category.id,
                    title: category.title,
                    iconSystemName: category.iconSystemName,
                    isSelected: category.id == input.selectedMealCategoryId
                )
            }
            
        
        return AddProductViewData(
            mealOptions: mealOptions,
            recentProductsData: recentProducts
        )
    }

    func onCloseButtonTap() {
        closeScreenRequested?()
    }
}
