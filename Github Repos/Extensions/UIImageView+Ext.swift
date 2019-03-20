//
//  UIImageView+Ext.swift
//  The Movie App
//
//  Created by Raul Marques de Oliveira on 12/03/19.
//  Copyright © 2019 Raul Marques de Oliveira. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode

        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            
            self.image = cachedImage
            
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    
                    self.image = image
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    
                }
                }.resume()
        }
        
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}
