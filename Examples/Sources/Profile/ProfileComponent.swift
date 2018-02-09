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
    
    public final func fetch(in context: Context) -> Promise<Void> {
        
        return Promise<Profile>(in: context) { fulfill, reject, _ in
            
            let profile = Profile(
                pictureURL: nil,
                name: "Roy Hsu"
            )
            
            fulfill(profile)
            
        }
        .then(in: .main) { profile -> Void in
            
            let headerComponent = ProfileHeaderComponent(profile: profile)
            
            let autoSize = CGSize(
                width: UITableViewAutomaticDimension,
                height: UITableViewAutomaticDimension
            )
            
            headerComponent.preferredContentSize = autoSize
            
            let components: [Component] = [
                headerComponent
            ]
            
            self.childComponents = AnyCollection(components)
            
        }
        
    }
    
}
