//
//  UIProductDetailCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 22/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDetailCoordinator

import TinyCore
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

        gallerySubscription = storage.gallery.observeValueDidChange { [unowned self] _, gallery in

            self.component.setGallery(gallery)

        }

        titleSubscription = storage.title.observeValueDidChange { [unowned self] _, title in

            self.component.setTitle(title)

        }

        subtitleSubscription = storage.subtitle.observeValueDidChange { [unowned self] _, subtitle in

            self.component.setSubtitle(subtitle)

        }

//        component
//            .setNumberOfReviews { [unowned self] in self.reviewComponents.count }
//            .setComponentForReview { [unowned self] index in self.reviewComponents[index] }

        reviewsSubscription = storage.reviews.observeValueDidChange { [unowned self] _, reviews in

            self.reviewComponents = reviews.map { review in

                let component = UIProductReviewComponent(
                    contentMode: .size(
                        CGSize(
                            width: 250.0,
                            height: 143.0
                        )
                    )
                )

                component.setTitle(review.title).setText(review.text)

                if let imageContainer = review.imageContainer {

//                    imageContainer.setImage(to: component.setPictureImage(<#T##image: UIImage?##UIImage?#>))

                }

                return component

            }

        }

        introductionPostSubscription = storage.introductionPost.observeValueDidChange { _, post in

            self.component.setIntroductionPost(elements: post.elements)

        }

    }

    // MAKR: View Life Cycle

    public final override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = .white

        view.wrapSubview(component.view)

    }

    public override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()

        component.contentMode = .size(view.bounds.size)

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

                for index in 0..<detail.imageContainers.count {

//                    let imageContainer = detail.imageContainers[index]
//
//                    let image: UIImage
//
//                    switch imageContainer {
//
//                    case let .image(value): image = value
//
//                    case let .url(url, provider):
//
//                        image = UIImage()
//
//                        provider.fetch(
//                            in: .background,
//                            url: url
//                        )
//                        .then(in: .main) { image in
//
//                            // TODO: should use weak object image wrapper to prevent the array manuplitating before all images finished.
//                            if index < weakSelf.storage.gallery.value.count {
//
//                                weakSelf.storage.gallery.value[index] = image
//
//                            }
//
//                        }
//
//                    }
//
//                    weakSelf.storage.gallery.value.append(image)

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

    private final var gallerySubscription: Gallery.ValueDidChangeSubscription?

    private final var titleSubscription: Title.ValueDidChangeSubscription?

    private final var subtitleSubscription: Subtitle.ValueDidChangeSubscription?

    private final var reviewsSubscription: Reviews.ValueDidChangeSubscription?

    private final var introductionPostSubscription: IntroductionPost.ValueDidChangeSubscription?

    // MARK: Storage

    public typealias Gallery = Observable<[UIImage]>

    public typealias Title = Observable<String?>

    public typealias Subtitle = Observable<String?>

    public typealias Reviews = Observable<[Review]>

    public typealias IntroductionPost = Observable<Post>

    public struct Storage {

        public let gallery: Gallery

        public let title: Title

        public let subtitle: Subtitle

        public let reviews: Reviews

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
