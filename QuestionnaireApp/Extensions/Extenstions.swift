//
//  Extenstions.swift
//  QuestionnaireApp
//
//  Created by Snow Lukin on 21.12.2021.
//

import UIKit

// MARK: - UIView
extension UIView {
    func setCustomContainerView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    func setGreenGradient() {
        let gradientLayer = CAGradientLayer()
        
        let lightGreenColor = UIColor(red: 0.097, green: 0.969, blue: 0.792, alpha: 1)
        let greenColor = UIColor(red: 0.254, green: 0.643, blue: 0.668, alpha: 1)
        
        gradientLayer.colors = [greenColor.cgColor, lightGreenColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 12
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - UIAlertController
extension UIAlertController {
    
    func setNeededFont() {
        let attributedString = NSAttributedString(string: self.message ?? "", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor : UIColor.gray
        ])
        
        self.setValue(attributedString, forKey: "attributedMessage")
    }
}
