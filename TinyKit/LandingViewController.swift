//
//  LandingViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/3/16.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - LandingViewController

import UIKit
import TinyCore

final class LandingViewController: UIViewController {
    
    lazy var dependencyManager = makeDependencyManager()
    
    private lazy var authReducers = makeAuthReducers()
    
    private lazy var authorizeButton = makeAuthorizeButton()
 
    private lazy var authViewController = makeAuthViewController()
    
}

extension LandingViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        authorizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(authorizeButton)
        
        NSLayoutConstraint.activate(
            [
                view.centerXAnchor.constraint(equalTo: authorizeButton.centerXAnchor),
                view.centerYAnchor.constraint(equalTo: authorizeButton.centerYAnchor)
            ]
        )
        
    }
    
}

extension LandingViewController {
    
    @objc
    func authorize(sender: Any) {
        
        authReducers.reduce { reducers in
            
            guard let authResult = reducers.currentValue else {
                
                #warning("Error handling.")
                print("Missing auth result.")
                
                return
                
            }
            
            do {
                
                let auth = try authResult.get()
                
                print("Did authorize with auth: \(auth)")
                
            }
            catch { print("\(error)") }
            
        }
        
    }
    
}

extension LandingViewController {
    
    private func makeAuthorizeButton() -> UIButton {
        
        let button = UIButton(type: .roundedRect)
        
        let title = "Authorize"
        
        button.setTitle(
            title,
            for: .normal
        )
        
        button.accessibilityLabel = title
        
        button.addTarget(
            self,
            action: #selector( authorize(sender:) ),
            for: .touchUpInside
        )
        
        return button
        
    }
    
    private func makeDependencyManager() -> Context<Dependency> {
        
        var dependencyManager = Context<Dependency>()
        
        dependencyManager.register(
            { throw DependencyError.missingDependency(.authService) },
            for: .authService
        )
        
        return dependencyManager
        
    }
    
    private func makeAuthViewController() -> AuthViewController { return AuthViewController() }
    
    private func makeAuthReducers() -> CombinedReducers<UUID, Result<Bearer>?> {
        
        return CombinedReducers<UUID, Result<Bearer>?>(
            initialValue: nil,
            actions: [
                showAuthViewController
            ]
        )
        
    }
    
}

// MARK: - Dependency

extension LandingViewController {
    
    enum Dependency {
        
        case authService
        
    }
    
    private enum DependencyError: Error {
        
        case missingDependency(Dependency)
        
    }
    
    var authService: AnyAuthService<Basic, Bearer>? {
        
        get {
            
            return try? dependencyManager.make(
                AnyAuthService.self,
                for: .authService
            )
            
        }
        
        set {
            
            guard let newAuthService = newValue else {
                
                dependencyManager.register(
                    { throw DependencyError.missingDependency(.authService) },
                    for: .authService
                )
                
                return
                
            }
            
            dependencyManager.register(
                newAuthService,
                for: .authService
            )
            
        }
        
    }
    
}

extension LandingViewController {
    
    private var showAuthViewController: ReducibleAction<UUID, Result<Bearer>?> {
        
        return ReducibleAction { [weak self] currentAuth, reducedAuth in
            
            guard let self = self else { return }
            
            if let currentAuth = currentAuth { reducedAuth(currentAuth); return }
            
            do {
                
                let authService = try self.dependencyManager.make(
                    AnyAuthService<Basic, Bearer>.self,
                    for: .authService
                )
                
                self.authViewController.didProvideCredentials = { authViewController, credentials in
                    
                    do {
                    
                        try authService.authorize(with: credentials) { result in
                            
                            do {
                                
                                let auth = try result.get()
                                
                                DispatchQueue.main.async {
                                    
                                    authViewController.dismiss(animated: true) { reducedAuth( .success(auth) ) }
                                    
                                }
                                
                            }
                            catch { reducedAuth( .failure(error) ) }
                            
                        }
                        
                    }
                    catch { reducedAuth( .failure(error) ) }
                    
                }
               
                self.present(
                    self.authViewController,
                    animated: true,
                    completion: nil
                )
                
            }
            catch { reducedAuth( .failure(error) ) }
            
        }
        
    }
    
}

//struct AuthUIReducer<Credentials, Auth> {
//
//    typealias CredentialsViewController = CredentialsContainer & UIViewController
//
//    private weak var presentingViewController: UIViewController?
//
//    private var credentialsViewController: CredentialsViewController
//
//    private let authService: AnyAuthService<Credentials, Auth>
//
//    init<S>(
//        presentingViewController: UIViewController,
//        presentedViewController: CredentialsViewController,
//        authService: S
//    )
//    where
//        S: AuthService,
//        S.Credentials == Credentials,
//        S.Auth == Auth {
//
//        self.presentingViewController = presentingViewController
//
//        self.authService = AnyAuthService(authService)
//
//    }
//
//}

// MARK: - CredentialsContainer

public protocol CredentialsContainer: AnyObject {
    
    associatedtype Credentials
    
    var didProvideCredentials: ( (Self, Credentials) -> Void )? { get set }
    
}

public final class AnyCredentialsContainer<Credentials> {
    
    public var didProvideCredentials: ( (AnyCredentialsContainer, Credentials) -> Void )?
    
    public init<C>(_ container: C)
    where
        C: CredentialsContainer,
        C.Credentials == Credentials {
            
        container.didProvideCredentials = { [weak self] _, credentials in
            
            guard let self = self else { return }
            
            self.didProvideCredentials?(
                self,
                credentials
            )
            
        }
            
    }
    
}

// MARK: - CredentialsContainer

extension AnyCredentialsContainer: CredentialsContainer { }

// MARK: - Reducer

public protocol Reducer {

    associatedtype Value
    
    func reduce(
        _ currentValue: Value,
        _ reducedResult: @escaping (_ newValue: Value) -> Void
    )
    
}

// MARK: - AnyReducer

public struct AnyReducer<Value> {
    
    private let _reduce: (
        _ currentValue: Value,
        _ reducedResult: @escaping (_ newValue: Value) -> Void
    )
    -> Void
    
    public init<R>(_ reducer: R)
    where
        R: Reducer,
        R.Value == Value { self._reduce = reducer.reduce }
    
}

// MARK: - Reducer

extension AnyReducer: Reducer {
    
    public func reduce(
        _ currentValue: Value,
        _ reducedResult: @escaping (Value) -> Void
    ) {
    
        _reduce(
            currentValue,
            reducedResult
        )
        
    }
    
}
