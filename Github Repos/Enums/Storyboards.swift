//
//  Storyboards.swift
//  The Movie App
//
//  Created by Raul Marques de Oliveira on 12/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit

enum Storyboard: String {

    case Main
    
    func instantiateViewController<T: UIViewController>(WithIdentifier id: String) -> T {
        let instance = UIStoryboard.init(name: self.rawValue, bundle: Bundle.main)
        return instance.instantiateViewController(withIdentifier: id) as! T
    }
}
