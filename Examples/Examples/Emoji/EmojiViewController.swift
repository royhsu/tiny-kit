//
//  EmojiViewController.swift
//  
//
//  Created by Roy Hsu on 2018/9/29.
//

// MARK: - EmojiViewController

import TinyKit

// To demonstrate how to change the underlying layout with single line of code.
public final class EmojiViewController: ViewController {
    
    private final let base = CollectionViewController()
    
    private enum LayoutOption: CaseIterable {
        
        case list
        
        case carousel
        
        internal var layout: CollectionViewLayout {
            
            switch self {
                
            case .list: return ListViewLayout()
                
            case .carousel: return CarouselViewLayout()
                
            }
            
        }
        
        internal var name: String {
            
            switch self {
                
            case .list: return "List"
                
            case .carousel: return "Carousel"
                
            }
            
        }
        
    }
    
    private final var currentLayoutOptionIndex = 0
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let currentOption = LayoutOption.allCases[currentLayoutOptionIndex]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: currentOption.name,
            style: .plain,
            target: self,
            action: #selector(changeLayout)
        )
        
        let emojiSection: Template = [
            "😀", "😃", "😄", "😁", "😆",
            "😅", "😂", "🤣", "☺️", "😊",
            "😇", "🙂", "🙃", "😉", "😌",
            "😍", "😘", "😗", "😙", "😚"
        ]
        .map { emoji in
            
            let label = UILabel()
            
            label.textAlignment = .center
            
            label.font = .systemFont(ofSize: 50.0)
            
            label.text = emoji
            
            return label
            
        }
        
        base.sections = [ emojiSection ]
        
        base.layout = currentOption.layout
        
        addChild(base)
        
        view.wrapSubview(base.view)
        
        base.didMove(toParent: self)
        
    }
    
    @objc
    public final func changeLayout(_ sender: Any) {
        
        var nextIndex = currentLayoutOptionIndex + 1
        
        if nextIndex >= LayoutOption.allCases.count { nextIndex = 0 }
        
        currentLayoutOptionIndex = nextIndex
        
        let option = LayoutOption.allCases[nextIndex]
        
        base.layout = option.layout
        
        base.layout?.invalidate()
        
        navigationItem.rightBarButtonItem?.title = option.name
        
    }
    
}
