//
//  SetNewElementView.swift
//  ToDoMvvm
//
//  Created by Grigore on 16.06.2023.
//

import UIKit

class SetNewElementView: UIView {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.text = "Enter task:"
        textField.textColor = .white
        textField.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 15
        textField.font = UIFont(name: "Avenir Next", size: 24)
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Type here"
        textView.font = UIFont(name: "Avenir Next", size: 24)
        textView.layer.cornerRadius = 15
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 1
        textView.textColor = .white
        textView.delegate = self
        textView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4378189445, blue: 0.4139066935, alpha: 1)
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.alpha = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var highPriorityButton: UIButton = {
        let image = UIImage(systemName: "exclamationmark.arrow.circlepath")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.addTarget(self, action: #selector(highTapped), for: .touchUpInside)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var mediumPriorityButton: UIButton = {
        let image = UIImage(systemName: "clock.arrow.2.circlepath")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.addTarget(self, action: #selector(mediumTapped), for: .touchUpInside)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var lowPriorityButton: UIButton = {
        let image = UIImage(systemName: "timer")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.addTarget(self, action: #selector(lowTapped), for: .touchUpInside)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var stackView = UIStackView()
    
    var setNewElementViewModel: SetNewElementViewModel?
    
    var isActive: Bool = false {
        didSet
        {
            if self.isActive {
                saveButton.alpha = 1.0
                saveButton.isEnabled = true
            } else {
                saveButton.alpha = 0.5
                saveButton.isEnabled = false
            }
        }
    }
    
    //MARK: - INITIALIZATION
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setConstraints()
        offKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //OBJC FUNCTIONS
    @objc private func lowTapped() {
        setNewElementViewModel?.setPriority(element: .low)
    }
    
    @objc private func mediumTapped() {
        setNewElementViewModel?.setPriority(element: .medium)
    }
    
    @objc private func highTapped() {
        setNewElementViewModel?.setPriority(element: .high)
    }
    
    @objc private func saveAction() {
        setNewElementViewModel?.save()
    }
    
    
    private func offKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        self.addGestureRecognizer(tapGesture)
    }
    
    //MARK: -
    
    private func setUpViews() {
        self.backgroundColor = #colorLiteral(red: 0.9444841743, green: 0.9411299825, blue: 0.7125524879, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(textField)
        self.addSubview(descriptionTextView)
        
        stackView = UIStackView(arrangedSubviews: [lowPriorityButton, mediumPriorityButton, highPriorityButton],
                                axis: .horizontal)
        
        stackView.distribution = .fillProportionally
        self.addSubview(stackView)
        self.addSubview(saveButton)
    }
}

//LAYOUTS
extension SetNewElementView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
            
            descriptionTextView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            descriptionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            descriptionTextView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            
            stackView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.11),
            
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 25),
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            saveButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07),
        ])
    }
}

//UITextView delegates
extension SetNewElementView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type here" {
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "Type here" || textView.text == " " || textView.text == "" {
            isActive = false
        } else {
            isActive = true
        }
    }
}


extension SetNewElementView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Enter task:" {
            textField.text = ""
        }
    }
}
