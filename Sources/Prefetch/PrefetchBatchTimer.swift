//
//  PrefetchBatchTimer.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/14.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PrefetchBatchTimer

protocol PrefetchBatchTimer: AnyObject {
    
    var timeout: ( (PrefetchBatchTimer) -> Void )? { get set }
    
}

