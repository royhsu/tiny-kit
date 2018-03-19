//
//  UICheckboxComponent.swift
//  TinyUI
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckboxComponent

public final class UICheckboxComponent: Component, Stylable, Inputable {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UICheckbox>
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        theme: Theme = .current,
        inputValue: Bool = true
    ) {
        
        self.bundle = Bundle(
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
        
        self.theme = theme
        
        self.input = Observable(inputValue)
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        let checkbox = itemComponent.itemView
        
        inputSubscription = input.subscribe { [unowned self] _, isChecked in
            
            let imageName =
                isChecked
                ? "icon-checkbox-checked"
                : "icon-checkbox-unchecked"
            
            checkbox.iconImageView.image = UIImage(
                named: imageName,
                in: self.bundle,
                compatibleWith: nil
            )?
            .withRenderingMode(.alwaysTemplate)
            
        }
        
        checkbox.actionButton.addTarget(
            self,
            action: #selector(toggleValue),
            for: .touchUpInside
        )
        
        applyTheme(
            theme,
            for: checkbox
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
    
    // MARK: Stylable
    
    public final var theme: Theme
    
    fileprivate final func applyTheme(
        _ theme: Theme,
        for checkbox: UICheckbox
    ) {
        
        checkbox.iconImageView.tintColor = theme.primaryColor
        
        checkbox.backgroundColor = theme.backgroundColor
        
    }
    
    // MARK: Inputable
    
    public final let input: Observable<Bool>
    
    private final var inputSubscription: Subscription<Bool>?
    
    // MARK: Action
    
    @objc
    public final func toggleValue(_ sender: Any) { input.value.toggle() }
    
}
