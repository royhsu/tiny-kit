//
//  View+ViewRepresentable.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewRepresentable

extension View: ViewRepresentable {
    
    public final var viewRepresentation: ViewRepresentation { return .view(self) }
    
}
