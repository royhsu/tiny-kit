//
//  ProfileComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileComponent

import TinyCore
import TinyKit

public final class ProfileComponent: ListComponent {
    
    private final let headerComponent: ProfileHeaderComponent
    
    public override init() {
        
        let headerComponent = ProfileHeaderComponent(
            profile: Profile(
                pictureURL: nil,
                name: nil
            )
        )
        
        let autoSize = CGSize(
            width: UITableViewAutomaticDimension,
            height: UITableViewAutomaticDimension
        )
        
        headerComponent.preferredContentSize = autoSize
        
        self.headerComponent = headerComponent
        
        super.init()
        
        childComponents = AnyCollection(
            [ headerComponent ]
        )
        
    }
    
    public final func fetch(in context: Context) -> Promise<Void> {
        
        let postListComponent = PostListComponent()
        
        let components: [Component] = [
            headerComponent,
            postListComponent
        ]
        
        childComponents = AnyCollection(components)
        
        return Promise<Profile>(in: context) { fulfill, reject, _ in
            
            let profile = Profile(
                pictureURL: nil,
                name: "Maecenas sed diam eget risus varius blandit sit amet non magna. Vestibulum id ligula porta felis euismod semper."
            )
            
            fulfill(profile)
            
        }
        .then(in: .main) { profile -> Void in
            
            self.headerComponent.model = profile
            
        }
        .then(
            in: .main,
            self.render
        )
        .always(in: context) {
            
            postListComponent
                .fetch(in: context)
                .then(
                    in: .main,
                    postListComponent.render
                )
                .then(in: .main) {
                    
                    postListComponent.preferredContentSize = postListComponent.tableView.contentSize
                    
                }
                .then(
                    in: .main,
                    self.render
                )
            
        }
        
    }
    
}
