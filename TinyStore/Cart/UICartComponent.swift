//
//  UICartComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartMode

public enum UICartMode {
    
    case bar, full
    
}

// MARK: - UICartComponent

public final class UICartComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICartView>
    
    private final var backgroundComponent: Component
    
    private final var itemListComponent: Component
    
    private final var mode: UICartMode = .bar
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        backgroundComponent: Component,
        itemListComponent: Component
    ) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.view = View()
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICartView.self,
                from: bundle
            )!
        )
        
        self.backgroundComponent = backgroundComponent
        
        self.itemListComponent = itemListComponent
        
        let itemView = itemComponent.itemView
        
        itemView.barView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(showFullInformation)
            )
        )
        
        enableShadow(for: itemView.barView)
        
        disableShadow(for: itemView.itemListContainerView)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        view.render(with: itemComponent)
        
        itemComponent.render()
        
        let itemView = itemComponent.itemView
        
        itemView.backgroundView.render(with: backgroundComponent)
        
        backgroundComponent.render()
        
        itemView.itemListContainerView.render(with: itemListComponent)
        
        itemListComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final let view: View
    
    public final var preferredContentSize: CGSize { return view.bounds.size }
    
    // MARK: Action
    
    @objc
    public final func showFullInformation(_ sender: Any) {
        
        let itemView = itemComponent.itemView
        
        switch mode {
            
        case .bar:
            
            mode = .full
            
            enableShadow(for: itemView.itemListContainerView)
            
            disableShadow(for: itemView.barView)
            
            NSLayoutConstraint.deactivate(
                [ itemView.itemListContainerViewHeightConstraint ]
            )
            
            NSLayoutConstraint.activate(
                [ itemView.itemListContainerViewTopConstraint ]
            )
            
        case .full:
            
            mode = .bar
            
            enableShadow(for: itemView.barView)
            
            disableShadow(for: itemView.itemListContainerView)
            
            NSLayoutConstraint.deactivate(
                [ itemView.itemListContainerViewTopConstraint ]
            )
            
            NSLayoutConstraint.activate(
                [ itemView.itemListContainerViewHeightConstraint ]
            )
            
        }
        
        itemView.setNeedsUpdateConstraints()
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1.0,
            options: [],
            animations: { itemView.layoutIfNeeded() },
            completion: nil
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
