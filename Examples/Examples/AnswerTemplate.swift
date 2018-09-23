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
    
    private let layout: CollectionViewLayout
    
    public init(
        storage: Comment,
        layout: CollectionViewLayout,
        actionDispatcher: ActionDispatcher? = nil,
        errorHandler: ErrorHandler? = nil,
        elements: [Element] = []
    ) {
        
        self.storage = storage
        
        self.layout = layout
        
        self.actionDispatcher = actionDispatcher
        
        self.errorHandler = errorHandler
        
        self.elements = elements
        
    }
    
    public var numberOfElements: Int { return elements.count }
    
    public func view(at index: Int) -> View {
        
        let element = elements[index]
        
        switch element {
            
        case .content:
            
            layout.setNumberOfSections { _ in 1 }
            
            layout.setNumberOfItems { _, _ in 5 }
            
            layout.setViewForItem { _, _ in
                
                let view = View.loadView(
                    UIAnswerItemContentView.self,
                    from: .main
                )!
    
                view.voteContainerView.isHidden = true
    
                view.userNameLabel.text = self.storage.username
    
                view.bodyLabel.text = self.storage.text
                
                return view
                
            }
            
            let collectionView = layout.collectionView
            
            collectionView.backgroundColor = .red
            
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            collectionView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
            
            return collectionView
            
        case .separator:
            
            let view = View()
            
            view.backgroundColor = .white
            
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
            
            return view
            
        }
        
    }
    
}
