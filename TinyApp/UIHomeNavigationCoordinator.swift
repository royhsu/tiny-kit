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
            
            print("Select a product.")
            
            guard
                let weakSelf = self
            else { return }
            
            let productDetailComponent = UIProductDetailComponent(
                listComponent: UIListComponent(),
                galleryComponent: UIProductGalleryComponent(),
                actionButtonComponent: UIPrimaryButtonComponent()
                    .setTitle("Add to Cart")
                    .setAction { },
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
    
}

// MARK: - ViewControllerRepresentable

extension UIHomeNavigationCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return navigationController }
    
}
