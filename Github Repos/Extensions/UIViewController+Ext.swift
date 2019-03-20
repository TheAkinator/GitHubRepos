//
//  UIViewController+Ext.swift
//  The Movie App
//
//  Created by Raul Marques de Oliveira on 12/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static var className: String {
        return String(describing: self)
    }
    
    class func instantiateFromStoryboard(storyboard: Storyboard) -> Self{
        
        return storyboard.instantiateViewController(WithIdentifier: className)
        
    }
    
    func navBarWithNoShadow() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.tintColor = .white
        navigationBar?.barTintColor = .appColor
        navigationBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.isTranslucent = false
    
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "WorkSans-SemiBold", size: 17)!,NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func presentSimpleAlert(title: String, andMessage message: String, onDismiss: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let onDismiss = onDismiss {
                onDismiss()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

