//
//  UIHomeCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIHomeCoordinator

import TinyKit
import TinyStore
import TinyUI

public final class UIHomeCoordinator: Coordinator {

    /// The navigator.
    private final let navigationController: UINavigationController

    private final let storeCoordinator: UIStoreCoordinator

    public init() {

        self.storeCoordinator = UIStoreCoordinator()

        self.navigationController = UINavigationController(rootViewController: storeCoordinator.viewController)

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        storeCoordinator.setDidSelectProduct { [weak self] product in

            guard
                let weakSelf = self
            else { return }

            let productDetailComponent = UIProductDetailComponent(
                listComponent: UIListComponent(),
                galleryComponent: UIProductGalleryComponent(),
                actionButtonComponent: UIPrimaryButtonComponent()
                    .setTitle("Add to Cart")
                    .setAction { weakSelf.addToCartHandler?(product) },
                reviewSectionHeaderComponent: UIProductSectionHeaderComponent()
                    .setIconImage(
                        #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate)
                    )
                    .setTitle("Reviews"),
                reviewCarouselComponent: UIProductReviewCarouselComponent(),
                introductionSectionHeaderComponent: UIProductSectionHeaderComponent()
                    .setIconImage(
                        #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate)
                    )
                    .setTitle("Introduction")
            )

            let productDetailCoordinator = UIProductDetailCoordinator(
                component: productDetailComponent,
                provider: ProductManager()
            )

            // TODO: prevent the bar covering its content.
            productDetailCoordinator.additionalSafeAreaInsets.bottom = 60.0

            weakSelf.navigationController.pushViewController(
                productDetailCoordinator,
                animated: true
            )

            DispatchQueue.main.async {

                productDetailCoordinator.activate()

            }

        }

    }

    // MARK: Coordinator

    public final func activate() { storeCoordinator.activate() }

    // MARK: Action

    public typealias AddToCartHandler = (Product) -> Void

    private final var addToCartHandler: AddToCartHandler?

}

public extension UIHomeCoordinator {

    @discardableResult
    public final func setAddToCart(_ handler: AddToCartHandler?) -> UIHomeCoordinator {

        addToCartHandler = handler

        return self

    }

}

// MARK: - ViewControllerRepresentable

extension UIHomeCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return navigationController }

}
