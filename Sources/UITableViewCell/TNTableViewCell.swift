//
//  TNTableViewCell.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - ComponentViewFactory

public protocol ComponentViewFactory {

    associatedtype ComponentView: UIView

    static func makeComponentView() throws -> ComponentView

}

// MARK: - TNTableViewCell

import UIKit
import TinyCore

public final class TNTableViewCell<Factory>: UITableViewCell, Identifiable where
    Factory: ComponentViewFactory {

    // MARK: Property

    public let componentView: Factory.ComponentView

    // MARK: Init

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        TNTableViewCell.validateReuseIdentifier(reuseIdentifier)

        do {

            self.componentView = try Factory.makeComponentView()

        } catch { fatalError(error.localizedDescription) }

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpComponentView()

    }

    required public init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) is not implemented.")

    }

    // MARK: Set Up

    fileprivate func setUpComponentView() {

        contentView.addSubview(componentView)

        componentView.translatesAutoresizingMaskIntoConstraints = false

        componentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true

        componentView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true

        componentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        componentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }

    fileprivate static func validateReuseIdentifier(_ reuseIdentifier: String?) {

        let reuseIdentifier = reuseIdentifier ?? "nil"

        if reuseIdentifier != identifier {

            fatalError("The cell expects its reuse identifier to be: \(identifier) but not \(reuseIdentifier)")

        }

    }

}
