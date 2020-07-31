//
//  ViewController.swift
//  FriendlyChatSwift
//
//  Created by William Lewis on 4/7/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Properties
    var user: User?
    var displayName = "Anonymous"
    
    // MARK: UI
    
    let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo2"))
        logoImageView.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .white
        return view
    }()
    
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.isEmpty != true && passwordTextField.text?.isEmpty != true
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 126, green: 126, blue: 126)
        }
    }
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign UP", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 126, green: 126, blue: 126)
        
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    //let name = user!.email!.components(separatedBy: "@")[0]
    //self.displayName = name
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text, !email.isEmpty else { return }
//        let username = emailTextField.text!.components(separatedBy: "@")[0]
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error: Error?) in
            
            if let err = error {
                print("Failed to create user:", err)
                return
            }
            
            print("Successfully created user:", user?.user.uid ?? "")
            
            guard let uid = user?.user.uid else { return }
            
            guard let fcmToken = Messaging.messaging().fcmToken else { return }
            
            //create firestore user
            let firUser = FireStoreUser.init(id: uid, stripeId: "")
            self.createFirestoreUser(user: firUser)
            
            let dictionaryValues = ["fcmToken": fcmToken, "email": email]
            let values = [uid: dictionaryValues]
            
            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if let err = err {
                    print("Failed to save user info into db:", err)
                    return
                }
                
                print("Successfully saved user info to db")
                
                guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
                
                mainTabBarController.setupViewControllers()
                
                self.dismiss(animated: true, completion: nil)
                
            })
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(logoContainerView)
        
        logoContainerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        logoContainerView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        logoContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, signUpButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoContainerView.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 200)
            ])

    }
    
    func createFirestoreUser(user: FireStoreUser) {
        // Step 1: Create document reference
        let newUserRef = Firestore.firestore().collection("users").document(user.id)
        
        // Step 2: Create model firestoreDoc
        let firestoreDoc = FireStoreUser.modelToFSDoc(user: user)
        
        // Step 3: Upload to Firestore.
        newUserRef.setData(firestoreDoc) { (error) in
            if let error = error {
                Auth.auth().handleFireAuthError(error: error, vc: self)
                debugPrint("Error signing in: \(error.localizedDescription)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    
}
