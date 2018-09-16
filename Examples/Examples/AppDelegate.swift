//
//  AppDelegate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AppDelegate

import UIKit

@UIApplicationMain
public final class AppDelegate: UIResponder {
    
    public final let window = UIWindow(frame: UIScreen.main.bounds)
    
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    
    public final func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    -> Bool {
        
        let viewController = FeedListViewController()
        
        viewController.reducer = { storage in
            
            let items: [FeedCollection.Section] = storage.values.map { value in
                
                switch value {
                    
                case let .comment(storage):
                    
                    let item = CommentItem(
                        storage: storage,
                        elements: [
                            .username,
                            .text
                        ]
                    )

                    return .comment(item)
                    
                }
                
                
            }
            
            return FeedCollection(items: items)
            
        }
        
        let storage = FeedStorage()
    
        viewController.storage = storage
        
        window.rootViewController = UINavigationController(
            rootViewController: viewController
        )
        
        window.makeKeyAndVisible()
        
        storage.setValues(
            [
                .comment(
                    Comment(
                        username: "Roy",
                        text: "Hi"
                    )
                )
            ]
        )
        
        return true
            
    }
    
}

import TinyCore
import TinyKit

public struct Post: Codable, Equatable {
    
    let id: Int
    
    let title: String
    
    let body: String
    
}

class TitleLabel: UILabel, Updatable {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.prepare()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        numberOfLines = 0
        
        font = UIFont.preferredFont(forTextStyle: .title1)
        
    }
    
    public func updateValue(_ value: Any?) {
        
        let post = value as? Post
        
        text = post?.title
        
    }
    
}

class BodyLabel: UILabel, Updatable {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.prepare()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.prepare()
        
    }
    
    fileprivate func prepare() {
        
        numberOfLines = 0
        
        font = UIFont.preferredFont(forTextStyle: .body)
        
        textColor = .darkGray
        
    }
    
    public func updateValue(_ value: Any?) {
        
        let post = value as? Post
        
        text = post?.body
        
    }
    
}

enum PostListElement: String {
    
    case title
    
    case body
    
}

//struct PostListConfiguration: TemplateConfiguration {
//
//    typealias Element = PostListElement
//
//    func preferredViewName(for element: Element) -> String? { return nil }
//
//}

//typealias PostListTemplate = ConfigurableTemplate<PostListConfiguration>

struct Comment {
    
    let username: String
    
    let text: String
    
}

class FeedStorage: Storage {
    
    enum Value {
        
        case comment(Comment)
        
    }
    
    typealias Storage = MemoryCache<Int, Value>
    
    var _storage = Storage()
    
    var keyDiff: Observable<[Int]> { return _storage.keyDiff }
    
    var values: AnyCollection<Value> { return _storage.values }

    func setPairs(_ pairs: AnyCollection<(Int, Value)>) { _storage.setPairs(pairs) }
    
}

struct CommentItem: Template {
    
    enum Element {
        
        case username
        
        case text
        
    }
    
    var storage: Comment
    
    var elements: [Element]
    
    var numberOfElements: Int { return elements.count }
    
    func view(at index: Int) -> View {
        
        let element = elements[index]
        
        switch element {
            
        case .username:
            
            let label = TitleLabel()
            
            label.text = storage.username
            
            return label
            
        case .text:
            
            let label = BodyLabel()
            
            label.text = storage.text
            
            return label
            
        }
        
    }
    
}

struct FeedCollection: SectionCollection {
    
    enum Section: Template {
        
        typealias Element = Any
        
        case comment(CommentItem)
        
        var storage: Any {
            
            switch self {
                
            case let .comment(elements): return elements.storage
                
            }
            
        }
        
        var numberOfElements: Int {
            
            switch self {
                
            case let .comment(elements):
                
                return elements.numberOfElements
                
            }
            
        }
        
        func view(at index: Int) -> View {
            
            switch self {
                
            case let .comment(elements): return elements.view(at: index)
                
            }
            
        }
        
    }
    
    var items: [Section]
    
    var count: Int { return items.count }
    
    func section(at index: Int) -> Section { return items[index] }
    
}

class FeedListViewController: TableViewController<FeedCollection, FeedStorage> { }

