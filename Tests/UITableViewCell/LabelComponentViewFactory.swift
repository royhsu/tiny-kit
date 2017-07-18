//
//  LabelComponentViewFactory.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - LabelComponentViewFactory

@testable import TinyKit

class LabelComponentViewFactory: ComponentViewFactory {

    // MARK: ComponentView

    typealias ComponentView = LabelComponentView

    // MARK: ComponentViewFactory

    static func makeComponentView() throws -> LabelComponentView {

        return ComponentView(frame: .zero)

    }

}
