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

    private typealias BaseComponent = ItemComponent<ProfileIntroductionView>

    private final let baseComponent: BaseComponent

    public init(
        contentMode: ComponentContentMode = .automatic
    ) {

        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            itemView: UIView.load(ProfileIntroductionView.self)!
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
    
    public final var pictureImage: UIImage? {
        
        get { return baseComponent.itemView.pictureImageView.image }
        
        set { baseComponent.itemView.pictureImageView.image = newValue }
        
    }
    
    public final var name: String? {
        
        get { return baseComponent.itemView.nameLabel.text }
        
        set { baseComponent.itemView.nameLabel.text = newValue }
        
    }
    
    public final var introduction: String? {
        
        get { return baseComponent.itemView.introductionLabel.text }
        
        set { baseComponent.itemView.introductionLabel.text = newValue }
        
    }
    
}
