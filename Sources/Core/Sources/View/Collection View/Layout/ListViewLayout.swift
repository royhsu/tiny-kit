//
//  ListViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListViewLayout

public final class ListViewLayout: CollectionViewLayout {
    
    private final let listView = ListView()
    
    public final var collectionView: View & CollectionView { return listView }
    
    public init() { }
    
}
