//
//  ToDoElementModel.swift
//  ToDoMvvm
//
//  Created by Grigore on 09.06.2023.
//

import Foundation
import UIKit

struct ToDoElementModel: Codable, Identifiable {
    var title: String
    var information: String
    var priority: Priority
    
    var id = UUID()
    
    init(title: String, information: String, priority: String) {
        self.title = title
        self.information = information
        self.priority = .init(rawValue: priority) ?? .low
    }
    
    init() {
        self.title = ""
        self.information = ""
        self.priority = .low
    }
}

enum Priority: String, Codable {
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
    
    var rawValue: String {
        switch self {
        case .low:
            return "low"
        case .medium:
            return "medium"
        case .high:
            return "high"
        }
    }
    
    case low = "low"
    case medium = "medium"
    case high = "high"
}
