//
//  File.swift
//  ToDoMvvm
//
//  Created by Grigore on 16.06.2023.
//

import Foundation

protocol SetNewElementViewModelProtocol {
    var setNewElementViewRefference: SetNewElementView { get set }
    var subject: Subject { get set }
    
    func save()
    func setPriority(element: Priority)
}

class SetNewElementViewModel: SetNewElementViewModelProtocol {
    var setNewElementViewRefference: SetNewElementView
    var subject: Subject

    
    init(setNewElementViewRefference: SetNewElementView) {
        self .setNewElementViewRefference = setNewElementViewRefference
        self.subject = Subject()
    }
    
    func save() {
        guard let title = setNewElementViewRefference.textField.text else { return }
        guard let description = setNewElementViewRefference.descriptionTextView.text else { return }
        
        subject.modifyTitle(tittle: title)
        subject.modifyInformation(information: description)
        DataBaseService.shared.addData(element: subject.context)
    }
    
    func setPriority(element: Priority) {
        subject.modifyPriority(priority: element)
    }
    
}
