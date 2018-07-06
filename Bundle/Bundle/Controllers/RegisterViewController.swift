//
//  RegisterViewController.swift
//  Bundle
//
//  Created by Daniel Frost on 4/19/18.
//  Copyright © 2018 Bundle. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let registrationWindow: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 34/255.0, green: 181/255.0, blue: 115/255.0, alpha: 1.0)
        button.setTitle("register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //button.addTarget(self, action: #selector(register), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    @objc
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Email & password required.")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (User, error ) in
            if (error != nil) {
                //error handling here
            }
            
            //successfully authenticated
        })
        
        let ref = Database.database().reference(fromURL: "https://bundle-a0145.firebaseio.com/")
        let values = ["name": name, "email": email]
        ref.updateChildValues(values) { (err, ref) in
            if err != nil {
                //error here
            }
        }
        
        print("saved user successfully")
    }
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "location"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let uploadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultprofile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode =  .scaleAspectFit
        return imageView
    }()
    
    let uploadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black
        button.alpha = 0.75
        button.setTitle("upload new picture", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        return button
    }()
    
    let emailAlert: UIImageView = {
        let emailAlert = UIImageView()
        emailAlert.translatesAutoresizingMaskIntoConstraints = false
        emailAlert.image = UIImage(named: "attention")
        emailAlert.image = emailAlert.image!.withRenderingMode(.alwaysTemplate)
        emailAlert.tintColor = UIColor.red
        return emailAlert
    }()
    
    let nameAlert: UIImageView = {
        let emailAlert = UIImageView()
        emailAlert.translatesAutoresizingMaskIntoConstraints = false
        emailAlert.image = UIImage(named: "attention")
        emailAlert.image = emailAlert.image!.withRenderingMode(.alwaysTemplate)
        emailAlert.tintColor = UIColor.red
        return emailAlert
    }()
    
    let passwordAlert: UIImageView = {
        let emailAlert = UIImageView()
        emailAlert.translatesAutoresizingMaskIntoConstraints = false
        emailAlert.image = UIImage(named: "attention")
        emailAlert.image = emailAlert.image!.withRenderingMode(.alwaysTemplate)
        emailAlert.tintColor = UIColor.red
        return emailAlert
    }()
    
    let locationAlert: UIImageView = {
        let emailAlert = UIImageView()
        emailAlert.translatesAutoresizingMaskIntoConstraints = false
        emailAlert.image = UIImage(named: "attention")
        emailAlert.image = emailAlert.image!.withRenderingMode(.alwaysTemplate)
        emailAlert.tintColor = UIColor.red
        return emailAlert
    }()
    
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "sign up"
        return lbl
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "please enter a valid email"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: label.font.fontName, size: 13)
        label.textColor = UIColor.white
        return label
    }()
    
    let imageAlert: UIImageView = {
        let emailAlert = UIImageView()
        emailAlert.translatesAutoresizingMaskIntoConstraints = false
        emailAlert.image = UIImage(named: "attention")
        emailAlert.image = emailAlert.image!.withRenderingMode(.alwaysTemplate)
        emailAlert.tintColor = UIColor.red
        return emailAlert
    }()
    
    let bio: UITextView = {
        let textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        
        return textview
    }()
    
    
    let user = User()
    var imageData: NSData?
    
    @objc
    func uploadImage() {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            uploadImageView.image = image
            imageData = UIImagePNGRepresentation(image)! as NSData
        } else {
            //display error from uploading image
        }
        self.dismiss(animated: true, completion: nil)
    }

    @objc
    func register() {
        //TODO: add email validation logic (refer to isValidEmail in LoginViewController)
        if (passwordTextField.text != "" && nameTextField.text != "" && locationTextField.text != "" && emailTextField.text != "" && imageData != nil) {
            if (isValidEmail(email: emailTextField.text!)) {
                if (user.registerUser(password: passwordTextField.text!, name: nameTextField.text!, location: locationTextField.text!, email: emailTextField.text!, image: imageData!)) {
                        UserDefaults.standard.set(emailTextField.text, forKey: "email")
                        performSegue(withIdentifier: "showMarketplace", sender: nil)
                } else {
                    //registration failed
                }
            } else {
                setUpEmailLabel()
                showAlerts()
            }
        } else {
            showAlerts()
        }
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
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
        if locationTextField.text == "" {
            setUpLocationAlert()
        } else {
            locationAlert.removeFromSuperview()
        }
        if nameTextField.text == "" {
            setUpNameAlert()
        } else {
            nameAlert.removeFromSuperview()
        }
        if imageData == nil {
            setUpImageAlert()
        } else {
            imageAlert.removeFromSuperview()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(registrationWindow)
        view.addSubview(registrationButton)
        view.addSubview(uploadImageView)
        view.addSubview(uploadButton)
        setUpRegistrationWindow()
        setUpRegistrationButton()
        setUpUploadImageView()
        setUpUploadButton()
    }
    
    func setUpEmailAlert() {
        emailTextField.addSubview(emailAlert)
        emailAlert.rightAnchor.constraint(equalTo: emailTextField.rightAnchor, constant: -20).isActive = true
        emailAlert.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailAlert.widthAnchor.constraint(equalToConstant: 25).isActive = true
        emailAlert.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setUpEmailLabel() {
        view.addSubview(emailLabel)
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: registrationWindow.topAnchor, constant: -10).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: registrationWindow.widthAnchor).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 5)
    }
    
    func setUpPasswordAlert() {
        passwordTextField.addSubview(passwordAlert)
        passwordAlert.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: -20).isActive = true
        passwordAlert.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        passwordAlert.widthAnchor.constraint(equalToConstant: 25).isActive = true
        passwordAlert.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setUpNameAlert() {
        nameTextField.addSubview(nameAlert)
        nameAlert.rightAnchor.constraint(equalTo: nameTextField.rightAnchor, constant: -20).isActive = true
        nameAlert.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor).isActive = true
        nameAlert.widthAnchor.constraint(equalToConstant: 25).isActive = true
        nameAlert.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setUpImageAlert() {
        view.addSubview(imageAlert)
        imageAlert.leftAnchor.constraint(equalTo: uploadButton.rightAnchor, constant: 10).isActive = true
        imageAlert.centerYAnchor.constraint(equalTo: uploadButton.centerYAnchor).isActive = true
        imageAlert.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageAlert.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setUpLocationAlert() {
        locationTextField.addSubview(locationAlert)
        locationAlert.rightAnchor.constraint(equalTo: locationTextField.rightAnchor, constant: -20).isActive = true
        locationAlert.centerYAnchor.constraint(equalTo: locationTextField.centerYAnchor).isActive = true
        locationAlert.widthAnchor.constraint(equalToConstant: 25).isActive = true
        locationAlert.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setUpRegistrationWindow() {
        //create constraints for the main login view
        registrationWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true
        registrationWindow.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        registrationWindow.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        registrationWindow.addSubview(nameTextField)
        registrationWindow.addSubview(nameSeparator)
        registrationWindow.addSubview(emailTextField)
        registrationWindow.addSubview(emailSeparator)
        registrationWindow.addSubview(passwordTextField)
        registrationWindow.addSubview(passwordSeparator)
        registrationWindow.addSubview(locationTextField)
        nameTextField.leftAnchor.constraint(equalTo: registrationWindow.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: registrationWindow.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: registrationWindow.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: registrationWindow.heightAnchor, multiplier: 1/4).isActive = true
        
        nameSeparator.leftAnchor.constraint(equalTo: registrationWindow.leftAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparator.widthAnchor.constraint(equalTo: registrationWindow.widthAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: registrationWindow.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSeparator.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: registrationWindow.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: registrationWindow.heightAnchor, multiplier: 1/4).isActive = true
        
        emailSeparator.leftAnchor.constraint(equalTo: registrationWindow.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: registrationWindow.widthAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: registrationWindow.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeparator.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: registrationWindow.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: registrationWindow.heightAnchor, multiplier: 1/4).isActive = true
        
        passwordSeparator.leftAnchor.constraint(equalTo: registrationWindow.leftAnchor).isActive = true
        passwordSeparator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparator.widthAnchor.constraint(equalTo: registrationWindow.widthAnchor).isActive = true
        passwordSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        locationTextField.leftAnchor.constraint(equalTo: registrationWindow.leftAnchor, constant: 12).isActive = true
        locationTextField.topAnchor.constraint(equalTo: passwordSeparator.bottomAnchor).isActive = true
        locationTextField.widthAnchor.constraint(equalTo: registrationWindow.widthAnchor).isActive = true
        locationTextField.heightAnchor.constraint(equalTo: registrationWindow.heightAnchor, multiplier: 1/4).isActive = true
    }
    
    func setUpUploadImageView() {
        uploadImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadImageView.bottomAnchor.constraint(equalTo: uploadButton.topAnchor, constant: -5).isActive = true
        uploadImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        uploadImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        uploadImageView.layer.cornerRadius = 58
        uploadImageView.layer.masksToBounds = true
        uploadImageView.layer.borderColor = UIColor.clear.cgColor
        uploadImageView.layer.borderWidth = 1.0
        
        
    }
    
    func setUpUploadButton() {
        uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadButton.bottomAnchor.constraint(equalTo: registrationWindow.topAnchor, constant: -40).isActive = true
        uploadButton.widthAnchor.constraint(equalToConstant: 175).isActive = true
        uploadButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setUpRegistrationButton() {
        registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationButton.topAnchor.constraint(equalTo: registrationWindow.bottomAnchor, constant: 12).isActive = true
        registrationButton.widthAnchor.constraint(equalTo: registrationWindow.widthAnchor).isActive = true
        registrationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func dismissModal(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
