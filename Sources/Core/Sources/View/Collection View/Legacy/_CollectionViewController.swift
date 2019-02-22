//
//  CollectionViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewController

//@available(*, deprecated: 1.0, renamed: "CollectionViewController")
//open class _CollectionViewController<S: Storage>: ViewController {
//
//    // Done.
//    public typealias Reducer = (S) -> LegacySectionCollection
//
//    // Done.
//    private final var observations: [Observation] = []
//
//    public final var layout: LegacyCollectionViewLayout? {
//
//        didSet {
//
//            if let prefetchableLayout = layout as? PrefetchableCollectViewLayout {
//
//                 prefetchableLayout.setPrefetchingForItems { [weak self] _, indexPaths in
//
//                    #warning("FIXME: The loading more won't trigger while the displayed cells were too few.")
//                    guard
//                        let self = self,
//                        let lastIndexPath = indexPaths.max(),
//                        let lastState = self.sections?.state(at: lastIndexPath.section),
//                        case .prefetching = lastState
//                    else { return }
//
//                    print("Loading more...")
//
//                    #warning("Why does here need to reduce the storage?")
//                    self.reduceStorage()
//
//                }
//
//            }
//
//        }
//
//    }
//
//    private struct Sections {
//
//        enum State {
//
//            case fetched(LegacySectionCollection.Section)
//
//            case prefetching(LegacySectionCollection.Section)
//
//        }
//
//        let fetchedSections: LegacySectionCollection?
//
//        let prefetchingSections: LegacySectionCollection?
//
//        init(
//            fetchedSections: LegacySectionCollection? = nil,
//            prefetchingSections: LegacySectionCollection? = nil
//        ) {
//
//            if let fetchedSections = fetchedSections {
//
//                self.fetchedSections = fetchedSections
//
//            }
//            else { self.fetchedSections = nil }
//
//            if
//                let prefetchingSections = prefetchingSections,
//                !prefetchingSections.isEmpty
//            {
//
//                self.prefetchingSections = prefetchingSections
//
//            }
//            else { self.prefetchingSections = nil }
//
//        }
//
//        var count: Int {
//
//            let fetchedCount = fetchedSections?.count ?? 0
//
//            let prefetchingCount = prefetchingSections?.count ?? 0
//
//            return fetchedCount + prefetchingCount
//
//        }
//
//        func numberOfElements(at section: Int) -> Int {
//
//            switch state(at: section) {
//
//            case let .fetched(section): return section.count
//
//            case let .prefetching(section): return section.count
//
//            }
//
//        }
//
//        func view(at indexPath: IndexPath) -> View {
//
//            switch state(at: indexPath.section) {
//
//            case let .fetched(section): return section.view(at: indexPath.item)
//
//            case let .prefetching(section): return section.view(at: indexPath.item)
//
//            }
//
//        }
//
//        func state(at section: Int) -> State {
//
//            let fetchedCount = fetchedSections?.count ?? 0
//
//            let isFetched = (fetchedCount != 0) && (section < fetchedCount)
//
//            if isFetched {
//
//                guard
//                    let section = fetchedSections?.section(at: section)
//                else { fatalError("Must have a fetched section.") }
//
//                return .fetched(section)
//
//            }
//
//            if let prefetchingSections = prefetchingSections {
//
//                let prefetchingIndex = (section - fetchedCount)
//
//                let section = prefetchingSections.section(at: prefetchingIndex)
//
//                return .prefetching(section)
//
//            }
//
//            fatalError("Must have a prefetching section.")
//
//        }
//
//    }
//
//    private final var sections: Sections? {
//
//        didSet {
//
////            if isViewLoaded { asyncReloadCollectionView() }
//
//        }
//
//    }
//
//    public final var _prefetchingSections: LegacySectionCollection?
//
//    public final var storage: S? {
//
//        didSet {
//
//            guard
//                let storage = storage
//            else { return }
//
//            observations = []
//
//            observations.append(
//                storage.observe { _ in self.reduceStorage() }
//            )
//
//        }
//
//    }

//    public final var storageReducer: Reducer? {
//
//        didSet { reduceStorage() }
//
//    }
//
//    public final var storageReducer: StorageReducer<S, LegacySectionCollection>?
//
//    public final func reduceStorageToSections() {
//
//        sections = Sections()
//
//        observations = []
//
//        guard
//            let reducer = storageReducer
//        else { return }
//
//        reducer.reduce(queue: .main) { [weak self] _ in
//
//            guard
//                let self = self
//            else { return }
//
//            switch result {
//
//            case let .success(fetchedSections):
//
//                let prefetchingSections = self._prefetchingSections
//
//                self.sections = Sections(
//                    fetchedSections: fetchedSections,
//                    prefetchingSections: prefetchingSections
//                )
//
//            case let .failure(error): self.errors.value = error
//
//            }

//        }
//
//    }

//    open override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//        if storage?.isLoaded == false { loadStorage() }
//
//    }

//    fileprivate final func reduceStorage() {

//        if storage?.isLoaded == false { return }

//        #warning("Use sync to ensure reduce happen immediately before the next reload.")
//        DispatchQueue.main.async { [weak self] in
//
//            guard
//                let self = self,
//                let storage = self.storage,
//                let reducer = self.storageReducer
//            else { return }
//
//            let fetchedSections = reducer(storage)
//
//            let prefetchingSections = self._prefetchingSections
//
//            self.sections = Sections(
//                fetchedSections: fetchedSections,
//                prefetchingSections: prefetchingSections
//            )
//
//        }
//
//    }

//    fileprivate final func loadStorage() {
//
//        guard
//            let storage = storage
//        else { return }
//
//        observations = []
//
//        observations.append(
//            storage.observe { _ in
//
//                #warning("This will resign first responder.")
//                self.reduceStorage()
//
//            }
//        )
//
//        storage.load { [weak self] result in
//
//            switch result {
//
//            case .success: self?.reduceStorage()
//
//            case let .failure(error): self?.errors.value = error
//
//            }
//
//        }
//
//    }

//    fileprivate final func asyncReloadCollectionView() {
//
//        DispatchQueue.main.async { [weak self] in
//
//            self?.layout?.invalidate()
//
//        }
//
//    }
//
//}
