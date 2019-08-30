//
//  LoginViewController.swift
//  AdventureGame
//
//  Created by Angel Buenrostro on 8/29/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case signIn
}

class LoginViewController: UIViewController {
    
    // MARK: -  Properties
    
    var apiController: APIController?
    var loginType = LoginType.signUp

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        segmentedControl.layer.cornerRadius = 8.0
        loginButton.layer.cornerRadius = 8.0
    }
    
    // MARK: - Action Handlers
    
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            loginType = .signIn
            loginButton.setTitle("Sign In", for: .normal)
            confirmTextField.isEnabled = false
            confirmTextField.isHidden = true
        } else {
            loginType = .signUp
            loginButton.setTitle("Sign Up", for: .normal)
            confirmTextField.isEnabled = true
            confirmTextField.isHidden = false
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // perform login or sign up operation based on enum loginType
        
        guard let apiController = apiController else { return }
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password1 = passwordTextField.text,
            !password1.isEmpty,
            let password2 = confirmTextField.text,
            !password2.isEmpty,
            segmentedControl.selectedSegmentIndex == 0 {
            let userRegister = UserRegister(username: username, password1: password1, password2: password2)
            
            apiController.signUp(with: userRegister) { error in
                if let error = error {
                    print("Error occurred during sign up: \(error.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }   else {
                if let username = usernameTextField.text,
                    !username.isEmpty,
                    let password = passwordTextField.text,
                    !password.isEmpty {
                    let userLogin = UserLogin(username: username, password: password)
                    
                    apiController.signIn(with: userLogin, completion: { (error) in
                            if let error = error {
                                print("Error occurred during sign in: \(error.localizedDescription)")
                            } else {
                                DispatchQueue.main.async {
                                    self.dismiss(animated: true, completion: nil)
                                }
                            }
                    })
                }
            }
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
