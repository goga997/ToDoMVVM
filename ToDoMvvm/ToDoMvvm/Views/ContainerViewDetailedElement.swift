//
//  ContainerViewDetailedElement.swift
//  ToDoMvvm
//
//  Created by Grigore on 14.06.2023.
//

import UIKit

class ContainerViewDetailedElement: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .yellow
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = .darkGray
        textView.textColor = .white
        textView.isEditable = false
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 20
        
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var detailedElementViewModel: DetailedElementViewModelProtocol? {
        didSet
        {
            detailedElementViewModel?.setUpTitle()
            detailedElementViewModel?.setUpINformation()
            detailedElementViewModel?.setUpPriority()
            
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
        setConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setConstraints()
    }
    
    private func setUpViews() {
        self.addSubview(titleLabel)
        self.addSubview(textView)
    }

}

//LAYOUTS
extension ContainerViewDetailedElement {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
        ])
    }
}

