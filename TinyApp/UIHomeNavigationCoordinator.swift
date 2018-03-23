//
//  UIHomeNavigationCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIHomeNavigationCoordinator

import TinyKit
import TinyStore
import TinyUI

// TODO: the navigation should be the child not parent to cart.
public final class UIHomeNavigationCoordinator: Coordinator {
    
    /// The navigator.
    private final let navigationController: UINavigationController
    
    private final let storeCoordinator: UIStoreCoordinator
    
    public init() {
        
        self.storeCoordinator = UIStoreCoordinator()
        
        self.navigationController = UINavigationController(rootViewController: storeCoordinator.viewController)
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
//        navigationController.navigationBar.isTranslucent = false
        
        storeCoordinator.setDidSelectProduct { [weak self] product in
            
            guard
                let weakSelf = self
            else { return }
            
            let productDetailCoordinator = UIProductDetailCoordinator(
                component: UIProductDetailComponent(
                    listComponent: UIListComponent(),
                    galleryComponent: UIProductGalleryComponent(),
                    actionButtonComponent: UIPrimaryButtonComponent()
                        .setTitle("Add to Cart")
                        .setAction {
                            
//                            weakSelf.cartManager.setItem(
//                                descriptor: CartItemDescriptor(
//                                    item: product,
//                                    quantity: 1,
//                                    isSelected: true
//                                )
//                            )
//
//                            weakSelf.setUpCartItemComponents()
//
//                            weakSelf.cartContentComponent.render()
                            
                        },
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
                ),
                provider: ProductManager()
            )
            
            DispatchQueue.main.async {
                
                productDetailCoordinator.activate()
                
            }
            
            // TODO: prevent the bar covering its content.
            productDetailCoordinator.additionalSafeAreaInsets.bottom = 60.0
            
            weakSelf.navigationController.pushViewController(
                productDetailCoordinator,
                animated: true
            )
            
        }
        
    }
    
    // MARK: Coordinator
    
    public final func activate() { storeCoordinator.activate() }
    
}

// MARK: - ViewControllerRepresentable

extension UIHomeNavigationCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return navigationController }
    
}
