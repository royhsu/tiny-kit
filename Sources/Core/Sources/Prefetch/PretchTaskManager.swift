//
//  PretchTaskManager.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/15.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PretchTaskManager

final class PrefetchTaskManager {
    
    private var _tasks: [PrefetchPage: PrefetchTask] = [:]
    
    private var executingTasks: [PrefetchPage: PrefetchTask] = [:]
    
    private(set) var allTasksCompletion: ( (PrefetchTaskManager) -> Void )?
    
    private(set) var isExecutingTasks = false {
        
        didSet {
            
            if isExecutingTasks { return }
            
            let completion = allTasksCompletion
            
            allTasksCompletion = nil
            
            completion?(self)
            
        }
        
    }
    
    var isDebugging = true
    
}

extension PrefetchTaskManager {
    
    var tasks: [PrefetchPage: PrefetchTask] {
        
        get { return isExecutingTasks ? executingTasks : _tasks }
        
        set { _tasks = _tasks.merging(newValue) { (old, new) in new } }
        
    }
    
}

extension PrefetchTaskManager {
    
    func executeAllTasks(
        completion: ( (PrefetchTaskManager) -> Void )? = nil
    ) {
        
        if isExecutingTasks { preconditionFailure("There are still tasks executing.") }
        
        isExecutingTasks = true
        
        executingTasks = _tasks
        
        allTasksCompletion = completion
        
        if isDebugging {
            
            let tasks = executingTasks.keys.map { "\($0)" }.joined(separator: ", ")
            
            print(
                String(describing: type(of: self) ),
                #function,
                "schedule all tasks [ \(tasks) ]..."
            )
            
        }
        
        _tasks = [:]
        
        executeRemainingTasks()
        
    }
    
    private func executeRemainingTasks() {
        
        if executingTasks.isEmpty {
            
            isExecutingTasks = false
            
            return
            
        }
        
        if let task = executingTasks.removeValue(forKey: .previous) {
            
            if isDebugging {
                
                print(
                    String(describing: type(of: self) ),
                    #function,
                    "start executing the task for previous page..."
                )
                
            }
            
            task(self) { [weak self] in
                
                guard let self = self else { return }
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self) ),
                        #function,
                        "The task for the previous page has been completed."
                    )
                    
                }
                
                self.executeRemainingTasks()
                
            }
            
            return
            
        }
        
        if let task = executingTasks.removeValue(forKey: .next) {
            
            if isDebugging {
                
                print(
                    String(describing: type(of: self) ),
                    #function,
                    "start executing the task for next page..."
                )
                
            }
            
            task(self) { [weak self] in
                
                guard let self = self else { return }
                
                if self.isDebugging {
                    
                    print(
                        String(describing: type(of: self) ),
                        #function,
                        "The task for the next page has been completed."
                    )
                    
                }
                
                self.executeRemainingTasks()
                
            }
            
            return
            
        }
        
    }
    
}
