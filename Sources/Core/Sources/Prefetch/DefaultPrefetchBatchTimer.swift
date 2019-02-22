//
//  DefaultPrefetchBatchTimer.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/14.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - DefaultPrefetchBatchTimer

import Foundation

#warning("TODO: refactor with a better implementation and make sure not to cause memory leaks.")
final class DefaultPrefetchBatchTimer {
    
    private var timeout: ( (DefaultPrefetchBatchTimer) -> Void )?
    
    private lazy var timer = Timer.scheduledTimer(
        withTimeInterval: 0.5,
        repeats: true,
        block: { [weak self] _ in
        
            guard let self = self else { return }
        
            self.timeout?(self)
        
        }
    )
    
    init() { _ = timer }
    
    deinit { timer.invalidate() }
    
}

// MARK: - PrefetchBatchScheduler

extension DefaultPrefetchBatchTimer: PrefetchBatchScheduler {
    
    func scheduleTask(
        _ task: @escaping (PrefetchBatchScheduler) -> Void
    ) { timeout = task }
    
}
