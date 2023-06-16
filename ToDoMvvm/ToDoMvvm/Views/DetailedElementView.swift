//
//  ContainerViewDetailedElement.swift
//  ToDoMvvm
//
//  Created by Grigore on 14.06.2023.
//

import UIKit

class DetailedElementView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 20
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .white
        textView.isEditable = false
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
    
    var detailedElementViewModel: DetailedElementViewModelProtocol? {
        didSet
        {
            detailedElementViewModel?.setUpTitle()
            detailedElementViewModel?.setUpINformation()
            detailedElementViewModel?.setUpPriority()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
        setConstraints()
    }
    
    private func setUpViews() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
        self.addSubview(textView)
        self.addSubview(deleteButton)
        
    }
    
    @objc private func deleteButtonTapped() {
        detailedElementViewModel?.deleteElement()
        
    }

}

//LAYOUTS
extension DetailedElementView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 90),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            deleteButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor)
        ])
    }
}

