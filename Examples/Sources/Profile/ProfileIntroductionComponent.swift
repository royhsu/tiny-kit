//
//  ProfileIntroductionComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileIntroductionComponent

import TinyKit

public final class ProfileIntroductionComponent: Component {
   
    private typealias BaseComponent = ItemComponent<ProfileIntroductionView, Profile>
    
    private final let baseComponent: BaseComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        profile: Profile = Profile()
    ) {
        
        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            view: UIView.load(ProfileIntroductionView.self)!,
            model: profile,
            binding: { introductionView, profile in
                
                introductionView.nameLabel.text = profile.name
                
                introductionView.introductionLabel.text = profile.introduction
                
            }
        )
        
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

public extension ProfileIntroductionComponent {
    
    public final var profile: Profile {
        
        get { return baseComponent.model }
        
        set { baseComponent.model = newValue }
        
    }
    
}
