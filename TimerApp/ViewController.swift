//
//  ViewController.swift
//  TimerApp
//
//  Created by imua yusei on 2018/03/03.
//  Copyright © 2018年 imua yusei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 多分型
    var timer: Timer?
    var duration = 0
    let settingKey = "timeValue"
    override func viewDidLoad() {
        super.viewDidLoad()
        // アプリで使用した値を参照する仕組み
        let settings = UserDefaults.standard
        settings.register(defaults: [settingKey : 60])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        duration = 0
        // メソッドを更新
        _ = displayUpdate()
    }

    @IBOutlet weak var timeDisplay: UILabel!
    // Display.textで変更できる
    
    @IBAction func SettingButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
        performSegue(withIdentifier: "OpenSetting", sender: nil)
    }
    @IBAction func startTimerAction(_ sender: Any) {
        // タイマーを呼び出す
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerStop(_:)), userInfo: true, repeats: true)
    }
    @IBAction func stopTimerAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == true {
                nowTimer.invalidate()
            }
        }
    }
    func displayUpdate() -> Int {
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let remainSeconds = timerValue - duration
        timeDisplay.text = "あと\(remainSeconds)秒"
        return remainSeconds
    }
    
    @objc func timerStop(_ timer:Timer) {
        duration += 1
        //
        if displayUpdate() == 0 {
           timeDisplay.text = "終了！"
            duration = 0
            timer.invalidate()
            
        }
    }
    
    
}

