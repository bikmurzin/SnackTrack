//
//  DiaryViewController.swift
//  SnackTrack
//
//  Created by Роберт Бикмурзин on 27.05.2026.
//

import UIKit

final class DiaryViewController: UIViewController {
    private lazy var diaryView = DiaryView()
    
    override func loadView() {
        view = diaryView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        diaryView.configure(with: DiaryViewData(headerModel: DiaryHeaderData(dayName: "Сегодня", date: "27 мая, среда"), calorieSummary: CalorieSummaryData(remainingCalories: 1240, goalCalories: 2200, consumedCalories: 960, progress: 0.44)))
    }
}
