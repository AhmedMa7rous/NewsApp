//
//  UIView+Extension.swift
//  NewsApp
//
//  Created by Adam on 09/05/2023.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}
