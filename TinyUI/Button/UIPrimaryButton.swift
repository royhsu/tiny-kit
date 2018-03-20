//
//  UIPrimaryButton.swift
//  TinyUI
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPrimaryButton

public final class UIPrimaryButton: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final weak var iconImageView: UIImageView!
    
    public final override func awakeFromNib() {
        
        setUpRootView(self)
        
        setUpTitleLabel(titleLabel)
        
        setUpIconImageView(iconImageView)
        
    }
    
    public final override func layoutSubviews() { layer.cornerRadius = (bounds.height / 2.0) }
    
    // MARK: Set Up
    
    fileprivate final func setUpRootView(_ view: UIView) { view.backgroundColor = tintColor }
    
    fileprivate final func setUpTitleLabel(_ label: UILabel) {
        
        label.textAlignment = .center
        
        label.text = nil
        
        label.textColor = .white
        
        label.numberOfLines = 1
        
        label.font = .systemFont(
            ofSize: 14.0,
            weight: .medium
        )
        
    }
    
    fileprivate final func setUpIconImageView(_ imageView: UIImageView) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        let image = UIImage(
            named: "icon-plus",
            in: bundle,
            compatibleWith: nil
        )
        
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        
        imageView.tintColor = .white
        
        imageView.contentMode = .scaleAspectFill
        
    }
    
}
