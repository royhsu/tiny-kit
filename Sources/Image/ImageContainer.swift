//
//  ImageContainer.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ImageContainer

import Foundation

public enum ImageContainer {
    
    case image(UIImage)
    
    case url(URL, ImageProvider)
    
}
