//
//  HTTPRouter.swift
//  TinyCore
//
//  Created by Roy Hsu on 19/10/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - HTTPRouter

public protocol HTTPRouter {

    func makeURLRequest() throws -> URLRequest

}
