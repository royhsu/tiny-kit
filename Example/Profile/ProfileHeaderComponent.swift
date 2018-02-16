//
//  ProfileHeaderComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileHeaderComponent

import Hydra
import TinyCore
import TinyKit

public final class ProfileHeaderComponent: Component {

    private final let baseComponent: ListComponent

    private final let introductionComponent = ProfileIntroductionComponent()

    public init(contentMode: ComponentContentMode = .automatic) {

        self.baseComponent = ListComponent(contentMode: contentMode)

    }

    public final func fetch(in context: Context) -> Promise<Void> {

        return Promise<Profile>(in: context) { fulfill, _, _ in

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

                let profile = Profile(
                    pictureURL: nil,
                    name: "Maecenas sed diam eget risus varius blandit sit amet non magna. Vestibulum id ligula porta felis euismod semper.",
                    introduction: "Nullam quis risus eget urna mollis ornare vel eu leo. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Cras justo odio, dapibus ac facilisis in, egestas eget quam."
                )

                fulfill(profile)

            }

        }
        .then(in: .main) { profile -> Void in

//            self.introductionComponent.profile = profile

        }

    }

    // MARK: ViewRenderable

    public final var view: View { return baseComponent.view }

    public final var preferredContentSize: CGSize { return baseComponent.preferredContentSize }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return baseComponent.contentMode }

        set { baseComponent.contentMode = newValue }

    }

    public final func render() {

        let components: [Component] = [ introductionComponent ]

        baseComponent.itemComponents = AnyCollection(components)

        baseComponent.render()

    }

}
