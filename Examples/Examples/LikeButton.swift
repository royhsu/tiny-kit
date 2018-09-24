//
//  LikeButton.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LikeButton

import UIKit
import TinyCore
import TinyKit

public final class LikeButton: UIButton, Actionable {
    
    public final var storage: LikeButtonStorage? {
        
        didSet {
            
            isSelected = storage?.isLiked ?? false
            
        }
        
    }
    
    public final let actions = Observable<Action>()
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        prepare()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        prepare()
        
    }
    
    private final func prepare() {
        
        addTarget(
            self,
            action: #selector(like),
            for: .touchUpInside
        )
        
        setTitle(
            "Like",
            for: .normal
        )
        
        setTitleColor(
            tintColor,
            for: .normal
        )
        
        setTitle(
            "Liked",
            for: .selected
        )

        setTitleColor(
            .white,
            for: .selected
        )
        
    }
    
    @objc
    public final func like(_ sender: Any) {
        
        isSelected.toggle()
        
        storage?.isLiked = isSelected
        
        guard
            let storage = storage
        else { return }
        
        let action: LikeButtonAction = .liked(storage)

        actions.value = action
        
    }
    
}

// MARK: - ErrorHandler

extension LikeButton: ErrorHandler {
    
    public final func `catch`(error: Error) {
        
        print(#function, "\(error)")
        
    }
    
}
