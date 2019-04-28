//
//  AppDelegate.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/3/16.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder {
    
    public final let window = UIWindow(frame: UIScreen.main.bounds)
    
    private lazy var environment: Environment = { return Environment(ProcessInfo.processInfo) }()
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
        let landingViewController = LandingViewController()
        
        landingViewController.dependencyManager.register(
            { [unowned self] in self.environment.context.authService },
            for: .authService
        )
        
        window.rootViewController = UINavigationController(rootViewController: landingViewController)
        
        window.makeKeyAndVisible()
        
        return true
            
    }
    
}

import TinyCore

enum Environment: String, EnvironmentContextRepresentable {
    
    case testing, development, production
    
    init(_ processInfo: ProcessInfo) {
        
        if
            let environmentValue = processInfo.environment["environment"],
            let environment = Environment(rawValue: environmentValue) {
            
            self = environment
            
        }
        else { self = .production }
        
    }
    
    var context: EnvironmentContext {
        
        switch self {
            
        case .testing: return .testing
            
        case .development, .production: fatalError("Unimplemented.")
            
        }
        
    }
    
}

protocol EnvironmentContextRepresentable {
    
    var context: EnvironmentContext { get }
    
}

final class EnvironmentContext {
    
    let authService: AnyAuthService<Basic, Bearer>
    
    private init(
        authService: AnyAuthService<Basic, Bearer>
    ) { self.authService = authService }
    
}

extension EnvironmentContext {
    
    static let testing: EnvironmentContext = {
        
        let authManager = MockAuthManager(
            authorizedUsers: [
                MockUser(
                    id: UUID(),
                    username: "Katherine",
                    password: "password"
                )
            ]
        )
        
        let context = EnvironmentContext(
            authService: AnyAuthService(authManager)
        )
        
        return context
        
    }()
    
}

struct MockServiceTask: ServiceTask { }

enum MockAuthError: Error {
    
    case credentialsMismatch
    
}

struct MockUser {
    
    let id: UUID
    
    let username: String
    
    let password: String
    
}

extension MockUser {
    
    var accessToken: Bearer { return Bearer(token: id.uuidString) }
    
}

extension MockUser: Equatable { }

final class MockAuthManager: AuthService {
    
    private let authorizedUsers: [MockUser]
    
    init(authorizedUsers: [MockUser]) { self.authorizedUsers = authorizedUsers }
    
    @discardableResult
    func authorize(
        with credentials: Basic,
        completion: @escaping (Result<Bearer>) -> Void
    )
    throws -> ServiceTask {
        
        DispatchQueue.global().async { [weak self] in

            guard let self = self else { return }
            
            let authorizedUser = self.authorizedUsers.first {
                
                return $0.username == credentials.username
                    && $0.password == credentials.password
                
            }
            
            guard
                let accessToken = authorizedUser?.accessToken
            else { completion( .failure(MockAuthError.credentialsMismatch) ); return }
            
            completion( .success(accessToken) )
            
        }
        
        return MockServiceTask()
        
    }
    
}
