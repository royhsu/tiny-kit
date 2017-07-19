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

class EmojiListTableViewController: UITableViewController {

    // MARK: Cell

    typealias Cell = TNTableViewCell<EmojiComponentViewFactory>

    // MARK: Property

    let emojis = [ "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊" ]

    // MARK: View Life Cycle

    override func viewDidLoad() {
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

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return emojis.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
            else { fatalError("Please make sure the cell has been registerd.") }

        cell.componentView.emojiLabel.text = emojis[indexPath.row]

        return cell

    }

}
