//
//  UIStoreCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

/// MARK: - UIStoreCoordinator

import Foundation
import TinyKit
import TinyStore

public final class UIStoreCoordinator: Coordinator {

    /// The navigator.
    private final let componentViewController: UIComponentViewController

    private final let storeComponent: UIGridComponent

    private final let productManager: ProductManager

    private final var products: [Product] {

        didSet {

            storeComponent
                .setNumberOfSections { 1 }
                .setNumberOfItems { _ in self.products.count }
                .setComponentForItem { indexPath in

                    let product = self.products[indexPath.row]

                    // Prevent the size of an item greater than the collection view, that will raise an exception.
                    let component = UIGridItemComponent(
                        contentMode: .size(.zero)
                    )
                    .setTitle(product.title)
                    .setSubtitle("$\(product.price)")

                    // Emulate the image downloading process.
                    // This will cause UI unrespondable.
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//
//                        component
//                            .setPreviewImages(
//                                [ #imageLiteral(resourceName: "image-dessert-1") ]
//                            )
//
//                    }

                    return component

                }
                .render()

        }

    }

    public init() {

        let storeComponent = UIGridComponent()

        self.componentViewController = UIComponentViewController(component: storeComponent)

        self.storeComponent = storeComponent

        self.productManager = ProductManager()

        self.products = []

    }

    // MARK: Coordinator

    public final func activate() {

        storeComponent.render()

        productManager
            .fetchProducts(in: .background)
            .then(in: .main) { self.products = $0 }
            .catch(in: .main) { error in

                // TODO: error handling.
                print("\(error)")

            }

    }

}

public extension UIStoreCoordinator {

    public typealias DidSelectProductHandler = (Product) -> Void

    @discardableResult
    public final func setDidSelectProduct(_ handler: DidSelectProductHandler?) -> UIStoreCoordinator {

        storeComponent.setDidSelectItem { indexPath in

            let product = self.products[indexPath.row]

            handler?(product)

        }

        return self

    }

}

// MARK: - ViewControllerRepresentable

extension UIStoreCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return componentViewController }

}
