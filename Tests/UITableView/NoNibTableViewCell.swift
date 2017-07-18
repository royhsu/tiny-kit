//
//  TableViewCell.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - NoNibTableViewCell

import TinyCore
import UIKit

class NoNibTableViewCell: UITableViewCell, Identifiable {

    // MARK: Property

    override var reuseIdentifier: String? {

        return NibTableViewCell.identifier

    }

}
