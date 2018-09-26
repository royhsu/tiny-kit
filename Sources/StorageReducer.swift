//
//  StorageReducer.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StorageReducer

import TinyCore
import TinyStorage

#warning("TODO: should move into TinyStorage.")
public final class StorageReducer<T, U> where T: Storage {
    
    private final let storage: T
    
    private final let reduction: (T) -> U
    
    public init(
        storage: T,
        reduction: @escaping (T) -> U
    ) {
        
        self.storage = storage
        
        self.reduction = reduction
            
    }
    
    public final func reduce(
        completion: @escaping (Result<U>) -> Void
    ) {
        
        storage.load { [weak self] result in
            
            guard
                let self = self
            else { return }
            
            switch result {
               
            case .success:
                
                let value = self.reduction(self.storage)
                
                completion(
                    .success(value)
                )
            
            case let .failure(error):
                    
                 completion(
                    .failure(error)
                )
                    
            }
            
        }
        
    }
    
}
