//
//  RoundButton.swift
//  quizTeam
//
//  Created by Lee McCormick on 3/8/21.
//

import UIKit

extension UIView {
    func addCornerRadius(radius: CGFloat = 6) {
        self.layer.cornerRadius = radius
    }

    class QuizButton: UIButton {
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupView()
        }
        
        func setupView() {
//            self.backgroundColor = .blue
//            self.setTitleColor(.white, for: .normal)
            self.addCornerRadius()
        }
    }
}
