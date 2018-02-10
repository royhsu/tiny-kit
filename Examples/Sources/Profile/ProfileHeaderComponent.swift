//
//  ProfileHeaderComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileHeaderComponent

import TinyCore
import TinyKit

public final class ProfileHeaderComponent: ListComponent {
    
    public final let introComponent = ProfileIntroductionComponent()
    
    public final func fetch(in context: Context) -> Promise<Void> {
        
        // Todo: test only
        introComponent.itemView.nameLabel.numberOfLines = 0
        
        introComponent.preferredContentSize = CGSize(
            width: UITableViewAutomaticDimension,
            height: UITableViewAutomaticDimension
        )
        
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
            
            self.introComponent.model = profile
         
            self.itemComponents = AnyCollection(
                [ self.introComponent ]
            )
            
        }
        
    }
    
}
