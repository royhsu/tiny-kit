//
//  ComponentContentMode.swift
//  TinyKit
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentContentMode

public enum ComponentContentMode {

    case size(CGSize)

    // TODO: add associated value preferredInitialWidth to replace UIScreen.main.bounds dependency.
    case automatic

}
