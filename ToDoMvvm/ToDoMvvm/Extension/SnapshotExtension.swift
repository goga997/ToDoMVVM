//
//  SnapshotExtension.swift
//  ToDoMvvm
//
//  Created by Grigore on 22.06.2023.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot {
    
    func decoded<Type: Decodable>() throws -> Type {
        
            let jsonData = try JSONSerialization.data(withJSONObject: data())
            let object = try JSONDecoder().decode(Type.self, from: jsonData)
            return object
        
    }
    
}
