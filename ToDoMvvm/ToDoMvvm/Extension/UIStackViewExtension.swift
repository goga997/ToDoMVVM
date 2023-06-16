//
//  UIStackViewExtension.swift
//  ToDoMvvm
//
//  Created by Grigore on 16.06.2023.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
//        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
