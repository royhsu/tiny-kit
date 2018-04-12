//
//  TSProductGalleryView.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSProductGalleryView

public final class TSProductGalleryView: UIView {

    @IBOutlet
    public fileprivate(set) final weak var contentView: UIView!

    @IBOutlet
    public fileprivate(set) final weak var triangleView: TriangleView!
    
    public final override func awakeFromNib() { setUpTriangleView(triangleView) }

    // MARK: Set Up

    fileprivate final func setUpTriangleView(_ triangleView: TriangleView) {

        triangleView.backgroundColor = .clear

        triangleView.triangleColor = .white

    }

}
