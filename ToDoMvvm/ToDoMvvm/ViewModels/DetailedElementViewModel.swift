//
//  DetailedElementViewModel.swift
//  ToDoMvvm
//
//  Created by Grigore on 12.06.2023.
//

import Foundation
import UIKit

protocol DetailedElementViewModelProtocol {
    var toDoElementModel: ToDoElementModel { get }
    var detailedViewReference: DetailedElementView { get set }
    
    init(detailedViewReference: DetailedElementView, toDoElementModel: ToDoElementModel)
    
    func setUpTitle()
    func setUpINformation()
    func setUpPriority()
    func deleteElement()
    func editElement()
    func editPriority(element: Priority)
}


class DetailedElementViewModel: DetailedElementViewModelProtocol {
    
    var detailedViewReference: DetailedElementView
    var toDoElementModel: ToDoElementModel
    
    required init(detailedViewReference: DetailedElementView, toDoElementModel: ToDoElementModel) {
        self.detailedViewReference = detailedViewReference
        self.toDoElementModel = toDoElementModel
    }
    
    
    func setUpTitle() {
        detailedViewReference.titleTxField.text = toDoElementModel.title
    }
    
    
    func setUpINformation() {
        detailedViewReference.textView.text = toDoElementModel.information
    }
    
    
    func setUpPriority() {
        detailedViewReference.textView.layer.borderColor = toDoElementModel.priority.color.cgColor
        detailedViewReference.textView.layer.borderWidth = 3
    }
    
    
    func deleteElement() {
        DataBaseService.shared.deleteElement(id: toDoElementModel.id)
    }
    
    
    func editElement() {
        guard let valueFromTextField = detailedViewReference.titleTxField.text else { return }
        toDoElementModel.title = valueFromTextField
        
        guard let valueFromTextView = detailedViewReference.textView.text else { return }
        toDoElementModel.information = valueFromTextView
        
        DataBaseService.shared.editElement(element: toDoElementModel)
    }
    
    
    func editPriority(element: Priority) {
        toDoElementModel.priority = element
        DataBaseService.shared.editElement(element: toDoElementModel)
    }
}
