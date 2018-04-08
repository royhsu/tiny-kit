//
//  ImageDownloader.swift
//  TinyApp
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ImageProcessing

import Foundation
import UIKit

public enum ImageProcessing {
    
    case image(UIImage)
    
    case url(URL, ImageDownloader)
    
}
