//
//  ViewController.swift
//  Single Timer
//
//  Created by 劉仲軒 on 2017/3/20.
//  Copyright © 2017年 劉仲軒. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var seconds = 60
    var timer = Timer()
    var isRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pauseButton.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startAction(_ sender: Any) {
        if isRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        if resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume", for: .normal)
        } else {
            self.runTimer()
            self.resumeTapped = false
            self.pauseButton.setTitle("Pause", for: .normal)
        }
        
        
    }

    @IBAction func resetAction(_ sender: Any) {
        timer.invalidate()
        
        self.seconds = 60
        
        timerLabel.text = "\(seconds)"
        
        self.isRunning = false
        self.pauseButton.isEnabled = false
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        self.isRunning = true
        self.pauseButton.isEnabled = true
    }
    
    func updateTimer() {
        if seconds < 1 {
             timer.invalidate()
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

