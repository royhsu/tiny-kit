//
//  UIView+UINib.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - UINib

import UIKit
import TinyCore

public extension UIView {

    /// A convenience method to load a view from the corresponding xib file.
    ///
    /// - Parameter type: The subclass of target UIView.
    /// - Parameter bundle: The bundle contains the nib file for the view.
    ///
    /// - Returns: An target instance of the view.
    ///
    public class func load<View: UIView>(
        _ type: View.Type,
        from bundle: Bundle? = nil
    )
    -> View? {

        let nibName = String(describing: type)

        return UINib(
            nibName: nibName,
            bundle: bundle
        )
        .instantiate(
            withOwner: nil,
            options: nil
        )
        .flatMap { $0 as? View }
        .first

    }

}
