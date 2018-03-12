//
//  UIGridItemView.swift
//  TinyStore
//
//  Created by Roy Hsu on 12/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGridItemView

public final class UIGridItemView: UIView {
    
    @IBOutlet
    public fileprivate(set) final var previewImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final var titleLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final var subtitleLabel: UILabel!
    
    // MARK: Life Cycle
    
    public final override func awakeFromNib() {
        
        setUpPreviewImageView(previewImageView)
        
        setUpTitleLabel(titleLabel)
        
        setUpSubtitleLabel(subtitleLabel)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpPreviewImageView(_ imageView: UIImageView) {
        
        imageView.backgroundColor = .lightGray
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
    }
    
    fileprivate final func setUpTitleLabel(_ label: UILabel) {
        
        label.text = nil
        
        label.textAlignment = .left
        
        label.numberOfLines = 2
        
        label.font = UIFont.systemFont(
            ofSize: 13.0,
            weight: .medium
        )
        
        label.textColor = .black
        
    }
    
    fileprivate final func setUpSubtitleLabel(_ label: UILabel) {
        
        label.text = nil
        
        label.textAlignment = .left
        
        label.numberOfLines = 1
        
        label.font = UIFont.systemFont(
            ofSize: 13.0,
            weight: .medium
        )
        
        label.textColor = .lightGray
        
    }
    
}
