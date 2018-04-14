//
//  ImageContainer.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ImageContainer

import Foundation
import Hydra

public enum ImageContainer {

    case image(UIImage)

    case url(URL, ImageProvider, Context)

}

// MARK: - UIImageView

public extension ImageContainer {

    // TODO: add completionHandler.
    public func setImage(to imageView: UIImageView) {
        
        switch self {
            
        case let .image(image): imageView.image = image
            
        case let .url(url, provider, context):
            
            provider.fetch(
                in: context,
                url: url
            )
            .then(in: .main) { image in imageView.image = image }
            
        }
        
    }
    
}
