//
//  UITableViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewBridge

public final class UITableViewBridge: NSObject {
    
    public final let cellIdentifier: String

    public final var renderables = AnyCollection<ViewRenderable>(
        []
    )
    
    public init(cellIdentifier: String) { self.cellIdentifier = cellIdentifier }
    
}

// MARK: - UITableViewDataSource

extension UITableViewBridge: UITableViewDataSource {
    
    public final func numberOfSections(in tableView: UITableView) -> Int { return Int(renderables.count) }
    
    public final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int { return 1 }
    
    public final func tableView(
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
    
}

// MARK: UITableViewDelegate

extension UITableViewBridge: UITableViewDelegate {

    public final func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    )
    -> CGFloat {

        let index = AnyIndex(indexPath.section)

        let renderable = renderables[index]

        return renderable.preferredContentSize.height

    }
    
}
