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
        diaryView.configure(with: DiaryViewData.mock)
    }
}
