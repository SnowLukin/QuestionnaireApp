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
        // move view when keyboard change frame
        getKeyboardStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginButton.setGreenGradient()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Override methods
    
    // Hide keyboard by touching on screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @objc func keyboardWillBeShown(_ notification: NSNotification) {
        
        // move view when keyboard shows up
        let heigthChange: CGFloat = 20
        view.frame.origin.y = 0 - heigthChange
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        
        // move view back to normal
        view.frame.origin.y = 0
    }
    
    // MARK: Private Methods
    
    private func setTextFields() {
        userInformationTF.returnKeyType = .done
        userInformationTF.enablesReturnKeyAutomatically = true
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
    
    // Keyboard
    private func getKeyboardStatus() {
        
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
