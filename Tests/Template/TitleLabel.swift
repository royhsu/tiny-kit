//
//  TitleLabel.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TitleLabel

import TinyKit
import UIKit

internal final class TitleLabel: UILabel, Updatable {
    
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
        
        font = UIFont.preferredFont(forTextStyle: .title2)
        
    }
    
    internal final func updateValue(_ value: Any?) {
        
        let post = value as? Post
        
        text = post?.title
        
    }
    
}
