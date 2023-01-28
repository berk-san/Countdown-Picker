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
    
    var digitalTimer: DigitalTimer = {
       let digitalTimer = DigitalTimer()
        return digitalTimer
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
        button.configuration?.baseBackgroundColor = .systemRed
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
    
    var counterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .systemBackground
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
    }()
    
    var hoursLabel: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var firstColon: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = ":"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var minutesLabel: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondColon: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = ":"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondsLabel: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var messageLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "It's Ready"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var didTimerStart = false
    var selectedHours = 0
    var selectedMinutes = 0
    var selectedSeconds = 0
    var circleTimerDuration = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        circle.setCircleTimer(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
        digitalTimer.setDigitalTimer(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
        digitalTimer.delegate = self
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        resetTimerButton.addTarget(self, action: #selector(resetTimerButtonPressed), for: .touchUpInside)
        
        counterStackView.isHidden = true
        messageLabel.isHidden = true
        stopButton.isEnabled = false
    }
    
    //MARK: - UI Constraints
    
    func configureUI() {
        view.addSubview(circle)
        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        ])
        view.addSubview(counterStackView)
        NSLayoutConstraint.activate([
            counterStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            counterStackView.widthAnchor.constraint(equalToConstant: 150),
            counterStackView.heightAnchor.constraint(equalToConstant: 48)
        ])
        counterStackView.addSubview(hoursLabel)
        NSLayoutConstraint.activate([
            hoursLabel.leadingAnchor.constraint(equalTo: counterStackView.leadingAnchor),
            hoursLabel.bottomAnchor.constraint(equalTo: counterStackView.bottomAnchor),
            hoursLabel.widthAnchor.constraint(equalToConstant: 40),
            hoursLabel.heightAnchor.constraint(equalTo: counterStackView.heightAnchor)
        ])
        counterStackView.addSubview(firstColon)
        NSLayoutConstraint.activate([
            firstColon.leadingAnchor.constraint(equalTo: hoursLabel.trailingAnchor),
            firstColon.bottomAnchor.constraint(equalTo: counterStackView.bottomAnchor),
            firstColon.widthAnchor.constraint(equalToConstant: 15),
            firstColon.heightAnchor.constraint(equalTo: counterStackView.heightAnchor)
        ])
        counterStackView.addSubview(minutesLabel)
        NSLayoutConstraint.activate([
            minutesLabel.leadingAnchor.constraint(equalTo: firstColon.trailingAnchor),
            minutesLabel.bottomAnchor.constraint(equalTo: counterStackView.bottomAnchor),
            minutesLabel.widthAnchor.constraint(equalToConstant: 40),
            minutesLabel.heightAnchor.constraint(equalTo: counterStackView.heightAnchor)
        ])
        counterStackView.addSubview(secondColon)
        NSLayoutConstraint.activate([
            secondColon.leadingAnchor.constraint(equalTo: minutesLabel.trailingAnchor),
            secondColon.bottomAnchor.constraint(equalTo: counterStackView.bottomAnchor),
            secondColon.widthAnchor.constraint(equalToConstant: 15),
            secondColon.heightAnchor.constraint(equalTo: counterStackView.heightAnchor)
        ])
        counterStackView.addSubview(secondsLabel)
        NSLayoutConstraint.activate([
            secondsLabel.leadingAnchor.constraint(equalTo: secondColon.trailingAnchor),
            secondsLabel.trailingAnchor.constraint(equalTo: counterStackView.trailingAnchor),
            secondsLabel.bottomAnchor.constraint(equalTo: counterStackView.bottomAnchor),
            secondsLabel.heightAnchor.constraint(equalTo: counterStackView.heightAnchor)
        ])
        view.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            messageLabel.widthAnchor.constraint(equalToConstant: 150),
            messageLabel.heightAnchor.constraint(equalToConstant: 48)
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
    
    //MARK: - Button Actions
    
    @objc func startButtonPressed() {
        messageLabel.isHidden = true
        counterStackView.isHidden = false
        stopButton.isEnabled = true
        
        if !didTimerStart {
            circle.start()
            digitalTimer.start()
            startButton.configuration?.title = "Pause"
            startButton.configuration?.baseBackgroundColor = .systemRed
            didTimerStart = true
        } else {
            circle.pause()
            digitalTimer.pause()
            startButton.configuration?.title = "Resume"
            startButton.configuration?.baseBackgroundColor = .systemGreen
            didTimerStart = false
        }
    }
    
    @objc func stopButtonPressed() {
        circle.stop()
        digitalTimer.stop()
        digitalTimer.setDigitalTimer(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
        startButton.configuration?.title = "Start"
        startButton.configuration?.baseBackgroundColor = .systemGreen
        stopButton.isEnabled = false
        didTimerStart = false
    }
    
    @objc func resetTimerButtonPressed() {
        self.dismiss(animated: true)
    }

}

//MARK: - DigitalTimer Delegate

extension CircleCountdownVC: DigitalTimerDelagte {
    func countdownDigitalTimer(time: (hours: String, minutes: String, seconds: String)) {
        hoursLabel.text = time.hours
        minutesLabel.text = time.minutes
        secondsLabel.text = time.seconds
    }
    
    func digitalTimerDone() {
        counterStackView.isHidden = true
        messageLabel.isHidden = false
        secondsLabel.text = String(selectedSeconds)
        didTimerStart = false
        stopButton.isEnabled = false
        startButton.setTitle("Start", for: .normal)
        startButton.isEnabled = false
        startButton.configuration?.baseBackgroundColor = .systemGreen
    }
}
