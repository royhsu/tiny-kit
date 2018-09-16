//
//  ConfigurableTemplate.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ConfigurableTemplate

/// Please define your preferred view by its name with a configuration.
/// The template will look up wether any registered view matches.
///
/// If the template can't find a configuration or mismatches with one, it
/// will use the earliest and registerd view for elements.
///
/// You must register at least one view for each element.
public final class ConfigurableTemplate<Storage, Configuration>: Template
where Configuration: TemplateConfiguration {
    
    public typealias Element = Configuration.Element
    
    private struct ViewTypeContainer {
        
        let date = Date()
        
        let viewType: View.Type
        
        let binding: (Storage, View) -> Void
        
    }
    
    private typealias ViewName = String
    
    private typealias ViewMapping = [ViewName: ViewTypeContainer]
    
    private final var elementMapping: [Element: ViewMapping] = [:]
    
    private final var elements: AnyCollection<Element> = AnyCollection( [] )
    
    public final let storage: Storage
    
    public final var configuration: Configuration?
    
    public init(
        storage: Storage,
        elements: [Element] = []
    ) {
        
        self.storage = storage
        
        self.elements = AnyCollection(elements)
        
    }
    
    public final func registerView(
        _ viewType: View.Type,
        binding: @escaping (Storage, View) -> (),
        for element: Element
    ) {
        
        var viewMapping = elementMapping[element] ?? [:]
        
        let viewName = String(describing: viewType)
        
        viewMapping[viewName] = ViewTypeContainer(
            viewType: viewType,
            binding: binding
        )
        
        elementMapping[element] = viewMapping
        
    }
    
    public final var numberOfElements: Int { return elements.count }
    
    public final func view(at index: Int) -> View {
        
        let index = AnyIndex(index)
        
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
        
        if let preferredViewName = configuration?.preferredViewName(for: element) {
            
            if let preferredContainer = viewMapping[preferredViewName] {
                
                let preferredView = preferredContainer.viewType.init()
                
                preferredContainer.binding(
                    storage,
                    preferredView
                )
                
                return preferredView
                
            }
            
            // TODO: development-only log.
            print("[Warning] CANNOT find a registered view with name \(preferredViewName). The template automatically fallbacks to use the earliest and registered one \(defaultContainer.viewType.self) instead.")
            
        }
        
        let defaultView = defaultContainer.viewType.init()
        
        defaultContainer.binding(
            storage,
            defaultView
        )
        
        return defaultView
    
    }
    
}
