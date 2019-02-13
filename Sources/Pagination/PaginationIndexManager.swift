//
//  PaginationIndexManager.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PaginationIndexManager

@available(*, deprecated: 1.0, message: "Could not find any use case.")
final class PaginationIndexManager {
    
    private let _fetchingIndices = Property(value: [Int]() )
    
}

extension PaginationIndexManager {
    
    var fetchingIndices: [Int] { return _fetchingIndices.value ?? [] }
    
    func startFetching(for index: Int) { _fetchingIndices.mutateValue { $0?.append(index) } }
    
    func endFetching(for index: Int) {
        
        _fetchingIndices.mutateValue {
            
            $0?.removeAll { fetchingIndex in fetchingIndex == index }
            
        }
        
    }
    
    func endAllFetchings() { _fetchingIndices.mutateValue { $0 = [] } }
    
}
