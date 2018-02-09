//
//  ProfileHeaderView.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileHeaderView

import UIKit

public final class ProfileHeaderView: UIView {
    
    @IBOutlet
    public fileprivate(set) weak var pictureImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) weak var nameLabel: UILabel!
    
    public final override func awakeFromNib() {
        
        setUpPictureImageView(pictureImageView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpPictureImageView(_ imageView: UIImageView) {
        
        imageView.backgroundColor = .darkGray
        
        imageView.layer.cornerRadius = imageView.bounds.width / 2.0
        
        imageView.clipsToBounds = true
        
    }
    
}
