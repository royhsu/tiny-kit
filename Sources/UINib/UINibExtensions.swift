//
//  UINibExtensions.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - UINibExtensions

import UIKit

public extension UINib {

    // MARK: Load Nibs

    /// A convenience method to load a xib file.
    ///
    /// - Parameter nibName: The name of xib file.
    /// - Parameter bundle: The bundle which contains the xib file. Default is nil.
    ///
    /// - Returns: The loaded instance.
    ///
    public class func load(nibName: String, bundle: Bundle? = nil) -> Any? {

        return UINib(nibName: nibName, bundle: bundle)
            .instantiate(withOwner: nil, options: nil)
            .first

    }

}
