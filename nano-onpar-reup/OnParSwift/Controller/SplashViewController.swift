//
//  SplashViewController.swift
//  OnParSwift
//
//  Created by William Lewis on 4/15/20.
//  Copyright © 2020 Google Inc. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    let logoContainerView: UIView = {
        let view = UIView()
        
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo2"))
        logoImageView.contentMode = .scaleAspectFill
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .white
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 5
        
        
        button.addTarget(self, action: #selector(handleLoginSegue), for: .touchUpInside)
        
        button.isEnabled = true
        
        return button
    }()
    
    @objc func handleLoginSegue() {
        //Dont have navcontroller so cant do this
        let loginController = LoginViewController()
        navigationController?.pushViewController(loginController, animated: true)
        
        //OR
//        var loginController: LoginViewController
//              loginController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//               present(loginController, animated: true, completion: nil)
    }
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.backgroundColor = UIColor.rgb(red: 229, green: 230, blue: 231)
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(handleSignUpSegue), for: .touchUpInside)
        
        //button.isEnabled = true
        
        return button
    }()
    
    @objc func handleSignUpSegue() {
            let signupController = SignupViewController()
            navigationController?.pushViewController(signupController, animated: true)
            
            //OR
//            var signupController: SignupViewController
//                   signupController = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
//                   present(signupController, animated: true, completion: nil)
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 160, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = .white
        
        createButtonStackView()
        
    }
    
    fileprivate func createButtonStackView(){
        let stackView = UIStackView(arrangedSubviews: [signUpButton,loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 120)
    }
}
