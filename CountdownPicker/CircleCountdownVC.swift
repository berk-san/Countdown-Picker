//
//  CircleCountdownVC.swift
//  CountdownPicker
//
//  Created by Berk on 26.01.2023.
//

import UIKit

class CircleCountdownVC: UIViewController {
    
    var startStopButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Start"
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.baseForegroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var resetTimerButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Reset Timer"
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.baseForegroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var animationDidStart = false
    
    var selectedHours = 0
    var selectedMinutes = 0
    var selectedSeconds = 0
    
    var circleTimerDuration = 0
    
    let innerLayer = CAShapeLayer()
    let outerLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureUI()
        
        createCountdown()
        
        adjustCircleTimer(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
        
        startStopButton.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)
        
        resetTimerButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)

    }
    
    func configureUI() {
        view.addSubview(startStopButton)
        NSLayoutConstraint.activate([
            startStopButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.7),
            startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startStopButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2)
        ])
        
        view.addSubview(resetTimerButton)
        NSLayoutConstraint.activate([
            resetTimerButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.8),
            resetTimerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetTimerButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2)
        ])
        
        
    }
    
    func createCountdown() {
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 3), radius: (view.frame.size.width / 3), startAngle: -CGFloat.pi / 2, endAngle: (3 * CGFloat.pi) / 2 , clockwise: true)
        
        innerLayer.path = circularPath.cgPath
        innerLayer.fillColor = UIColor.clear.cgColor
        innerLayer.strokeColor = UIColor.systemGray5.cgColor
        innerLayer.lineWidth = 8
        view.layer.addSublayer(innerLayer)
        
        outerLayer.path = circularPath.cgPath
        outerLayer.fillColor = UIColor.clear.cgColor
        outerLayer.strokeColor = UIColor.systemRed.cgColor
        outerLayer.lineWidth = 10
        outerLayer.lineCap = .round
        outerLayer.strokeEnd = 0
        view.layer.addSublayer(outerLayer)
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startAnimation)))
    }
    
    @objc func startAnimation() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 10
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        outerLayer.add(basicAnimation, forKey: "countdownAnimation")
        
        if animationDidStart {
            startStopButton.configuration?.title = "Start"
            startStopButton.configuration?.baseBackgroundColor = .systemGreen
            
            outerLayer.speed = 0
            let pausedTime = outerLayer.convertTime(CACurrentMediaTime(), from: nil)
            outerLayer.timeOffset = pausedTime
            animationDidStart = false
        } else {
            startStopButton.configuration?.title = "Stop"
            startStopButton.configuration?.baseBackgroundColor = .systemRed
            animationDidStart = true
            
            let pausedTime = outerLayer.timeOffset
            outerLayer.speed = 1.0
            outerLayer.timeOffset = 0.0
            
            outerLayer.beginTime = 0.0
            let timeSincePause = outerLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            outerLayer.beginTime = timeSincePause
        }
    }
    
    @objc func resetTimer() {
        self.dismiss(animated: true)
    }
    
    func adjustCircleTimer(hours: Int, minutes: Int, seconds: Int) {
        
        let hoursToSeconds = hours * 3600
        let minutesToSeconds = minutes * 60
        let totalSeconds = hoursToSeconds + minutesToSeconds + seconds
        circleTimerDuration = totalSeconds
    }

}
