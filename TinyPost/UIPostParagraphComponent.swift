//
//  UIPostParagraphComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostParagraphComponent

public final class UIPostParagraphComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIPostParagraphView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIPostParagraphView.self,
                from: bundle
            )!
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
    
}

public extension UIPostParagraphComponent {
    
    @discardableResult
    public final func setParagraph(_ paragraph: UIPostParagraph) -> UIPostParagraphComponent {
        
        let paragraphView = itemComponent.itemView
        
        paragraphView.contentLabel.text = paragraph.content
        
        return self
        
    }
    
}
