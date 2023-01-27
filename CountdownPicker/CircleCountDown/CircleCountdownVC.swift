//
//  CircleCountdownVC.swift
//  CountdownPicker
//
//  Created by Berk on 26.01.2023.
//

import UIKit

class CircleCountdownVC: UIViewController {
    
    var circle: Circle = {
       let circle = Circle()
        circle.backgroundColor = .systemGray
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
    
    var startButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Start"
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.baseForegroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var stopButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Stop"
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
    
    var didTimerStart = false
    
    var selectedHours = 0
    var selectedMinutes = 0
    var selectedSeconds = 0
    
    var circleTimerDuration = 0
    
//    let innerLayer = CAShapeLayer()
//    let outerLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        print(selectedHours)
        print(selectedMinutes)
        print(selectedSeconds)
        
        configureUI()
        
//        createCountdown()
        
        circle.setCircleTimer(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        
        resetTimerButton.addTarget(self, action: #selector(resetTimerButtonPressed), for: .touchUpInside)

    }
    
    func configureUI() {
        
        view.addSubview(circle)
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circle.widthAnchor.constraint(equalToConstant: 300),
            circle.heightAnchor.constraint(equalToConstant: 300)
        ])
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.6),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2)
        ])
        
        view.addSubview(stopButton)
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.7),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2)
        ])
        
        view.addSubview(resetTimerButton)
        NSLayoutConstraint.activate([
            resetTimerButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.8),
            resetTimerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetTimerButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2)
        ])
        
        
    }
    
//    func createCountdown() {
//
//        let circularPath = UIBezierPath(arcCenter: CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 3), radius: (view.frame.size.width / 3), startAngle: -CGFloat.pi / 2, endAngle: (3 * CGFloat.pi) / 2 , clockwise: true)
//
//        innerLayer.path = circularPath.cgPath
//        innerLayer.fillColor = UIColor.clear.cgColor
//        innerLayer.strokeColor = UIColor.systemGray5.cgColor
//        innerLayer.lineWidth = 8
//        view.layer.addSublayer(innerLayer)
//
//        outerLayer.path = circularPath.cgPath
//        outerLayer.fillColor = UIColor.clear.cgColor
//        outerLayer.strokeColor = UIColor.systemRed.cgColor
//        outerLayer.lineWidth = 10
//        outerLayer.lineCap = .round
//        outerLayer.strokeEnd = 0
//        view.layer.addSublayer(outerLayer)
//
////        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startAnimation)))
//    }
    
    @objc func startButtonPressed() {
        print("@objc func startButtonPressed")
        
        if !didTimerStart {
            
            circle.start()
            startButton.configuration?.title = "Pause"
            startButton.configuration?.baseBackgroundColor = .systemRed
            didTimerStart = true
        } else {
            
            circle.pause()
            startButton.configuration?.title = "Resume"
            startButton.configuration?.baseBackgroundColor = .systemBlue
            didTimerStart = false
        }
    }
    
    @objc func stopButtonPressed() {
        print("@objc func stopButtonPressed")
        
        circle.stop()
        startButton.configuration?.title = "Start"
        didTimerStart = false
    }
    
    @objc func resetTimerButtonPressed() {
        print("@objc func resetTimerButtonPressed()")
        self.dismiss(animated: true)
    }

}
