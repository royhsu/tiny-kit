//
//  ListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 28/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListComponent

public final class ListComponent: ComponentNode, Component {
    
    internal final let tableViewController = ListTableViewController(style: .plain)
    
    // MARK: ViewRenderable
    
    public final var view: View { return tableViewController.tableView }

    public final var preferredContentSize: CGSize { return tableViewController.tableView.contentSize }
    
}

// MARK: - ViewRender

import Hydra

extension ListComponent: ViewRender {
    
    public final var renderables: AnyCollection<ViewRenderable> {
        
        let renderables = childComponentNodes.flatMap { $0 as? ViewRenderable }
        
        return AnyCollection(renderables)
        
    }
    
    public final func render() -> Promise<Void> {
     
        return Promise(in: .main) { fulfill, _, _ in
            
            self.tableViewController.renderables = self.renderables
        
            self.tableViewController.tableView.reloadData()
            
            let result: Void = ()
            
            fulfill(result)
                
        }
        
    }
    
}
