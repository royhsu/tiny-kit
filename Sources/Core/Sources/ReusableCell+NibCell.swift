//
//  Reusable+NibCell.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/8/18.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - NibCell

extension NibCell where Self: Reusable {

    public static var nibName: String { return reuseIdentifier }

}
