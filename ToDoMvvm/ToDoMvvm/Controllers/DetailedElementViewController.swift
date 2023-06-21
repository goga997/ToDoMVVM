//
//  DetailedElementViewController.swift
//  ToDoMvvm
//
//  Created by Grigore on 12.06.2023.
//

import UIKit

class DetailedElementViewController: UIViewController {

    private lazy var containerView = DetailedElementView()
            
    init(toDoElementModel: ToDoElementModel) {
        super.init(nibName: nil, bundle: nil)
        self.containerView.detailedElementViewModel = DetailedElementViewModel(detailedViewReference: containerView, toDoElementModel: toDoElementModel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
}

extension DetailedElementViewController {
    private func setConstraints() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

