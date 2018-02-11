//
//  ProfileIntroductionView.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileIntroductionView

import UIKit

public final class ProfileIntroductionView: UIView {

    @IBOutlet
    public fileprivate(set) weak var pictureImageView: UIImageView!

    @IBOutlet
    public fileprivate(set) weak var nameLabel: UILabel!

    @IBOutlet
    public fileprivate(set) weak var introductionLabel: UILabel!
    
    public final override func awakeFromNib() {

        setUpPictureImageView(pictureImageView)
        
        setUpNameLabel(nameLabel)
        
        setUpIntroductionLabel(introductionLabel)

    }

    // MARK: Set Up

    fileprivate final func setUpPictureImageView(_ imageView: UIImageView) {

        imageView.backgroundColor = .darkGray

        imageView.layer.cornerRadius = imageView.bounds.width / 2.0

        imageView.clipsToBounds = true

    }
    
    fileprivate final func setUpNameLabel(_ label: UILabel) {
        
        label.textAlignment = .center
        
        label.text = nil
        
        label.font = .preferredFont(forTextStyle: .title1)
        
    }
    
    fileprivate final func setUpIntroductionLabel(_ label: UILabel) {
        
        label.textAlignment = .center
        
        label.text = nil
        
        label.font = .preferredFont(forTextStyle: .caption1)
        
        label.textColor = .lightGray
        
    }

}
