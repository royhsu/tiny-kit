//
//  PostListComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostListComponent

import UIKit
import TinyCore
import TinyKit

public final class PostListComponent: Component {

    private final let baseComponent: ListComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.baseComponent = ListComponent(contentMode: contentMode)
        
    }
    
    public final func fetch(in context: Context) -> Promise<Void> {
        
        return Promise<[Post]>(in: context) { fulfill, reject, _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
                let posts = [
                    Post(
                        title: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros.",
                        content: "Cras justo odio, dapibus ac facilisis in, egestas eget quam. Maecenas sed diam eget risus varius blandit sit amet non magna. Donec sed odio dui. Donec ullamcorper nulla non metus auctor fringilla. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Maecenas sed diam eget risus varius blandit sit amet non magna. Praesent commodo cursus magna, vel scelerisque nisl consectetur et."
                    ),
                    Post(
                        title: "Nullam quis risus eget urna mollis ornare vel eu leo.",
                        content: "Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui."
                    ),
                    Post(
                        title: "Aenean lacinia bibendum nulla sed consectetur.",
                        content: "Donec sed odio dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec ullamcorper nulla non metus auctor fringilla. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Nulla vitae elit libero, a pharetra augue. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor."
                    )
                ]
                
                fulfill(posts)
            
            }

        }
        .then(in: .main) { posts -> Void in
            
            let components: [Component] = posts.map { post in

                let component = PostComponent(post: post)

                return component

            }

            self.baseComponent.itemComponents = AnyCollection(components)
            
        }

    }

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

public extension PostListComponent {
    
    public final var headerComponent: Component? {
        
        get { return baseComponent.headerComponent }
        
        set { baseComponent.headerComponent = newValue }
        
    }
    
}
