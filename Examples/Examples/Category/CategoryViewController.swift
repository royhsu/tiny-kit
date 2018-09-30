//
//  CategoryViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/30.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CategoryViewController

import TinyKit

/// To demonstrate how to make the width of view match its content with carousel layout.
public final class CategoryViewController: ViewController {
    
    private let base = CollectionViewController()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white

        let categories = [
            "Clothing",
            "Shoes",
            "Accessories",
            "Watches",
            "Jewelry",
            "HandBag",
            "Wallets"
        ]
        .map { category -> (view: View, size: CGSize) in
            
            let label = UILabel()
            
            label.backgroundColor = .orange
            
            label.textAlignment = .center
            
            label.font = .preferredFont(forTextStyle: .title1)
            
            label.text = category
            
            let size = label.sizeThatFits(label.frame.size)

            return (label, size)
            
        }
        
        base.sections = [ categories.map { $0.view } ]
        
        let layout = CarouselViewLayout()
        
        layout.interitemSpacing = 20.0
        
        layout.setWidthForItem { _, _, indexPath in

            let sizes = categories.map { $0.size }
            
            return sizes[indexPath.item].width

        }
        
        base.layout = layout
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
}
