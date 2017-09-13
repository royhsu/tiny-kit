//
//  UIViewExtensions.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - UIViewExtensions

import UIKit
import TinyCore

public extension UIView {

    // MARK: Load Views From Nibs

    /// A convenience method to load a view from the corresponding xib file.
    ///
    /// - Parameter type: The subclass of target UIView. It must conform to the protocol `Identifiable`.
    /// - Parameter bundle: The bundle contains the nib file for the view.
    ///
    /// - Returns: An target instance of the view.
    ///
    public class func load<View: UIView>(type: View.Type, from bundle: Bundle? = nil) -> View? where View: Identifiable {

        let nibName = View.identifier

        return UINib.load(nibName: nibName, bundle: bundle) as? View

    }

}
