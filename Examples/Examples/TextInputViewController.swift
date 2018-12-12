//
//  TextInputViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/10/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

import TinyKit

public class TextInputViewController: ViewController {

    private let base = CollectionViewController()

    public override func viewDidLoad() {

        super.viewDidLoad()

        let textView = UITextView()

        textView.backgroundColor = .red

        textView.translatesAutoresizingMaskIntoConstraints = false

        textView.heightAnchor.constraint(equalToConstant: 500.0).isActive = true

        let template: Template = [ textView ]

        base.collectionView.sections = [ template ]

        base.collectionView.applyLayout(ListViewLayout.self)

        addChild(base)

        view.wrapSubview(base.view)

        base.didMove(toParent: self)

    }

}
