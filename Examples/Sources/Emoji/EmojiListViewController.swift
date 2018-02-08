//
//  EmojiListViewController.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 19/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - EmojiListViewController

import UIKit
import TinyCore
import TinyKit

public final class EmojiListViewController: UIViewController {
    
    private final let listComponent = ListComponent()
    
    public override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        
        super.init(
            nibName: nibNameOrNil,
            bundle: nibBundleOrNil
        )
        
        setUpListComponent(listComponent)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setUpListComponent(listComponent)
        
    }
    
    fileprivate final func setUpListComponent(_ component: ListComponent) {
        
        let emojiItem1Component = ItemComponent(
            view: UIView.load(EmojiView.self)!,
            model: "😎",
            binding: { emojiView, emoji in
         
                emojiView.emojiLabel.text = emoji
                
            }
        )
        
        listComponent.addChild(emojiItem1Component)
        
        let emojiView2 = UIView.load(EmojiView.self)!
        
        emojiView2.emojiLabel.numberOfLines = 0
        
//        emojiView2.emojiLabel.font = .systemFont(ofSize: 20.0)

        let emojiItem2Component = ItemComponent(
            view: emojiView2,
            model: "Donec id elit non mi porta gravida at eget metus. Aenean lacinia bibendum nulla sed consectetur. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Maecenas faucibus mollis interdum. Sed posuere consectetur est at lobortis.",
            binding: { emojiView, emoji in
                
                emojiView.emojiLabel.text = emoji
                
            }
        )
        
        emojiItem2Component.preferredContentSize = CGSize(
            width: UITableViewAutomaticDimension,
            height: UITableViewAutomaticDimension
        )
        
        listComponent.addChild(emojiItem2Component)
        
        let emojiItem3Component = ItemComponent(
            view: UIView.load(EmojiView.self)!,
            model: "😎",
            binding: { emojiView, emoji in
                
                emojiView.emojiLabel.text = emoji
                
            }
        )
        
        listComponent.addChild(emojiItem3Component)
        
        let emojiItem4Component = ItemComponent(
            view: UIView.load(EmojiView.self)!,
            model: "😎",
            binding: { emojiView, emoji in
                
                emojiView.emojiLabel.text = emoji
                
            }
        )
        
        listComponent.addChild(emojiItem4Component)
        
        let contentView = component.view
        
        view.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(
            [
                contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                contentView.topAnchor.constraint(equalTo: view.topAnchor),
                contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
        
        listComponent.render().then {
            
        }
        
    }
    
}
