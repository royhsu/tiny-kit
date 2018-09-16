//
//  BodyLabel.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - BodyLabel

import TinyKit
import UIKit

internal final class BodyLabel: UILabel {
    
    internal override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.prepare()
        
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        numberOfLines = 0
        
        font = .preferredFont(forTextStyle: .body)
        
        textColor = .darkGray
        
    }
    
}
