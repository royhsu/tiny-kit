//
//  PrefetchIndexManagerTests.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/14.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PrefetchIndexManagerTests

import XCTest

@testable import TinyKit

final class PrefetchIndexManagerTests: XCTestCase {
    
    private let expectationTimeout = 5.0
    
    func testBatchTask() {
        
        let batchTask = expectation(description: "Execute the batch task.")
        
        let timer = Timer()
        
        let manager = PrefetchIndexManager(
            batchTimer: timer,
            batchTask: { manager, batchIndices in
                    
                defer { batchTask.fulfill() }
                
                XCTAssertEqual(
                    batchIndices,
                    [ 3, 1 ]
                )
        
                XCTAssertEqual(
                    manager.queue,
                    [ 4 ]
                )
            
            }
        )
        
        manager.queue.append(3)
        
        manager.queue.append(1)
        
        timer.timeOut()
        
        manager.queue.append(4)
        
        wait(
            for: [ batchTask ],
            timeout: expectationTimeout
        )
        
    }
    
}

// MARK: - Timer

fileprivate final class Timer: PrefetchBatchTimer {
    
    var timeout: ( (PrefetchBatchTimer) -> Void )?
    
    func timeOut() { timeout?(self) }
    
}
