//
//  ToDoFireBase.swift
//  ToDoMvvm
//
//  Created by Grigore on 22.06.2023.
//

import Foundation
import FirebaseFirestore


struct ToDoFireBase: Decodable {
    let information: String
    let title: String
    let priority: String
    
}
