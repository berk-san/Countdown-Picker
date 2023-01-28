//
//  Circle.swift
//  CountdownPicker
//
//  Created by Berk on 27.01.2023.
//

import UIKit

class Circle: UIView {
    
    let innerLayer = CAShapeLayer()
    let outerLayer = CAShapeLayer()
    
    var circleTimerDuration = 0
    
    var circleAnimationDidStart = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCountdown()
        print("override init run")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCircleTimer(hours: Int, minutes: Int, seconds: Int) {
        let hoursToSeconds = hours * 3600
        let minutesToSeconds = minutes * 60
        let totalSeconds = hoursToSeconds + minutesToSeconds + seconds
        circleTimerDuration = totalSeconds
    }
    
    func createCountdown() {
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 120, startAngle: -(.pi / 2), endAngle: (3 * .pi) / 2 , clockwise: true)
        
        innerLayer.path = circularPath.cgPath
        innerLayer.fillColor = UIColor.clear.cgColor
        innerLayer.strokeColor = UIColor.systemGray5.cgColor
        innerLayer.lineWidth = 12
        layer.addSublayer(innerLayer)
        
        outerLayer.path = circularPath.cgPath
        outerLayer.fillColor = UIColor.clear.cgColor
        outerLayer.strokeColor = UIColor.systemRed.cgColor
        outerLayer.lineWidth = 8
//        outerLayer.lineCap = .round
        outerLayer.strokeStart = 0
        outerLayer.strokeEnd = 0
        layer.addSublayer(outerLayer)
    }
    
    func start() {
        if !circleAnimationDidStart {
            outerLayer.speed = 1.0
            outerLayer.timeOffset = 0.0
            outerLayer.beginTime = 0.0
            outerLayer.strokeEnd = 0.0
        
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.fromValue = 0
            basicAnimation.toValue = 1
            basicAnimation.fillMode = .forwards
            basicAnimation.duration = CFTimeInterval(circleTimerDuration)
            basicAnimation.isAdditive = true
            basicAnimation.isRemovedOnCompletion = false
            outerLayer.add(basicAnimation, forKey: "countdownAnimation")
            circleAnimationDidStart = true
        } else {
            let pausedTime = outerLayer.timeOffset
            outerLayer.speed = 1.0
            outerLayer.timeOffset = 0.0
            outerLayer.beginTime = 0.0
            let timeSincePause = outerLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            outerLayer.beginTime = timeSincePause
        }
    }
    
    func pause() {
        let pausedTime = outerLayer.convertTime(CACurrentMediaTime(), from: nil)
        outerLayer.speed = 0.0
        outerLayer.timeOffset = pausedTime
    }
    
    func stop() {
        outerLayer.speed = 1.0
        outerLayer.timeOffset = 0.0
        outerLayer.beginTime = 0.0
        outerLayer.strokeEnd = 0.0
        outerLayer.removeAllAnimations()
        circleAnimationDidStart = false
    }
}
