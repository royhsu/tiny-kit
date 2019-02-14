//
//  PrefetchIndexManager.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/14.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PrefetchIndexManager

final class PrefetchIndexManager {
    
    private let batchTimer: PrefetchBatchTimer
    
    private let batchTask: (
        _ manager: PrefetchIndexManager,
        _ batchIndices: [Int]
    )
    -> Void
    
    private lazy var batchTaskQueue: DispatchQueue =  {
        
        let id = UUID()
        
        let typeName = String(describing: type(of: self) )
        
        return DispatchQueue(label: "\(typeName).SerialQueue.\(id).BatchTask")
        
    }()
    
    private let _indices = Atomic(value: [Int]() )
    
    init(
        batchTimer: PrefetchBatchTimer,
        batchTask: @escaping (
            _ manager: PrefetchIndexManager,
            _ batchIndices: [Int]
        )
        -> Void
    ) {
        
        self.batchTimer = batchTimer
        
        self.batchTask = batchTask
        
        self.load()
        
    }
    
    private func load() {
        
        batchTimer.timeout = { [weak self] _ in
            
            guard let self = self else { return }
            
            let batchIndices = self.queue
            
            self.queue = []
            
            self.batchTaskQueue.async {
                
                self.batchTask(
                    self,
                    batchIndices
                )
                
            }
            
        }
        
    }
    
}

extension PrefetchIndexManager {
    
    var queue: [Int] {
        
        get { return _indices.value }
     
        set { _indices.mutateValue { $0 = newValue } }
        
    }
    
}
