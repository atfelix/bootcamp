//
//  AuthenticateViewController.swift
//  FoodTracker
//
//  Created by atfelix on 2017-06-05.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import UIKit

protocol SignupProtocol: class {
    func signup(username: String?, password: String?) -> Void
    func cancel() -> Void
}

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var authenticateButton: UIBarButtonItem!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameLabel: UINavigationBar!
    weak var delegate: SignupProtocol!

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


    // MARK: - Button actions


    @IBAction func authenticate(_ sender: UIBarButtonItem) {
        delegate.signup(username: usernameField.text ?? "", password: passwordField.text ?? "")
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate.cancel()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameField {
            passwordField.becomeFirstResponder()
        }
        else if textField === passwordField {
            textField.resignFirstResponder()
            delegate.signup(username: usernameField.text, password: textField.text)
        }
        return true
    }
}
