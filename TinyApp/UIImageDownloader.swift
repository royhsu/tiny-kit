//
//  UIImageDownloader.swift
//  TinyApp
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWzorld. All rights reserved.
//

// MARK: - UIImageDownloader

import Foundation
import Hydra
import TinyKit

public final class UIImageDownloader: ImageProvider {
    
    public init() { }
    
    public final func fetch(
        in context: Context,
        url: URL
    )
    -> Promise<UIImage> {
        
        return Promise(in: context) { fulfill, reject, _ in
            
            fulfill(#imageLiteral(resourceName: "image-carolyn-simmons"))
            
        }
            
    }
    
}

