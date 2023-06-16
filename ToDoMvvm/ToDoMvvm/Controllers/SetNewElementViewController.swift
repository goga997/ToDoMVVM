//
//  SetNewElementViewController.swift
//  ToDoMvvm
//
//  Created by Grigore on 12.06.2023.
//

import UIKit

class SetNewElementViewController: UIViewController {

    private let containerView = SetNewElementView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.containerView.setNewElementViewModel = SetNewElementViewModel(setNewElementViewRefference: containerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
    }
}

extension SetNewElementViewController {
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
