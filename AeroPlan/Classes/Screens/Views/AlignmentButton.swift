//
//  AlignmentButton.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.05.21.
//

import UIKit

class AlignmentButton: UIButton {
    public enum Alignment {
        case left, center, right
    }

    public var imageAlignment: Alignment = .left {
        didSet {
            setNeedsLayout()
        }
    }

    public var titleAlignment: Alignment = .center {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var imageInset: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleSize = super.titleRect(forContentRect: contentRect).size

        let center = CGPoint(x: contentRect.midX - titleSize.width / 2, y: contentRect.midY - titleSize.height / 2)
        let rect: CGRect
        switch titleAlignment {
        case .left:
            rect = CGRect(origin: CGPoint(x: 0, y: center.y), size: titleSize)
        case .center:
            rect = CGRect(origin: center, size: titleSize)
        case .right:
            rect = CGRect(origin: CGPoint(x: contentRect.maxX - titleSize.width, y: center.y),
                          size: titleSize)
        }

        return rect.inset(by: titleEdgeInsets)
    }

    public override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageSize = super.imageRect(forContentRect: contentRect).size

        let center = CGPoint(x: contentRect.midX - imageSize.width / 2, y: contentRect.midY - imageSize.height / 2)
        let rect: CGRect
        switch imageAlignment {
        case .left:
            rect = CGRect(origin: CGPoint(x: imageInset, y: center.y), size: imageSize)
        case .center:
            rect = CGRect(origin: center, size: imageSize)
        case .right:
            rect = CGRect(origin: CGPoint(x: contentRect.maxX - imageSize.width - imageInset, y: center.y),
                          size: imageSize)
        }

        return rect.inset(by: imageEdgeInsets)
    }
}
