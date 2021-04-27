//
//  Animators.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 27.04.21.
//

import UIKit

final class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { 0.3 }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) else { return }
        
        UIView.transition(
            from: fromVC.view,
            to: toVC.view,
            duration: transitionDuration(using: transitionContext),
            options: [.layoutSubviews, .beginFromCurrentState, .transitionCrossDissolve, .showHideTransitionViews],
            completion: { transitionContext.completeTransition($0) }
        )
    }
}
