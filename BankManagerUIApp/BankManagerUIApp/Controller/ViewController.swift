//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    private let mainView: MainView
    private let dataSource: BankManager
    private var stopwatch: Timer?
    private var elapsedTime: TimeInterval = 0
    
    init(dataSource: BankManager) {
        self.mainView = MainView()
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
        dataSource.delegate = self.mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        view.backgroundColor = .white
    }
    
    @objc func addCustomerButtonTapped() {
        countElapsedTime()
        dataSource.addCustomer()
        dataSource.startBankingProcess(completion: stopTimer)
    }
    
    @objc func resetService() {
        dataSource.reset()
        stopTimer()
    }
    
    func stopTimer() {
        stopwatch?.invalidate()
        stopwatch = nil
        elapsedTime = 0
        mainView.setTimer("업무시간 - 00:00:000")
    }
    
    func countElapsedTime() {
        stopwatch = Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { timer in
            self.elapsedTime += timer.timeInterval
            let minutes = Int(self.elapsedTime) / 60
            let seconds = Int(self.elapsedTime) % 60
            let milliseconds = Int(self.elapsedTime * 1000) % 1000
            
            let timeString = String(format: "%02d:%02d:%03d", minutes, seconds, milliseconds)
            self.mainView.setTimer("업무시간 - \(timeString)")
        }
    }
}
