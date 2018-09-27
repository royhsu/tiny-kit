//
//  UIView+UINib.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINib

import UIKit

public extension UIView {

    /// A convenience method to load a view from the corresponding xib file.
    ///
    /// - Parameter viewType: The subclass of target UIView.
    /// - Parameter bundle: The bundle contains the nib file for the view.
    ///
    /// - Returns: An target instance of the view.
    ///
    public static func loadView<View: UIView>(
        _ viewType: View.Type,
        from bundle: Bundle
    )
    -> View? {

        let nibName = String(describing: viewType)

        return UINib(
            nibName: nibName,
            bundle: bundle
        )
        .instantiate(
            withOwner: nil,
            options: nil
        )
        .compactMap { $0 as? View }
        .first

    }

}
