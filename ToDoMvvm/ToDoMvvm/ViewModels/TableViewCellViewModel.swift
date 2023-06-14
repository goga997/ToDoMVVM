//
//  TableViewCellViewModel.swift
//  ToDoMvvm
//
//  Created by Grigore on 09.06.2023.
//

import Foundation
import UIKit

protocol TableViewCellViewModelProtocol {
    var cellReference: TableViewCell { get set }
    func setUpData(element: ToDoElementModel)
    
    func setPriorityColor(element: ToDoElementModel)
}

class TableViewCellViewModel: TableViewCellViewModelProtocol {
    
    var cellReference: TableViewCell
        
    init(cellReference: TableViewCell) {
        self.cellReference = cellReference
    }
    
    
    func setUpData(element: ToDoElementModel) {
        cellReference.namelabel.text = element.title
    }
    
    func setPriorityColor(element: ToDoElementModel) {
        switch element.priority {
        case .low :
            cellReference.namelabel.textColor = .green
        case .medium :
            cellReference.namelabel.textColor = .yellow
        case .high :
            cellReference.namelabel.textColor = .red

        }
        
    }
    
}
