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

    private final var products: [Product]

    public init() {

        self.storeComponent = UIGridComponent(
            contentMode: .size(UIScreen.main.bounds.size),
            layout: UIGridLayout(
                columns: 2,
                rows: 2,
                interitemSpacing: 30.0,
                lineSpacing: 30.0
            )
        )
        
        let boxComponent = UIBoxComponent(contentComponent: storeComponent)

        boxComponent.paddingInsets = UIEdgeInsets(
            top: 30.0,
            left: 30.0,
            bottom: 30.0,
            right: 30.0
        )

        // TODO: the box component is not protected under safe area, so the top and bottom will be cut.
        self.componentViewController = UIComponentViewController(component: boxComponent)
        
        self.productManager = ProductManager()

        self.products = []
        
        self.prepare()

    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        storeComponent.setMinimumItemSize { layout, gridSize, indexPath in
            
            let itemWidth = gridSize.width
            
            let imageAspectRatio: CGFloat = 4.0 / 3.0
            
            let itemHeight = (itemWidth / imageAspectRatio)  + 63.0
            
            return CGSize(
                width: itemWidth,
                height: itemHeight
            )
            
        }
        
    }

    // MARK: Coordinator

    public final func activate() {

        storeComponent.render()

        productManager
            .fetchProducts(in: .background)
            .then(in: .main) { [weak self] products in
                
                guard
                    let weakSelf = self
                else { return }
                
                weakSelf.products = products
            
                weakSelf.storeComponent.setItemComponents(
                    products.map { product in
                        
                        let itemComponent = TSStoreItemComponent()
                        
                        itemComponent.titleLabel.text = product.title
                        
                        itemComponent.subtitleLabel.text = "$\(product.price)"
                        
                        let imageContainer = product.imageContainers.first
                        
                        imageContainer?.setImage(to: itemComponent.previewImageView)
        
                        return itemComponent
                        
                    }
                )
                
                weakSelf.storeComponent.render()
                
            }
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

//        storeComponent.setDidSelectItem { indexPath in
//
//            let product = self.products[indexPath.row]
//
//            handler?(product)
//
//        }

        return self

    }

}

// MARK: - ViewControllerRepresentable

extension UIStoreCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return componentViewController }

}
