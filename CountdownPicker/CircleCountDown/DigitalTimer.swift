//
//  Digital.swift
//  CountdownPicker
//
//  Created by Berk on 28.01.2023.
//

import Foundation

protocol DigitalTimerDelagte:AnyObject {
    func countdownDigitalTimer(time: (hours: String, minutes:String, seconds:String))
    func digitalTimerDone()
}

class DigitalTimer {
    weak var delegate: DigitalTimerDelagte?
    var digitalTimerDuration = 0.0
    lazy var timer: Timer = {
        let timer = Timer()
        return timer
    }()
    
    func setDigitalTimer(hours: Int, minutes: Int, seconds: Int) {
        let hoursToSeconds = hours * 3600
        let minutesToSeconds = minutes * 60
        let totalSeconds = hoursToSeconds + minutesToSeconds + seconds
        digitalTimerDuration = Double(totalSeconds)
        delegate?.countdownDigitalTimer(time: timeString(time: TimeInterval(ceil(digitalTimerDuration))))
    }
    
    func timeString(time: TimeInterval) -> (hours: String, minutes: String, seconds: String) {
        let calculatedHours = Int(time) / 3600
        let calculatedMinutes = (Int(time) / 60) % 60
        let calculatedSeconds = Int(time) % 60
        return (hours: String(format: "%02i", calculatedHours), minutes: String(format: "%02i", calculatedMinutes), seconds: String(format: "%02i", calculatedSeconds))
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func stop() {
        timer.invalidate()
        delegate?.countdownDigitalTimer(time: timeString(time: TimeInterval(ceil(digitalTimerDuration))))
    }
    
    @objc func updateTimer() {
        if digitalTimerDuration < 0.0 {
            timer.invalidate()
            delegate?.digitalTimerDone()
        } else {
            digitalTimerDuration -= 0.01
            delegate?.countdownDigitalTimer(time: timeString(time: TimeInterval(ceil(digitalTimerDuration))))
        }
    }
}
