//
//  ContainerViewDetailedElement.swift
//  ToDoMvvm
//
//  Created by Grigore on 14.06.2023.
//

import UIKit

class DetailedElementView: UIView {
    
    lazy var titleTxField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.textColor = .white
        textField.layer.cornerRadius = 20
        textField.font = .boldSystemFont(ofSize: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .white
        textView.layer.cornerRadius = 20
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var deleteButton: UIButton = {
        let image = UIImage(systemName: "trash.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4378189445, blue: 0.4139066935, alpha: 1)
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Buttons stackView
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
    
    //MARK: - conection with ViewModel
    var detailedElementViewModel: DetailedElementViewModelProtocol? {
        didSet
        {
            detailedElementViewModel?.setUpTitle()
            detailedElementViewModel?.setUpINformation()
            detailedElementViewModel?.setUpPriority()
        }
    }
    
    //Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setConstraints()
        offKeyboard()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
        setConstraints()
        offKeyboard()
    }
    
    private func setUpViews() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleTxField)
        self.addSubview(textView)
        
        stackView = UIStackView(arrangedSubviews: [lowPriorityButton, mediumPriorityButton, highPriorityButton],
                                axis: .horizontal)
        stackView.distribution = .fillProportionally
        self.addSubview(stackView)
        
        self.addSubview(deleteButton)
        self.addSubview(saveButton)
        
    }
    
    @objc private func deleteButtonTapped() {
        detailedElementViewModel?.deleteElement()
        dissapearWhenDeleteOrEdit()
    }
    
    @objc private func saveAction() {
        detailedElementViewModel?.editElement()
        dissapearWhenDeleteOrEdit()
    }
    
    private func dissapearWhenDeleteOrEdit() {
        guard let parrentController = self.findViewController() as? DetailedElementViewController else {
            print("There is no result of Controller")
            return
        }
        parrentController.navigationController?.popViewController(animated: true)
    }
    
    private func offKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        self.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Senders For Buttons (priority)
    @objc private func lowTapped() {
        detailedElementViewModel?.editPriority(element: .low)
    }
    
    @objc private func mediumTapped() {
        detailedElementViewModel?.editPriority(element: .medium)

    }
    
    @objc private func highTapped() {
        detailedElementViewModel?.editPriority(element: .high)
    }
    
}

//LAYOUTS
extension DetailedElementView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleTxField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleTxField.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            titleTxField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            titleTxField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textView.topAnchor.constraint(equalTo: titleTxField.bottomAnchor, constant: 25),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            stackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 25),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            deleteButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor),
            
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            saveButton.heightAnchor.constraint(equalTo: deleteButton.heightAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}

extension DetailedElementViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}
