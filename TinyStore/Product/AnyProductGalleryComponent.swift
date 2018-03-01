//
//  AnyProductGalleryComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 01/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AnyProductGalleryComponent

public struct AnyProductGalleryComponent<T: UIImage>: ProductGalleryComponent {
    
    private let _numberOfImages: () -> Int
    
    private let _imageAtIndex: (_ index: Int) -> T
    
    public init<
        U: ProductGalleryComponent
    >(_ component: U)
    where U.Image == T {
        
        self._numberOfImages = component.numberOfImages
        
        self._imageAtIndex = component.imageAtIndex
        
    }
    
    // MARK: ProductGalleryComponent
    
    public typealias Image = T
    
    public func numberOfImages() -> Int { return _numberOfImages() }
    
    public func imageAtIndex(_ index: Int) -> Image { return _imageAtIndex(index) }
    
}
