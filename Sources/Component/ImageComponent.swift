//
//  ImageComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/15.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ImageComponent

public protocol ImageComponent: Component {
    
    var image: Image? { get set }
    
}

import Hydra

public extension ImageComponent {
    
    func setImageResource(_ resource: ImageResource) {
        
        switch resource {
            
        case let .memory(image): self.image = image
            
        case let .remote(
            url,
            provider,
            context
        ):
            
            provider.fetch(
                in: context,
                url: url
            )
            .then(in: .main) { [weak self] image in self?.image = image }
            
        }
        
    }
    
}
