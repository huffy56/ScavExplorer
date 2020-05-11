//
//  SignUpViewController.swift
//  scavExplorer
//
//  Created by Jacob Huffman on 4/17/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
  
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
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
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
            return "Please fill in all fields."
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is 8 characters long, contains a special character and a number"
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //Validate fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil {
                    //There was an error
                    self.showError("Error creating user")
                }
                else {
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["email": email, "firstname": firstName, "lastname": lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            self.showError("Problem with storing user data. Log in still functional")
                        }
                    }
                    
                    //Transition to home
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
