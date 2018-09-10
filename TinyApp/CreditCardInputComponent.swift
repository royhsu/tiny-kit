//
//  CreditCardInputComponent.swift
//  TinyApp
//
//  Created by Roy Hsu on 2018/5/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CreditCardInputComponent

import TinyCore
import TinyKit

public final class CreditCardInputComponent {
    
    private final let listComponent: ListComponent
    
    private final let titleComponent: TitleComponent

    private final let inputComponent: TextInputComponent

    private final var inputSubscription: Observable<String>.ValueDidChangeSubscription?
    
    public init(
        listComponent: ListComponent,
        titleComponent: TitleComponent,
        inputComponent: TextInputComponent
    ) {
        
        self.listComponent = listComponent
        
        self.titleComponent = titleComponent

        self.inputComponent = inputComponent

        self.prepare()

    }

    // MARK: Set Up

    private final func prepare() {

        inputSubscription = inputComponent.input.observeValueDidChange { _, value in
            
        }

    }
    
    public final func render() {
        
        listComponent.setItemComponents(
            [
                titleComponent,
                inputComponent
            ]
        )
        
        listComponent.render()
        
    }

}

public protocol TitleComponent: Component {
    
    var title: String { get set }
    
}

public protocol TextInputComponent: Component {
    
    var input: Observable<String> { get }
    
}
