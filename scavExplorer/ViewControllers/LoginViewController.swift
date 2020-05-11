//
//  LoginViewController.swift
//  scavExplorer
//
//  Created by Jacob Huffman on 4/17/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements()
    {
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String? {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        return nil
    }


    @IBAction func loginTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                
                if err != nil {
                    self.showError(err!.localizedDescription)
                }
                else {
                    self.transitionToHome()
                }
            }
        }
        
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome()
    {
        let navController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.navigationController)
        
        view.window?.rootViewController = navController
        view.window?.makeKeyAndVisible()
    }
}
