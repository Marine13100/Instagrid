//
//  UIView+tranformeToImage.swift
//  Instagrid
//
//  Created by Marine Bernard on 29/06/2020.
//  Copyright © 2020 Marine Bernard. All rights reserved.
//

import UIKit

extension UIView {
    /// transforme a UIView to UIImage
    var transformeToImage: UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}
