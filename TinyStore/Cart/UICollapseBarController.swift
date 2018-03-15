//
//  UICollapseBarController.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollapseBarController

import TinyUI

public final class UICollapseBarController: UIViewController {
    
    public final var collapseView: UICollapseView!
    
    public private(set) var isCollapsed: Bool = true
    
    public final override func loadView() {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        collapseView = UIView.load(
            UICollapseView.self,
            from: bundle
        )
        
        view = collapseView
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collapseView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(toggleContent)
            )
        )
        
    }
    
    public final func render() {
        
//        view.render(with: itemComponent)
//
//        itemComponent.render()
//
//        let itemView = itemComponent.itemView
//
//        itemView.backgroundView.render(with: backgroundComponent)
//
//        backgroundComponent.render()
//
//        itemView.itemListContainerView.render(with: itemListComponent)
//
//        itemListComponent.render()
//
//        itemView.barView.render(with: barComponent)
//
//        barComponent.setActionButtonItem(
//            UIPrimaryButtonItem(
//                title: "Checkout",
//                titleColor: .white,
//                iconImage: #imageLiteral(resourceName: "icon-add").withRenderingMode(.alwaysTemplate),
//                backgroundColor: UIColor(
//                    red: 0.35,
//                    green: 0.56,
//                    blue: 0.87,
//                    alpha: 1.0
//                )
//            )
//        )
//
//        barComponent.render()
        
    }
    
    // MARK: Action
    
    @objc
    public final func toggleContent(_ sender: Any) {
        
        setCollapsed(
            !isCollapsed,
            animated: true
        )
    
    }
    
}

public extension UICollapseBarController {
    
    public final func setCollapsed(
        _ isCollapsed: Bool,
        animated: Bool
    ) {
        
        if self.isCollapsed == isCollapsed { return }
        
        self.isCollapsed = isCollapsed

        if isCollapsed {
            
            NSLayoutConstraint.deactivate(
                [ collapseView.barContainerViewTopConstraint ]
            )

            NSLayoutConstraint.activate(
                [ collapseView.barContainerViewHeightConstraint ]
            )

        }
        else {
            
            NSLayoutConstraint.deactivate(
                [ collapseView.barContainerViewHeightConstraint ]
            )

            NSLayoutConstraint.activate(
                [ collapseView.barContainerViewTopConstraint ]
            )

        }

        collapseView.setNeedsUpdateConstraints()
        
        if animated {

            UIView.animate(
                withDuration: 0.5,
                delay: 0.0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 1.0,
                options: [],
                animations: { self.collapseView.layoutIfNeeded() },
                completion: nil
            )
            
        }
        else { collapseView.layoutIfNeeded() }
        
    }
    
}
