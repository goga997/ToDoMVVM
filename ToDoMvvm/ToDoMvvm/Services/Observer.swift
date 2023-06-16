//
//  Services.swift
//  ToDoMvvm
//
//  Created by Grigore on 16.06.2023.
//

import Foundation

protocol Observer {
    func update(subject: Subject)
        
}

class Subject {
    
    private lazy var observers = [Observer]()
    
    var context = ToDoElementModel()
    
    func addObserver(observer: Observer) {
        observers.append(observer)
    }
    
    func notify() {
        observers.forEach({$0.update(subject: self)})
    }
    
    func modifyTitle(tittle: String) {
        context.title = tittle
        notify()
    }
    
    func modifyInformation(information: String) {
        context.information = information
        notify()
    }
    
    func modifyPriority(priority: Priority) {
        context.priority = priority
        notify()
    }
}

