//
//  NumberViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - NumberViewController

import TinyKit

/// To demonstrate how simple it is to create a number list by defining single template.
public final class NumberViewController: ViewController {

    private final let base = CollectionViewController()
    
    public final override func viewDidLoad() {

        super.viewDidLoad()
        
        view.backgroundColor = .white

        let numberSection: Template = (0..<100).map { number in

            let label = UILabel()

            label.textAlignment = .center

            label.font = .preferredFont(forTextStyle: .title1)

            label.text = "\(number)"

            return label

        }

        base.collectionView.sections = [ numberSection ]
        
        base.collectionView.applyLayout(ListViewLayout.self)
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }

}
