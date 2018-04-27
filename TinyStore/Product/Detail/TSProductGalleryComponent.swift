//
//  TSProductGalleryComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 2018/4/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSProductGalleryComponent

public final class TSProductGalleryComponent: Component {
    
    private final let bundle: Bundle
    
    /// The base component.
    private final let containerComponent: UIItemComponent<TSProductGalleryContainerView>
    
    private final let galleryComponent: UIGalleryComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {
        
        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.containerComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                TSProductGalleryContainerView.self,
                from: bundle
            )!
        )
        
        self.galleryComponent = UIGalleryComponent()
    
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() { prepareLayout() }
    
    fileprivate final func prepareLayout() { containerView.contentView.wrapSubview(galleryComponent.view) }
    
    // MARK: GalleryComponent
    
    public final var numberOfImageComponents: Int {
        
        get { return galleryComponent.numberOfImageComponents }

        set { galleryComponent.numberOfImageComponents = newValue }
        
    }
    
    public typealias ImageComponentProvider = UIGalleryComponent.ImageComponentProvider
    
    public final func setImageComponent(provider: @escaping ImageComponentProvider) { galleryComponent.setImageComponent(provider: provider) }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return containerComponent.contentMode }
        
        set { containerComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        galleryComponent.contentMode = containerComponent.contentMode
        
        galleryComponent.render()
        
        containerComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return containerComponent.view }
    
    public final var preferredContentSize: CGSize { return containerComponent.preferredContentSize }
    
}

fileprivate extension TSProductGalleryComponent {
    
    fileprivate final var containerView: TSProductGalleryContainerView { return containerComponent.itemView }
    
}

public extension TSProductGalleryComponent {
    
    public final func applyTheme(_ theme: Theme) { containerView.applyTheme(theme) }
    
    public final func setImageComponents(
        _ components: [UIImageComponent]
    ) {
        
        numberOfImageComponents = components.count
        
        setImageComponent { _, index in components[index] }
        
    }
    
    public typealias ImageContainerProvider = UIGalleryComponent.ImageResourceProvider
    
    public final func setImageContainer(provider: @escaping ImageContainerProvider) { galleryComponent.setImageResource(provider: provider) }
    
    public final func setImageResources(
        _ resources: [ImageResource]
    ) { galleryComponent.setImageResources(resources) }
    
}
