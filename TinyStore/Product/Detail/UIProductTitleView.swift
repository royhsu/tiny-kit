//
//  UIProductTitleView.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductTitleView

public final class UIProductTitleView: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final weak var subtitleLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final weak var actionContainerView: UIView!
    
}
