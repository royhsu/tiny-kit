//
//  ImageProcessing.swift
//  TinyApp
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ImageDownloader

import Foundation
import Hydra
import UIKit

public protocol ImageDownloader {
    
    func download(
        in context: Context,
        url: URL
    )
    -> Promise<UIImage>
    
}

