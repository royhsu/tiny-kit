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

public final class ProfileComponent: StateComponent<ProfileComponentState> {

    private final let loadingComponent = LoadingComponent()
    
    private final let loadedComponent = ListComponent()
    
    public init() {
        
        super.init(
            initialComponent: loadingComponent,
            initialState: .loading
        )
        
        registerComponent(
            loadedComponent,
            for: .loaded
        )
        
        // Todo: register the error state.
        
    }
    
    public final func fetch(in context: Context) -> Promise<Void> {
        
        let autoSize = CGSize(
            width: UITableViewAutomaticDimension,
            height: UITableViewAutomaticDimension
        )
        
        let headerComponent = ProfileHeaderComponent(
            profile: Profile(
                pictureURL: nil,
                name: nil
            )
        )
        
        headerComponent.preferredContentSize = autoSize
        
        let postListComponent = PostListComponent()
        
        let components: [Component] = [
            headerComponent,
            postListComponent
        ]
        
        loadedComponent.childComponents = AnyCollection(components)
        
        let activityIndicatorView = loadingComponent.itemView.activityIndicatorView!
        
        activityIndicatorView.startAnimating()
        
        return Promise<Profile>(in: context) { fulfill, reject, _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {

                let profile = Profile(
                    pictureURL: nil,
                    name: "Maecenas sed diam eget risus varius blandit sit amet non magna. Vestibulum id ligula porta felis euismod semper."
                )
            
                fulfill(profile)
                
            }
            
        }
        .then(in: .main) { profile -> Void in
            
            headerComponent.model = profile
            
        }
        .then(in: context) { _ -> Promise<Void> in
            
            return postListComponent
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
                    self.loadedComponent.render
                )
 
        }
        .then(in: .main) { try self.enter(.loaded) }
        .catch(in: .main) { error in
            
            // Todo: error handling
            print("\(error)")
            
        }
        .always(in: .main) { activityIndicatorView.stopAnimating() }
        
    }
    
}
