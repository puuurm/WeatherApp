//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by yangpc on 19/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension UIView {

    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}
