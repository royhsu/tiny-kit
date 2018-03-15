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
    public fileprivate(set) final weak var barContainerView: UIView!
    
    @IBOutlet
    public fileprivate(set) final var barContainerViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet
    public fileprivate(set) final var barContainerViewHeightConstraint: NSLayoutConstraint!
    
    /// The content view of the bar.
    @IBOutlet
    public fileprivate(set) final weak var barContentView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var barView: UIView!
    
    public final override func awakeFromNib() {
        
        setUpBarContainer(barContainerView)

        setUpBarView(barView)

        setUpBarContentView(barContentView)

        setUpSafeAreaBottomView(safeAreaBottomView)
        
        safeAreaBottomViewHeightConstraint.constant = 0.0
        
        barContainerViewHeightConstraint.constant = 60.0
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpBarContainer(_ view: UIView) {
        
        view.layer.shadowColor = UIColor.black.cgColor
        
        view.layer.shadowOffset = .zero
        
        view.layer.shadowRadius = 10.0
        
        view.layer.shadowOpacity = 0.2
        
    }
    
    fileprivate final func setUpBarView(_ view: UIView) { view.backgroundColor = .white }
    
    fileprivate final func setUpBarContentView(_ view: UIView) { view.backgroundColor = .white }
    
    fileprivate final func setUpSafeAreaBottomView(_ view: UIView) { view.backgroundColor = .white }
    
}
