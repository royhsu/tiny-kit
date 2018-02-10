//
//  NewProfileComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - NewProfileComponent

//import TinyCore
//import TinyKit
//
//public final class NewProfileComponent: Component {
//    
//    public let headerComponent = ProfileHeaderComponent()
//    
//    public let postListComponent = PostListComponent()
//    
//    public final func fetch(in context: Context) -> Promise<Void> {
//        
//        return headerComponent
//            .fetch(in: context)
//            .then(
//                in: .main,
//                headerComponent.render
//            )
//            .then(in: .main) { _ -> Promise<Void> in
//                
//                self.postListComponent.headerComponent = self.headerComponent
//                
//                return self.postListComponent.fetch(in: context)
//                
//            }
//            .then(
//                in: .main,
//                postListComponent.render
//            )
//        
//    }
//    
//    // MARK: ViewRenderable
//    
//    public final var view: View { return postListComponent.view }
//    
//    public final var preferredContentSize: CGSize { return postListComponent.preferredContentSize }
//    
//}
