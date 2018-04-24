//
//  ImageResource+UIImageView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIImageView

public extension ImageResource {

    public func setImage(to imageView: UIImageView) {
        
        switch self {
            
        case let .memory(image): imageView.image = image
            
        case let .remote(url, provider, context):
            
            provider.fetch(
                in: context,
                url: url
            )
            .then(in: .main) { image in imageView.image = image }
            
        }
        
    }
    
}
