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
    public fileprivate(set) final weak var firstContainerView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var firstTitleLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final weak var firstButton: UIButton!
    
    @IBOutlet
    public fileprivate(set) final weak var secondContainerView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var secondTitleLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final weak var secondButton: UIButton!
    
    @IBOutlet
    public fileprivate(set) final weak var separatorView: UIView!
    
    public final override func awakeFromNib() {
        
        setUpSelectionContainerView(selectionContainerView)
        
        setUpContentContainer(contentContainer)
        
        setUpPreviewImageView(previewImageView)
        
        setUpTitleLabel(titleLabel)
        
        setUpPriceLabel(priceLabel)
        
        setUpQuantityPickerContainerView(quantityPickerContainerView)
        
        setUpFirstContainerView(firstContainerView)
        
        setUpFirstTitleLabel(firstTitleLabel)
        
        setUpFirstButton(firstButton)
        
        setUpSecondContainerView(secondContainerView)
        
        setUpSecondTitleLabel(secondTitleLabel)
        
        setUpSecondButton(secondButton)
        
        setUpSeparatorView(separatorView)
        
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
    
    fileprivate final func setUpFirstContainerView(_ view: UIView) { view.backgroundColor = nil }
    
    fileprivate final func setUpFirstTitleLabel(_ label: UILabel) {
        
        label.text = "First"
        
        label.textAlignment = .left
        
        label.numberOfLines = 1
        
        label.font = .systemFont(ofSize: 10.0)
        
        label.textColor = tintColor
        
    }
    
    fileprivate final func setUpFirstButton(_ button: UIButton) {
        
        button.setTitle(
            nil,
            for: .normal
        )
        
    }
 
    fileprivate final func setUpSecondContainerView(_ view: UIView) { view.backgroundColor = nil }
    
    fileprivate final func setUpSecondTitleLabel(_ label: UILabel) {
        
        label.text = "Second"
        
        label.textAlignment = .left
        
        label.numberOfLines = 1
        
        label.font = .systemFont(ofSize: 10.0)
        
        label.textColor = tintColor
        
    }
    
    fileprivate final func setUpSecondButton(_ button: UIButton) {
        
        button.setTitle(
            nil,
            for: .normal
        )
        
    }
    
    fileprivate final func setUpSeparatorView(_ view: UIView) { view.backgroundColor = .lightGray }
    
}
