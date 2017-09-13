//
//  EmojiListTableViewController.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 19/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - EmojiListTableViewController

import UIKit
import TinyKit

public final class EmojiListTableViewController: UITableViewController {

    // MARK: Cell

    public typealias Cell = TNTableViewCell<EmojiComponentViewFactory>

    // MARK: Property

    public final let emojis = [ "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊" ]

    // MARK: View Life Cycle

    public final override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerCell(
            Cell.self
        )

        tableView.estimatedRowHeight = 44.0

        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.separatorStyle = .none

        navigationItem.title = "Emojis"

    }

    // MARK: UITableViewDataSource

    public final override func numberOfSections(in tableView: UITableView) -> Int {

        return 1

    }

    public final override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return emojis.count

    }

    public final override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(
                Cell.self,
                for: indexPath
            )
            else {

                fatalError("Please make sure the cell has been registerd.")

        }

        cell.componentView.emojiLabel.text = emojis[indexPath.row]

        return cell

    }

}
