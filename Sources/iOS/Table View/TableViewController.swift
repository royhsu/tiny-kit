//
//  TableViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TableViewController

import UIKit
import TinyCore

public typealias View = UIView

public protocol ViewRepresentable {
    
    var view: View { get }
    
}

// Row: ViewConvertible. (CellConvertible)
public protocol Row: ViewRepresentable {
    
    associatedtype Value
    
    func configure(with value: Value)
    
}

public struct AnyRow<Value>: Row {
    
    private let _configureHandler: (Value) -> Void
    
    public let view: View
    
    public init<R: Row>(_ row: R) where R.Value == Value {
        
        self.view = row.view
        
        self._configureHandler = row.configure
        
    }
    
    public func configure(with value: Value) { _configureHandler(value) }
    
}

public typealias Section<Value> = AnyCollection< AnyRow<Value> >

public typealias Layout<Value> = AnyCollection< Section<Value> >

// TODO: find a better name. ("Template" seems like a good choice)
// TODO: Define as static. Only use as a factory and cache the returned setions inside the view controller.
// TODO: provide a convenient default template for every custom view controler to reduce complexity.
public protocol SectionBuilder {
    
    associatedtype Value
    
    // TODO: should not contain any instance methods and properties.
    func section(from value: Value) -> Section<Value>
    
}

// TODO: add SectionBuilderExpressible after use static type.
// Example:
// [Design 1]
//let viewController: TableViewController<PostListBuilder> = [
//    .title,
//    .content
//]

// [Design 2]
// Each case must contains only one associated value (that conforms to BindableProtocol) to reduce complexity.
// This approach needs to provide a way to forward fetched value to specific case.
//let viewController: TableViewController<PostListBuilder> = [
//    .title("Hello"),
//    .content("This is awesome")
//]

// TODO: a way to register multiple templates for the same view, and configure by json.
// always have a Default.self at the bottom.
//
// JSON config
//{
//    "template": "BLabel"
//}
//
// In code side.
//templates.register(
//  [
//    ALabel.self,
//    BLabel.self,
//    CLabel.self,
//    Default.self
//  ]
//)

open class TableViewController<Builder: SectionBuilder>: UIViewController {
    
    public typealias Value = Builder.Value
    
    private final let tableView = UITableView()
    
    // TODO: delete this and use static type instead.
    public final var sectionBuilder: Builder?
    
    private final let dataSourceController = UITableViewDataSourceController()
    
    public final var storage: AnyStorage<Int, Value>? {
        
        didSet {
            
            guard
                let storage = storage
            else { return }
            
            let subscription = storage.keyDiff.subscribe { _ in
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
            subscriptions = [ subscription ]
            
        }
        
    }
    
    private final var subscriptions: [ObservableSubscription] = []
    
    open override func loadView() { view = tableView }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = dataSourceController
        
        dataSourceController.setNumberOfSections { [weak self] _ in
            
            guard
                let maxKey = self?.storage?.maxKey
            else { return 0 }

            return maxKey + 1
            
        }
        
        dataSourceController.setNumberOfRows { [weak self] _, section in
            
            guard
                let self = self,
                let value = self.storage?[section],
                let section = self.sectionBuilder?.section(from: value)
            else { return 0 }
            
            return section.count
            
        }
        
        dataSourceController.setCellForRow { [weak self] _, indexPath in
            
            guard
                let self = self,
                let value = self.storage?[indexPath.section],
                let section = self.sectionBuilder?.section(from: value)
            else { return UITableViewCell() }
            
            let row = section[ AnyIndex(indexPath.row) ]
            
            let cell = UITableViewCell()

            let view = row.view
            
            cell.wrapSubview(view)
            
            row.configure(with: value)
            
            return cell
            
        }
        
    }
    
}

