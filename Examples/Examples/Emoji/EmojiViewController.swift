//
//  NumberListViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - NumberListViewController

import TinyStorage
import TinyKit
import UIKit

public final class NumberListViewController: CollectionViewController {

    public final override func viewDidLoad() {

        super.viewDidLoad()

        layout = TableViewLayout()

        let numberSection: Template = (0..<100).map { number in

            let label = UILabel()

            label.textAlignment = .center

            label.font = .preferredFont(forTextStyle: .title1)

            label.text = "\(number)"

            return label

        }

        sections = [ numberSection ]

    }

}
