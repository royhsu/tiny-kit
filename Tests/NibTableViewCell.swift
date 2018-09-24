//
//  NibTableViewCell.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/9/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - NibTableViewCell

import UIKit
import TinyKit

internal final class NibTableViewCell: UITableViewCell { }

// MARK: - ReusableCell

extension NibTableViewCell: ReusableCell {  }

// MARK: - ReusableCell

extension NibTableViewCell: NibCell { }
