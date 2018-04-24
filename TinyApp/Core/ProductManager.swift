//
//  ProductManager.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProductManager

import Foundation
import Hydra
import TinyPost

public final class ProductManager: ProductProvider {

    public init() { }

    public final func fetchProducts(in context: Context) -> Promise<[Product]> {

        return Promise(in: context) { fulfill, reject, _ in

            let products = [
                Product(
                    id: UUID().uuidString,
                    imageContainers: [ .memory(#imageLiteral(resourceName: "image-dessert-1")) ],
                    title: "Cras mattis consectetur purus sit amet fermentum.",
                    price: 40.0
                ),
                Product(
                    id: UUID().uuidString,
                    imageContainers: [ .memory(#imageLiteral(resourceName: "image-dessert-2")) ],
                    title: "Aenean eu leo quam.",
                    price: 120.0
                ),
                Product(
                    id: UUID().uuidString,
                    imageContainers: [ .memory(#imageLiteral(resourceName: "image-dessert-3")) ],
                    title: "Donec id elit non mi porta gravida at eget metus.",
                    price: 75.0
                )
            ]

            fulfill(products)

        }

    }

    public final func fetchDetail(
        in context: Context,
        productID: String
    )
    -> Promise<ProductDetail> {

        return Promise(in: context) { fulfill, reject, _ in

            let result = ProductDetail(
                imageContainers: [ .memory(#imageLiteral(resourceName: "image-dessert-1")) ],
                title: "Donec id elit non mi porta gravida at eget metus. Sed posuere consectetur est at lobortis. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Sed posuere consectetur est at lobortis.",
                price: 100.0
            )

            fulfill(result)

        }

    }

    public final func fetchReviews(
        in context: Context,
        productID: String
    )
    -> Promise<[Review]> {

        return Promise(in: context) { fulfill, reject, _ in

            fulfill(
                [
                    Review(
                        imageContainer: .remote(
                            URL(string: "https//apple.com")!,
                            UIImageDownloader(),
                            .background
                        ),
                        title: "Carolyn Simmons",
                        text: "Etiam porta sem malesuada magna mollis euismod. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui."
                    ),
                    Review(
                        imageContainer: .memory(#imageLiteral(resourceName: "image-jerry-price")),
                        title: "Jerry Price",
                        text: "Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    ),
                    Review(
                        imageContainer: .memory(#imageLiteral(resourceName: "image-danielle-schneider")),
                        title: "Danielle Schneider",
                        text: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Curabitur blandit tempus porttitor."
                    )
                ]
            )

        }

    }

//    public final func fetchIntroductionPost(
//        in context: Context,
//        productID: String
//    )
//    -> Promise<Post> {
//
//        return Promise(in: context) { fulfill, reject, _ in
//
//            fulfill(
//                Post(
//                    elements: [
//                        .text("Sed posuere consectetur est at lobortis. Seosuere consectetur est at lobortis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante venenatis dapibus posuere elit aliquet. Lorem ipsum dolor sit amet, coctetur adipiscing."),
//                        .image(#imageLiteral(resourceName: "image-product-story-1")),
//                        .image(#imageLiteral(resourceName: "image-product-story-2")),
//                        .text("Etiam porta sem malesuada magna mollis euismod. Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
//                        .image(#imageLiteral(resourceName: "image-product-story-3")),
//                        .image(#imageLiteral(resourceName: "image-product-story-4"))
//                    ]
//                )
//            )
//
//        }
//
//    }

}
