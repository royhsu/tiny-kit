//
//  ProfileComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileComponent

import Hydra
import TinyCore
import TinyKit

public final class ProfileComponent: Component {

    private final let headerComponent = ProfileHeaderComponent()

    private final let baseComponent: ListComponent

    public init(contentMode: ComponentContentMode = .automatic) {

        let baseComponent = ListComponent(contentMode: contentMode)

        baseComponent.headerComponent = headerComponent

        self.baseComponent = baseComponent

    }

    // TODO: split into data provider.
//    public final func fetch(in context: Context) -> Promise<Void> {
//
//        try! baseComponent.enter(.loading)
//
//        loadingComponent.startAnimating()
//
//        render()
//
//        return all(
//            postListComponent.fetch(in: context).always(in: context) { }
//        )
//        .then(in: .main) { _ -> Void in
//
//            try self.baseComponent.enter(.loaded)
//
//        }
//        .catch(in: .main) { error in
//
//            try self.baseComponent.enter(.error)
//
////            self.messageComponent.message = Message(error: error)
//
//        }
//        .always(in: .main) { self.loadingComponent.stopAnimating() }
//
//    }

    // MARK: ViewRenderable

    public final var view: View { return baseComponent.view }

    public final var preferredContentSize: CGSize { return baseComponent.preferredContentSize }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return baseComponent.contentMode }

        set { baseComponent.contentMode = newValue }

    }

    public final func render() { baseComponent.render() }

}

public extension ProfileComponent {
    
    public final var pictureImage: UIImage? {
        
        get { return headerComponent.pictureImage }
        
        set { headerComponent.pictureImage = newValue }
        
    }
    
    public final var name: String? {
        
        get { return headerComponent.name }
        
        set { headerComponent.name = newValue }
        
    }
    
    public final var introduction: String? {
        
        get { return headerComponent.introduction }
        
        set { headerComponent.introduction = newValue }
        
    }
    
    public final func appendPosts(
        _ posts: [Post]
    ) {
        
        let postComponents: [Component] = posts.map { post in
            
            let component = PostComponent()
            
            component.title = post.title
            
            component.content = post.content
            
            return component
            
        }
        
        baseComponent.itemComponents = AnyCollection(
            postComponents
        )
        
    }
    
}
