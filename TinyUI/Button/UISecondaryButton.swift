//
//  UISecondaryButton.swift
//  TinyUI
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UISecondaryButton

public final class UISecondaryButton: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!
    
    public final override func awakeFromNib() {
        
        setUpRootView(self)
        
        setUpTitleLabel(titleLabel)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpRootView(_ view: UIView) {
        
        view.backgroundColor = tintColor
        
        view.layer.cornerRadius = 3.0
        
        view.layer.shadowColor = UIColor.black.cgColor
        
        view.layer.shadowOffset = CGSize(
            width: 0.0,
            height: 2.0
        )
        
        view.layer.shadowRadius = 4.0
        
        view.layer.shadowOpacity = 0.2
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = view.safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: 44.0)
        
        heightConstraint.priority = UILayoutPriority(500)
        
        NSLayoutConstraint.activate(
            [ heightConstraint ]
        )
        
    }
    
    fileprivate final func setUpTitleLabel(_ label: UILabel) {
        
        label.textAlignment = .center
        
        label.text = "Title"
        
        label.textColor = .white
        
        label.numberOfLines = 1
        
        label.font = .systemFont(
            ofSize: 14.0,
            weight: .medium
        )
        
    }
    
}
