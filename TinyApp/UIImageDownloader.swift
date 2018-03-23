//
//  UIImageDownloader.swift
//  TinyApp
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIImageDownloader

import Foundation
import Hydra
import UIKit

public final class UIImageDownloader: ImageDownloader {
    
    public init() { }
    
    public final func download(
        in context: Context,
        url: URL
    )
    -> Promise<UIImage> {
        
        return Promise(in: context) { fulfill, reject, _ in
            
            fulfill(#imageLiteral(resourceName: "image-carolyn-simmons"))
            
        }
            
    }
    
}

