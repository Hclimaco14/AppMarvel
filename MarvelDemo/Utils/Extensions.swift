//
//  Extensions.swift
//  MarvelDemo
//
//  Created by Hector Climaco on 12/07/22.
//

import Foundation
import UIKit


let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            self.contentMode = .scaleAspectFill
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    self.contentMode = .scaleAspectFit
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
    
}

extension UIView {
    func addBlurEffect() {
        DispatchQueue.main.async {
          let blurEffect = UIBlurEffect(style: .light)
          let blurEffectView = UIVisualEffectView(effect: blurEffect)
          blurEffectView.frame = self.bounds

          blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
          self.addSubview(blurEffectView)
        }
      }
}
