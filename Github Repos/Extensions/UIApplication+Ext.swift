//
//  UIApplication+Ext.swift
//  The Movie App
//
//  Created by Raul Marques de Oliveira on 12/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit

extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
