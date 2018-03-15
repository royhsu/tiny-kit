//
//  UICollapseBarContrller.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollapseBarContrller

import TinyUI

// TODO: refactor to view controller.

// TODO: extend bottom edge of bar view while there is not tab bar.
// safeAreaBottomViewHeightConstraint.constant = safeAreaInsets.bottom

public final class UICollapseBarContrller: UIViewController {
    
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
        
        disableShadow(for: collapseView.barContentView)
        
        enableShadow(for: collapseView.barView)
        
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
    
    fileprivate final func enableShadow(for view: UIView) {
        
        view.layer.shadowColor = UIColor.black.cgColor
        
        view.layer.shadowOffset = .zero
        
        view.layer.shadowRadius = 10.0
        
        view.layer.shadowOpacity = 0.2
        
    }
    
    fileprivate final func disableShadow(for view: UIView) {
        
        view.layer.shadowColor = nil
        
        view.layer.shadowOffset = .zero
        
        view.layer.shadowRadius = 0.0
        
        view.layer.shadowOpacity = 0.0
        
    }
    
}

public extension UICollapseBarContrller {
    
    public final func setCollapsed(
        _ isCollapsed: Bool,
        animated: Bool
    ) {
        
        if self.isCollapsed == isCollapsed { return }
        
        self.isCollapsed = isCollapsed

        if isCollapsed {
            
            enableShadow(for: collapseView.barView)
            
            NSLayoutConstraint.deactivate(
                [ collapseView.barContentViewTopConstraint ]
            )

            NSLayoutConstraint.activate(
                [ collapseView.barContentViewHeightConstraint ]
            )

        }
        else {

            disableShadow(for: collapseView.barView)
            
            enableShadow(for: collapseView.barContentView)
            
            NSLayoutConstraint.deactivate(
                [ collapseView.barContentViewHeightConstraint ]
            )

            NSLayoutConstraint.activate(
                [ collapseView.barContentViewTopConstraint ]
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
                completion: { _ in
                
                    if self.isCollapsed {
                        
                        
                        self.disableShadow(for: self.collapseView.barContentView)

                    }
                    
                }
            )
            
        }
        else { collapseView.layoutIfNeeded() }
        
    }
    
}
