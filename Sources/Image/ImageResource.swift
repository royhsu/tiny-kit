//
//  ImageResource.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ImageResource

import Foundation
import Hydra

public enum ImageResource {

    case memory(Image)

    case remote(URL, ImageProvider, Context)

}
