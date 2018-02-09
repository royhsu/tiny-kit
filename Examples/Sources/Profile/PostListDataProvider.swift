//
//  PostListDataProvider.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostListDataProvider

import UIKit
import TinyCore
import TinyKit

public final class PostListDataProvider: Collection {
    
    private final var posts: [Post] = []
    
    public final var startIndex: Int { return 0 }
    
    public final var endIndex: Int { return posts.count }
    
    public final subscript(position: Int) -> Component {
        
        let post = posts[position]
        
        let component = PostComponent(
            title: post.title ?? "",
            content: post.content ?? ""
        )
        
        component.preferredContentSize = CGSize(
            width: UITableViewAutomaticDimension,
            height: UITableViewAutomaticDimension
        )
        
        return component
        
    }
    
    public final func index(after i: Int) -> Int { return posts.index(after: i) }
    
    public final func fetch() -> Promise<Void> {

        return Promise { fulfill, reject, _ in

            self.posts = [
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
            
            let result: Void = ()
            
            fulfill(result)

        }

    }
    
}
