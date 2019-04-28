//
//  AuthViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/3/17.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - AuthViewController

import TinyCore
import UIKit

final class AuthViewController: UIViewController {

    var didProvideCredentials: ( (AuthViewController, Basic) -> Void )?

    private lazy var signUpButton = makeSignUpButton()
    
}

extension AuthViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate(
            [
                view.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor),
                view.centerYAnchor.constraint(equalTo: signUpButton.centerYAnchor)
            ]
        )
        
    }
    
}

extension AuthViewController {
    
    @objc
    func signUp(sender: Any) {
        
        #warning("Use text fields to replace magic strings.")
        
        didProvideCredentials?(
            self,
            Basic(
                username: "Katherine",
                password: "password"
            )
        )
        
    }
    
}

extension AuthViewController {
    
    private func makeSignUpButton() -> UIButton {
        
        let button = UIButton(type: .roundedRect)
        
        let title = "Sign Up"
        
        button.setTitle(
            title,
            for: .normal
        )
        
        button.accessibilityLabel = title
        
        button.addTarget(
            self,
            action: #selector( signUp(sender:) ),
            for: .touchUpInside
        )
        
        return button
        
    }

}

//protocol AuthControllerDelegate: AnyObject {
//
//    func authController(
//        _ authController: AuthController,
//        didProvide credentials: Basic
//    )
//
//}

//public protocol AuthViewControllerDataSource: AnyObject {
//
//    associatedtype Credentials
//
//    func authController(
//        _ authController: AuthViewController,
//        didProvide credentials: Credentials
//    )
//
//}

//public struct AuthController
