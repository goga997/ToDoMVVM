//
//  ToDoElementModel.swift
//  ToDoMvvm
//
//  Created by Grigore on 09.06.2023.
//

import Foundation
import UIKit

struct ToDoElementModel: Codable, Identifiable {
    var title: String = ""
    var information: String = ""
    var priority: Priority = .low
    
    var id = UUID()
}

enum Priority: Codable {
    var color: UIColor {
        switch self {
        case .low :
            return UIColor.green
        case .medium :
            return UIColor.yellow
        case .high :
            return UIColor.red
        }
    }
    
    case low
    case medium
    case high
}
