//
//  UICartView.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartView

public final class UICartView: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var safeAreaBottomView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var safeAreaBottomViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet
    public fileprivate(set) final weak var backgroundView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var barView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var itemListContainerView: UIView!
    
    @IBOutlet
    public fileprivate(set) final var itemListContainerViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet
    public fileprivate(set) final var itemListContainerViewHeightConstraint: NSLayoutConstraint!
    
    public final override func awakeFromNib() {
        
        setUpSafeAreaBottomView(safeAreaBottomView)
        
        safeAreaBottomViewHeightConstraint.constant = 0.0
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpSafeAreaBottomView(_ view: UIView) {
        
        view.backgroundColor = .white
        
    }
    
}
