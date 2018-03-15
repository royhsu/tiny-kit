//
//  UICollapseView.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollapseView

public final class UICollapseView: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var safeAreaBottomView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var safeAreaBottomViewHeightConstraint: NSLayoutConstraint!
    
    /// The view behind the bar.
    @IBOutlet
    public fileprivate(set) final weak var backgroundView: UIView!
    
    /// The bar.
    @IBOutlet
    public fileprivate(set) final weak var barView: UIView!
    
    /// The content view of the bar.
    @IBOutlet
    public fileprivate(set) final weak var barContentView: UIView!
    
    @IBOutlet
    public fileprivate(set) final var barContentViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet
    public fileprivate(set) final var barContentViewHeightConstraint: NSLayoutConstraint!
    
    public final override func awakeFromNib() {
        
        setUpBarView(barView)
        
        setUpBarContentView(barContentView)
        
        setUpSafeAreaBottomView(safeAreaBottomView)
        
        safeAreaBottomViewHeightConstraint.constant = 0.0
        
        barContentViewHeightConstraint.constant = 0.0
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpBarView(_ view: UIView) { view.backgroundColor = .white }
    
    fileprivate final func setUpBarContentView(_ view: UIView) { view.backgroundColor = .white }
    
    fileprivate final func setUpSafeAreaBottomView(_ view: UIView) { view.backgroundColor = .white }
    
}
