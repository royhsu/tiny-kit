//
//  AnswerTemplate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/22.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AnswerTemplate

import TinyKit

public struct AnswerTemplate: Template {
    
    public enum Element {
        
        case content
        
        case separator
        
    }
    
    public let storage: Comment
    
    public weak var actionDispatcher: ActionDispatcher?
    
    public weak var errorHandler: ErrorHandler?
    
    public let elements: [Element]
    
    public init(
        storage: Comment,
        actionDispatcher: ActionDispatcher? = nil,
        errorHandler: ErrorHandler? = nil,
        elements: [Element] = []
    ) {
        
        self.storage = storage
        
        self.actionDispatcher = actionDispatcher
        
        self.errorHandler = errorHandler
        
        self.elements = elements
        
    }
    
    public var numberOfElements: Int { return elements.count }
    
    public func view(at index: Int) -> View {
        
        let element = elements[index]
        
        switch element {
            
        case .content:
            
            let view = View.loadView(
                UIAnswerItemContentView.self,
                from: .main
            )!
            
            view.voteContainerView.isHidden = true
            
            view.userNameLabel.text = storage.username
            
            view.bodyLabel.text = storage.text
            
            return view
            
        case .separator:
            
            let view = View()
            
            view.backgroundColor = .white
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
            
            return view
            
        }
        
    }
    
}
