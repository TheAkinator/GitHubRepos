//
//  UICollectionCel+Ext.swift
//  The Movie App
//
//  Created by Raul Marques de Oliveira on 12/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    class var typeName: String {
        return String(describing: self)
    }
}
