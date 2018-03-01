//
//  ProductGalleryComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 01/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProductGalleryComponent

public protocol ProductGalleryComponent {
    
    associatedtype Image
    
    func numberOfImages() -> Int
    
    func imageAtIndex(_ index: Int) -> Image
    
}
