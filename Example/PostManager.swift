//
//  PostManager.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 17/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostManager

import Foundation
import Hydra

public final class PostManager {
    
    public final func fetchPosts(
        in context: Context,
        userId: String
    )
    -> Promise<[Post]> {
        
        return Promise(in: context) { fulfill, _, _ in
            
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
            
    }
    
    
}
