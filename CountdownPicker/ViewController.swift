//
//  ViewController.swift
//  CountdownPicker
//
//  Created by Berk on 25.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var hours = [Int]()
    
    var minutes = [Int]()
    
    var seconds = [Int]()
    
    var chosenHours = 0
    var chosenMinutes = 0
    var chosenSeconds = 0
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var hoursLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var minutesLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    var setTimerButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .filled()
        button.configuration?.title = "Set Timer"
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.baseForegroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(setTimer), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        configureUI()
        
        setArrays()
        
        setTimerButton.addTarget(self, action: #selector(setTimer), for: .touchUpInside)
    }
    
    func configureUI() {
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.widthAnchor.constraint(equalToConstant: view.frame.size.width - 50)
        ])
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        stackView.addSubview(hoursLabel)
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            hoursLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            hoursLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        stackView.addSubview(minutesLabel)
        NSLayoutConstraint.activate([
            minutesLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            minutesLabel.leadingAnchor.constraint(equalTo: hoursLabel.trailingAnchor),
            minutesLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        stackView.addSubview(secondsLabel)
        NSLayoutConstraint.activate([
            secondsLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            secondsLabel.leadingAnchor.constraint(equalTo: minutesLabel.trailingAnchor),
            secondsLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(setTimerButton)
        NSLayoutConstraint.activate([
            setTimerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            setTimerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setTimerButton.widthAnchor.constraint(equalToConstant: pickerView.frame.size.width - 80)
        ])
    }
    
    func setArrays() {
        for item in 0...23 {
            hours.append(item)
        }
        
        for item in 0...59 {
            minutes.append(item)
        }
        
        for item in 0...59 {
            seconds.append(item)
        }
    }
    
    @objc func setTimer() {
        print("Set timer button pressed")
        print(chosenHours)
        print(chosenMinutes)
        print(chosenSeconds)
        let circleCountdownVC = CircleCountdownVC()
        
        circleCountdownVC.selectedHours = chosenHours
        circleCountdownVC.selectedMinutes = chosenMinutes
        circleCountdownVC.selectedSeconds = chosenSeconds
        
        self.present(circleCountdownVC, animated: true)
        
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 1
        case 2:
            return 60
        case 3:
            return 1
        case 4:
            return 60
        case 5:
            return 1
        default:
            return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Time selected")
        
        switch component {
        case 0:
            hoursLabel.text = "\(hours[row]) hours"
            chosenHours = hours[row]
        case 1:
            return
        case 2:
            minutesLabel.text = "\(minutes[row]) minutes"
            chosenMinutes = minutes[row]
        case 3:
            return
        case 4:
            secondsLabel.text = "\(seconds[row]) seconds"
            chosenSeconds = seconds[row]
        case 5:
            return
        default:
            hoursLabel.text = "hours label"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let numberWidth = pickerView.frame.size.width / 6 - 30
        let labelWidth = pickerView.frame.size.width / 6
        switch component {
        case 0, 2, 4:
            return numberWidth
        case 1, 3, 5:
            return labelWidth
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
                let label = UILabel()
                switch component {
                case 0:
                    label.text = String(hours[row])
                    label.textAlignment = .center
                    label.font = .systemFont(ofSize: 20)
                    return label
                case 2:
                    label.text = String(minutes[row])
                    label.textAlignment = .center
                    label.font = .systemFont(ofSize: 20)
                    return label
                case 4:
                    label.text = String(seconds[row])
                    label.textAlignment = .center
                    label.font = .systemFont(ofSize: 20)
                    return label
                case 1:
                    label.text = "hours"
                    label.textAlignment = .left
                    label.font = .systemFont(ofSize: 16)
                    return label
                case 3:
                    label.text = "min"
                    label.textAlignment = .left
                    label.font = .systemFont(ofSize: 16)
                    return label
                case 5:
                    label.text = "sec"
                    label.textAlignment = .left
                    label.font = .systemFont(ofSize: 16)
                    return label
                default:
                    return label
                }
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        var title = ""
//        switch component {
//        case 0:
//            title = "\(hours[row])"
//        case 1:
//            title = "hours"
//        case 2:
//            title = "\(minutes[row])"
//        case 3:
//            title = "min"
//        case 4:
//            title = "\(seconds[row])"
//        case 5:
//            title = "sec"
//        default:
//            return ""
//        }
//        return title
//    }
    
}

