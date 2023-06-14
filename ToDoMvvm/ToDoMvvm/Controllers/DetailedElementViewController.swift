//
//  DetailedElementViewController.swift
//  ToDoMvvm
//
//  Created by Grigore on 12.06.2023.
//

import UIKit

class DetailedElementViewController: UIViewController {

    private lazy var containerView: ContainerViewDetailedElement = {
        let view = ContainerViewDetailedElement()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(toDoElementModel: ToDoElementModel) {
        super.init(nibName: nil, bundle: nil)
        containerView.detailedElementViewModel = DetailedElementViewModel(detailedViewReference: containerView, toDoElementModel: toDoElementModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
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

