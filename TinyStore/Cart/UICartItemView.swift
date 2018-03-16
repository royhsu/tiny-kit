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
    public fileprivate(set) final weak var contentContainer: UIView!
    
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
        
        setUpContentContainer(contentContainer)
        
        setUpPreviewImageView(previewImageView)
        
        setUpTitleLabel(titleLabel)
        
        setUpPriceLabel(priceLabel)
        
        setUpQuantityPickerContainerView(quantityPickerContainerView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpSelectionContainerView(_ view: UIView) { view.backgroundColor = nil }
    
    fileprivate final func setUpContentContainer(_ view: UIView) { view.backgroundColor = nil }
    
    fileprivate final func setUpPreviewImageView(_ imageView: UIImageView) {
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.layer.cornerRadius = 2.0
        
    }
    
    fileprivate final func setUpTitleLabel(_ label: UILabel) {
        
        label.text = nil
        
        label.textAlignment = .left
        
        label.numberOfLines = 1
        
        label.font = .systemFont(ofSize: 14.0)
        
        label.textColor = .lightGray
        
    }
    
    fileprivate final func setUpPriceLabel(_ label: UILabel) {
        
        label.text = nil
        
        label.textAlignment = .left
        
        label.numberOfLines = 1
        
        label.font = .systemFont(ofSize: 14.0)
        
        label.textColor = .black
        
    }
    
    fileprivate final func setUpQuantityPickerContainerView(_ view: UIView) { view.backgroundColor = nil }
    
}
