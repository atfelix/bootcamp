//
//  AuthenticateViewController.swift
//  FoodTracker
//
//  Created by atfelix on 2017-06-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

enum AuthenticationType {
    case login, signup
}

protocol AuthenticateProtocol: class {
    func authenticate() -> Void
    func cancel() -> Void
}

class AuthenticateViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var authenticateButton: UIBarButtonItem!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameLabel: UINavigationBar!
    weak var delegate: AuthenticateProtocol!
    var authType: AuthenticationType = .signup

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordField.textColor = UIColor.white
        passwordField.backgroundColor = UIColor.white
        passwordField.delegate = self
        usernameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    // MARK: - Authenticate User and Password


    func authenticate(username: String, token: String) {
        if !isValidUsername(username: username) || !isValidToken(token: token) {
            return
        }

        switch authType {
            case .login: APIManager.loginUser(username: username, password: token)
            case .signup: APIManager.signupUser(username: username, password: token)
        }
    }


    // MARK: - Validate password


    func isValidUsername(username: String) -> Bool {
        return username.characters.count > 0
    }

    func isValidToken(token: String) -> Bool {
        return token.characters.count >= 4
    }


    // MARK: - Button actions


    @IBAction func authenticate(_ sender: UIBarButtonItem) {
        authenticate(username: usernameField.text ?? "", token: passwordField.text ?? "")
        delegate.authenticate()
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate.cancel()
    }


    // MARK: - UITextField delegate methods


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        var returnValue = false

        if textField === usernameField && isValidUsername(username: textField.text ?? "") {
            passwordField.becomeFirstResponder()
            returnValue = true
        }
        else if textField === passwordField && isValidToken(token: textField.text ?? "") {
            textField.resignFirstResponder()
            returnValue = true
        }

        return returnValue
    }
}
