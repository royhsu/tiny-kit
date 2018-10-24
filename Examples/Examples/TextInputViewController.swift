////
////  TextInputViewController.swift
////  Examples
////
////  Created by Roy Hsu on 2018/10/23.
////  Copyright © 2018 TinyWorld. All rights reserved.
////
//
//import TinyKit
//
//public class TextInputViewController: ViewController {
//    
//    private let base = CollectionViewController()
//    
//    public override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        
//        addChild(base)
//        
//        view.wrapSubview(base.view)
//        
//        base.didMove(toParent: self)
//        
//        base.layout = ListViewLayout()
//        
//        let textView = UITextView()
//        
//        textView.backgroundColor = .red
//        
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        
//        textView.heightAnchor.constraint(equalToConstant: 500.0).isActive = true
//        
//        let template: Template = [ textView ]
//        
//        base.sections = [ template ]
//        
//    }
//    
//}
//
//public class TextInput2ViewController: UITableViewController {
//    
//    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return 1
//        
//    }
//    
//    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let textView = UITextView()
//        
//        textView.backgroundColor = .red
//        
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        
//        textView.heightAnchor.constraint(equalToConstant: 500.0).isActive = true
//        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        
//        cell.contentView.wrapSubview(textView)
//        
//        return cell
//        
//    }
//    
//}
//
//public class TextInput3ViewController: UIViewController, UITableViewDataSource {
//    
//    public let tableView = UITableView()
//    
//    public override func loadView() {
//
//        self.view = tableView
//
//    }
//    
//    public override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        
//        tableView.contentInsetAdjustmentBehavior = .scrollableAxes
//        
//        tableView.insetsContentViewsToSafeArea = true
//        
////        edgesForExtendedLayout = [ .top, .bottom ]
//        
//        extendedLayoutIncludesOpaqueBars = true
//        
////        view.wrapSubview(tableView)
//        
//        tableView.dataSource = self
//        
//    }
//    
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return 1
//        
//    }
//    
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let textView = UITextView()
//        
//        textView.backgroundColor = .red
//        
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        
//        textView.heightAnchor.constraint(equalToConstant: 500.0).isActive = true
//        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        
//        cell.contentView.wrapSubview(textView)
//        
//        return cell
//        
//    }
//    
//}
