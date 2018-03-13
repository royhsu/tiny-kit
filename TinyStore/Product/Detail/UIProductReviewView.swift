//
//  UIProductReviewView.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductReviewView

public final class UIProductReviewView: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var pictureImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final weak var contentLabel: UILabel!
    
    // MARK: Life Cycle
    
    public final override func awakeFromNib() {
        
        setUpRootView(self)
        
    }
    
    fileprivate final func setUpRootView(_ view: UIView) {
        
        view.layer.shadowColor = UIColor.black.cgColor
        
        view.layer.shadowOffset = CGSize(
            width: 0.0,
            height: 2.0
        )
        
        view.layer.shadowOpacity = 0.15
        
        view.layer.shadowRadius = 5.0
        
    }
    
}
