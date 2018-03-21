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
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICheckbox.self,
                from: bundle
            )!
        )
        
        self.theme = theme
        
        self.input = Observable(inputValue)
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        let checkbox = itemComponent.itemView
        
        setUpCheckboxIconImageView(
            checkbox.iconImageView,
            isChecked: input.value
        )
        
        inputSubscription = input.subscribe { [unowned self] _, isChecked in
            
            self.setUpCheckboxIconImageView(
                checkbox.iconImageView,
                isChecked: isChecked
            )
            
        }
        
        checkbox.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(toggleValue)
            )
        )
        
        checkbox.applyTheme(theme)
        
    }
    
    fileprivate final func setUpCheckboxIconImageView(
        _ imageView: UIImageView,
        isChecked: Bool
    ) {
        
        let imageName =
            isChecked
            ? "icon-checkbox-checked"
            : "icon-checkbox-unchecked"
        
        let image = UIImage(
            named: imageName,
            in: bundle,
            compatibleWith: nil
        )
        
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let checkbox = itemComponent.itemView
        
        checkbox.applyTheme(theme)
        
        itemComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Stylable
    
    public final var theme: Theme
    
    // MARK: Inputable
    
    public final let input: Observable<Bool>
    
    private final var inputSubscription: Subscription<Bool>?
    
    // MARK: Action
    
    @objc
    public final func toggleValue(_ sender: Any) { input.value.toggle() }
    
}
