//
//  DefaultSection.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - DefaultSection

/// Please define your preferred view by its name with a configuration.
/// The template will look up wether any registered view matches.
///
/// If the template can't find a configuration or mismatches with one, it
/// will use the earliest and registerd view for elements.
///
/// You must register at least one view for each element.
public final class DefaultSection<Storage, Configuration: DefaultSectionConfiguration>: LegacyViewCollection {

    public typealias Element = Configuration.Element

    private struct ViewTypeContainer {

        internal let date = Date()

        internal let viewType: View.Type

        internal let bundle: Bundle?

        internal let binding: (Storage, View) -> Void

        internal var view: View {

            guard
                let bundle = bundle
            else { return viewType.init() }

            guard
                let view = View.loadView(
                    viewType,
                    from: bundle
                )
            else { fatalError("CANNOT find the coresponding UINib from the bundle \(bundle).") }

            return view

        }

    }

    private typealias ViewName = String

    private typealias ViewMapping = [ViewName: ViewTypeContainer]

    private final var elementMapping: [Element: ViewMapping] = [:]

    #warning("need to be replaced by OrderedSet.")
    private final let elements: [Element]

    public final let storage: Storage

    public final var configuration: Configuration?

    public init(
        storage: Storage,
        elements: [Element]
    ) {

        self.storage = storage

        self.elements = elements

    }

    public final func registerView<V>(
        _ viewType: V.Type,
        from bundle: Bundle? = nil,
        binding: @escaping (Storage, V) -> Void,
        for element: Element
    )
    where V: View {

        var viewMapping = elementMapping[element] ?? [:]

        let viewName = name(for: viewType)

        viewMapping[viewName] = ViewTypeContainer(
            viewType: viewType,
            bundle: bundle,
            binding: { storage, view in

                let view = view as! V

                binding(
                    storage,
                    view
                )

            }
        )

        elementMapping[element] = viewMapping

    }

    private final func name(for viewType: View.Type) -> String { return String(describing: viewType) }

    public final var count: Int { return elements.count }

    public final func view(at index: Int) -> View {

        let element = elements[index]

        return view(for: element)

    }

    public final func view(for element: Element) -> View {

        let viewMapping = elementMapping[element] ?? [:]

        guard
            let firstViewTypePair = viewMapping
                .sorted(
                    by: { $0.value.date < $1.value.date }
                )
                .first
        else { fatalError("Please make sure to register at least one view for \(element).") }

        let defaultContainer = firstViewTypePair.value

        if let preferredViewType = configuration?.preferredViewType(for: element) {

            let preferredViewName = name(for: preferredViewType)

            if let preferredContainer = viewMapping[preferredViewName] {

                let preferredView = preferredContainer.view

                preferredContainer.binding(
                    storage,
                    preferredView
                )

                return preferredView

            }

            // TODO: development-only log.
            print("[Warning] CANNOT find a registered view with name \(preferredViewName). The template automatically fallbacks to use the earliest and registered one \(defaultContainer.viewType.self) instead.")

        }

        let defaultView = defaultContainer.view

        defaultContainer.binding(
            storage,
            defaultView
        )

        return defaultView

    }

}

// MARK: - KeyPath Binding

public extension DefaultSection {

    public final func registerView<V, T>(
        _ viewType: V.Type,
        from bundle: Bundle? = nil,
        binding: (
            from: KeyPath<Storage, T?>,
            to: ReferenceWritableKeyPath<V, T>
        ),
        for element: Element
    )
    where V: View {

        registerView(
            viewType,
            from: bundle,
            binding: { storage, view in

                guard
                    let value = storage[keyPath: binding.from]
                else { return }

                view[keyPath: binding.to] = value

            },
            for: element
        )

    }

    public final func registerView<V, T>(
        _ viewType: V.Type,
        from bundle: Bundle? = nil,
        binding: (
            from: KeyPath<Storage, T>,
            to: ReferenceWritableKeyPath<V, T>
        ),
        for element: Element
    )
    where V: View {

        registerView(
            viewType,
            from: bundle,
            binding: { storage, view in

                view[keyPath: binding.to] = storage[keyPath: binding.from]

            },
            for: element
        )

    }

    public final func registerView<V, T>(
        _ viewType: V.Type,
        from bundle: Bundle? = nil,
        binding: (
            from: KeyPath<Storage, T>,
            to: ReferenceWritableKeyPath<V, T?>
        ),
        for element: Element
    )
    where V: View {

        registerView(
            viewType,
            from: bundle,
            binding: { storage, view in

                let value: T? = storage[keyPath: binding.from]

                view[keyPath: binding.to] = value

            },
            for: element
        )

    }

}
