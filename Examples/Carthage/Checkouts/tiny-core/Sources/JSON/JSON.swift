//
//  JSON.swift
//  TinyCore
//
//  Created by Roy Hsu on 19/10/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - JSON

public typealias JSON = Any

public typealias JSONObject = [String: JSON]

// MARK: - JSONError

// Todo: completely replaced by Codable?
public enum JSONError: Error {

    // MARK: Case

    case notObject

    case notArray

    case missingValueForKey(String)

    case invalidValueForKey(String)

}

// MARK: - JSONInitializable

// Todo: completely replaced by Codable?
public protocol JSONInitializable {

    init(_ json: JSON) throws

}
