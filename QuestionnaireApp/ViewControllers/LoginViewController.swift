//
//  ViewController.swift
//  QuestionnaireApp
//
//  Created by Snow Lukin on 20.12.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var userInformationTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
        setInfoTextField()
        // move view when keyboard change frame
        getKeyboardStatus()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.setGreenGradient()
    }
    
    // MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard userInformationTF.text != nil, userInformationTF.text != "" else {
            let title = "Invilid name\n"
            let message = "Please enter your name and try again.\n"
            invalidInputAlert(title: title, message: message)
            return
        }
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
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        userInformationTF.text = nil
    }
    
    @objc func keyboardWillBeShown(_ notification: NSNotification) {
        
        // move view when keyboard shows up
        let heigthChange: CGFloat = 80
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
        loginButton.setCustomContainerView()
    }
    
    private func setInfoTextField() {
        
        let lightGreenColor = UIColor(red: 0.097, green: 0.969, blue: 0.792, alpha: 1)
        
        userInformationTF.delegate = self
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

// MARK: Alerts
extension LoginViewController {
    private func invalidInputAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.setNeededFont()
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: TextField
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "LogInSegue", sender: self)
        return true
    }
}
