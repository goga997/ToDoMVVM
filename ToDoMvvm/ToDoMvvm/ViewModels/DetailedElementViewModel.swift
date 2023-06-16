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
}


class DetailedElementViewModel: DetailedElementViewModelProtocol {
    
    
    var detailedViewReference: DetailedElementView
    var toDoElementModel: ToDoElementModel
  
    required init(detailedViewReference: DetailedElementView, toDoElementModel: ToDoElementModel) {
        self.detailedViewReference = detailedViewReference
        self.toDoElementModel = toDoElementModel
    }
    
    func setUpTitle() {
        detailedViewReference.titleLabel.text = toDoElementModel.title
    }
    
    func setUpINformation() {
        detailedViewReference.textView.text = toDoElementModel.information
    }
    
    func setUpPriority() {
        detailedViewReference.textView.layer.borderColor = toDoElementModel.priority.color.cgColor
        detailedViewReference.textView.layer.borderWidth = 3
    }
    
    func deleteElement() {
        var temporarContainer = DataBaseService.shared.readData()

        temporarContainer.removeAll(where: {$0.id == toDoElementModel.id})

        DataBaseService.shared.save(dataArray: temporarContainer)
    }
}
