//
//  UINibView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/1/25.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - UINibView

@IBDesignable
open class UINibView<NibView: UIView>: UIView {
    
    public final let nibView: NibView = {
        
        return UIView.loadView(
            NibView.self,
            from: Bundle(for: NibView.self)
        )!
        
    }()
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.load()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() { wrapSubview(nibView) }
    
}
