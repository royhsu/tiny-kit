//
//  TPPostElement.swift
//  TinyPost
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TPPostElement

public enum TPPostElement {

    case paragraph(String)

    case image(container: ImageContainer)

}

public enum Element {
    
    case paragraph(ParagraphComponent)
    
}

public protocol ParagraphComponent: Component {
    
    var textLabel: UILabel { get }
    
}

extension TPPostParagraphComponent: ParagraphComponent { }

public protocol PostComponent: Component {
    
    var numberOfElements: Int { get set }
    
    func element(at index: Int) -> Element
    
    typealias ElementProvider = (_ index: Int) -> Element
    
    func setElement(provider: @escaping ElementProvider)
    
}

public extension PostComponent {
    
    public func setElements(
        _ elements: [Element]
    ) {
        
        numberOfElements = elements.count
        
        setElement { index in elements[index] }
        
    }
    
}

public final class TPNewPostComponent: PostComponent {
    
    /// The base component.
    private final let listComponent: ListComponent
    
    public init(listComponent: ListComponent) {
        
        self.listComponent = listComponent
        
        self.numberOfElements = 0
        
        self.prepare()
        
    }
    
    public final var numberOfElements: Int
    
    public final func element(at index: Int) -> Element {
    
        guard
            let element = elementProvider?(index)
        else { fatalError("Please make sure to set the element provider with function setElement(provider:) firstly.") }
    
        return element
        
    }
    
    private final var elementProvider: ElementProvider?
    
    public final func setElement(provider: @escaping ElementProvider) { elementProvider = provider }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        listComponent.setNumberOfItemComponents { [unowned self] _ in self.numberOfElements }
        
        listComponent.setItemComponent { [unowned self] indexPath in
            
            switch self.element(at: indexPath.item) {
                
            case let .paragraph(component): return component
                
            }
            
        }
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        listComponent.numberOfSections = (numberOfElements == 0) ? 0 : 1
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}
