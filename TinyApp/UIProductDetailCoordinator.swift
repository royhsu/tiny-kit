//
//  UIProductDetailCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 22/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDetailCoordinator

import TinyPost
import TinyStore
import TinyUI
import TinyKit

// TODO: [Current workaround] inherit from UIViewController for keeping a strong reference while pushed into a navigation controller / presented by another view controller.
public final class UIProductDetailCoordinator: UIViewController, Coordinator {
    
    public final let storage: Storage
    
    private final let component: ProductDetailComponent
    
    private final let provider: ProductProvider
    
    public init(
        component: ProductDetailComponent,
        provider: ProductProvider
    ) {
        
        self.storage = Storage()
        
        self.component = component
        
        self.provider = provider
        
        self.reviewComponents = []
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        self.prepare()
        
    }
    
    public required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        gallerySubscription = storage.gallery.subscribe { [unowned self] _, gallery in
            
            self.component.setGallery(gallery)
            
        }
        
        titleSubscription = storage.title.subscribe { [unowned self] _, title in
                
            self.component.setTitle(title)
                
        }
        
        subtitleSubscription = storage.subtitle.subscribe { [unowned self] _, subtitle in
            
            self.component.setSubtitle(subtitle)
            
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
            
                if let imageProcessing = review.imageProcessing {
                
                    switch imageProcessing {
                        
                    case let .image(image): component.setPictureImage(image)
                        
                    case let .url(url, downloader):
                        
                        downloader
                            .download(
                                in: .background,
                                url: url
                            )
                            .then(
                                in: .main,
                                component.setPictureImage
                            )
                        
                    }
                    
                }

                
                return component
                
            }
            
        }
        
        introductionPostSubscription = storage.introductionPost.subscribe { _, post in
            
            self.component.setIntroductionPost(elements: post.elements)
            
        }
        
    }
    
    // MAKR: View Life Cycle
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.render(with: component)
        
    }
    
    public override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        component.contentMode = .size(
            width: view.bounds.width,
            height: view.bounds.height
        )
        
        component.render()
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        component.render()
        
        let productID = "1"
        
        storage.gallery.value = []
        
        provider
            .fetchDetail(
                in: .background,
                productID: productID
            )
            .then(in: .main) { [weak self] detail in
                
                guard
                    let weakSelf = self
                else { return }
                
                for index in 0..<detail.imageProcessings.count {
                    
                    let processing = detail.imageProcessings[index]
                    
                    let image: UIImage
                    
                    switch processing {
                        
                    case let .image(value): image = value
                        
                    case let .url(url, downloader):
                        
                        image = UIImage()
                        
                        downloader.download(
                            in: .background,
                            url: url
                        )
                        .then(in: .main) { image in
                            
                            // TODO: should use weak object image wrapper to prevent the array manuplitating before all images finished.
                            if index < weakSelf.storage.gallery.value.count {
                                
                                weakSelf.storage.gallery.value[index] = image
                                
                            }
                            
                        }
                        
                    }
                    
                    weakSelf.storage.gallery.value.append(image)
                    
                }
                
                weakSelf.storage.title.value = detail.title
                
                weakSelf.storage.subtitle.value = "$\(detail.price)"
                
                DispatchQueue.main.async { weakSelf.component.render() }
                
            }

        provider
            .fetchReviews(
                in: .background,
                productID: productID
            )
            .then(in: .main) { [weak self] reviews in
                
                guard
                    let weakSelf = self
                else { return }
                
                weakSelf.storage.reviews.value = reviews
                
                DispatchQueue.main.async { weakSelf.component.render() }
                
            }
        
        provider
            .fetchIntroductionPost(
                in: .background,
                productID: productID
            )
            .then(in: .main) { [weak self] post in
                
                guard
                    let weakSelf = self
                    else { return }
                
                weakSelf.storage.introductionPost.value = post
                
                DispatchQueue.main.async { weakSelf.component.render() }
                
            }
        
    }
    
    // MARK: Observer
    
    private final var gallerySubscription: Subscription<[UIImage]>?

    private final var titleSubscription: Subscription<String?>?
    
    private final var subtitleSubscription: Subscription<String?>?
    
    private final var reviewsSubscription: Subscription<[Review]>?
    
    private final var introductionPostSubscription: Subscription<Post>?
    
    // MARK: Storage
    
    public struct Storage {
        
        public let gallery: Observable<[UIImage]>
        
        public let title: Observable<String?>
        
        public let subtitle: Observable<String?>
        
        public let reviews: Observable<[Review]>
        
        public let introductionPost: Observable<Post>
        
        public init(
            gallery: [UIImage] = [],
            title: String? = nil,
            subtitle: String? = nil,
            reviews: [Review] = [],
            introductionPost: Post = Post()
        ) {
            
            self.gallery = Observable(gallery)
            
            self.title = Observable(title)
            
            self.subtitle = Observable(subtitle)
            
            self.reviews = Observable(reviews)
            
            self.introductionPost = Observable(introductionPost)
            
        }
        
    }
    
    // MARK: Review
    
    private final var reviewComponents: [UIProductReviewComponent]
    
}

// MARK: - ViewControllerRepresentable

extension UIProductDetailCoordinator: ViewControllerRepresentable {
    
    public final var viewController: UIViewController { return self }
    
}
