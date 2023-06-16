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
        cellReference.colorIndicator.backgroundColor = element.priority.color
    }
    
    
    func setPriorityColor(element: ToDoElementModel) {
        cellReference.colorIndicator.backgroundColor = element.priority.color
    }
}
