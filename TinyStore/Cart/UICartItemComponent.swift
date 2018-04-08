//
//  UICartItemComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartItemComponent

import TinyCore
import TinyUI

public final class UICartItemComponent: Component, Stylable {

    private final let bundle: Bundle

    /// The base component.
    private final let itemComponent: UIItemComponent<UICartItemView>

    private final let selectionComponent: UICheckboxComponent

    private typealias Selection = Observable<Bool>

    private final var selectionSubscription: Selection.ValueDidChangeSubscription?

    private final let quantityComponent: UINumberPickerComponent

    private final let optionChainComponent: UIOptionChainComponent

    public init(
        contentMode: ComponentContentMode = .automatic,
        theme: Theme = .current,
        selectionComponent: UICheckboxComponent,
        quantityComponent: UINumberPickerComponent,
        optionChainComponent: UIOptionChainComponent
    ) {

        self.bundle = Bundle(
            for: type(of: self)
        )

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UICartItemView.self,
                from: bundle
            )!
        )

        self.theme = theme

        self.selectionComponent = selectionComponent

        self.quantityComponent = quantityComponent

        self.optionChainComponent = optionChainComponent

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        let itemView = itemComponent.itemView

        setUpContentView(
            itemView.contentContainerView,
            isSelected: selectionComponent.input.value
        )

        selectionSubscription = selectionComponent.input.observeValueDidChange { [unowned self] _, isSelected in

            self.setUpContentView(
                itemView.contentContainerView,
                isSelected: isSelected
            )

        }

        itemView.applyTheme(theme)

    }

    fileprivate func setUpContentView(
        _ view: UIView,
        isSelected: Bool
    ) { view.alpha = (isSelected ? 1.0 : 0.5) }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() {

        let itemView = itemComponent.itemView

        itemView.selectionContainerView.render(with: selectionComponent)

        selectionComponent.render()

        itemView.quantityPickerContainerView.render(with: quantityComponent)

        quantityComponent.render()

        itemView.optionChainContainerView.render(with: optionChainComponent)

        optionChainComponent.render()

        itemView.applyTheme(theme)

        itemComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return itemComponent.view }

    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }

    // MARK: Stylable

    public final var theme: Theme

}

public extension UICartItemComponent {

    @discardableResult
    public final func setPreviewImages(
        _ images: [UIImage]
    )
    -> UICartItemComponent {

        itemComponent.itemView.previewImageView.image = images.first

        return self

    }

    @discardableResult
    public final func setTitle(_ title: String?) -> UICartItemComponent {

        itemComponent.itemView.titleLabel.text = title

        return self

    }

    @discardableResult
    public final func setPrice(_ price: Double) -> UICartItemComponent {

        itemComponent.itemView.priceLabel.text = "$\(price)"

        return self

    }

}
