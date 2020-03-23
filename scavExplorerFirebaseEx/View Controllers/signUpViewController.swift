//
//  signUpViewController.swift
//  scavExplorerFirebaseEx
//
//  Created by Jacob Huffman on 3/15/20.
//  Copyright © 2020 Jacob Huffman. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class signUpViewController: UIViewController {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var backButton: UIButton!
    
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

    //Check fields and validate correct data
    func validateFields() -> String?
    {
        
        //Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        
        //Check if password is Secure
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanPassword) == false{
            return "Password is not secure enough. Please make sure that it is at least 8 characters long, has a number and a special character"
        
        }
        return nil
    }

    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //Validate fields
        let error = validateFields()
        
        if error != nil {
            //Error detected, show error
            showError(error!)
        }
        else
        {
            //Create cleanded versions of the data
            let first_name = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let last_name = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //check for errors
                if err != nil {
                    //there was an error
                    self.showError("Error creating user")
                }
                else
                {
                    //user was created successfully, now store first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["first_name":first_name, "last_name":last_name, "uid":result!.user.uid]) { (error) in
                        
                        if error != nil
                        {
                            self.showError("User data couldn't be stored. Log in should still work")
                        }
                    }
                    //Transition to home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome()
    {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? homeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
