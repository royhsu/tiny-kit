//
//  PrefetchTask.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/15.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PrefetchTask

typealias PrefetchTask = (
    _ manager: PrefetchTaskManager,
    _ completion: @escaping () -> Void
)
-> Void

