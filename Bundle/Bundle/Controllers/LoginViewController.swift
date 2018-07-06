//
//  LoginViewController.swift
//  Bundle
//
//  Created by Daniel Frost on 4/18/18.
//  Copyright © 2018 Bundle. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let inputsView: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 34/255.0, green: 181/255.0, blue: 115/255.0, alpha: 1.0)
        button.setTitle("login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "whitefulllogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode =  .scaleAspectFit
        return imageView
    }()
    
    let emailAlert: UIImageView = {
        let emailAlert = UIImageView()
        emailAlert.translatesAutoresizingMaskIntoConstraints = false
        emailAlert.image = UIImage(named: "attention")
        emailAlert.image = emailAlert.image!.withRenderingMode(.alwaysTemplate)
        emailAlert.tintColor = UIColor.red
        return emailAlert
    }()
    
    let passwordAlert: UIImageView = {
        let passwordAlert = UIImageView()
        passwordAlert.translatesAutoresizingMaskIntoConstraints = false
        passwordAlert.image = UIImage(named: "attention")
        passwordAlert.image = passwordAlert.image!.withRenderingMode(.alwaysTemplate)
        passwordAlert.tintColor = UIColor.red
        return passwordAlert
    }()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "need an account?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: label.font.fontName, size: 13)
        label.textColor = UIColor.white
        return label
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 34/255.0, green: 181/255.0, blue: 115/255.0, alpha: 1.0)
        button.setTitle("sign Up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        return button
    }()
    
    let userNotFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "invalid username or password"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: label.font.fontName, size: 13)
        label.textColor = UIColor.red
        return label
    }()
    
    let model = User()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(inputsView)
        view.addSubview(loginButton)
        view.addSubview(logo)
        setUpInputsView()
        setUpLoginButton()
        setUpLogo()
        setUpRegisterLabel()
        setUpRegisterButton()
    }
    
    @objc func login() {
        if emailTextField.text != "" && passwordTextField.text != "" {
            if (isValidEmail(email: emailTextField.text!)) {
                if let password = passwordTextField.text, password.count >= 4 {
                    //validate the user, if successful show the marketplace
                    if (model.login(email: emailTextField.text!, password: passwordTextField.text!)) {
                        UserDefaults.standard.set(emailTextField.text, forKey: "email")
                        self.performSegue(withIdentifier: "showMainController", sender: nil)
                    } else {
                        setUpNotFoundLabel()
                    }
                } else {
                    //password too short
                }
            } else {
                //not a valid email
            }
        } else {
            //check to see which field has no text, and add a warning 
            showAlerts()
        }
    }
    
    func showAlerts() {
        if emailTextField.text == "" {
            setUpEmailAlert()
        } else {
            emailAlert.removeFromSuperview()
        }
        if passwordTextField.text == "" {
            setUpPasswordAlert()
        } else {
            passwordAlert.removeFromSuperview()
        }
    }
    
    //Function to validate whether an email is valid through regex
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    @objc func register() {
        self.performSegue(withIdentifier: "openRegisterModal", sender: nil)
    }
    
    func setUpRegisterButton() {
        view.addSubview(registerButton)
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpRegisterLabel() {
        view.addSubview(registerLabel)
        registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        registerLabel.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerLabel.heightAnchor.constraint(equalToConstant: 5)
    }
    
    func setUpNotFoundLabel() {
        view.addSubview(userNotFoundLabel)
        userNotFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userNotFoundLabel.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -10).isActive = true
        userNotFoundLabel.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        userNotFoundLabel.heightAnchor.constraint(equalToConstant: 5)
    }
    
    func setUpEmailAlert() {
        emailTextField.addSubview(emailAlert)
        emailAlert.rightAnchor.constraint(equalTo: emailTextField.rightAnchor, constant: -20).isActive = true
        emailAlert.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailAlert.widthAnchor.constraint(equalToConstant: 25).isActive = true
        emailAlert.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setUpPasswordAlert() {
        passwordTextField.addSubview(passwordAlert)
        passwordAlert.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -20).isActive = true
        passwordAlert.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        passwordAlert.widthAnchor.constraint(equalToConstant: 25).isActive = true
        passwordAlert.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setUpLogo() {
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -20).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 300).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setUpLoginButton() {
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpInputsView() {
        //create constraints for the main login view
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //add a textfield for the email & password as well as a line to separate the two
        inputsView.addSubview(emailTextField)
        inputsView.addSubview(emailSeparator)
        inputsView.addSubview(passwordTextField)
        //set up constraints for the email text field
        emailTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2).isActive = true
        
        //line to separate email and password fields
        emailSeparator.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //password field constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeparator.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}
