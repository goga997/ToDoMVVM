//
//  ViewController.swift
//  ToDoMvvm
//
//  Created by Grigore on 09.06.2023.
//

import UIKit

class MainViewController: UIViewController {

    lazy var horizontalTitleStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .systemBlue
        stackView.layer.cornerRadius = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let image = UIImage(systemName: "plus.circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.addTarget(self, action: #selector(addingAction), for: .touchUpInside)
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupHorizontalTitleStackView()
        setLayout()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.idCell)
        
        
    }

    private func setUpView() {
        view.addSubview(tableView)
        view.addSubview(addButton)
    }
    
    @objc private func addingAction() {
        let setNewElementViewController = SetNewElementViewController()
        navigationController?.pushViewController(setNewElementViewController, animated: true)
    }

}

//LAYOUTS
extension MainViewController {
    
    private func setupHorizontalTitleStackView() {
        let line = UIView()
        line.backgroundColor = .white
        line.translatesAutoresizingMaskIntoConstraints = false
        let lineSecond = UIView()
        lineSecond.backgroundColor = .white
        lineSecond.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "To Do"
        label.font = UIFont(name: "Avenir Next Bold", size: 32)
        label.textAlignment = .center
        label.textColor = .white
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.cornerRadius = 7
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        horizontalTitleStackView.addSubview(line)
        horizontalTitleStackView.addSubview(label)
        horizontalTitleStackView.addSubview(lineSecond)
        
        view.addSubview(horizontalTitleStackView)
        NSLayoutConstraint.activate([
            horizontalTitleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalTitleStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            horizontalTitleStackView.topAnchor.constraint(equalTo: view.topAnchor),
            horizontalTitleStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
            label.centerXAnchor.constraint(equalTo: horizontalTitleStackView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: horizontalTitleStackView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: horizontalTitleStackView.widthAnchor, multiplier: 0.5),
            label.heightAnchor.constraint(equalTo: horizontalTitleStackView.heightAnchor, multiplier: 0.3),
            
            line.trailingAnchor.constraint(equalTo: label.leadingAnchor),
            line.leadingAnchor.constraint(equalTo: horizontalTitleStackView.leadingAnchor),
            line.centerYAnchor.constraint(equalTo: horizontalTitleStackView.centerYAnchor),
            line.heightAnchor.constraint(equalToConstant: 2),
            
            lineSecond.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            lineSecond.trailingAnchor.constraint(equalTo: horizontalTitleStackView.trailingAnchor),
            lineSecond.centerYAnchor.constraint(equalTo: horizontalTitleStackView.centerYAnchor),
            lineSecond.heightAnchor.constraint(equalToConstant: 2),
        ])
    }

    
    private func setLayout() {
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: horizontalTitleStackView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: 20),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            addButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor)
        ])
    }
}

// TABLEVIEW DELEGATES + DATA SOURCE
typealias MainViewControllerDelegates = MainViewController
extension MainViewControllerDelegates: UITableViewDataSource, UITableViewDelegate {
    //1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataBaseService.shared.elementsData.count
    }
    
    //2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idCell, for: indexPath) as? TableViewCell else { return UITableViewCell() }
      
        cell.selectionStyle = .none
        cell.tableViewCellViewModel?.setUpData(element: DataBaseService.shared.elementsData[indexPath.row])
        cell.tableViewCellViewModel?.setPriorityColor(element: DataBaseService.shared.elementsData[indexPath.row])
        return cell
    }
    
    //3
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentElement = DataBaseService.shared.elementsData[indexPath.row]
        
        let detailedViewController = DetailedElementViewController(toDoElementModel: currentElement)
        navigationController?.pushViewController(detailedViewController, animated: true)
        
    }
    
}


