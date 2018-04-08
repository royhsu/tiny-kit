//
//  UIRootCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIRootCoordinator

import TinyKit

public final class UIRootCoordinator: Coordinator {

    private final let navigationController: UINavigationController

    private final let rootComponent: Component

    public init(contentSize: CGSize) {

        let listComponent = UIListComponent()
        
        let labelComponent = UIItemComponent(
            itemView: UILabel()
        )
        
        let label = labelComponent.itemView
        
        label.text = "Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Sed posuere consectetur est at lobortis. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Cras mattis consectetur purus sit amet fermentum."
        
        label.numberOfLines = 0
        
        label.backgroundColor = .red
        
        let boxComponent = UIBoxComponent(contentComponent: labelComponent)
        
        boxComponent.paddingInsets = UIEdgeInsets(
            top: 10.0,
            left: 20.0,
            bottom: 30.0,
            right: 40.0
        )
        
        boxComponent.view.backgroundColor = .green
        
        listComponent.setItemComponents(
            [ boxComponent ]
        )
        
        self.rootComponent = listComponent
        
        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: rootComponent)
        )

    }

    public final func activate() { rootComponent.render() }

}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return navigationController }

}

// TODO: replace with UIItemComponent + UIBox
public final class UIBoxComponent: Component {
    
    /// The base component.
    private final let contentComponent: Component
    
    // TODO: move into box view.
    private final let leadingConstraint: NSLayoutConstraint
    
    // TODO: move into box view.
    private final let topConstraint: NSLayoutConstraint
    
    // TODO: move into box view.
    private final let trailingConstraint: NSLayoutConstraint
    
    // TODO: move into box view.
    private final let bottomConstraint: NSLayoutConstraint
    
    // TODO: move into box view.
    public final var paddingInsets: UIEdgeInsets
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        contentComponent: Component
    ) {
        
        self.contentComponent = contentComponent
        
        self.view = View()
        
        let contentView = contentComponent.view
        
        self.leadingConstraint = view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        self.topConstraint = view.topAnchor.constraint(equalTo: contentView.topAnchor)
        
        self.trailingConstraint = view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        
        self.bottomConstraint = view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        self.paddingInsets = UIEdgeInsets(
            top: topConstraint.constant,
            left: leadingConstraint.constant,
            bottom: bottomConstraint.constant,
            right: trailingConstraint.constant
        )
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        view.backgroundColor = .clear
        
        trailingConstraint.priority = UILayoutPriority(900.0)
        
        bottomConstraint.priority = UILayoutPriority(900.0)
        
    }
    
    // MARK: Component
    
    public var contentMode: ComponentContentMode {
        
        get { return contentComponent.contentMode }
        
        set { contentComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let contentView = contentComponent.view
        
        contentView.removeFromSuperview()
        
        view.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint.constant = -paddingInsets.top
        
        leadingConstraint.constant = -paddingInsets.left
        
        bottomConstraint.constant = paddingInsets.bottom
        
        trailingConstraint.constant = paddingInsets.right
        
        NSLayoutConstraint.activate(
            [
                leadingConstraint,
                topConstraint,
                trailingConstraint
            ]
        )
        
        contentComponent.render()
        
        view.bounds = contentView.bounds
        
        NSLayoutConstraint.activate(
            [ bottomConstraint ]
        )
        
    }
    
    // MARK: ViewRenderable

    public final let view: View

    public final var preferredContentSize: CGSize { return view.bounds.size }
    
}
