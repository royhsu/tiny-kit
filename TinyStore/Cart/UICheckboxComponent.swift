//
//  UICheckboxComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckboxComponent

public final class UICheckboxComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICheckbox>
    
    public private(set) final var isChecked: Bool
    
    public typealias ToggleCheckboxHandler = (_ isChecked: Bool) -> Void
    
    private final var toggleCheckboxHandler: ToggleCheckboxHandler?
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let isChecked = false
        
        self.isChecked = isChecked
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        let itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICheckbox.self,
                from: bundle
            )!
        )
        
        self.itemComponent = itemComponent
        
        self.itemComponent.itemView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(toggleCheckbox)
            )
        )
        
        self.setUpCheckbox(
            itemComponent.itemView,
            isChecked: isChecked
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
    public final func toggleCheckbox(_ sender: Any) {
        
        isChecked = !isChecked
        
        setUpCheckbox(
            itemComponent.itemView,
            isChecked: isChecked
        )
        
        toggleCheckboxHandler?(isChecked)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpCheckbox(
        _ checkbox: UICheckbox,
        isChecked: Bool
    ) {
        
        let iconImage = isChecked ? #imageLiteral(resourceName: "icon-checkbox-checked") : #imageLiteral(resourceName: "icon-checkbox-unchecked")
        
        let checkbox = itemComponent.itemView
        
        checkbox.iconImageView.image = iconImage.withRenderingMode(.alwaysTemplate)
        
        checkbox.iconImageView.tintColor = .darkGray
        
    }
    
}

public extension UICheckboxComponent {
    
    @discardableResult
    public final func setChecked(_ isChecked: Bool) -> UICheckboxComponent {
        
        self.isChecked = isChecked
        
        setUpCheckbox(
            itemComponent.itemView,
            isChecked: isChecked
        )
        
        toggleCheckboxHandler?(isChecked)
        
        return self
        
    }
    
    @discardableResult
    public final func onToggleCheckbox(
        handler: ToggleCheckboxHandler? = nil
    )
    -> UICheckboxComponent {
        
        toggleCheckboxHandler = handler
        
        return self
        
    }
    
}
