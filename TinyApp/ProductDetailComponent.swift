//
//  ProductDetailComponent.swift
//  TinyApp
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProductDetailComponent

import TinyPost

public protocol ProductDetailComponent: Component {

    @discardableResult
    func setGallery(
        _ images: [UIImage]
    )
    -> Self

    @discardableResult
    func setTitle(_ title: String?) -> Self

    @discardableResult
    func setSubtitle(_ subtitle: String?) -> Self

//    typealias NumberOfReviewsHandler = () -> Int
//
//    @discardableResult
//    func setNumberOfReviews(
//        _ handler: NumberOfReviewsHandler?
//    )
//    -> Self
//
//    typealias ComponentForReviewHandler = (_ index: Int) -> Component
//
//    @discardableResult
//    func setComponentForReview(_ handler: ComponentForReviewHandler?) -> Self

    @discardableResult
    func setIntroductionPost(
        elements: [PostElement]
    )
    -> Self

}
