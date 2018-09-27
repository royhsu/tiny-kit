//
//  View.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - View

#if canImport(UIKit)

import UIKit

public typealias View = UIView

#else

open class View {

    open init() { }

}

#endif
