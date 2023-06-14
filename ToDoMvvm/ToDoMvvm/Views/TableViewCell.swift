//
//  TableViewCell.swift
//  ToDoMvvm
//
//  Created by Grigore on 09.06.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let idCell = "idCell"
    
    var tableViewCellViewModel: TableViewCellViewModelProtocol?
    
    lazy var namelabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 26)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.tableViewCellViewModel = TableViewCellViewModel(cellReference: self)

        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
        setConstraints()
    }
    
    
    private func setUpView() {
        self.addSubview(namelabel)
        backgroundColor = .clear
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            namelabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            namelabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            namelabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            namelabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
        ])
    }
}


