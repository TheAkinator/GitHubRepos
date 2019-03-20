//
//  UITableViewCell+Ext.swift
//  Github Repos
//
//  Created by Raul Marques de Oliveira on 18/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var typeName: String {
        return String(describing: self)
    }
}
