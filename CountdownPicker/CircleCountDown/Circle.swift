//
//  Circle.swift
//  CountdownPicker
//
//  Created by Berk on 27.01.2023.
//

import UIKit

class Circle: UIView, CAAnimationDelegate {
    
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
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        createCountdown()
//
//        // Do any additional setup after loading the view.
//    }
    
    func setCircleTimer(hours: Int, minutes: Int, seconds: Int) {
        
        let hoursToSeconds = hours * 3600
        let minutesToSeconds = minutes * 60
        let totalSeconds = hoursToSeconds + minutesToSeconds + seconds
        circleTimerDuration = totalSeconds
    }
    
    func createCountdown() {
        
        print("func createCountdown")
        
        let startAngle = CGFloat(-Double.pi / 2)
        let endAngle = CGFloat(3 * Double.pi / 2)
        let centerPoint = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        //THIS IS HERE WHERE YOU HAVE BEEN
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: frame.width / 2 - 30.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
//        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 3), radius: (frame.size.width / 3), startAngle: -CGFloat.pi / 2, endAngle: (3 * CGFloat.pi) / 2 , clockwise: true)
        
        innerLayer.path = circularPath.cgPath
        innerLayer.fillColor = UIColor.clear.cgColor
        innerLayer.strokeColor = UIColor.systemGray5.cgColor
        innerLayer.lineWidth = 8
        layer.addSublayer(innerLayer)
        
        outerLayer.path = circularPath.cgPath
        outerLayer.fillColor = UIColor.clear.cgColor
        outerLayer.strokeColor = UIColor.systemRed.cgColor
        outerLayer.lineWidth = 10
        outerLayer.lineCap = .round
        outerLayer.strokeStart = 0
        outerLayer.strokeEnd = 0
        layer.addSublayer(outerLayer)
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startAnimation)))
    }
    
    func start() {
        
        print("func start")
        
        if !circleAnimationDidStart {
            
            
            // This is resetAnimation
            outerLayer.speed = 1.0
            outerLayer.timeOffset = 0.0
            outerLayer.beginTime = 0.0
            outerLayer.strokeEnd = 0.0
            
            // Bunu kontrol et iki kez yapılıyor
//            circleAnimationDidStart = false
            
//            resetAnimation()
            
            
            // This is startAnimation
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.fromValue = 0
            basicAnimation.toValue = 1
            basicAnimation.duration = CFTimeInterval(circleTimerDuration)
            
            basicAnimation.delegate = self
            
            basicAnimation.fillMode = .forwards
            basicAnimation.isAdditive = true
            basicAnimation.isRemovedOnCompletion = false
            outerLayer.add(basicAnimation, forKey: "countdownAnimation")
            
            circleAnimationDidStart = true
            
        } else {
            
            // This is resumeAnimation
            let pausedTime = outerLayer.timeOffset
            outerLayer.speed = 1.0
            outerLayer.timeOffset = 0.0
            outerLayer.beginTime = 0.0
            let timeSincePause = outerLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            outerLayer.beginTime = timeSincePause
        }
    }
    
    func pause() {
        print("func pause")
        
        //This is pauseAnimation
        let pausedTime = outerLayer.convertTime(CACurrentMediaTime(), from: nil)
        outerLayer.speed = 0.0
        outerLayer.timeOffset = pausedTime
    }
    
    func stop() {
        print("func stop")
        
        // This is stopAnimation
        outerLayer.speed = 1.0
        outerLayer.timeOffset = 0.0
        outerLayer.beginTime = 0.0
        outerLayer.strokeEnd = 0.0
        outerLayer.removeAllAnimations()
        circleAnimationDidStart = false
    }
    
    func startAnimation() {
        
    }
    
    func resetAnimation() {
        
    }
    
    func stopAnimation() {
        
    }
    
    func pauseAnimation() {
        
    }
    
    func resumeAnimation() {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stop()
    }
}
