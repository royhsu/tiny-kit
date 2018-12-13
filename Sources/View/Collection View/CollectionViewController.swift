//
//  CollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewController

open class NewCollectionViewController: ViewController, CollectionViewDataSource {
    
    open var sections: NewSectionCollection = []
    
    public final var collectionView: (View & NewCollectionView)? { return collectionViewLayout?.collectionView }
    
    public final var collectionViewLayout: NewCollectionViewLayout? {
        
        willSet {
            
            guard
                isViewLoaded,
                let oldLayout = collectionViewLayout
            else { return }
            
            oldLayout.collectionView.removeFromSuperview()
            
        }
        
        didSet {
            
            guard
                isViewLoaded,
                let newLayout = collectionViewLayout
            else { return }
            
            view.wrapSubview(newLayout.collectionView)
            
            newLayout.collectionView.dataSource = self
            
        }
        
    }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let initialLayout = collectionViewLayout {
            
            view.wrapSubview(initialLayout.collectionView)
            
            initialLayout.collectionView.dataSource = self
            
        }
        else {
            
            #warning("Debug-only warning.")
            print("[WARNING]: The collection view controller has no layout to display sections.")
            
        }
        
    }
    
}

@available(*, deprecated: 1.0, message: "", renamed: "NewCollectionViewController")
open class CollectionViewController: ViewController {

    public final let collectionView = CollectionView()

    public init() {

        super.init(
            nibName: nil,
            bundle: nil
        )

        self.prepare()

    }

    public required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.prepare()

    }

    public final override func viewDidLoad() {

        super.viewDidLoad()

        view.wrapSubview(collectionView)

    }

    fileprivate final func prepare() {

        collectionView.layoutDidChange = { [weak self] oldLayout, newLayout in

            let oldViewController = oldLayout?._viewController

            oldViewController?.willMove(toParent: nil)

            oldViewController?.view.removeFromSuperview()

            oldViewController?.removeFromParent()

            guard
                let self = self,
                let newViewController = newLayout?._viewController
            else { return }

            self.addChild(newViewController)

            self.view.wrapSubview(newViewController.view)

            newViewController.didMove(toParent: self)

        }

//        layout.setViewForItem { [weak self] _, indexPath in
//
//            guard
//                let self = self
//            else { return View() }
//
//            let section = self.sections.section(at: indexPath.section)
//
//            let view = section.view(at: indexPath.item)
//
//            if let actionable = view as? Actionable {
//
//                self._observations.append(
//                    actionable.actions.observe { [weak self] change in
//
//                        guard
//                            let action = change.currentValue
//                        else { return }
//
//                        self?._actionDispatcher?(action)
//
//                    }
//                )
//
//            }
//
//            if let failable = view as? Failable {
//
//                self._observations.append(
//                    failable.errors.observe { [weak self] change in
//
//                        guard
//                            let error = change.currentValue
//                        else { return }
//
//                        self?._errorHandler?(error)
//
//                    }
//                )
//
//            }
//
//            return view
//
//        }

    }

}
