//
//  Stylable.swift
//  TinyUI
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Stylable

public protocol Stylable {
    
    var theme: Theme { get }
    
}

public extension Theme {
    
    public static var current = { return azureSky }()
    
    // TODO: rename to debugging theme.
    // and create the real azure sky.
    public static let azureSky = Theme(
        primaryColor: .blue,
        secondaryColor: .yellow,
        backgroundColor: .red,
        titleColor: .blue,
        subtitleColor: .yellow,
        bodyColor: .white,
        placeholderColor: .green
    )
    
}
