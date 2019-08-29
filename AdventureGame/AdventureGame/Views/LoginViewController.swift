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
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // perform login or sign up operation based on enum loginType
        
        guard let apiController = apiController else { return }
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password1 = passwordTextField.text,
            !password1.isEmpty,
            let password2 = confirmTextField.text,
            !password2.isEmpty {
            let user = User(username: username, password1: password1, password2: password2)
            
            if loginType == .signUp {
                // signup with apicontroller function
                
                // Dispatch queue main to perform UI changes
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
