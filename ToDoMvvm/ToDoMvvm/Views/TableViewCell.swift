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
    
    lazy var colorIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var underTextBack: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        view.layer.cornerRadius = 25
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorIndicator.layer.cornerRadius = colorIndicator.frame.size.height / 2
    }
    
    private func setUpView() {
        self.addSubview(underTextBack)
        self.addSubview(namelabel)
        self.addSubview(colorIndicator)
        backgroundColor = .clear
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            underTextBack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -0),
            underTextBack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            underTextBack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            underTextBack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            namelabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            namelabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            namelabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            namelabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            
            colorIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            colorIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            colorIndicator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            colorIndicator.widthAnchor.constraint(equalTo: colorIndicator.heightAnchor)
            
        ])
    }
}


