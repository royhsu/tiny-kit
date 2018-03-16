//
//  UICartItemView.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartItemView

public final class UICartItemView: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var selectionContainerView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var previewImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final weak var priceLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final weak var quantityPickerContainerView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var editButton: UIButton!
    
    @IBOutlet
    public fileprivate(set) final weak var deleteButton: UIButton!
    
    @IBOutlet
    public fileprivate(set) final weak var separatorView: UIView!
    
    public final override func awakeFromNib() {
        
        setUpSelectionContainerView(selectionContainerView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpSelectionContainerView(_ view: UIView) { view.backgroundColor = .white }
    
}
