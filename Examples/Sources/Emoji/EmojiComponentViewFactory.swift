//
//  EmojiComponentViewFactory.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 19/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - EmojiComponentViewFactory

import UIKit
import TinyKit

class EmojiComponentViewFactory: ComponentViewFactory {

    // MARK: ComponentView

    typealias ComponentView = EmojiComponentView

    // MARK: ComponentViewFactory

    static func makeComponentView() throws -> ComponentView {

        guard
            let componentView: ComponentView = UIView.load(from: .main)
            else { fatalError("Cannot load the target ComponentView from the selected bundle.") }

        return componentView

    }

}
