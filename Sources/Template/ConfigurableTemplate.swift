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
public final class ConfigurableTemplate<Configuration>: Template
where Configuration: TemplateConfiguration {
    
    public typealias Element = Configuration.Element
    
    private struct ViewTypeContainer {
        
        let date = Date()
        
        let viewType: View.Type
        
    }
    
    private typealias ViewName = String
    
    private typealias ViewMapping = [ViewName: ViewTypeContainer]
    
    private final var elementMapping: [Element: ViewMapping] = [:]
    
    private final var elements: AnyCollection<Element> = AnyCollection( [] )
    
    public final var configuration: Configuration?
    
    public init(
        elements: [Element] = []
    ) { self.elements = AnyCollection(elements) }
    
    public final func registerView(
        _ viewType: View.Type,
        for element: Element
    ) {
        
        var viewMapping = elementMapping[element] ?? [:]
        
        let viewName = String(describing: viewType)
        
        viewMapping[viewName] = ViewTypeContainer(viewType: viewType)
        
        elementMapping[element] = viewMapping
        
    }
    
    // MARK: Template
    
    public final var numberOfElements: Int { return elements.count }
    
    public final func element(at index: Int) -> Element { return elements[ AnyIndex(index) ] }
    
    public final func view(for element: Element) -> View {
        
        let viewMapping = elementMapping[element] ?? [:]
        
        guard
            let firstViewTypePair = viewMapping
                .sorted(
                    by: { $0.value.date < $1.value.date }
                )
                .first
        else { fatalError("Please make sure to register at least one view for \(element).") }
        
        let firstViewType = firstViewTypePair.value.viewType
        
        guard
            let viewName = configuration?.preferredViewName(for: element)
        else { return firstViewType.init() }
            
        if let viewTypeContainer = viewMapping[viewName] {
            
            return viewTypeContainer.viewType.init()
            
        }
        
        print("[Warning] CANNOT find a registered view with name \(viewName). The template automatically fallbacks to use the earliest and registered one \(firstViewType.self) instead.")
        
        return firstViewType.init()
        
    }
    
}

// MARK: - ExpressibleByArrayLiteral

extension ConfigurableTemplate: ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = Element
    
    public convenience init(arrayLiteral elements: ArrayLiteralElement...) {
        
        self.init(elements: elements)
        
    }
    
}
