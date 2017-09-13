//
//  NoNibCollectionViewCell.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - NoNibCollectionViewCell

import UIKit
import TinyCore

final class NoNibCollectionViewCell: UICollectionViewCell, Identifiable {

    // MARK: Property

    final override var reuseIdentifier: String? {

        return NoNibCollectionViewCell.identifier

    }

}
