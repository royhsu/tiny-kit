//
//  ProfileIntroductionComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

import TinyKit

public final class ProfileIntroductionComponent: ItemComponent<ProfileIntroductionView, Profile> {
    
    public init(
        profile: Profile = Profile()
    ) {
        
        super.init(
            view: UIView.load(ProfileIntroductionView.self)!,
            model: profile,
            binding: { headerView, profile in
                
                headerView.nameLabel.text = profile.name
                
            }
        )
        
    }
    
}
