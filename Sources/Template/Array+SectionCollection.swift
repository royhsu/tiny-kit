//
//  Array+SectionCollection.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - SectionCollection

extension Array: SectionCollection where Element == Template {

    public func section(at index: Int) -> Section { return self[index] }

}
