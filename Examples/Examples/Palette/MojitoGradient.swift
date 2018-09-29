//
//  MojitoGradient.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MojitoGradient

import TinyKit

public struct MojitoGradient: TemplateRepresentable {
    
    public let template: Template = MojitoTemplate()
    
    private let controller = CollectionViewController()
    
    public init() {
    
        controller.layout = ListViewLayout()
        
        controller.sections = [ template ]
        
    }
    
}

