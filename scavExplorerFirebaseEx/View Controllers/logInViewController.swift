//
//  logInViewController.swift
//  scavExplorerFirebaseEx
//
//  Created by Jacob Huffman on 3/15/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import UIKit
import FirebaseAuth

class logInViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    
    func setUpElements()
    {
        //hide error label
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String?
    {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        return nil
    }

    
    
    @IBAction func signInTapped(_ sender: Any) {
        
        //TODO: validate text fields
        let error = validateFields()
        
        if error != nil
        {
            showError(error!)
        }
        else
        {
        
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else
                {
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? homeViewController
                
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    
    
    func showError(_ message:String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
