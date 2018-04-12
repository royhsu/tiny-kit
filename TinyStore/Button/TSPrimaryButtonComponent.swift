//
//  TSPrimaryButtonComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSPrimaryButtonComponent

public final class TSPrimaryButtonComponent: UIButtonComponent {

    private final let bundle: Bundle

    /// The base component.
    private final let itemComponent: UIItemComponent<TSPrimaryButton>
    
    public final let eventEmitter: NewEventEmitter<UITouchEvent>

    public init(contentMode: ComponentContentMode = .automatic) {

        self.bundle = Bundle(
            for: type(of: self)
        )

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                TSPrimaryButton.self,
                from: bundle
            )!
        )

        self.eventEmitter = NewEventEmitter()

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        itemComponent.itemView.button.addTarget(
            self,
            action: #selector(touchUpInside),
            for: .touchUpInside
        )
        
    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() { itemComponent.render() }

    // MARK: ViewRenderable

    public final var view: View { return itemComponent.view }

    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }

    // MARK: Action

    @objc
    public final func touchUpInside(_ sender: Any) { eventEmitter.emit(event: .touchUpInside) }

}

public extension TSPrimaryButtonComponent {
    
    public final var titleLabel: UILabel { return itemComponent.itemView.titleLabel }
    
    public final var iconImageView: UIImageView { return itemComponent.itemView.iconImageView }
    
    public final func applyTheme(_ theme: Theme) { itemComponent.itemView.applyTheme(theme) }

}
