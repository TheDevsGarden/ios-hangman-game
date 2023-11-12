//
//  LoginController.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        loginButton.isEnabled = false
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        guard let username = userNameInput.text, !username.isEmpty else {
            showErrorMessage("Please enter a valid username.")
            return
        }
        
        UserDefaults.standard.set(username, forKey: "username")
//        performSegue(withIdentifier: "goToNextPage", sender: self)
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        loginButton.isEnabled = !(textField.text?.isEmpty ?? true)
    }
}

