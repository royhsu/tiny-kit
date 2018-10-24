//
//  ListViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListViewLayout

public final class ListViewLayout: ViewController, CollectionViewLayout {
    
    private final class Cell: TableViewCell, ReusableCell { }

    #warning("make this property internal.")
    private final let bridge = TableViewBridge()
    
    public final unowned let collectionView: CollectionView

    public init(collectionView: CollectionView) {
        
        self.collectionView = collectionView
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        self.prepare()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        fatalError()
        
//        super.init(coder: aDecoder)
//
//        self.prepare()
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(bridge)
        
        view.wrapSubview(bridge.view)
        
        bridge.didMove(toParent: self)
        
    }
    
    fileprivate final func prepare() {
        
        bridge.tableView.backgroundColor = nil
        
        bridge.tableView.separatorStyle = .none

        bridge.tableView.registerCell(Cell.self)
        
        bridge.setNumberOfSections { _ in self.collectionView.sections.count }
        
        bridge.setNumberOfRows { _, section in
            
            let section = self.collectionView.sections.section(at: section)
                
            return section.numberOfViews
            
        }
        
        bridge.setCellForRow { tableView, indexPath in
            
            let section = self.collectionView.sections.section(at: indexPath.section)
            
            let view = section.view(at: indexPath.row)
            
            let cell = tableView.dequeueCell(
                Cell.self,
                for: indexPath
            )
            
            cell.backgroundColor = nil
            
            cell.selectionStyle = .none
            
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            cell.contentView.wrapSubview(view)
            
            return cell
            
        }

    }

    public final func invalidate() { bridge.tableView.reloadData() }

}
