//
//  ShadowImage.swift
//  ShadowView
//
//  Created by Pierre Perrin on 25/07/2017.
//  Copyright © 2017 Pierreperrin. All rights reserved.
//

import UIKit

public class ShadowView: UIView {

    public var shadowImageView = UIImageView()

    internal let scaleImageConstant: CGFloat = 3

    internal var blurRadius: CGFloat = 5.0

    public var highPerformanceBlur = true

    public var correctShadowScale: CGFloat {

        return shadowScale + scaleImageConstant - 1

    }

    public override init(frame: CGRect) {

        super.init(frame: frame)

        setUpShadowImageView(shadowImageView)

    }

    public required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        setUpShadowImageView(shadowImageView)

    }

    private final func setUpShadowImageView(_ imageView: UIImageView) {

        imageView.frame.size = frame.size.scaled(by: shadowScale)

        imageView.center = CGPoint(
            x: bounds.midX,
            y: bounds.midY
        )

        imageView.layer.masksToBounds = false

        insertSubview(
            imageView,
            at: 0
        )

    }

    public final var shadowColor: UIColor?

    public final var shadowScale: CGFloat = 1 {

        didSet { layoutSubviews() }

    }

    public final var shadowSaturation: CGFloat = 1 {

        didSet { updateShadow() }

    }

    public final var shadowOffset: CGSize = .zero {

        didSet { layoutSubviews() }

    }

    public final var shadowRadius: CGFloat {

        set {

            blurRadius = newValue

            updateShadow()

        }

        get { return blurRadius }

    }

    public final var shadowOpacity: CGFloat {

        set { shadowImageView.alpha = newValue }

        get { return shadowImageView.alpha }

    }

    public final override func didMoveToSuperview() {

        super.didMoveToSuperview()

        updateShadow()

    }

    // Reload the image if the view changed.
    public final override func layoutSubviews() {

        super.layoutSubviews()

        shadowImageView.frame.size = frame.size.scaled(by: correctShadowScale)

        shadowImageView.center = CGPoint(
            x: bounds.midX + shadowOffset.width,
            y: bounds.midY + shadowOffset.height
        )

    }

}
