//
//  Timer.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/14.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Timer

final class Timer {
    
    private var timeout: ( (Timer) -> Void )?
    
    func timeOut() { timeout?(self) }
    
}

// MARK: - PrefetchBatchScheduler

@testable import TinyKit

extension Timer: PrefetchBatchScheduler {
    
    func scheduleTask(
        _ task: @escaping (PrefetchBatchScheduler) -> Void
    ) { timeout = task }
    
}
