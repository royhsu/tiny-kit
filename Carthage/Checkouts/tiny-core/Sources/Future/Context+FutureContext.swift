//
//  Context+FutureContext.swift
//  TinyCore
//
//  Created by Roy Hsu on 23/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - FutureContext

import Hydra

public extension Context {

    public init(_ context: FutureContext) {

        switch context {

        case .main: self = .main

        case .background: self = .background

        }

    }

}
