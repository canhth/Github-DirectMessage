//
//  ImageView.swift
//  Messenger
//
//  Created by Canh Tran Wizeline on 3/10/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(urlString: String) {
        
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                Logger.shared.error(object: "Couldn't download image: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                Logger.shared.error(object: "Unable to parse image: \(urlString)")
                return
            }
            
            ImageCache.shared.save(image: image, forKey: urlString)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()

    }
}
