//
//  Timer.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/14.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Timer

@testable import TinyKit

final class Timer: PrefetchBatchTimer {
    
    var timeout: ( (PrefetchBatchTimer) -> Void )?
    
    func timeOut() { timeout?(self) }
    
}
