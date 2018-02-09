//
//  ProfileHeaderComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

import TinyKit

public final class ProfileHeaderComponent: ItemComponent<ProfileHeaderView, Profile> {
    
    public init(profile: Profile) {
        
        super.init(
            view: UIView.load(ProfileHeaderView.self)!,
            model: profile,
            binding: { headerView, profile in
                
                headerView.nameLabel.text = profile.name
                
            }
        )
        
    }
    
}
