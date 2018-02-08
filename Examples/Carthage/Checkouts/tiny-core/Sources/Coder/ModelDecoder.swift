//
//  ModelDecoder.swift
//  TinyCore
//
//  Created by Roy Hsu on 19/10/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - ModelDecoder

public protocol ModelDecoder {

    func decode<Model: Decodable>(
        _ type: Model.Type,
        from data: Data
    )
    throws -> Model

}
