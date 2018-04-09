//
//  ImageProvider.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ImageProvider

import Foundation
import Hydra

public protocol ImageProvider {

    func fetch(
        in context: Context,
        url: URL
    )
    -> Promise<UIImage>

}
