//
//  ProductProvider.swift
//  TinyApp
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProductProvider

import Hydra
import TinyKit
import TinyPost

public protocol ProductProvider {

    typealias ProductDetail = (imageContainers: [ImageContainer], title: String?, price: Double)

    func fetchDetail(
        in context: Context,
        productID: String
    )
    -> Promise<ProductDetail>

    func fetchReviews(
        in context: Context,
        productID: String
    )
    -> Promise<[Review]>

    func fetchIntroductionPost(
        in context: Context,
        productID: String
    )
    -> Promise<Post>

}
