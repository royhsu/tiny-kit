//
//  ListTableViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 28/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListTableViewController

import UIKit

internal final class ListTableViewController: UITableViewController {
    
    internal final let cellIdentifier = String(
        describing: UITableViewCell.self
    )
    
    internal final var renderables: AnyCollection<ViewRenderable> = AnyCollection(
        []
    )
    
    // MARK: View Life Cycle
    
    internal final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpTableView(tableView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: cellIdentifier
        )
        
        tableView.separatorStyle = .none
        
    }
    
    // MARK: UITableViewDataSource
    
    internal final override func numberOfSections(in tableView: UITableView) -> Int { return Int(renderables.count) }
    
    internal final override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
        )
        -> Int { return 1 }
    
    internal final override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
        )
    -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        )
        
        cell.selectionStyle = .none
        
        cell.backgroundColor = .clear
        
        let index = AnyIndex(indexPath.section)
        
        let renderable = renderables[index]
        
        let containerView = cell.contentView
        
        let contentView = renderable.view
        
        contentView.removeFromSuperview()
        
        containerView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                contentView
                    .leadingAnchor
                    .constraint(
                        equalTo: containerView.leadingAnchor
                    ),
                contentView
                    .topAnchor
                    .constraint(
                        equalTo: containerView.topAnchor
                    ),
                contentView
                    .trailingAnchor
                    .constraint(
                        equalTo: containerView.trailingAnchor
                    ),
                contentView
                    .bottomAnchor
                    .constraint(
                        equalTo: containerView.bottomAnchor
                    )
            ]
        )
        
        return cell
            
    }
    
    // MARK: UITableViewDelegate
    
    // For self-resizing
    internal final override func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    )
    -> CGFloat {
        
        let index = AnyIndex(indexPath.section)
        
        let renderable = renderables[index]
        
        return renderable.preferredContentSize.height
            
    }
    
    // For self-resizing
    internal final override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    )
    -> CGFloat {
        
        let index = AnyIndex(indexPath.section)
        
        let renderable = renderables[index]
        
        return renderable.preferredContentSize.height
            
    }
    
}
