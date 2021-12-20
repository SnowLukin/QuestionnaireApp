//
//  ViewController.swift
//  QuestionnaireApp
//
//  Created by Snow Lukin on 20.12.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userInformationTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
        setInfoTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginButton.setGreenGradient()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setButton() {
        loginButton.layer.cornerRadius = 12
    }
    
    private func setInfoTextField() {
        
        let lightGreenColor = UIColor(red: 0.097, green: 0.969, blue: 0.792, alpha: 1)
        
        userInformationTF.layer.borderColor = lightGreenColor.cgColor
        userInformationTF.layer.borderWidth = 2
        userInformationTF.layer.cornerRadius = 10
    }
}

extension UIView {
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
