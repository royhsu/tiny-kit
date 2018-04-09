//
//  AuthManager.swift
//  TinyApp
//
//  Created by Roy Hsu on 28/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AuthManager

import Hydra

public final class AuthManager {

    public final func authorize(
        in context: Context,
        username: String,
        password: String
        )
        -> Promise<AccessToken> {

            return Promise(in: context) { fulfill, reject, _ in

                let accessToken = AccessToken(value: "helloworld_access_token")

                fulfill(accessToken)

            }

    }

}
