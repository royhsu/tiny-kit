//
//  AuthCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 28/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AuthCoordinator

import TinyKit

public protocol AuthCoordinator: Coordinator, ViewControllerRepresentable {

    associatedtype Auth

    typealias AuthHandler = (_ auth: Auth) -> Void

    @discardableResult
    func onGrant(handler: AuthHandler?) -> Self

}
