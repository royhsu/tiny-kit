//
//  UIProductDetailCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 22/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProductDetailCoordinator

import TinyKit

public final class ProductDetailCoordinator: Coordinator {
    
    public final let storage: Storage
    
    private final let componentViewController: UIComponentViewController
    
    private final let component: ProductDetailComponent
    
    public init(component: ProductDetailComponent) {
        
        self.storage = Storage()
        
        self.componentViewController = UIComponentViewController(component: component)
        
        self.component = component
        
        self.reviewComponents = []
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        componentViewController.view.backgroundColor = .white
        
        titleSubscription = storage.title.subscribe { [unowned self] _, title in
                
            self.component.setTitle(title)
            
            DispatchQueue.main.async { self.component.render() }
                
        }
        
        subtitleSubscription = storage.subtitle.subscribe { [unowned self] _, subtitle in
            
            self.component.setSubtitle(subtitle)
            
            DispatchQueue.main.async { self.component.render() }
            
        }
    
        component
            .setNumberOfReviews { [unowned self] in self.reviewComponents.count }
            .setComponentForReview { [unowned self] index in self.reviewComponents[index] }
        
        reviewsSubscription = storage.reviews.subscribe { [unowned self] _, reviews in
        
            self.reviewComponents = reviews.map { review in
                
                let component = UIProductReviewComponent(
                    contentMode: .size(
                        width: 250.0,
                        height: 143.0
                    )
                )
                    
                component.setTitle(review.title).setText(review.text)
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    
                    component.setPictureImage(#imageLiteral(resourceName: "image-carolyn-simmons"))
                    
                }
                
                return component
                
            }
            
            DispatchQueue.main.async { self.component.render() }
            
        }
        
        introductionPostSubscription = storage.introductionPost.subscribe { _, post in
            
            self.component.setIntroductionPost(elements: post.elements)
            
            DispatchQueue.main.async { self.component.render() }
            
        }
        
    }
    
    // MARK: Coordinator
    
    public final func activate() { component.render() }
    
    // MARK: Observer

    private final var titleSubscription: Subscription<String?>?
    
    private final var subtitleSubscription: Subscription<String?>?
    
    private final var reviewsSubscription: Subscription<[Review]>?
    
    private final var introductionPostSubscription: Subscription<Post>?
    
    // MARK: Storage
    
    public struct Storage {
        
        public let title: Observable<String?>
        
        public let subtitle: Observable<String?>
        
        public let reviews: Observable<[Review]>
        
        public let introductionPost: Observable<Post>
        
        public init(
            title: String? = nil,
            subtitle: String? = nil,
            reviews: [Review] = [],
            introductionPost: Post = Post()
        ) {
            
            self.title = Observable(title)
            
            self.subtitle = Observable(subtitle)
            
            self.reviews = Observable(reviews)
            
            self.introductionPost = Observable(introductionPost)
            
        }
        
    }
    
    // MARK: Review
    
    public typealias Review = (title: String?, text: String?)
    
    private final var reviewComponents: [UIProductReviewComponent]
    
}

// MARK: - ViewControllerRepresentable

extension ProductDetailCoordinator: ViewControllerRepresentable {
    
    public final var viewController: UIViewController { return componentViewController }
    
}

// MARK: - ProductDetailComponent

import TinyPost

public protocol ProductDetailComponent: Component {
    
    @discardableResult
    func setTitle(_ title: String?) -> Self
    
    @discardableResult
    func setSubtitle(_ subtitle: String?) -> Self
    
    typealias NumberOfReviewsHandler = () -> Int
    
    @discardableResult
    func setNumberOfReviews(
        _ handler: NumberOfReviewsHandler?
    )
    -> Self
    
    typealias ComponentForReviewHandler = (_ index: Int) -> Component
    
    @discardableResult
    func setComponentForReview(_ handler: ComponentForReviewHandler?) -> Self
    
    @discardableResult
    func setIntroductionPost(
        elements: [PostElement]
    )
    -> Self
    
}

import TinyStore

extension UIProductDetailComponent: ProductDetailComponent { }
