//
//  HTTPClient.swift
//  TinyCore
//
//  Created by Roy Hsu on 19/10/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - HTTPClient

public protocol HTTPClient {

    func data(
        with request: URLRequest,
        in context: FutureContext
    )
    -> Future<Data>

}

// MARK: - Model

public extension HTTPClient {

    public func model<D: Decodable>(
        _ type: D.Type,
        with request: URLRequest,
        in context: FutureContext,
        decoder: ModelDecoder
    )
    -> Future<D> {

        return self.data(
            with: request,
            in: context
        )
        .then(in: context) { data in

            let object = try decoder.decode(
                type,
                from: data
            )

            return object

        }

    }

}
