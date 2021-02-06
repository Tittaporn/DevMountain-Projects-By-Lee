//
//  UIImageViewExtension.swift
//  SuperContact
//
//  Created by Lee McCormick on 2/6/21.
//

import Foundation
import UIKit

class RoundedImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = self.bounds.size.width / 2
        self.layer.cornerRadius = radius
        self.contentMode = .scaleAspectFill
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }
}//end of class //AND WE NEED TO CLASS image in Storyboard to be the RoundedImage
