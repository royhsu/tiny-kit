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

public protocol Updatable {
    
    associatedtype Value
    
    func update(with value: Value?)
    
}

public struct AnyUpdatable<Value>: Updatable where Value: Equatable {
    
    private let _updater: (Value?) -> Void
    
    public init<U: Updatable>(_ updatable: U) where U.Value == Value {
        
        self._updater = updatable.update
        
    }
    
    public func update(with value: Value?) { return _updater(value) }
    
}

public typealias UpdatableView = Updatable & View

public final class AnyUpdatableView<Value>: UIView, Updatable where Value: Equatable {
   
    private final let _updater: (Value?) -> Void
    
    public init<V: UpdatableView>(_ view: V) where V.Value == Value {
        
        self._updater = view.update
        
        super.init(frame: .zero)
        
    }
    
    internal required init?(coder aDecoder: NSCoder) { fatalError("AnyUpdatableView is a type erasure.") }
    
    public final func update(with value: Value?) { _updater(value) }

}

// MARK: - TemplateElement

public protocol TemplateElement {
    
    associatedtype Value: Equatable
    
    func makeView() -> AnyUpdatableView<Value>
    
}

// MARK: - AnyTemplateElement

public struct AnyTemplateElement<Value>: TemplateElement where Value: Equatable {
    
    public let _makeViewFactory: () -> AnyUpdatableView<Value>
    
    public init<E: TemplateElement>(_ element: E) where E.Value == Value {
        
        self._makeViewFactory = element.makeView
        
    }
    
    public func makeView() -> AnyUpdatableView<Value> { return _makeViewFactory() }
    
}

public protocol Template {
    
    associatedtype Element: TemplateElement
    
    static var elements: AnyCollection<Element> { get }
    
}

//public typealias Template<> = AnyCollection< AnyTemplateElement<> >

//public protocol TemplateBuilder {
//
//    associatedtype T: Template
//
//    static func build(_ value: Value) -> T
//
//}

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

open class TableViewController<T: Template>: UIViewController {
    
    public typealias Value = T.Element.Value
    
    private final class Cell: UITableViewCell, ReusableCell { }
    
    private final let tableView = UITableView()
    
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
        
        tableView.register(Cell.self)
        
        tableView.dataSource = dataSourceController
        
        dataSourceController.setNumberOfSections { [weak self] _ in
            
            guard
                let maxKey = self?.storage?.maxKey
            else { return 0 }

            return maxKey + 1
            
        }
        
        dataSourceController.setNumberOfRows { _, _ in T.elements.count }
        
        dataSourceController.setCellForRow { [weak self] _, indexPath in
            
            guard
                let self = self
            else { return UITableViewCell() }
            
            let elementIndex = AnyIndex(indexPath.row)
            
            let element = T.elements[elementIndex]
            
            let cell = self.tableView.dequeueReusableCell(
                Cell.self,
                for: indexPath
            )
            
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let view = element.makeView()
            
            cell.contentView.wrapSubview(view)
            
            let value = self.storage?[indexPath.section]
            
            view.update(with: value)
            
            return cell
            
        }
        
    }
    
}

