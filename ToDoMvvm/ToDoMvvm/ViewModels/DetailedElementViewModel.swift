//
//  DetailedElementViewModel.swift
//  ToDoMvvm
//
//  Created by Grigore on 12.06.2023.
//

// 1. fac UI pentru DetCOntr!
// 2. fac ca prin VIewModel sa se seteze titl inform si culoarea 

import Foundation
import UIKit

protocol DetailedElementViewModelProtocol {
    var toDoElementModel: ToDoElementModel { get }
    var detailedViewReference: ContainerViewDetailedElement { get set }
    
    init(detailedViewReference: ContainerViewDetailedElement, toDoElementModel: ToDoElementModel)
    
    func setUpTitle()
    func setUpINformation()
    func setUpPriority()
}


class DetailedElementViewModel: DetailedElementViewModelProtocol {
    
    var detailedViewReference: ContainerViewDetailedElement
    
    var toDoElementModel: ToDoElementModel
  
   required init(detailedViewReference: ContainerViewDetailedElement, toDoElementModel: ToDoElementModel) {
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

}
